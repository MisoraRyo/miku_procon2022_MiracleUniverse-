#define linearstep(edge0, edge1, x) min(max(((x) - (edge0)) / ((edge1) - (edge0)), 0.0), 1.0)

uniform float u_time;
uniform float u_exp;

uniform vec3 u_topColor;
uniform vec3 u_bottomColor;

uniform vec3 u_endTopColor;
uniform vec3 u_endBottomColor;


varying vec2 vUv;
varying vec2 repeat_vUv;

uniform sampler2D uTexture;//星空の画像のデータ
uniform sampler2D uTextureB;//雲の画像のデータ

//
float circularIn(float t) {
  return 1.0 - sqrt(1.0 - t * t);
}

///////////////////////////////////////////////////////////////////////////////////////////////
void main() {
  
  //テクスチャ 
  vec4 tColor = texture2D(uTexture, repeat_vUv).rgba;
  vec4 cColor = texture2D(uTextureB, vUv).rgba;

  //TOP色 ENDカラーと線形補完
  vec3 topColor = mix(u_topColor, u_endTopColor, smoothstep(0.45, 1.0, u_time) );
  //BOTTOM色　ENDカラーと線形補完
  vec3 bottomColor = mix(u_bottomColor, u_endBottomColor, smoothstep(0.45, 1.0, u_time) );
  //線形補間
  vec4 color = vec4( mix(bottomColor, topColor, pow(vUv.y, u_exp)), 1.0 );


  //中央に伸びる光の線の追加 u_timeに応じで徐々に光が強くなる
  //
  //vec3 col = vec3 (1.0, 1.0, 1.0 ) * abs( ( circularIn(linearstep(0.975, 1.0, u_time))*.001 + 0.0002 ) / (vUv.y-0.5) );
  vec3 col = vec3 (1.0, 1.0, 1.0 ) * abs( ( 0.0002 ) / (vUv.y-0.5) );
  //vec3 colB = vec3 (.7, .7, .7 ) * abs( ( circularIn(linearstep(0.99, 1.05, u_time))*.00001 ) / clamp(vUv.y - 0.5, 0.0000001, 1.0) );
  vec3 colB = vec3 (.7, .7, .7 ) * abs( ( circularIn(linearstep(0.945, .97, u_time))*.00001 ) / clamp(vUv.y - 0.5, 0.0000001, 1.0) );
  vec4 colLibe = vec4(col+colB, 1.0);


  //** grid **
  float divisionsX = 32.0;  //X分割数
  float divisionsY = 16.0;  //Y分割数
  float thickness = 0.0008; //明るさ
  //float delta = 0.05 / 2.0;   
  //
  float x = fract(vUv.x * divisionsX);
  x = min(x, 1.0 - x);
  //
  float xdelta = fwidth(x);
  x = smoothstep(x - xdelta, x + xdelta, thickness);
  //
  float y = fract(vUv.y * divisionsY);
  y = min(y, 1.0 - y);
  //
  float ydelta = fwidth(y);
  y = smoothstep(y - ydelta, y + ydelta, thickness);
  //
  float grid = clamp(x + y, 0.0, 1.0);
  vec4 gridColor = vec4(.408, .443, .6, 1.0);//0xb1bcec 0x8f99cc 0x687199
  
  //合成
  vec4 colorMix = color + tColor  + cColor + colLibe + gridColor*grid;
      
  //gl_FragColor = vec4( mix(color1, color2, pow(vUv.y, u_exp)), 1.0 );
  gl_FragColor = vec4( colorMix );

}