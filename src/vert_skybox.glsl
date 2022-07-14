  
varying vec2 vUv;
varying vec2 repeat_vUv;

void main() {

    //通常
    vUv = uv;
    //星画像用のマッピング
    repeat_vUv =  vec2(uv.x*10.0, uv.y*5.0); // 2:1なので

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position,1.0);
}