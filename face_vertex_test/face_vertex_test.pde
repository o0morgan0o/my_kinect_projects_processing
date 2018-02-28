
import KinectPV2.*;
Particle[] particles;
KinectPV2 kinect;
float tx=0;


void setup() {
  background(0);
  fullScreen();

  kinect = new KinectPV2(this);

  //enable HD Face detection
  kinect.enableHDFaceDetection(true);
  kinect.enableColorImg(true); //to draw the color image
  kinect.init();
  
  
    particles = new Particle[20];
  for (int i=0; i<particles.length; i++){
    particles[i] =new Particle();
}

  
  
}

void draw() {

  imageMode(CENTER);

  //image(kinect.getColorImage(),width/2, height/2);

  ArrayList<HDFaceData> hdFaceData = kinect.getHDFaceVertex();
  background(0);
     scale(1.5,1.5);
  for (int j = 0; j < hdFaceData.size(); j++) {
    //obtain a the HDFace object with all the vertex data
    HDFaceData HDfaceData = (HDFaceData)hdFaceData.get(j);

    if (HDfaceData.isTracked()) {

      //draw the vertex points
   
      stroke(255, 255,255);

      strokeWeight(2);
      beginShape(POINTS);
      for (int i = 0; i < KinectPV2.HDFaceVertexCount; i++) {
        float x = HDfaceData.getX(i);
        float y = HDfaceData.getY(i);
        vertex(x, y);
        
        
        //if(i< KinectPV2.HDFaceVertexCount-1){
        //float x2 = HDfaceData.getX(i+1);
        //float y2 = HDfaceData.getY(i+1);
        //stroke(125,0,0);
        //strokeWeight(0.5);
        //line(x,y,x2,y2);
        //}
        
        
    }
      endShape();

    }
  }
  for (int i=0; i< particles.length; i++){
  particles[i].display();
  particles[i].move();
}
}