import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;
import java.util.Iterator;


//---------------------------
// Il y a un bug qui fait que l'on doit rebooter plusieurs fois avant d'avoir
// les données sur Z, voirs si on peut améliore avec une méthode getRawDepth.
//**************************


//pas utilisé pour l'instant
float ratio=1;


ArrayList<ParticleSystem> systems;

KinectPV2 kinect;

HandController LeftBox = new HandController();
HandController RightBox = new HandController();




void setup() {


  //valeurs de kinect initial res 512 x 424
    size(1920, 1080, P3D);



    //initialisation kinect
    kinect = new KinectPV2(this);

    //pour récupérer les données de profondeur uniquement.
    kinect.enableSkeletonDepthMap(true);

    kinect.enableColorImg(true);
    kinect.enableSkeletonColorMap(true);
  
    kinect.init(); 

    
    //particules system
    systems=new ArrayList<ParticleSystem>();
}



void draw(){

    
    background(0);

    //image vidéo
    image(kinect.getColorImage(), 0, 0, width, height);
 
    //obtention des données dans kinectwork
    getSkeletonZ();
    getDataSkeleton();

    //drawScene dessine les mains et donne les conditions sur celles ci.          
    drawScene();


    for(ParticleSystem ps: systems){
        ps.run();
        ps.addParticle();
    }

}


void mousePressed(){

  //Réinitialisatio Kinect
    background(0);

    kinect = new KinectPV2(this);
    //pour récupérer les données de profondeur uniquement.
    kinect.enableSkeletonDepthMap(true);
    kinect.enableColorImg(true);
    kinect.enableSkeletonColorMap(true);
    
    kinect.init(); 
}


void keyPressed(){
  println(keyCode);
  if(keyCode== 32){ //32 for space bar
  //Clear
    systems=new ArrayList<ParticleSystem>();
    println("clear" + systems.size());
  }
}