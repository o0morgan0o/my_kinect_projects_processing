class Line extends Particle {

    float length;

    Line(HandController hand, PVector l, color _col){
        super(hand, l, _col);
        col = color(255,255,255);
        acceleration = new PVector(random(0.005,-0.005),random(0.005,-0.005),0);
        velocity = PVector.random2D().normalize().mult(random(15));
        length = random(200);
    }

        void update(){
            position=position;
            lifespan-=50;
        }

        void display(){
        pushMatrix();
        translate(position.x, position.y);
        fill(col);
        noStroke();
        
        //avec une bordure c'est cool.
        stroke(col);
        float lineWeight=map(length, 0, 200,5,0.1);
        strokeWeight(lineWeight);
        
        line(0, 0,velocity.x*length,velocity.y*length);
        popMatrix();
    }

}