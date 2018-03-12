
void getDataSkeleton(){
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      color col  = skeleton.getIndexColor();
     
      fill(col);
      stroke(col);
      

      //récupore état de la main (ouvert ou fermé)
      RightBox.updateColor(joints[KinectPV2.JointType_HandRight]);
      LeftBox.updateColor(joints[KinectPV2.JointType_HandLeft]);


      //update la position des mains
      RightBox.updatePosition(joints[KinectPV2.JointType_HandRight]);
      LeftBox.updatePosition(joints[KinectPV2.JointType_HandLeft]);

    }
  }
}


//obtention des données de profondeur qu'on a pas avec la méthode précédente
void getSkeletonZ(){

      ArrayList<KSkeleton> skeletonArrayZ =  kinect.getSkeleton3d();
      for (int i = 0; i < skeletonArrayZ.size(); i++) {
        KSkeleton skeleton = (KSkeleton) skeletonArrayZ.get(i);
        if (skeleton.isTracked()) {
          KJoint[] joints = skeleton.getJoints();


        println("trying to get Z -3");
          //update la position des mains
          RightBox.updateZ(joints[KinectPV2.JointType_HandRight]);
          LeftBox.updateZ(joints[KinectPV2.JointType_HandLeft]);
    }
  }
}


























