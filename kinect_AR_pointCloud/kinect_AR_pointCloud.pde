import processing.video.*;
import jp.nyatla.nyar4psg.*;
import java.nio.*;
import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;
import g4p_controls.*;

PWindow win;
int vertLoc;
//openGL object and shader
PGL pgl;
PShader sh;
int vertexVboId;

Capture cam;
MultiMarker nya;
float paramMouse1;
float paramMouse2;
PVector offset = new PVector(0, 0, 0);

KinectPV2 kinect;
PVector[] angleRotation={
new PVector(0, 0, 0), new PVector(0, 0, 0)};
PFont font;
float angleAnim=0;

public void settings(){
  size(1600 , 1200, P3D);  
}

void setup() {

   win = new PWindow();
  colorMode(RGB, 100);
  font = createFont("FFScala", 32);
  //println(MultiMarker.VERSION);

  cam = new Capture(this, 800, 600);
  nya = new MultiMarker(this, 800, 600, "data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("data/patt.hiro", 80);
  nya.addARMarker("data/patt.kanji", 80);
  nya.addNyIdMarker(0, 80); //id=2
  nya.addNyIdMarker(1, 80); //id=3
  cam.start();

  kinect = new KinectPV2(this);
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);
  kinect.enableSkeleton3DMap(true);

  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);
  kinect.setLowThresholdPC(win.minD);
  kinect.setHighThresholdPC(win.maxD);
  kinect.init();

  //*************************
  sh = loadShader("frag.glsl", "vert.glsl");
  PGL pgl = beginPGL();
  IntBuffer intBuffer = IntBuffer.allocate(1);
  pgl.genBuffers(1, intBuffer);
  //memory location of the VBO
  vertexVboId = intBuffer.get(0);
  endPGL();
  //****************************
  skeletonInitValCol();
}



void draw() {

  kinect.setLowThresholdPC(win.minD);
  kinect.setHighThresholdPC(win.maxD);

  if (cam.available() != true) {
    return;
  }
  cam.read();
  nya.detect(cam);
  background(100, 100, 100);
  nya.drawBackground(cam);

  for (int i = 0; i < 4; i++) {
    //************ici réglage pour chaque apparition
    //rotateY(i*PI);
    //**************
    if ((!nya.isExist(i))) {
      return;
    }
    skeletonArray = new ArrayList();
    skeletonArray = kinect.getSkeletonDepthMap();
    getDataSkeleton();
    nya.setARPerspective();
    nya.beginTransform(i);
    pushMatrix();

      fill(100, 100, 100);
      rect(-40, -40, 80, 80);
      rotateZ(angleAnim);
     if(win.axesVisible ==true){
        stroke(100,0,0);
        noFill();
        pushMatrix();
          translate(0,0,win.sceneSize/2);
          box(win.sceneSize);
        popMatrix();
        stroke(0);
        strokeWeight(2);
        line(0, 0, 0, 100, 0, 0);
        textFont(font, 20.0);
        text("X", 100, 0, 0);
        line(0, 0, 0, 0, 100, 0);
        textFont(font, 20.0);
        text("Y", 0, 100, 0);
        line(0, 0, 0, 0, 0, 100);
        textFont(font, 20.0);
        text("Z", 0, 0, 100);
     }
    
    //****Inital rotation for having right axis order
    rotateX(HALF_PI);
    rotateY(win.ry);
    rotateZ(win.rz);
    if (win.skeletonVisible ==true){
    drawBody();
    }
    //*****************************
    drawPointCloud(i);
    //*****************************
    angleAnim += win.angleIncrement;
    popMatrix();
    nya.endTransform();
  }

}




void drawPointCloud(int i) {
  pushMatrix();
    rotateX(PI);
    //rotation custom
    rotateX(win.rotateFactorX);
    rotateY(win.rotateFactorY);
    rotateZ(win.rotateFactorZ);
    translate(0,-win.echelleCloud,win.echelleCloud);
    
    translate(win.translationFactorX,win.translationFactorY, win.translationFactorZ);
    scale(-win.echelleCloud);

    if(win.boxCloudVisible==true){
    stroke(0,100,0);
    fill(255,0,0,10);
    box(10);
    }

    // Threahold of the point Cloud.
    kinect.setLowThresholdPC(win.minD);
    kinect.setHighThresholdPC(win.maxD);
    //get the points in 3d space
    FloatBuffer pointCloudBuffer = kinect.getPointCloudDepthPos();
    /*Cette partie dessine en sphere l'emplacement de kinect
    stroke(0, 255, 0);
    for(int i = 0; i < kinect.WIDTHDepth * kinect.HEIGHTDepth; i+=30){
        float x = pointCloudBuffer.get(i*3 + 0) * scaleDepthPoint;
        float y = pointCloudBuffer.get(i*3 + 1) * scaleDepthPoint;
        float z = pointCloudBuffer.get(i*3 + 2) * scaleDepthPoint;
        //strokeWeight(1);
        point(x, y, z);
    }
    */
    pgl = beginPGL();
    sh.bind();
    vertLoc = pgl.getAttribLocation(sh.glProgram, "vertex");
    pgl.enableVertexAttribArray(vertLoc);
    int vertData = kinect.WIDTHDepth * kinect.HEIGHTDepth * 3;
    {
      pgl.bindBuffer(PGL.ARRAY_BUFFER, vertexVboId);
      pgl.bufferData(PGL.ARRAY_BUFFER, Float.BYTES * vertData, pointCloudBuffer, PGL.DYNAMIC_DRAW);
      pgl.vertexAttribPointer(vertLoc, 3, PGL.FLOAT, false, Float.BYTES * 3, 0);
    }
    pgl.bindBuffer(PGL.ARRAY_BUFFER, 0);
    pgl.drawArrays(PGL.POINTS, 0, vertData);
    pgl.disableVertexAttribArray(vertLoc);
    sh.unbind();
    endPGL();
  popMatrix();
}