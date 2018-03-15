uniform mat4 transform;

attribute vec4 vertex;
attribute vec4 color;

varying vec4 vertColor;

void main() {
  gl_PointSize = 0.1;
  gl_Position = transform * vertex;    
  vertColor = vec4(1.0,.0,0.0, 1.);
}