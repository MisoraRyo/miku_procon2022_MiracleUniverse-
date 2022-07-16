uniform float u_count;//テキスト画像が表示された回数のカウントアップ
uniform float c_step;//In_掲載時間を0~1（easing）にしたもの
uniform float c_stepB;//Out_掲載時間を0~1（easing）にしたもの
uniform sampler2D uTexture;//文字画像のデータ
uniform sampler2D udisplayment;//変換画像のデータその１
//uniform sampler2D u_outdisplayment;//変換画像のデータその２

varying vec2 ScrollvUv;
varying vec2 vUv;
float PI = 3.14159265;


//回転行列
mat2 rotate2d(float _angle){
  //mat2二次元配列
  return mat2( cos(_angle),-sin(_angle), sin(_angle),cos(_angle));
}
//
float random (in float x) {
    return fract(sin(x)*1e4);
}
//
float random (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}
//
float randomSerie(float x, float freq, float t) {
    return step(.8,random( floor(x*freq)-floor(t) ));
}

void main(){
  //
  vec4 disp = texture2D(udisplayment, ScrollvUv + vec2( sin(u_count) * 0.25 + 0.25, 0.0 ) );

  //
  float alpha = disp.r * 0.2 + disp.g * 0.7 + disp.b * 0.1;
  
  if (alpha > 1.0 - c_step ) {
    //
    float r = texture2D( uTexture, vUv + vec2( 0.015 - c_step*0.015, 0.015 - c_step*0.015 )  + rotate2d(PI) * vec2(disp.r, 0.0) * (1.0 - c_step) * 0.1 ).r;
    //
    float g = texture2D( uTexture, vUv + vec2( 0.001 - c_step*0.001, 0.001 - c_step*0.001 ) + rotate2d(PI) * vec2(disp.r, 0.0) * (1.0 - c_step) * 0.1 ).g;
    //
    float b = texture2D( uTexture, vUv - vec2( 0.015 - c_step*0.015, 0.015 - c_step*0.015 ) + rotate2d(PI) * vec2(disp.r, 0.0) * (1.0 - c_step) * 0.1 ).b;
    float a = texture2D( uTexture, vUv).a;
    
    //
    vec4 color = vec4( r, g, b, a );
    float alphatest = color.r * 0.2 + color.g * 0.7 + color.b * 0.1;
    
    if(alphatest < 0.01){
      discard;
    }
    gl_FragColor = vec4(color.r,color.b,color.g, color.a - c_stepB);

  }else{
    discard;
  }

}