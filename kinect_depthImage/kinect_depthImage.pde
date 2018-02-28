import KinectPV2.*;
KinectPV2 kinect;

float a=0;

void setup(){
 size(800,600,P3D);
 kinect= new KinectPV2(this);
 kinect.enableDepthImg(true);
 kinect.init();
   
}

void draw(){
 background(0);
 
 pushMatrix();
 //translate(width/2, height/2, -2250);
 
 translate(width/2, height/2, -2000);
  rotateY(a);
      
  int skip=5;
  int[] depth= kinect.getRawDepthData();
 
 stroke(255);
 strokeWeight(2);
 beginShape(POINTS);
 for(int x=0; x< kinect.WIDTHDepth; x+=skip){
  for (int y=0; y<kinect.HEIGHTDepth; y+=skip){
     int offset=x + y *kinect.WIDTHDepth;
     int d= depth[offset];
     
     
     float threshold=20;
     
     threshold=map(mouseX,0, width, 0,5000);
     //println(d);
     
     if (d < threshold){
       
     
     PVector point= depthToPointCloudPos(x,y,d);
     vertex(point.x,point.y,point.z); 
}  
} 
      
 }
  
   endShape();
   popMatrix();
   fill(255);
   text(frameRate,50,50);
   a+=0.015;
  
}


PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}