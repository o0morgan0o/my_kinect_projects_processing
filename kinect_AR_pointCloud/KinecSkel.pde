    //coeff for scaling the position data
    float minX= -1;
    float maxX= 1;
    float minY= -1;
    float maxY=1;
    float minZ=0;
    float maxZ= 3;

class Articulation{

    float radius;
    PVector position = new PVector(0,0,0);
    color col;
    String state = "unknown";
    String stringPosition="unknown";

    Articulation(){
        col = color(100,0,0);
        radius=radiusJoints;
    }

    void updateColor(KJoint joint){
         switch(joint.getState()) {
        case KinectPV2.HandState_Open:
            col= color(0,255,0);
            state= "open";
            break;
        case KinectPV2.HandState_Closed:
            col =color(255, 0, 0);
            state ="closed";
            break;
        case KinectPV2.HandState_Lasso:
            col = color(0, 0, 255);
            state="lasso";
            break;
        case KinectPV2.HandState_NotTracked:
            col= color(100, 100, 100);
            state="notTracked";
            break;
        }
    }

    void updatePosition(KJoint joint){
        float sceneSize=100;
        //scale the position to the scene
        float xJoint = map(joint.getX(), minX,maxX, -sceneSize/2, sceneSize/2);
        float yJoint = map(joint.getY(), minY,maxY, 0, sceneSize);
        float zJoint = map(joint.getZ(), minZ,maxZ, -sceneSize/2, sceneSize/2);
        
        //rectification of y and z axis to be inverted
        position = new PVector(xJoint, yJoint, -1*zJoint); 
        position.mult(scaleDisplay);
  
        String posX = nf(position.x,0,2);
        String posY = nf(position.y,0,2);
        String posZ = nf(position.z,0,2);
        stringPosition= "X: "+posX + " // Y: " + posY+ " // Z: " + posZ + " // State: ";
    }


    void display(){
        pushMatrix();
        translate(position.x, position.y, position.z);
        fill(col);
        stroke(col);
        sphere(radius*scaleDisplay);
        popMatrix();
    }

}