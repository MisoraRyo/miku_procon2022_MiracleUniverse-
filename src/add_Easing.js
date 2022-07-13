//////////////////////////////////////////////////

//textで使用中
export function easeOutExpo(x) {
  return x === 1 ? 1 : 1 - Math.pow(2, -10 * x);
}
//
export function easeOutSine(x) {
  return Math.sin((x * Math.PI) / 2);
}
