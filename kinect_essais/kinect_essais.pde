import KinectPV2.*;
KinectPV2 kinect;


void setup() {
  size(900, 768, P3D);
  kinect = new KinectPV2(this);
  kinect.enableColorImg(true);
  kinect.enableDepthImg(true);
  kinect.enableInfraredImg(true);
  kinect.enableBodyTrackImg(true);
  kinect.enableInfraredLongExposureImg(true);
  kinect.enableHDFaceDetection(true);
  kinect.enableDepthMaskImg(true);
  kinect.enablePointCloud(true);
  kinect.init();
}



void draw(){
  
  
  background(0);    
   //image(kinect.getDepthImage(), 0, 0);   
   //image(kinect.getColorImage(),0,0);
   //image(kinect.getInfraredImage(),0,0);
   //image(kinect.getBodyTrackImage(),0,0);
   //image(kinect.getInfraredLongExposureImage(),0,0);
   //image(kinect.getDepthMaskImage(),0,0);
   //image(kinect.getDepth256Image(), 512, 0);
    image(kinect.getPointCloudImage(),0,0);
   
   
      //  int [] rawData = kinect.getRawDepthData();
      //println(rawData);
    
}

void mousePressed(){
 saveFrame(); 
}