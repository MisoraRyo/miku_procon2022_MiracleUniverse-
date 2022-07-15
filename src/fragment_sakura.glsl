uniform float uTime1;
uniform float uTime2;
uniform float uTime3;
uniform float uTime4;
uniform float uTime5;
uniform vec3 uColor;
uniform sampler2D uTexture;
///////////////////////////////////////////////////////////////////////////////////////////////
void main(){

  vec4 texcel = texture2D(uTexture, gl_PointCoord);

  vec3 white = vec3(1.0, 1.0, 1.0);
  vec3 fcolor = mix(white,uColor, smoothstep(0.88, 1.0, (uTime1+uTime2+uTime3+uTime4+uTime5)/5.0));
  gl_FragColor = vec4(fcolor, 1.0) * texcel;

}


