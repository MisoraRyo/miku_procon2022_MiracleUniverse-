uniform float uPixelRation;
uniform float uTime;
uniform vec3 uColor;

attribute vec3 uSpeed;
attribute float uRadius;

//
float random (in float x) {
    return fract(sin(x)*1e4);
}
//
float random (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}
//////////////////////////////////////////////////////////////////////////////////////////////////

void main(){

  vec4 modelPostion =  modelMatrix * vec4(position, 1.0);
  
  gl_PointSize = ( 2.5 + 7.5 * random(position.x) ) * uPixelRation;

  vec3 speed = uSpeed;
  
  //modelPostion.x += speed.x * uTime + (10.0+uTime*40.0) * cos(uRadius) ;
  //modelPostion.y += speed.y * uTime ;
  //modelPostion.z += speed.z * uTime + (10.0+uTime*40.0) * sin(uRadius) ;
  modelPostion.x += (10.0+uTime*100.0) * cos(uRadius) ;
  modelPostion.y += speed.y * smoothstep(0.25, 1.0, uTime);
  modelPostion.z += (10.0+uTime*100.0) * sin(uRadius) ;

  vec4 viewPostion = viewMatrix * modelPostion;
  vec4 projectionPosotion = projectionMatrix * viewPostion;

  //vec4 mvPosition = viewPostion * vec4(position, 1.0);

  gl_Position = projectionPosotion;

}