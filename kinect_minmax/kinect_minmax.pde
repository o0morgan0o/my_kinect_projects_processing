import KinectPV2.*;
KinectPV2 kinect;
PImage img;
float a=0;

float minThres=0;
float maxThres= 1000;

void setup(){
 size(512,424);
 kinect= new KinectPV2(this);
 kinect.enableDepthImg(true);
 kinect.init();
   img=createImage(kinect.WIDTHDepth, kinect.HEIGHTDepth, RGB);
}

void draw(){
 background(0);



img.loadPixels();
  
  //minThres= map(mouseX,0,width,0, 500);
  //maxThres= map(mouseY,0,width,0, 500);
  
  
  
  int[] depth= kinect.getRawDepthData();

   
   
  
   for(int x=0; x< kinect.WIDTHDepth; x++){
    for (int y=0; y<kinect.HEIGHTDepth; y++){
       int offset=x + y *kinect.WIDTHDepth;
       int d= depth[offset];
       
       if(d> 100 && d< 830){

       img.pixels[offset] = color(255,0,12);
       } else{
        img.pixels[offset] =color(0);
       }
       

} 
      
 }
  img.updatePixels();
  image(img,0,0);
//fill(255);
//textSize(32);
//Text(minThres + ' ' + maxThres);

  
}