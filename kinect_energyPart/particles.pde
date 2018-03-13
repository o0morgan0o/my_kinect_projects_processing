
class ParticleSystem{
    PVector origin;
    ArrayList<Particle> particles;
    HandController h;
    float depthSystem=0;
    color col;
    PVector velocity;
    PVector acceleration;

    ParticleSystem(HandController hand){
        
        h=hand;
        origin = h.position.get();
        particles= new ArrayList();
        depthSystem= origin.z;
        col = color(255,100,50);

    }

    void addParticle(){
        particles.add(new Particle(h,origin, col));
        particles.add(new Line(h,origin, col));
        
    }

    void run(){
            origin= h.position.get();
            Iterator<Particle> it = particles.iterator();
              while(it.hasNext()){
                Particle p = it.next();
                p.run();
                    if(p.isDead() || p.position.y <-30){
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
    color col;

    Particle(HandController hand, PVector l, color _col){
      
      position = l.get();
      velocity=new PVector(random(-3.0,2.0), random(-5.0,0),0);
      acceleration= new PVector(0,0.5);
      lifespan=255;
      col = _col;
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
        lifespan-= 5;
    

    }


    void display(){
        pushMatrix();
        translate(position.x, position.y);
        fill(col,lifespan);
        noStroke();
        
        //avec une bordure c'est cool.
        stroke(255,50);
        strokeWeight(0.2);
        
        float rad=10/ (depthPart*depthPart); //calul du radius en fonction de la profondeur
        if(depthPart < 0.1){rad= 50;}
        ellipse(0, 0,rad,rad);
        popMatrix();
    }

    boolean isDead(){
        return(lifespan<0);
    }



    
}