// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A random walker object!

class Walker {
  float x, y;
  float tx, ty;
  

  float prevX, prevY;

  Walker(float X, float Y) {

    x = X;
    y = Y;
  }

  void render() {
    stroke(255,0,0);
    point(x, y);
  }

  // Randomly move according to floating point values
  void step(PVector V) {

    x += V.x * random(0.05) + random(-x/10, x/10);
    y += V.y * random(0.1) + random(-x/10, x/10);


  }
}