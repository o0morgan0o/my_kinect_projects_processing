
class ParticleSystem{
    PVector origin;
    ArrayList<Particle> particles;
    HandController h;
    float depthSystem=0;
    int r;
    int g;
    int b;


    ParticleSystem(HandController hand){
        
        h=hand;
        origin = h.position.get();
        particles= new ArrayList();
        depthSystem= origin.z;

        r=randomRed;
        g=randomGreen;
        b=randomBlue;
    }

    void addParticle(){
        particles.add(new Particle(h,origin, r, g, b));
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
    float depthPart = 100;
    int r;
    int g;
    int b;

    Particle(HandController hand, PVector l, int red, int green, int blue){
      
      position = l.get();
      velocity=new PVector(random(-3.0,2.0), random(-5.0,0),0);
      acceleration= new PVector(0,0.5);
      lifespan=255;
      r=red;
      g=green;
      b= blue;
      
      // mappage de la taille des part en fonction de la profondeur pour effet 3d
      depthPart= position.z;

    }

    void run(){
        update();
        display();
    }

    void update(){ 

        position.add(velocity);
        velocity.add(acceleration);
        lifespan-= 20;
    

    }


    void display(){
        pushMatrix();
        translate(position.x, position.y);
        fill(r/depthPart,g,b);
        noStroke();
        
        //avec une bordure c'est cool.
        //stroke(255,lifespan);
        //strokeWeight(2);
        
        float rad=10/ (depthPart*depthPart); //calul du radius en fonction de la profondeur
        ellipse(0, 0,rad,rad);
        popMatrix();
    }

    boolean isDead(){
        return(lifespan<0);
    }



    
}