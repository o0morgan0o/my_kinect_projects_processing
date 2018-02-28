class Particle {
  float x;
  float y;
  
  float vx;
  float vy;

  Particle() {
    x = width/2;
    y = height/2;
    float a = random(TWO_PI);
    float speed = random(1,10);
    vx = cos(a)*speed ;
    vy = sin(a)*speed;
  }

  void display() {
    noStroke();

    fill(120,13,25);
    ellipse(x, y, mouseX/20, mouseX/20);
  }

  void move() {
    x = x + vx;//random(-5, 5);
    y = y + vy;//random(-5, 5);
    if (y < 0) {
      y = height;
    } 

    if (y > height) {
      y = 0;
    }
    if (x < 0) {
      x = width;
    } 

    if (x > width) {
      x = 0;
    }
  }
}