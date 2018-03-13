import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;
import java.util.Iterator;


//---------------------------
// Il y a un bug qui fait que l'on doit rebooter plusieurs fois avant d'avoir
// les données sur Z, voirs si on peut améliore avec une méthode getRawDepth.
//**************************



ArrayList<ParticleSystem> systems;
HandController LeftBox = new HandController();
HandController RightBox = new HandController();


KinectPV2 kinect;

color newCol = color(255,0,0);
String isNewColor="";


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
//blendMode(ADD);
    
    background(0);

    image(kinect.getColorImage(), 0, 0, width, height);
    getSkeletonZ();
    getDataSkeleton();

    
    if(LeftBox.state=="open" && frameCount % 1 == 0){
                systems.add(new ParticleSystem(LeftBox));
                
                 if(systems.size() >80){
                   systems.remove(0);
                 }
    }

    //tirage d'une nouvelle couleur lorsque main droite est ouverte
    if(RightBox.state=="open" && frameCount % 1 == 0){
            newCol = color(floor(random(255)),floor(random(255)),floor(random(255)));
            isNewColor="New Color";
    }

    if(RightBox.state=="closed" && frameCount % 1 == 0){
                isNewColor="";
    }

    for(ParticleSystem ps: systems){
        ps.addParticle();
        ps.run();
    }


    displayGlobalHud();

}

void displayGlobalHud(){
    pushMatrix();
        strokeWeight(2);
        fill(255);
        rect(0,0,600,100);
        translate(0,40);
        LeftBox.displayPosition();
        translate(0,20);
        RightBox.displayPosition();
        translate(0,20);
        text(frameRate,0,0);
    popMatrix();
    RightBox.handHud();
}


void mousePressed(){

  //Réinitialisatio Kinect
    background(0);
    kinect = new KinectPV2(this);
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