uniform vec3 uColor;
uniform sampler2D u_texture;


void main(){

  vec4 texcel = texture2D(u_texture, gl_PointCoord);
  gl_FragColor = vec4(uColor, 1.0) * texcel;

}