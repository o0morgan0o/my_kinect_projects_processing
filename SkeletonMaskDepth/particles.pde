


class Particle{



    PVector position = new PVector(0,0,0);
    PVector velocity;
    PVector acceleration;


    Particle(HandController hand){
      
      position = new PVector(hand.position.x, hand.position.y, hand.position.z);
      velocity=new PVector(5,0,0);
      
    }

    void update(){ 

        position.add(velocity);

    

    }


    void display(){
        pushMatrix();
        translate(position.x, position.y, position.z);
        fill(255);
        stroke(2);
        sphere(50);
        popMatrix();
    }



    
}