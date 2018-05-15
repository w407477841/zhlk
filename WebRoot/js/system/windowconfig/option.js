var d=false;
	$("#kq").click(function(ev){
		var length=$("input:checked").length;
		if(length<=0) {layer.msg("请选择窗户再开启！"); return;}
		clickBtnOpen(ev,$(this));
	});
	$("#gb").click(function(ev){
		var length=$("input:checked").length;
		if(length<=0) {layer.msg("请选择窗户再关闭！"); return;}
		clickBtnClose(ev,$(this));
	});
	$("#zt").click(function(){
		var length=$("input:checked").length;
		if(length<=0) {layer.msg("请选择窗户再开暂停！"); return;}
		pause();
	});
	
	$("#editCangkudianwei").click(function(){
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
			type : 2,
			maxmin :true,
			area : [ "1200px", "600px" ],
			content : rootPath + '/cangkudianwei/editUI.shtml?id='+$(this).attr("data-id"),
			end :function(){
				location.reload();
			}
		});
	});
	
	var jsonArry=[];
	
	var windows={};
	$(function(){
		$.each($(".window-check"),function(i,v){
			var $obj=$(v);
			var jsonObj={
					open1 : $obj.attr("data-open1"),
					open2 : $obj.attr("data-open2"),
					 openNeed:$obj.attr("data-open-need"),
					 close1:$obj.attr("data-close1"),
					 close2:$obj.attr("data-close2"),
					 closeNeed:$obj.attr("data-close-need"),
					 ip:$obj.attr("data-ip"),
					 port:$obj.attr("data-port"),
					duration:$obj.attr("data-duration")
				};
			var _id=$obj.attr("data-id");
			windows[_id]={};
			windows[_id].data=jsonObj;
			windows[_id].timeout=null;
			windows[_id].value=0;
		});
		console.debug(windows);
	});
	
	function clickBtnOpen(ev,$this){
		
		 var  $checkeds=$("input:checked");
		 
		 $.each($checkeds,function(i,obj){
			 var $obj=$(obj);
				var _id=$obj.attr("data-id"); 
				var jsonObj=windows[_id];
				reset(_id,jsonObj );
		 });
		 
		 
		 $.each($checkeds,function(i,obj){
			var $obj=$(obj);
			var _id=$obj.attr("data-id");
			var jsonObj=windows[_id];
			jsonArry[i]=jsonObj.data;
			
			increment( _id,jsonObj);
			
		 });
		 var jsonString=JSON.stringify(jsonArry);
		 
		 $.ajax({
				url :  rootPath+"/windowConfig/option.shtml",
				type : "post",
				async:false,
				cache : false,
				dataType : "json",
				data : {
					"data" : jsonString,option : "open"
				},
				success : function(rs) {
							$("#changePNG").attr("src",rootPath+"/img/window/1-2.png");
							lastOption="open";
							
				}
			});
		 
		
	
	}
	
	
	function clickBtnClose(ev,$this){
		
		 var  $checkeds=$("input:checked");
		 
		 $.each($checkeds,function(i,obj){
			 var $obj=$(obj);
				var _id=$obj.attr("data-id"); 
				var jsonObj=windows[_id];
				reset(_id,jsonObj );
		 });
		 
		 $.each($checkeds,function(i,obj){
			 
			var $obj=$(obj);
			var _id=$obj.attr("data-id");
			var jsonObj=windows[_id];	
			jsonArry[i]=jsonObj.data;
	
			increment( _id,jsonObj);
		 });
		 var jsonString=JSON.stringify(jsonArry);
		 
		 $.ajax({
				url :  rootPath+"/windowConfig/option.shtml",
				type : "post",
				async:false,
				cache : false,
				dataType : "json",
				data : {
					"data" : jsonString,option : "close"
				},
				success : function(rs) {
						$("#changePNG").attr("src",rootPath+"/img/window/1-1.png");
						lastOption="close";
				}
			});
		 
		
	
	}
	
	//var value = 0;
	//var time = 100;
	//var st;
	var lastOption;
			 function increment(id,jsonObj) {
				// console.debug($("#"+id));
				 
				 jsonObj.value += 1;
		       
		                
		         if (jsonObj.value>=0 && jsonObj.value<=30) {
		          //          	console.debug("0-30");
		                       $("#"+id).addClass("progress-bar-danger");
		                  }
		                    else if (jsonObj.value>=30 && jsonObj.value <=60) {
		                        $("#"+id).removeClass("progress-bar-danger");
		                        $("#"+id).addClass("progress-bar-warning");
		            //            console.debug("60-30");
		                    }
		                    else if (jsonObj.value>=60 && jsonObj.value <=90) {
		                       $("#"+id).removeClass("progress-bar-warning");
		                       $("#"+id).addClass("progress-bar-info");
		              //         console.debug("60-90");
		                   }
		                   else if(jsonObj.value >= 90 && jsonObj.value<=100) {
		                       $("#"+id).removeClass("progress-bar-info");
		                        $("#"+id).addClass("progress-bar-success");    
		                //        console.debug("90-100");
		                    }
		                    else{
		                      //  setTimeout(reset,3000);
		                      clearTimeout(jsonObj.timeout);
		                  //    console.debug("...");
		                        return;
		                   }
		         $("#"+id).css("width",jsonObj.value + "%").text(jsonObj.value + "%") 
		                    jsonObj.timeout = setTimeout(function(){
		                    	increment(id,jsonObj);
		                    },parseInt(jsonObj.data.duration)/110);
		               }
			 
			 function pause(){
				
				 var  $checkeds=$("input:checked");
				 $.each($checkeds,function(i,obj){
					var $obj=$(obj);
					var _id=$obj.attr("data-id");
					var jsonObj=windows[_id];
					jsonArry[i]=jsonObj.data;
				 });
				 var jsonString=JSON.stringify(jsonArry);
				 var option;
				 var value;
				 var html;
				 var callback;
				 if($("#zt").val()=="pause"){
					 option="pause";
					 value="goon";
					 html=" <i class=\"glyphicon glyphicon-play\"></i> 继续";
					callback = function(){callbackPause($checkeds)};
				 }
				 else if($("#zt").val()=="goon"){
					 option=lastOption;
					 value="pause";
					 html=" <i class=\"glyphicon glyphicon-pause\"></i> 暂停";
					 callback=function(){
						 callbackGoon($checkeds);
					 } ;
				 }
				 $.ajax({
						url :  rootPath+"/windowConfig/option.shtml",
						type : "post",
						async:false,
						cache : false,
						dataType : "json",
						data : {
							"data" : jsonString,option : option
						},
						success : function(rs) {
							callback();
							 
							 $("#zt").val(value).html(html);
						}
					});
				 
			 }
			 
			 	function callbackGoon(checks){
			 		$.each(checks,function(i,v){
			 			$obj=$(v);
			 			var _id=$obj.attr("data-id");
			 			increment(_id,windows[_id]);
			 			
			 		});
			 	}
				function callbackPause(checks){
					$.each(checks,function(i,v){
			 			$obj=$(v);
			 			var _id=$obj.attr("data-id");
			 			clearTimeout(windows[_id].timeout);	
			 		});
			 	}
			 
			 	function reset(id,jsonObj ) {
			 		jsonObj.value=0;
				                //value = 0;
			 		if(jsonObj.timeout!=null){
	                clearTimeout(jsonObj.timeout);
	                }
			 		jsonObj.timeout=null;
				      $("#"+id).removeClass("progress-bar-success").css("width","0%").text("等待启动");
				                   $("#zt").val("pause").html("<i class=\"glyphicon glyphicon-pause\"></i> 暂停");
				                   //setTimeout(increment,5000);
				               }
			 	
			 	
			 //视频
			 
			var g_aIframe = $(".shipinframe");
			 var g_length= g_aIframe.length||0;

$(function () {
	// 检查插件是否已经安装过
    var iRet = WebVideoCtrl.I_CheckPluginInstall();
	if (-2 == iRet) {
		alert("您的Chrome浏览器版本过高，不支持NPAPI插件！");
		return;
	} else if (-1 == iRet) {
        alert("您还未安装过插件，双击开发包目录里的WebComponentsKit.exe安装！");
		return;
    }	

	// 关闭浏览器
	$(window).unload(function () {
		$.each(g_aIframe, function (i, oIframe) {
            getWebVideoCtrl(oIframe).I_Stop();
        });
	});
});

var iLoadedCount = 0;
function iframeLoaded() {
    iLoadedCount++;

    if (g_length === iLoadedCount) {
	//	var oLiveView=[];
        $.each(g_aIframe, function (i, oIframe) {
        	$obj=$(oIframe);
        	var oLiveView={
        			 iProtocol: 1,			// protocol 1：http, 2:https
        	            szIP: $obj.attr("data-ip"),	// protocol ip
        	            szPort: $obj.attr("data-port"),			// protocol port
        	            szUsername: $obj.attr("data-username"),	// device username
        	            szPassword: $obj.attr("data-password"),	// device password
        	            iStreamType: 1,			// stream 1：main stream  2：sub-stream  3：third stream  4：transcode stream
        	            iChannelID: $obj.attr("data-ipnum"),			// channel no
        	            bZeroChannel: false		// zero channel	
        	};
        	
            var oWebVideoCtrl = getWebVideoCtrl(oIframe);
            // 登录设备
            oWebVideoCtrl.I_Login(oLiveView.szIP, oLiveView.iProtocol, oLiveView.szPort, oLiveView.szUsername, oLiveView.szPassword, {
                success: function (xmlDoc) {
                    // 开始预览
                    oWebVideoCtrl.I_StartRealPlay(oLiveView.szIP, {
                        iStreamType: oLiveView.iStreamType,
                        iChannelID: oLiveView.iChannelID,
                        bZeroChannel: oLiveView.bZeroChannel
                    });
                }
            });
        });
    }
}

function getWebVideoCtrl(oIframe) {
    return oIframe.contentWindow.WebVideoCtrl;
}
			 
			 
			 	

