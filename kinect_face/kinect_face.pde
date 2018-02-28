
import KinectPV2.*;
Walker[] walkers; 
KinectPV2 kinect;
boolean isWalker=false;
ArrayList<HDFaceData> hdFaceData;

float sumX, sumY;
float avgX, avgY;
PVector v;
color col1;
float alpha=255;

void setup() {
  size(960, 540);
  walkers= new Walker[6]; 
  kinect = new KinectPV2(this);

  //enable HD Face detection
  kinect.enableHDFaceDetection(true);
  //kinect.enableColorImg(true); //to draw the color image
  kinect.init();
  //frameRate(60);
  col1=color(random(255),random(255),random(255));
}



void draw() {


pushMatrix();
scale(0.5);
translate(-width,0);
scale(2);
  background(0);



  //image(kinect.getColorImage(), 0, 0);


  // 1347 Vertex Points for each user.
  hdFaceData = kinect.getHDFaceVertex();

  for (int j = 0; j < hdFaceData.size(); j+=16) {

    HDFaceData HDfaceData = (HDFaceData)hdFaceData.get(j);

    if (HDfaceData.isTracked()) {


      beginShape(POINTS);
      for (int i = 0; i < KinectPV2.HDFaceVertexCount; i++) {

        float x = HDfaceData.getX(i);
        float y = HDfaceData.getY(i);
        strokeWeight(5);
        stroke(255);



        vertex(x, y);
        if (mousePressed) {
            col1=color(random(255),random(255),random(255));
          alpha=255;
          sumX=0;
          sumY=0;

          isWalker=true;
          walkers[0]= new Walker(HDfaceData.getX(1136), HDfaceData.getY(1136)); 
          walkers[1]= new Walker(HDfaceData.getX(1324), HDfaceData.getY(1324)); 
          walkers[2]= new Walker(HDfaceData.getX(1322), HDfaceData.getY(1322)); 
          walkers[3]= new Walker(HDfaceData.getX(10), HDfaceData.getY(10)); 
          walkers[4]= new Walker(HDfaceData.getX(1342), HDfaceData.getY(1342)); 
          walkers[5]= new Walker(HDfaceData.getX(1146), HDfaceData.getY(1146)); 

          for (int k=0; k<walkers.length; k++) {
            sumX +=walkers[k].x;
            sumY +=walkers[k].y;
          }
          avgX=sumX/walkers.length;
          avgY=sumY/walkers.length;
        }
      }
      endShape();
    }
  }

  if (isWalker) {
    stroke(col1);
    fill(col1,alpha);




    beginShape();
    for (int i=0; i<walkers.length; i++) {

      vertex(walkers[i].x, walkers[i].y);   

      v = new PVector(walkers[i].x-avgX, walkers[i].y-avgY);

      walkers[i].step(v);
      walkers[i].render();
    }
    vertex(walkers[0].x, walkers[0].y);
    //vertex(avgX,avgY);
    endShape();
  }
  popMatrix();
  
  alpha-=1;
}