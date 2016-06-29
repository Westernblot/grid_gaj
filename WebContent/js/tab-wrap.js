 window.onload=function(){
   var oTab=document.getElementById("tab-wrap");
   var oList=oTab.getElementsByTagName("ul")[0];
   var aLi=oTab.getElementsByTagName("li");
   var aImg=oTab.getElementsByTagName("img");
   var aDiv=oTab.getElementsByTagName("div");
   var sWidth=aImg[0].offsetHeight;
   var index=i=0;
   var timer=playTimer=null;
   var bOrder=true;
   var aTmp=[];
   var aLib=[0];
   //
   for(i=0;i<aLi.length;i++){
    aTmp.push("<li></li>")
   }
   var oCount=document.createElement("ul");
   oCount.className="count";
   oCount.innerHTML=aTmp.join("");
   oTab.appendChild(oCount);
   //
   var aBtn=oTab.getElementsByTagName("ul")[1].getElementsByTagName("li");
   for(i=0;i<aBtn.length;i++){
    aBtn[i].index=i;
    aBtn[i].onclick=function(){
     index=this.index;
     aLib.push(index);
     if(aLib.length>2){aLib.shift()};
     for(i=0;i<aBtn.length;i++){
      aBtn[i].className="";
      aLi[i].style.zIndex=85;
      aLi[i].style.display="none";
     }
     aBtn[index].className="current";
     aLi[index].style.zIndex=170;
     aLi[index].style.top=sWidth+"px";
     aLi[index].style.display="block";
     aLi[aLib[0]].style.display="block";
     if(aLib[0]!=aLib[1]){
      showMove(aLi[index])
     }else {
      aLi[index].style.top=0;
     }
     
    }
   }
   //
   aBtn[index].className="current";
   aLi[index].style.zIndex=170;
   autoPlay();
   //
   oTab.onmouseover=function(){
    clearInterval(playTimer);
   }
   oList.onmouseout=function(){
    autoPlay();
   }
   //
   function autoPlay(){
    playTimer=setInterval(function(){
     index==aBtn.length-1 && (bOrder=false);
     index==0 && (bOrder=true);
     bOrder ? index++ : index--;
     //console.log(index);
     aBtn[index].onclick();
    },5000)
   }
   //
   function showMove(obj){
    clearInterval(timer);
    timer=setInterval(function(){
     doMove(obj)
    },30)
   }
   //
   function doMove(obj){
    var iSpeed=obj.offsetTop/10;
    iSpeed=iSpeed>0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);
    obj.offsetTop<=0 ? clearInterval(timer) : obj.style.top=obj.offsetTop-iSpeed+"px";
   }
  } 