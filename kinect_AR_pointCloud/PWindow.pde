
import controlP5.*;
ControlP5 cp5;
ControlWindow controlWindow;


class PWindow extends PApplet {
  
  public float echelleCloud= 120;
  public float testParam2 = 0.0;

  public boolean axesVisible = true;
  public boolean skeletonVisible = true;
  public boolean boxCloudVisible = false;

  public float sceneSize = 100;

  //Distance Threashold
 public int minD=200;
 public int maxD=1410;
  
  public float rotateFactorX = 0;
  public float rotateFactorY = 0;
  public float rotateFactorZ = 0;
  public float translationFactorX = 0;
  public float translationFactorY = 0;
  public float translationFactorZ = 0;


  public float correctionVerticCloud = 0.3;
  public float angleIncrement=0;

  public float ry = 0; // laisser a 0
  public float rz = 0; // laisser a 0


  //*************************************************
  //***********************************************


  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(500, 800);
  }

  void setup() {
    background(30);
  
  
  kinect = new KinectPV2(this);
  kinect.init();

  
  
    cp5 = new ControlP5(this);
    
    text("Scene reglages", 40,20);
    

      addASlider("minD",            1, 0,1500);
      addASlider("maxD",            2, 500,7000);
      addASlider("rotateFactorX",    3, -3.14,3.14);
      addASlider("rotateFactorY",    4, -3.14,3.14);
      addASlider("rotateFactorZ",    5, -3.14,3.14);
      addASlider("translationFactorX",6, -500,500);
      addASlider("translationFactorY",7, -500,500);
      addASlider("translationFactorZ",8, -500,500);
      addASlider("correctionVerticCloud",9, -0.5,0.5);
      addASlider("angleIncrement"    ,20, -0.2,0.2);
      addASlider("sceneSize"    ,21, 20,900);


      addASlider("echelleCloud", 23, 0,500);
      addASlider("testParam2", 24, -500,500);



       cp5.addBang("bang")
     .setPosition(40, 260)
     .setSize(60, 20)
     .setTriggerEvent(Bang.RELEASE)
     .setLabel("Toggle Axes")
     ;


        cp5.addBang("bang2")
     .setPosition(120, 260)
     .setSize(60, 20)
     .setTriggerEvent(Bang.RELEASE)
     .setLabel("Toggle Skeleton")
     ;


         cp5.addBang("bang3")
     .setPosition(200, 260)
     .setSize(60, 20)
     .setTriggerEvent(Bang.RELEASE)
     .setLabel("Toggle Box Cloud")
     ;

}


void addASlider(String str, int yposition, float minRange, float maxRange){

    cp5.addSlider(str)
     .setRange(minRange, maxRange)
     .setPosition(40, 20+yposition * 20)
     .setSize(200, 20)
     ;     

}


void bang() {
 if (axesVisible ==true){
   axesVisible =false;
 }else{
   axesVisible =true;
 }
}

void bang2(){
 if (skeletonVisible ==true){
   skeletonVisible =false;
 }else{
   skeletonVisible =true;
 }
}

void bang3(){
 if (boxCloudVisible ==true){
   boxCloudVisible =false;
 }else{
   boxCloudVisible =true;
 }
}

  void draw() {
    background(30);
   image(kinect.getDepthMaskImage(), 20, 300, 160, 120);

  }


void myTextfield(String theValue) {
 // println(theValue);
}

void myWindowTextfield(String theValue) {
//  println("from controlWindow: "+theValue);
}



}