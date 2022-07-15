uniform float uPixelRation;
uniform vec3 uColor;
///////////////////////////////////////////////////////////////////////////////////////////////
void main(){

  gl_PointSize = 3.0 * uPixelRation;//6.0
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

}