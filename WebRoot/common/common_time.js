(function(){
	var monArray=["01","02","03","04","05","06","07","08","09","10","11","12"];
	var dayArray=["星期天","星期一","星期二","星期三","星期四","星期五","星期六"];
	var hours=0;
	var mins=0;
	var seconds=0;
	var timer=null;
var	formatter=function(n,w1,h1,w2,h2){
	var s="";
			if(n>=0&&n<10)
			s= "0"+n;
			else s= ""+n;
return	"<img width='"+w1+"px' height='"+h1+"px' style='width:"+w1+"px' src='img/time/"+s.substring(0,1)+".png'/><img src='img/time/"+s.substring(1,2)+".png' width='"+w2+"px' style='width:"+w2+"px' height='"+h2+"px'/>";
		};
var toWrite=function(a,b,w1,h1,w2,h2){
var o=document.getElementById(a);
if(o){o.innerHTML=formatter(b,w1,h1,w2,h2)}};
var setDate=function(n){
	hours=n.getHours();
	toWrite("hours",hours,20,40,20,40);
mins=n.getMinutes();
	toWrite("minutes",mins,20,40,20,40);
seconds=n.getSeconds();
	toWrite("seconds",seconds,20,40,20,40);
};
var setDay=function(n){
	var o=document.getElementById("day");
	if(o){
		o.innerHTML=("<font class='user_define_title_color' size='4'>"+n.getFullYear()+"年"+monArray[n.getMonth()]+"月"+n.getDate()+"日"+"&nbsp;"+dayArray[n.getDay()]+"</font>");
	}
};
var doTime=function(){
	clearTimeout(timer);
	timer=null;
	var	date=new Date();
		setDate(date);
		date=null;
	timer=setInterval(function(){
		date=new Date();
		setDate(date);
		date=null;
	},1000);};
	var init=function(){
		var date=new Date();
		var milliSecs=date.getMilliseconds();
		setDay(date);
		setDate(date);
		timer=setTimeout(doTime,milliSecs);
	};
MyTimer=function(){
	var t=function(){init();} ;
	return new t();}();})();
