import gab.opencv.*;
import KinectPV2.*;

//faire un son et que la fft change en direct le threeshold sur le beat


KinectPV2 kinect;
OpenCV opencv;

PGraphics pg;

float polygonFactor = 5.1;

int threshold = 19;

//Distance in cm
int maxD = 1200; //4.5m
int minD = 0; //50cm

boolean    contourBodyIndex = false;

void setup() {
  
  size(524, 424, P3D);
  gui();
  pg=createGraphics(width, height);
  opencv = new OpenCV(this, 512, 424);
  kinect = new KinectPV2(this);

  kinect.enableDepthImg(true);
  kinect.enableBodyTrackImg(true);
  kinect.enablePointCloud(true);

  kinect.init();



}

void draw() {
  threshold = floor(cp5.getController("threshold").getValue());
  minD = floor(cp5.getController("minD").getValue());
  maxD = floor(cp5.getController("maxD").getValue());
  polygonFactor = floor(cp5.getController("polyFact").getValue());

//  background(0);
  pg.beginDraw();
  pg.background(0,20);
  pg.endDraw();
  image(pg,0,0);
  
  //noFill();
  fill(200,200,0,20);
  strokeWeight(10);

  if (contourBodyIndex) {
    opencv.loadImage(kinect.getBodyTrackImage());
    opencv.gray();
    opencv.threshold(threshold);
    PImage dst = opencv.getOutput();
   // image(dst, 0, 0);
  } else {
    opencv.loadImage(kinect.getPointCloudDepthImage());
    opencv.gray();
    opencv.threshold(threshold);
    PImage dst = opencv.getOutput();
  //  image(dst, 0, 0);
  }

  ArrayList<Contour> contours = opencv.findContours(false, false);

  if (contours.size() > 0) {
    for (Contour contour : contours) {

      contour.setPolygonApproximationFactor(polygonFactor);
      if (contour.numPoints() > 50) {

        stroke(200, 200, 0);
        beginShape();

        for (PVector point : contour.getPolygonApproximation ().getPoints()) {
          vertex(point.x, point.y);
        }
        endShape();
      }
    }
  }

  noStroke();
  fill(0);
  rect(0, 0, 130, 100);
  fill(255, 0, 0);
  text("fps: "+frameRate, 20, 20);
  text("threshold: "+threshold, 20, 40);
  text("minD: "+minD, 20, 60);
  text("maxD: "+maxD, 20, 80);

  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);

}