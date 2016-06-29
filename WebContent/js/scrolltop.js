
   var speed=50
   demo2.innerHTML=demo1.innerHTML
   function Marquee(){
   if(demo2.offsetTop-demo.scrollTop<=0)
   demo.scrollTop-=demo1.offsetHeight
   else{
   demo.scrollTop++
   }
   }
   var MyMar=setInterval(Marquee,speed)
   demo.onmouseover=function() {clearInterval(MyMar)}
   demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)}





//DOM 样式优化
$(document).ready(function() {
    $(".news .tabs").tabs(".news > div", {
    event:'mouseover', 
    tabs:'li'
  });
  $(".a5 li:last").css("width","265px");
    $(".focus").slides({
        preload: true,
        generateNextPrev: true,
        preloadImage: 'images/loading.gif',
        play: 5000,
        pause: 2500,
        hoverPause: true
    });
    $(".video").slides({
        preload: true,
        generateNextPrev: true,
        generatePagination: false,
        preloadImage: 'images/loading.gif',
        //play: 5000,
        //pause: 2500,
        hoverPause: true
    });
});
