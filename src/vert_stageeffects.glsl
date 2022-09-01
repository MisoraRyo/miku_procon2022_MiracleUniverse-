uniform float uPixelRation;
uniform float uTime;
uniform vec3 uColor;

attribute vec4 uSpeed;


//////////////////////////////////////////////////////////////////////////////////////////////////

void main(){

  vec4 modelPostion =  modelMatrix * vec4(position, 1.0);

  vec4 speed = uSpeed;
  //
  gl_PointSize = (2.0 + speed.w * 5.0 )* uPixelRation;//max20=>max15

  modelPostion.x += speed.x + 3.0*sin( speed.w * 10.0 + uTime);
  modelPostion.y += 2.5 * speed.y + uTime;
  modelPostion.z += speed.z;+ 3.0*sin( speed.w * 10.0 + uTime);

  vec4 viewPostion = viewMatrix * modelPostion;
  vec4 projectionPosotion = projectionMatrix * viewPostion;

  //vec4 mvPosition = viewPostion * vec4(position, 1.0);

  gl_Position = projectionPosotion;

}