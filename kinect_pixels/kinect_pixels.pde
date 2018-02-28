import KinectPV2.*;
KinectPV2 kinect;

void setup(){
 size(512,424, P3D);
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.enableBodyTrackImg(true);
  kinect.init();
 
}



void draw(){
 background(0);
   //  image(kinect.getBodyTrackImage(), 0, 0);
 
 PImage img = kinect.getDepthImage();
 //image(img,0,0);
  
  int skip=10;
  for(int x=0; x<img.width; x+=skip){
   for(int y=0; y<img.height; y+=skip){
     
     int index = x + y * img.width;
     float b = brightness(img.pixels[index]);
     float z = map(b,0,255,250,-250);
    // println(img.width);
     fill(255-b);
     pushMatrix();
     translate(x,y,z);
     //box(skip);
     rect(0,0, skip/2,skip/2);
     popMatrix();
   }
    
  }
  
}