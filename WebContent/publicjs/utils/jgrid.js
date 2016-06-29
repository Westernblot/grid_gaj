/**
 * 浏览器刷新
 * by ylw 2014.10.22
 */
function WindowReload(){
	window.location.reload();
}
/**
 * 浏览器前进/后退
 * @param step：前进后退的步数，正数为前进，负数为后退
 * by ylw 2014.10.22
 */
function WindowReload(step){
	window.location.go(step);
}
/**
 * 浏览器前进
 * by ylw 2014.10.22
 */
function WindowForward(){
	window.location.forward();
}
/**
 * 浏览器后退
 * by ylw 2014.10.22
 */
function WindowBack(){
	window.location.back();
}