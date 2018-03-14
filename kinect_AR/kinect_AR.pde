
import processing.video.*;
import jp.nyatla.nyar4psg.*;

import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;


Capture cam;
MultiMarker nya;
float paramMouse1;
float paramMouse2;
PVector offset = new PVector(0,0,0);

KinectPV2 kinect;
float angle=0;
PFont font;

void setup() {
  size(640, 480, P3D);
  colorMode(RGB,100);
  font = createFont("FFScala",32) ;
  println(MultiMarker.VERSION);

  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, 640, 480, "data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("data/patt.hiro", 80);
  cam.start();

  kinect = new KinectPV2(this);
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);
  kinect.enableSkeleton3DMap(true);
  kinect.init();

  skeletonInitValCol();
}

void draw(){

  //scaleDisplay = map(mouseX,0,width,0.1,4);
  //paramMouse2 = map(mouseY,0, height,-200,200);
  if (cam.available() !=true) {
    return;
  }

  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);
  fill(255, 0, 0);
  text(frameRate, 50, 50);
  image(kinect.getDepthMaskImage(), 0, 0, 160, 120);

  text(LeftHand.stringPosition,20,20);
  text(RightHand.stringPosition,20,40);

  if ((!nya.isExist(0))) {
    return;
  }
    
   skeletonArray=new ArrayList();
   skeletonArray =  kinect.getSkeletonDepthMap();
 
  getDataSkeleton();
  
  nya.beginTransform(0);
    pushMatrix();
      rotate(angle);
      stroke(0);
      strokeWeight(2);
      rotateX(HALF_PI);
      rotateY(PI);
      /*
      line(0,0,0,100,0,0);
      textFont(font,20.0); text("X",100,0,0);
      line(0,0,0,0,100,0);
      textFont(font,20.0); text("Y",0,100,0);
      line(0,0,0,0,0,100);
      textFont(font,20.0); text("Z",0,0,100);
      */
      drawBody();
     // box(20);
    popMatrix();
  nya.endTransform();

angle+=0;
}




