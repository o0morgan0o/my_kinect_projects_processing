
class ParticleSystem{
    PVector origin;
    ArrayList<Particle> particles;
    HandController h;

    ParticleSystem(){

        particles= new ArrayList();

    }

    void addParticle(HandController hand){
        particles.add(new Particle(hand));
    }

    void run(){
        Iterator<Particle> it = particles.iterator();
    while(it.hasNext()){
        Particle p = it.next();
        p.run();
            if(p.isDead()){
                it.remove();
            }
    }
    }

}


class Particle{



    PVector position = new PVector(0,0,0);
    PVector velocity;
    PVector acceleration;
    float lifespan;


    Particle(HandController hand){
      
      position = new PVector(hand.position.x, hand.position.y, hand.position.z);
      velocity=new PVector(random(-3.0,2.0), random(-5.0,0),random(-2.0,2.0));
      acceleration= new PVector(0,0.5);
      lifespan=255;

    }

    void run(){
        update();
        display();
    }

    void update(){ 

        position.add(velocity);
        velocity.add(acceleration);
        lifespan-= 2;
    

    }


    void display(){
        pushMatrix();
        translate(position.x, position.y, position.z);
        fill(255);
        noStroke();
        sphere(5);
        popMatrix();
    }

    boolean isDead(){
        return(lifespan<0);
    }



    
}