PImage imgC;
import KinectPV2.*;
float radius;
KinectPV2 kinect;

public void setup() {
  size(1536, 848);
  kinect = new KinectPV2(this);
  kinect.enableColorImg(true);
  kinect.enableDepthImg(true);
  kinect.enableInfraredImg(true);
  kinect.enableInfraredLongExposureImg(true);
  kinect.enableBodyTrackImg(true);
  kinect.enableDepthMaskImg(true);
  
  frameRate(60);

  kinect.init();

  
  //imgC=createImage(kinect.WIDTHDepth,kinect.HEIGHTDepth, RGB);
  
  

}

public void draw() {
  radius = map(mouseY,0,height,0,10);
  background(0);

    PImage imgC =kinect.getColorImage();
 imgC.loadPixels();



background(0);
for(int x=0; x<imgC.width;x+=10){
 for(int y=0; y<imgC.height; y+=10){

  int index= x + y*imgC.width;
     if(x%10 ==0 && y%10==0){
   if(red(imgC.pixels[index])<map(mouseX,0,width,0,200)){

fill(red(imgC.pixels[index]),green(imgC.pixels[index]),blue(imgC.pixels[index]));

imgC.pixels[index]=color(255,0,0);
ellipse(x,y,radius,radius);
   }else{
    imgC.pixels[index]=color(0); 
     
   }
   }else{
     
    imgC.pixels[index]=color(0); 
   }
 }
  
}


updatePixels();

 // image(imgC, 0, 0,1024,780);

}