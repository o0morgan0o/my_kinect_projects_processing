import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;
import java.util.Iterator;



Particle p;


ArrayList<ParticleSystem> systems;

KinectPV2 kinect;


HandController LeftBox = new HandController();
HandController RightBox = new HandController();

void settings(){
   size(1280, 720,P3D); // 3D
   smooth(8);

}


void setup() {

  camera_setup();

    //initialisation kinect
    kinect = new KinectPV2(this);
    kinect.enableDepthMaskImg(true);
    kinect.enableSkeletonDepthMap(true);
    kinect.enableSkeleton3DMap(true);
    kinect.init();
    
    //il faudra régler des lumières ici
  //  lights();
    
    //particules system
    systems=new ArrayList<ParticleSystem>();

}



void draw() {

    camera_draw();

    background(0);
    getDataSkeleton();
    drawScene();

    for(ParticleSystem ps: systems){
        ps.run();
        ps.addParticle(LeftBox);
    }


}


void mouseClicked(){
  //  systems.add(new ParticleSystem());

}




