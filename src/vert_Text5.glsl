#define linearstep(edge0, edge1, x) min(max(((x) - (edge0)) / ((edge1) - (edge0)), 0.0), 1.0)

uniform float uPixelRation;
uniform float u_count;//テキスト画像が表示された回数のカウントアップ
uniform float c_step;
uniform float c_stepB;
uniform sampler2D uTexture;
uniform float cameraLength;

attribute vec3 speed;

varying vec2 vUv;
varying vec2 ScrollvUv;


float circularIn(float t) {
  return 1.0 - sqrt(1.0 - t * t);
}

void main(){
  
  //通常のテクスチャ画像
  vUv = uv;
  //スクロールテクスチャ用の座標
  ScrollvUv = vec2(uv.x*0.5, uv.y);

  vec4 modelPostion = modelMatrix * vec4( position.x, position.y, position.z , 1.0 );


  modelPostion.x += (speed.x - 0.5) * 24.0 * circularIn(linearstep(0.8, 1.0, c_stepB));
  modelPostion.y += speed.y * 10.0 * circularIn(linearstep(0.8, 1.0, c_stepB));
  modelPostion.z += (speed.z - 0.5) * 24.0 * circularIn(linearstep(0.8, 1.0, c_stepB));


  vec4 viewPostion = viewMatrix * modelPostion;

  // 18
  float PointSize = 8.0 * uPixelRation * ( 100.0 / length( cameraLength ) );
  float finalSize = mix(PointSize, 0.0, circularIn(linearstep(0.7, 1.0, c_stepB)));
  gl_PointSize = finalSize;

  gl_Position = projectionMatrix * viewPostion;

	
}