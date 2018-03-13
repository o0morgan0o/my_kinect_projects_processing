class HandController{

    float radius;

    PVector position = new PVector(0,0,0);
    color col;

    //coeff for scaling the position data
        float minX= -1;
        float maxX= 1;
        float minY= -1;
        float maxY=1;
        float minZ=0;
        float maxZ= 3;
    //-------------------------------


    String state = "unknown";

    HandController(){

        radius=12;
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
       
        float xJoint = joint.getX();
        float yJoint = joint.getY();
        position.x= xJoint;
        position.y = yJoint;
 
    }

    void updateZ(KJoint joint){
        println("getZ Ok");
        float zJoint = map(joint.getZ(), minZ,maxZ, 0.0, 1.0);
        position.z = zJoint;
        //z vas de 30 a 100 environ en pratique
    }




    void handHud(){
        stroke(col);
        fill(col);
        pushMatrix();

            translate(position.x, position.y);
            ellipse(0,0,radius,radius);
            translate(20,-20);
            fill(col);
            noStroke();
            rect(0,0,30,30);
            fill(255);
            translate(10,0);
            stroke(255);
            textSize(32);
            text(isNewColor,0,0);
       
            
        popMatrix();
    }


    void displayPosition(){

        fill(255,128,0);
        String posX = nf(position.x,0,2);
        String posY = nf(position.y,0,2);
        String posZ = nf(position.z,0,2);

        stroke(0);
        fill(0);
        textSize(14);
        text("X: "+posX + " // Y: " + posY+ " // Z: " + posZ + " // State: " + state, 0,0);
        noStroke();
        noFill();
        //text("x: "+nf(position.x,2) + " // y:" + nf(position.y,2) + " // z: " + nf(position.z,2), 10, 15);
    }
}