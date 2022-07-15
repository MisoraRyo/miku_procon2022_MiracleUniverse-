
uniform float u_beat;
uniform float u_changeTime;
uniform vec3 u_color;
uniform vec3 u_changeColor;

//varying vec2 vUv;

void main(){

  vec3 fcolor = mix(u_color, u_changeColor, u_beat - u_changeTime) ;
  gl_FragColor = vec4(fcolor, 0.2 + u_beat*0.3);
  
}