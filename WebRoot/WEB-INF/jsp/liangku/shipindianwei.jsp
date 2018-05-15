<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
    <div id="content" class="col-lg-12 col-sm-12" style="padding-left: 0px; padding-right: 0px;">
            <!-- content starts -->
     <div class="row" id="cangku" style="position:relative;background:url(${imgPath});background-size:100% 100%;height:700px ">
    
    </div>
 </div>
<script type="text/javascript">

var Wyf_=function(config){
	 this.properties(config);
	};

	Wyf_.prototype={
		toString:function(){

		return this.defaultV.divid;

		},defaultV:{ 
		divid:'cangku'
		}
		,properties:function(c){
		this.defaultV.divid=c.divid;
		}
		,viewCangKu:function(){
			//this.viewCangKu().initCangKu(this.defaultV.divid);
		},initCangKu:function(conf){
			var ck= new this.viewCangKu();
			ck.initCangKu({'divid':this.defaultV.divid,location_id:conf.location_id,lx:conf.lx});
		}
		,viewShiPin:function(){
		    
			//this.viewShiPin().initShiPin(this.defaultV.divid);
		},initShiPin:function(){
			var that=this;
			var sp=new that.viewShiPin();
			sp.initShiPin(this.defaultV.divid);
			
		}
		
		,rightClickDiv :function (x,y){
					var rightClick= $("#rightClick");
				if(rightClick[0]) rightClick.css({"left":x+"px","top":y+"px"});
				else{
					$("<div class='open' id=\"rightClick\">")
					.mouseleave(function(){
						
						$(this).remove();
					})
					.css({"height":"0px","width":"200px","background":"#ffffff","z-index":"9999","position":"absolute","left":x-10+"px","top":y-10+"px"})
					.html("<ul class='dropdown-menu'><li><a href=\"javascript:Wyf.initCangKu({'location_id':'${param.name}','lx':'1'});\">仓库信息<a/></li><li><a href=\"javascript:Wyf.initShiPin();\">视频监控<a/></li><li><a href=\"javascript:Wyf.initCangKu({'location_id':'${param.name}','lx':'2'});\">仓外传感器<a/></li></ul>").appendTo("#cangku");
				}
			}
	};
	var Wyf=new  Wyf_({'divid':"cangku"});
	
	Wyf.viewCangKu.prototype={
	     dataing:false,
	     initCangKu:function(conf){
					this.dataing=false;
					this.divid=conf.divid;
					this.location_id=conf.location_id;
					this.lx=conf.lx;
					$("#"+conf.divid).empty();
					var dangqian=this.getCangKuDianWeiData();
					for(var c=0;c<dangqian.length;c++){
						this.createCangKuDiv(dangqian[c],c);
						this.createChuanGanqiDiv(dangqian[c],c);
					}
		 },
		 createCangKuDiv:function(c,index){
						var that=this;
						var name=c.name;
						var location_id=c.location_id;
						var dwId = c.id;
						var ckl=$("<div>")
						.css("width","40px").css("height","40px")
						.css("border-radius","4px 4px 3px 3px")
						.css("color","#ffffff")
						.css("font-weight","bold")
						.attr("id","cangkudiv"+index)
						.attr("data-id","cangku"+index)
						.attr("dw-id",dwId)
						.css("cursor","pointer")
						.mouseover(function(event){
							$("#"+$(this).attr("data-id")).show();
						    	
						    if(!this.dataing){
						    	this.dataing=true;
						    	 var cgqdl=that.getChuanGanQiData({"data-ips":$(this).attr("data-ips"),
						    		 					"data-ports":$(this).attr("data-ports"),
						    		 					"data-zls":$(this).attr("data-zls"),"dw-id":$(this).attr("dw-id")
						    		 					});
						    	 if(cgqdl){
						    		 for(var k=0;k<cgqdl.length;k++){
											//$("#"+$(this).attr("data-id")+"_data"+k).html(cgqdl[k].data.replace("PPM","ppm"));
						    			 var d_lx = cgqdl[k].lx;
						    			 if(d_lx == 'o2'){
						    				 $("#"+$(this).attr("data-id")+"_data"+k).html(cgqdl[k].data+" VOL%");
						    			 }else if(d_lx == 'co2'){
						    				 $("#"+$(this).attr("data-id")+"_data"+k).html(cgqdl[k].data+" PPM");
						    			 }else if(d_lx == 'h3p'){
						    				 $("#"+$(this).attr("data-id")+"_data"+k).html(cgqdl[k].data+" PPB");
						    			 }else if(d_lx == 'h3pW'){
						    				 $("#"+$(this).attr("data-id")+"_data"+k).html(cgqdl[k].data+" PPB");
						    			 }
										}
								}
						    	//获取仓库信息 
						    	if(that.lx=="1"){
						    	var sskc= that.getCurrentStorage({
						    		"storageID":$(this).attr("data-storateid"),
						    	});
						    	var zjxx=[];
						    	//zjxx.push("该仓库目前存有",sskc.name,sskc.cangKu,"kg,属于",sskc.quanZhong)
						    	zjxx.push("<span style='font-weight:bold;'>粮食品种：</span>",sskc.name,"</br>");
						    	zjxx.push("<span style='font-weight:bold;'>粮食性质：</span>",sskc.quanZhong,"</br>");
						    	zjxx.push("<span style='font-weight:bold;'>实时库存：</span>",sskc.cangKu,"kg");
						    	$("#"+$(this).attr("data-id")+"_shishikucun").html(zjxx.join(""));
						    	zjxx=[];
						    	zjxx.push("<span style='font-weight:bold;'>水份：</span>",sskc.sdMoisture||"无数据","% ","</br>","<span style='font-weight:bold;'>杂质：</span>",sskc.sdImpurity||"无数据","% ");
						    	$("#"+$(this).attr("data-id")+"_zhijianxinxi1").html(zjxx.join(""));
						    	
						    	zjxx=[];
						    	zjxx.push("<span style='font-weight:bold;'>容重：</span>",sskc.sdUnitweight||"无数据","g/l ","</br>","<span style='font-weight:bold;'>不完善粒：</span>",sskc.sdUnsoundgrain||"无数据","% ");
						    	$("#"+$(this).attr("data-id")+"_zhijianxinxi2").html(zjxx.join(""));
						    	zjxx=[];
						    	zjxx.push("<span style='font-weight:bold;'>黄粒：</span>",sskc.sdYellowrice||"无数据","% ","</br>","<span style='font-weight:bold;'>整精米粒：</span>",sskc.sdHeadricerate||"无数据","% ");
						    	$("#"+$(this).attr("data-id")+"_zhijianxinxi3").html(zjxx.join(""));
						    	
						       	zjxx=[];
						    	zjxx.push("<span style='font-weight:bold;'>出糙：</span>",sskc.sdBrownricerate||"无数据","% ","</br>","<span style='font-weight:bold;'>谷外糙米：</span>",sskc.sdHuskedriceinpeddy||"无数据","% ");
						    	$("#"+$(this).attr("data-id")+"_zhijianxinxi4").html(zjxx.join(""));
						    	}
						    	 this.dataing=false;
						    }
						   
						})
						.mouseout(function(event){
							$("#"+$(this).attr("data-id")).hide();
						})
						.css("background","#158cba")
						.attr("data-name",name).attr("data-locationId",location_id)
						.css("position","absolute").css("left",c.cLeft).css("top",c.cTop).css("font-size","10").css("text-align","center")
						.html(name)
						.appendTo($("#"+this.divid));
		 },
				createChuanGanqiDiv:function(c,index){
				//定义 三个变量，分别存放传感器的参数
					var ips=[], ports=[], zls=[],stroage="";
					//创建传感器展示DIV
					var templeft= c.cLeft.split("%")[0]*1;
					var temptop=c.cTop.split("%")[0]*1;
					if(templeft>70) templeft=42;
					if(temptop>64)   temptop=64;
					var cangkuL= $("<div>")
					.attr("id","cangku"+index)
					.css({"height":"320px","width":"250px","border-radius":"4px","background":"#ffffff","z-index":"999","position":"absolute","left":templeft+4+"%","top":temptop+4+"%","display":"none"});
					var sensorList=c.sensorList;
					stroage=c.warehouse_id;
					if(sensorList||sensorList.length==0){
						cangkuL.html("暂无传感器，请添加");
					}
					var html=["<ul>"];
					for( var j=0;j<sensorList.length;j++){
						ips.push(sensorList[j].cIp);
						ports.push(sensorList[j].cPort);
						zls.push(sensorList[j].zl);

						var _lx=sensorList[j].lx;
						if(_lx=="o2") {
							_lx="氧气";
						}else if(_lx=="co2"){
							_lx="二氧化碳";
						}else if(_lx=="h3p"){
						_lx="磷化氢";
						}
						else if(_lx=="h3pW"){
							_lx="磷化氢";
							}

						html.push("<li style=\"list-style:none\"></li><span style='font-weight:bold;'>",_lx,"：</span><span id=\"cangku",index,"_data",j,"\" data-load=\"cangku",index,"_data\"></span>");
					}
					if(this.lx==1){
					html.push("<li style=\"list-style:none\" ></li><span></span><span id='cangku",index,"_shishikucun' ></span>");
					html.push("<li style=\"list-style:none\" ></li><span>-----------质检信息-----------</span>");
					html.push("<li style=\"list-style:none\" ></li><span></span><span id='cangku",index,"_zhijianxinxi1' ></span>");
					html.push("<li style=\"list-style:none\" ></li><span></span><span id='cangku",index,"_zhijianxinxi2' ></span>");
					html.push("<li style=\"list-style:none\" ></li><span> </span><span id='cangku",index,"_zhijianxinxi3' ></span>");
					html.push("<li style=\"list-style:none\" ></li><span></span><span id='cangku",index,"_zhijianxinxi4' ></span>");
					}
					html.push("</ul>");
					cangkuL.html(html.join(""));
					cangkuL.appendTo($("#"+this.divid));
					
					//将传感器参数装入 仓库div 
					$("#cangkudiv"+index).attr("data-ips",ips.length==0?'':ips.join(","))
					.attr("data-ports",ports.length==0?'':ports.join(","))
					.attr("data-zls",zls.length==0?'':zls.join(","))
					.attr("data-storateid",stroage);
					

		},getCangKuDianWeiData:function(){
				var data=null;
					$.ajax({
						type : "POST",
						data : {
							"location_id" : this.location_id,
							"lx" :this.lx
						},
						url : rootPath + '/cangkudianwei/findByLocation.shtml',
						dataType : 'json',
						async : false,
						success : function(json) {
							data= json;
							}
					});
					return data;
		
		},getChuanGanQiData:function(data){
				var cgqData=null;
				$.ajax({
					timeout : 2000,
					url:rootPath+"/cangkudianwei/getSensorData.shtml",
					type:'post',
					dataType:'json',
					data:{
						//'ips':data["data-ips"],
						//'ports':data["data-ports"],
						//'zls':data["data-zls"],
						'dwId':data["dw-id"]
						},
						async:false,
						success:function(dataList){
							cgqData=dataList;
						}
						
					});
				
				return cgqData;
		
		},getCurrentStorage:function(data){
			var cgqData=null;
			$.ajax({
				url:rootPath+"/store/findCurrentStorageOne.shtml",
				type:'post',
				dataType:'json',
				data:{
					'source':'${param.name}',
					'storageID':data["storageID"]
					},
					async:false,
					success:function(dataList){
						cgqData=dataList;
					}
				});
			
			return cgqData;
			
		}

	};
	Wyf.viewShiPin.prototype={
			initShiPin:function(divid){
					this.divid=divid;
					$("#"+divid).empty();
					var dl= this.getShiPinDianWeiData();
					if(dl){
					for(var i=0;i<dl.length;i++){
						this.createShiPinDianWeiDiv(dl[i],i);
					}
					}
				},
				getShiPinDianWeiData:function(){
					var spdwData=null;
					$.ajax({
						type : "POST",
						data : {
							"location_id" : "${param.name}"
						},
						url : rootPath + '/shipindianwei/findALlByCid.shtml',
						dataType : 'json',
						async : false,
						success : function(json) {
							spdwData=json;
							}
					});
					return spdwData;
				},
				createShiPinDianWeiDiv:function(c,index){
				
					var ip_Num=c.ipNum;
					var ip=c.ip;
					var port=c.port;
					var userName=c.userName;
					var password=c.password;
					$("<div>")
					.attr("data-id","shipin"+index)
					.css("cursor","pointer")
					.append("<img src='${pageContext.servletContext.contextPath}/img/a.png' width='16px' height='16px'>")
					/*
					.mouseover(function(event){
						$("#"+$(this).attr("data-id")).show();
						
					})
					.mouseout(function(event){
						$("#"+$(this).attr("data-id")).show();
					})
					*/
					.click(function(){
						//window.open(rootPath + '/liangku/viewjiankong.shtml?name=${param.name}&ipNum='+$(this).attr("data-ipNum")+'&ip='+$(this).attr("data-ip")+'&port='+$(this).attr("data-port")+'&userName='+$(this).attr("data-userName")+'&password='+$(this).attr("data-password"),'','height=600,width=1000,resizable=no,scrollbars=yes,status=yes,toolbar=no,menubar=yes,location=no')
						openPostWindow(rootPath + '/liangku/viewjiankong.shtml',${param.name},$(this).attr("data-ipNum"),$(this).attr("data-ip"),$(this).attr("data-port"),$(this).attr("data-userName"),$(this).attr("data-password"));
					})
					.attr("data-ipNum",ip_Num).attr("data-ip",ip).attr("data-port",port).attr("data-userName",userName).attr("data-password",password)
					.css("position","absolute").css("left",c.sLeft).css("top",c.top)
					.appendTo($("#"+this.divid));
					$("<div>").attr("id","shipin"+index)
					.css("position","absolute").css("left",(c.sLeft.split("%")[0]*1+2)+"%").css("top",c.top)
					/*.css("display","none")*/
					.html("<span style='color:#00FA9A;font-size:x-small';font-weight: bold;>"+c.name+"</span>").appendTo($("#"+this.divid));
			}	
	};
	document.getElementById("cangku").onmousedown = function(e){
		//e.layerX   e.layerY
		if(window.event) e=window.event;
	    if(e.button ==2){
	    	document.oncontextmenu=function(e){
	  			if(window.event){
				e=window.event;
	   		e.returnValue=false;         //对IE 中断 默认点击右键事件处理函数
	 			 }else{
	 			 e.preventDefault();          //对标准DOM 中断 默认点击右键事件处理函数
					}
	    };
	    	Wyf.rightClickDiv(e.layerX,e.layerY);
	};
	};
	Wyf.initShiPin();
</script>
<script type="text/javascript">
//window.open(rootPath + '/liangku/viewjiankong.shtml?
		//name=${param.name}&
		//ipNum='+$(this).attr("data-ipNum")+'&
		//ip='+$(this).attr("data-ip")+'&
		//port='+$(this).attr("data-port")+'&
		//userName='+$(this).attr("data-userName")+'&
		//password='+$(this).attr("data-password"),'','height=600,width=1000,resizable=no,scrollbars=yes,status=yes,toolbar=no,menubar=yes,location=no')
function openPostWindow(url,name,ipNum,ip,port,userName,password)      

{      
  
   var tempForm = document.createElement("form");      
   tempForm.id="tempForm1";      
   tempForm.method="post";      
   tempForm.action=url;      
   tempForm.target="viewjiank";
   
   var hideInput = document.createElement("input");      
   hideInput.type="hidden";      
   hideInput.name= "name";  
   hideInput.value= name;    
   tempForm.appendChild(hideInput);
   
   var hideInput1 = document.createElement("input");      
   hideInput1.type="hidden";      
   hideInput1.name= "ipNum";  
   hideInput1.value= ipNum;    
   tempForm.appendChild(hideInput1);
   
   var hideInput2 = document.createElement("input");      
   hideInput2.type="hidden";      
   hideInput2.name= "ip";  
   hideInput2.value= ip;    
   tempForm.appendChild(hideInput2);
   
   var hideInput3 = document.createElement("input");      
   hideInput3.type="hidden";      
   hideInput3.name= "port";  
   hideInput3.value= port;    
   tempForm.appendChild(hideInput3);
   
   var hideInput4 = document.createElement("input");      
   hideInput4.type="hidden";      
   hideInput4.name= "userName";  
   hideInput4.value= userName;    
   tempForm.appendChild(hideInput4);
   
   var hideInput5 = document.createElement("input");      
   hideInput5.type="hidden";      
   hideInput5.name= "password";  
   hideInput5.value= password;    
   tempForm.appendChild(hideInput5);
   
   tempForm.onsubmit = openWindow("viewjiank");    
   document.body.appendChild(tempForm);      
   //tempForm.fireEvent("onsubmit");    
   tempForm.submit();    
   document.body.removeChild(tempForm);    
} 
function openWindow(name)      
{      
   window.open('about:blank',name,'height=500,width=1000,resizable=no,scrollbars=yes,status=yes,toolbar=no,menubar=yes,location=no');       
}      
</script>
