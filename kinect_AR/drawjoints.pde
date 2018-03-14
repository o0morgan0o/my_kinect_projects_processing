    float radiusMainArticulations;
    float radiusJoints;
    float radiusHead;
    float scaleDisplay;
ArrayList<KSkeleton> skeletonArray;

//joint unique
Articulation LeftHand       = new Articulation();
Articulation RightHand      = new Articulation();
Articulation LeftFoot       = new Articulation();
Articulation RightFoot      = new Articulation();
Articulation Head           = new Articulation();


//joint a liens
Articulation Neck           = new Articulation();
Articulation SpineShoulder  = new Articulation();
Articulation ShoulderRight  = new Articulation();
Articulation ShoulderLeft   = new Articulation();
Articulation SpineMid       = new Articulation();
Articulation SpineBase      = new Articulation();
Articulation HipRight       = new Articulation();
Articulation HipLeft        = new Articulation();
Articulation ElbowRight     = new Articulation();
Articulation ElbowLeft      = new Articulation();
Articulation WristRight     = new Articulation();
Articulation WristLeft      = new Articulation();
Articulation HandTipRight   = new Articulation();
Articulation HandTipLeft    = new Articulation();
Articulation ThumbRight     = new Articulation();
Articulation ThumbLeft      = new Articulation();
Articulation AnkleRight     = new Articulation();
Articulation AnkleLeft      = new Articulation();
Articulation KneeRight      = new Articulation();
Articulation KneeLeft       = new Articulation();



void skeletonInitValCol(){
      
    scaleDisplay=1;
    radiusMainArticulations= 3;
    radiusJoints=1;
    radiusHead=4;

  LeftHand.radius = radiusMainArticulations;
  RightHand.radius = radiusMainArticulations;
  LeftFoot.radius = radiusMainArticulations;
  RightFoot.radius = radiusMainArticulations;
  Head.radius = radiusHead;
  Head.col = color(100,0,0);
  LeftFoot.col = color(100,0,0);
  RightFoot.col= color(100,0,0);
}


void getDataSkeleton(){

    //get the skeletons as an Arraylist of KSkeletons
      ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();
      for (int i = 0; i < skeletonArray.size(); i++) {
        KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
        if (skeleton.isTracked()) {
          KJoint[] joints = skeleton.getJoints();
          color col  = skeleton.getIndexColor();
        
          fill(col);
          stroke(col);
          
          //récupore état de la main (ouvert ou fermé)
          RightHand.updateColor(joints[KinectPV2.JointType_HandRight]);
          LeftHand.updateColor(joints[KinectPV2.JointType_HandLeft]);

          //update la position des mains
          RightHand.updatePosition(joints[KinectPV2.JointType_HandRight]);
          LeftHand.updatePosition(joints[KinectPV2.JointType_HandLeft]);
          RightFoot.updatePosition(joints[KinectPV2.JointType_FootRight]);
          LeftFoot.updatePosition(joints[KinectPV2.JointType_FootLeft]);
          Head.updatePosition(joints[KinectPV2.JointType_Head]);

          Neck.updatePosition(joints[KinectPV2.JointType_Neck]);          
          SpineShoulder.updatePosition(joints[KinectPV2.JointType_SpineShoulder]);
          ShoulderRight.updatePosition(joints[KinectPV2.JointType_ShoulderRight]); 
          ShoulderLeft.updatePosition(joints[KinectPV2.JointType_ShoulderLeft]);  
          SpineMid.updatePosition(joints[KinectPV2.JointType_SpineMid]);      
          SpineBase.updatePosition(joints[KinectPV2.JointType_SpineBase]);     
          HipRight.updatePosition(joints[KinectPV2.JointType_HipRight]);      
          HipLeft.updatePosition(joints[KinectPV2.JointType_HipLeft]);       
          ElbowRight.updatePosition(joints[KinectPV2.JointType_ElbowRight]);    
          ElbowLeft.updatePosition(joints[KinectPV2.JointType_ElbowLeft]);     
          WristRight.updatePosition(joints[KinectPV2.JointType_WristRight]);    
          WristLeft.updatePosition(joints[KinectPV2.JointType_WristLeft]);     
          HandTipRight.updatePosition(joints[KinectPV2.JointType_HandTipRight]);  
          HandTipLeft.updatePosition(joints[KinectPV2.JointType_HandTipLeft]);   
          ThumbRight.updatePosition(joints[KinectPV2.JointType_ThumbRight]);    
          ThumbLeft.updatePosition(joints[KinectPV2.JointType_ThumbLeft]);     
          AnkleRight.updatePosition(joints[KinectPV2.JointType_AnkleRight]);    
          AnkleLeft.updatePosition(joints[KinectPV2.JointType_AnkleLeft]);     
          KneeRight.updatePosition(joints[KinectPV2.JointType_KneeRight]);     
          KneeLeft.updatePosition(joints[KinectPV2.JointType_KneeLeft]);      

        }
      }
}


//draw the body
void drawBody() {

      LeftHand.display();
      RightHand.display();
      Head.display();



  drawBone(Head, Neck);
  drawBone(Neck, SpineShoulder);
  drawBone(SpineShoulder, SpineMid);
  drawBone(SpineMid, SpineBase);
  drawBone(SpineShoulder, ShoulderRight);
  drawBone(SpineShoulder, ShoulderLeft);
  drawBone(SpineBase, HipRight);
  drawBone(SpineBase, HipLeft);

  // Right Arm
  drawBone(ShoulderRight, ElbowRight);
  drawBone(ElbowRight, WristRight);
  drawBone(WristRight, RightHand);
  drawBone(RightHand, HandTipRight);
  drawBone(WristRight, ThumbRight);

  // Left Arm
  drawBone(ShoulderLeft, ElbowLeft);
  drawBone(ElbowLeft, WristLeft);
  drawBone(WristLeft, LeftHand);
  drawBone(LeftHand, HandTipLeft);
  drawBone(WristLeft, ThumbLeft);

  // Right Leg
  drawBone(HipRight, KneeRight);
  drawBone(KneeRight, AnkleRight);
  drawBone(AnkleRight, RightFoot);

  // Left Leg
  drawBone(HipLeft, KneeLeft);
  drawBone(KneeLeft, AnkleLeft);
  drawBone(AnkleLeft, LeftFoot);


  drawFeet(AnkleLeft, LeftFoot);
  drawFeet(AnkleRight, RightFoot);

}


void drawFeet(Articulation a1, Articulation a2){
  pushMatrix();
  float xoff = a2.position.x + (a1.position.x-a2.position.x)*0.5;
  float yoff = a2.position.y + (a1.position.y-a2.position.y)*0.5;
  float zoff = a2.position.z + (a1.position.z-a2.position.z)*0.5;
    translate(xoff, yoff, zoff);
    fill(0);
    box(4,0.2,2);
  popMatrix();

}


//draw a bone from two joints
void drawBone(Articulation a1, Articulation a2) {
  a1.display();
  stroke(0,0,100);
  line(a1.position.x, a1.position.y , a1.position.z, a2.position.x, a2.position.y, a2.position.z);
}



/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */

//Depending on the hand state change the color
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(100, 100, 100);
    break;
  }
}

