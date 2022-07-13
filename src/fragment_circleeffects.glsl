#define linearstep(edge0, edge1, x) min(max(((x) - (edge0)) / ((edge1) - (edge0)), 0.0), 1.0)

uniform float uTime;
uniform vec3 uColor;
uniform sampler2D u_texture;

float circularIn(float t) {
  return 1.0 - sqrt(1.0 - t * t);
}

void main(){
  
  vec4 texcel = texture2D(u_texture, gl_PointCoord);
  float v = circularIn(linearstep(0.8, 1.0, uTime));

  gl_FragColor = vec4(uColor, 1.0 - v ) * texcel;

}


