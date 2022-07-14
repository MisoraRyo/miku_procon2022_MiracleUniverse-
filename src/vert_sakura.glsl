uniform float uPixelRation;
uniform float uTime1;
uniform float uTime2;
uniform float uTime3;
uniform float uTime4;
uniform float uTime5;
uniform vec3 uColor;
uniform sampler2D uTexture;

attribute vec3 firstPosition;
attribute vec3 secPosition;
attribute vec3 thirdPosition;
attribute vec3 fourthPosition;
attribute vec3 finalPosition;

///////////////////////////////////////////////////////////////////////////////////////////////

void main(){

  float finalSize = mix(2.5*uPixelRation, 10.0*uPixelRation, smoothstep(0.70, 1.0, (uTime1+uTime2+uTime3+uTime4+uTime5)/5.0));//6.0 24.0
  gl_PointSize = finalSize;

  vec3 firstPos = mix(position, firstPosition, uTime1);
  vec3 secPos = mix(firstPos, secPosition, uTime2);
  vec3 thirdPos = mix(secPos, thirdPosition, uTime3);
  vec3 fourthPos = mix(thirdPos, fourthPosition, uTime4);
  vec3 finalPos = mix(fourthPos, finalPosition, uTime5);

  gl_Position = projectionMatrix * modelViewMatrix * vec4(finalPos, 1.0);
  

}