var m_iPtzSpeed = 60;
/*************************************************
Function:		Preview
Description:	预览		
*************************************************/
function Preview () {
	var that = this;
	
	this.m_szXmlStr = "";
	this.m_bChannelPlay = [];  //通道是否在预览
	this.m_bChannelRecord = [];  //通道是否在录像
	this.m_iWndChannel = [];  //窗口对应的通道
	this.m_iChannelWindow = [];  //通道对应的窗口
	this.m_bSound = [];  //通道声音属否打开
	this.m_iChannelStream = [];//通道的码流，0主码流，1子码流
	this.m_bEnableEZoom = [];  //电子放大是否开启
	this.m_bEnable3DZoom = [];  //3D放大是否开启
	this.m_bPTZAuto = [];  //云台是否自动轮询
	this.m_iCurWnd = 0;
	this.m_iCurWndChannel = -1;
	this.m_iCurWndNum = 1;
	this.m_bAllPlay = false;
	this.m_bAllRecord = false;
	for(var i = 0; i < 256; i++) {
		this.m_bSound[i] = 0;
		this.m_bChannelPlay[i] = 0;
		this.m_bChannelRecord[i] = 0;
		this.m_iWndChannel[i] = -1;
		this.m_iChannelWindow[i] = -1;
		this.m_bEnableEZoom[i] = false;
		this.m_bEnable3DZoom[i] = false;
		this.m_bPTZAuto[i] = false;
		this.m_iChannelStream[i] = 0;
	}
	this.m_bIsDiskFreeSpaceEnough = true;
	this.m_iTotalPageNum = 0;  //总的页数
	this.m_iCurrentPageNum = 0;  //当前页面数
	this.m_bIsSupportPage = false;  //是否支持分页
	this.m_oSliderPtzSpd = null;  //PTZ速度滑动条
	this.m_oSliderVolume = null;  //声音滑动条
	this.m_oSliderBright = null;  //亮度滑动条
	this.m_oSliderContrast = null;  //对比度滑动条
	this.m_oSliderSaturation = null;  //饱和度滑动条
	this.m_oSliderHue = null;  //色度滑动条
	this.m_oSliderSharpness = null;  //色度滑动条
	this.m_oSliderNoiseReduce = null;  //去噪滑动条
	this.m_iBright = 0;  //当前亮度
	this.m_iContrast = 0;  //当前对比度
	this.m_iSaturation = 0;  //当前饱和度
	this.m_iHue = 0;  //当前色度
	this.m_iSharpness = 0;
	this.m_iNoiseReduce = 0;
	this.m_iBrightMin = 0;  //最小亮度
	this.m_iBrightMax = 255;  //最大亮度
	this.m_iContrastMin = 0;  //最小对比度
	this.m_iContrastMax = 255;  //最大对比度
	this.m_iSaturationMin = 0;  //最小饱和度
	this.m_iSaturationMax = 255;  //最大饱和度
	this.m_iHueMin = 0;  //最小色度
	this.m_iHueMax = 255;  //最大色度
	this.m_iSharpnessMin = 0;
	this.m_iSharpnessMax = 3;
	this.m_iNoiseReduceMin = 0;
	this.m_iNoiseReduceMax = 5;
	this.m_iBrightDefault = 128;  //默认亮度
	this.m_iContrastDefault = 129;  //默认对比度
	this.m_iSaturationDefault = 132;  //默认饱和度
	this.m_iHueDefault = 153;  //默认色度
	this.m_iSharpnessDefault = 0;
	this.m_iNoiseReduceDefault = 2;
	this.m_bSupportScene = false;
	this.m_iSceneParamDef = [];
	for(var i = 0; i < 4; i++) {
		this.m_iSceneParamDef[i] = [];
		for(var j = 0; j < 6; j++) {
			this.m_iSceneParamDef[i][j] = 0;
		}
	}
	this.m_bVideoExpand = false;  //视频栏是否伸展
	this.m_oSelectPreset = null;  //选中行的对象
	this.m_iSelectPatrolPreset = -1;  //路径中选中的预置点
	this.m_oSelectPattern = null;  //选中轨迹行的对象
	this.m_iOperateMode = 0;  //弹出编辑路径窗口后的操作  0 - 添加 1 - 修改
	this.m_oOperated = null;  //被操作修改值的对象
	this.m_iProtocolType = 0;  //取流方式，默认为RTSP
	this.m_lxdPreview = null;  //Preview.xml
	this.m_iWndArrangePartTimeOut = -1;
	this.m_iEnLargeZeroChannel = -1;  //零通道是否放大 0:nomal, 1:enlarge
	this.m_iPTZPatrolNum = 0;
	this.m_szSecretKey = "";
	this.m_bNoStreamSecret = false;
	
	//初始化预览界面
	this.InitPreview = function () {
		$.cookie('page',null);
		g_oCommon.m_szUserPwdValue = $.cookie('userInfo'+g_oCommon.m_lHttpPort);
		if(g_oCommon.m_szUserPwdValue == null) {
			window.parent.location.href="login.asp";
			return;
		}
		window.parent.$("#curruser").text(Base64.decode(g_oCommon.m_szUserPwdValue).split(":")[0]);  //显示用户
		window.parent.g_oMain.changeMenu(1);
		
		//add by tangzz 2011-12-29 初始化左边树table
		g_oCommon.getTreeTable();
	
		g_oCommon.getRTSPPort();			//获取RTSP端口
		that.InitTree();				//初始化通道树
		//SetFontColor(1);
		
		$('#presetParam').height($('#content_right').height() - $('#PTZ').height() - $('#VideoEffect').height()- 35);
		$('#PresetArea').height($('#presetParam').height());
		$('#CruiseArea').height($('#presetParam').height());
		$('#PatrolPresetList').height($('#CruiseArea').height() - 26);
		$('#TrackArea').height($('#presetParam').height());
		$('#videoParam').height($('#Preset').height() - 20);
		
		that.InitSlider();
		
		that.InitPreset();      //初始化预置点
		that.InitPattern();
		that.InitPresetList();
		
		g_oCommon.getCapbilities();
		that.GetPatrolsCab();
		that.GetPatternCab();		
		
		that.changeLanguage(parent.translator.szCurLanguage);	
		
		var iWndSqrt = 0;
		
		iWndSqrt = Math.ceil(Math.sqrt(g_oCommon.m_iAnalogChannelNum + g_oCommon.m_iDigitalChannelNum + g_oCommon.m_iZeroChanNum));
		if(0 == iWndSqrt) {
			iWndSqrt = 1;
		}
		if(iWndSqrt > 4) {
			iWndSqrt = 4;
		}
		//ChangeWnd(iWndSqrt);
		for(var i = 0;i < iWndSqrt && i < 4; i++) {
			$("#wnd"+((i+1)*(i+1))).show();
		}
		that.m_iCurWndNum = iWndSqrt*iWndSqrt;
		for(var i = 1; i < 5; i++) {
			if(i != iWndSqrt) {
				$("#wnd"+i*i).attr("src","../images/public/Arrange/Wnd"+i*i+".png");
			} else {
				$("#wnd"+i*i).attr("src","../images/public/Arrange/PushWnd"+i*i+".png");
			}
		}
		var iAllChannelNum = g_oCommon.m_iAnalogChannelNum + g_oCommon.m_iDigitalChannelNum + g_oCommon.m_iZeroChanNum; 
		if (0 == (iAllChannelNum % that.m_iCurWndNum)) {
			that.m_iTotalPageNum = (iAllChannelNum / that.m_iCurWndNum);
		} else {
			that.m_iTotalPageNum = parseInt(iAllChannelNum / that.m_iCurWndNum, 10) + 1;
		}
		if(iAllChannelNum <= that.m_iCurWndNum) {
			that.m_bIsSupportPage = false;
	
			$("#frontpage").attr("src",'../images/public/VideoBottom/disabled/Preview_DisFrontPage.png');
			$("#nextpage").attr("src",'../images/public/VideoBottom/disabled/Preview_DisNextPage.png');
		} else {
			that.m_bIsSupportPage = true;
			$("#frontpage").attr("src",'../images/public/VideoBottom/normal/Preview_FrontPage.png');
			$("#nextpage").attr("src",'../images/public/VideoBottom/normal/Preview_NextPage.png');
		}
		$(window.parent.document.getElementById("footer")).append("<div id='WndArrangePart' style='display:none; height:31px; position:absolute; z-index:10; left:218px; bottom:0px;'>"+$("#WndArrangePart").html()+"</div>");
		$(window.parent.document.getElementById("WndArrangePart")).bind({
			mouseleave: function(){$(this).hide();}
		});
		//初始化画面分割事件响应 
		//
		for(var j = 0; j < 4; j++) {
			var obj = window.parent.document.getElementById("wnd"+(j+1)*(j+1));
			$(obj).bind('mouseout', {iWndType: j+1}, function(event) {
				var iWindowType = event.data.iWndType;
				that.MouseOutWnd(iWindowType);
			});
			$(obj).bind('mouseover', {iWndType: (j+1)}, function(event) {
				var iWindowType = event.data.iWndType;
				$(this).attr("src","../images/public/Arrange/SelWnd"+iWindowType*iWindowType+".png");
			});
			$(obj).bind('click', {iWndType: j+1}, function(event) {
				var iWindowType = event.data.iWndType;
				that.ChangeWnd(iWindowType);
			});
	
		}
		$('#ArrangeWnd').bind({
			mouseenter: function(){
				$(window.parent.document.getElementById("WndArrangePart")).show();
				//删除动画
				if(that.m_iWndArrangePartTimeOut != -1){
					clearTimeout(that.m_iWndArrangePartTimeOut);
				}
			},
			mouseleave: function(){
				//创建动画 add by tangzz 2012-02-28
				that.m_iWndArrangePartTimeOut = setTimeout(function(){
					//隐藏掉分割图片
					$(window.parent.document.getElementById("WndArrangePart")).hide();		
				}, 500);
			}
		});
		
		//add by tangzz 鼠标在小分割图片上时清除动画，可以选择，离开后有隐藏事件保证
		$(window.parent.document.getElementById("WndArrangePart")).bind({
			mouseenter: function(){ 
				if(that.m_iWndArrangePartTimeOut != -1){
					clearTimeout(that.m_iWndArrangePartTimeOut);
				}
			}
		});
		$('#WndArrangePart').remove();
		//初始化音量滑块
		$(window.parent.document.getElementById("footer")).append("<div id='volumeDiv' style='display:none; position:absolute; height:23px; width:73px; z-index:10; right:200px; bottom:0px;' align='left'></div>");
		$(window.parent.document.getElementById("volumeDiv")).bind({
			mouseleave: function(){$(this).hide();}
		});
		window.parent.m_oSliderVolume = new neverModules.modules.slider({
			targetId: "volumeDiv",
			sliderCss: "VolumeSlider",
			barCss: "VolumeBar",
			parent: window.parent,
			min: 0,
			max: 100
		}); 
		window.parent.m_oSliderVolume.create();
		window.parent.m_oSliderVolume.onchange = function () {
			var iVol = this.getValue();
			that.SetVolume(iVol);
		};
		$(window).bind('resize', function() {
			var iHeight = $(window).height() - $('#PTZ').height() - 63;
			$('#PatrolPresetList').height(iHeight - 26);
			$('#CruiseArea').height(iHeight);
			$('#PresetArea').height(iHeight);
			$('#TrackArea').height(iHeight);
			$('#presetParam').height($(window).height() - $('#PTZ').height() - 63);
			$('#videoParam').height(iHeight + 15);
			$("#PreviewActiveX").height(document.body.clientHeight - 34);
		});
		//添加巡航参数有效性验证
		$('#PatrolTime').bind('keyup', function() {
			if(parseInt($(this).val(), 10) >= 0 && parseInt($(this).val(), 10) <= 30) {
				$(this).val(parseInt($(this).val(), 10));
			} else {
				if(parseInt($(this).val(), 10) > 30) {
					$(this).val("30");
				} else {
					$(this).val("1");
				}
			}
		});
		$("#PatrolSpeed").bind("keyup", function() {
			if(parseInt($(this).val(), 10) >= 1 && parseInt($(this).val(), 10) <= 40) {
				$(this).val(parseInt($(this).val(), 10));
			} else {
				if(parseInt($(this).val(), 10) > 40) {
					$(this).val("40");
				} else {
					$(this).val("1");
				}
			}		
		});
		
		//是否支持语音对讲
		g_oCommon.getTalkNum();	
		if(g_oCommon.m_iTalkNum > 0) {
			$("#tdVoiceTalk").show();
		}
		if(!g_oCommon.checkPlugin('2', parent.translator.translateNode(that.m_lxdPreview, 'laPlugin'), iWndSqrt)) {
			return;
		}
		g_oCommon.m_PreviewOCX=document.getElementById("PreviewActiveX");
		if(!g_oCommon.compareFileVersion()) {  //比较插件版本信息
			g_oCommon.updateTips();
		}
		var szPathInfo = '';
		try {
			szPathInfo = g_oCommon.m_PreviewOCX.HWP_GetLocalConfig();
		} catch(e) {
			szPathInfo = g_oCommon.m_PreviewOCX.GetLocalConfig();
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(szPathInfo);
		if($(xmlDoc).find("SecretKey").eq(0).text() != "") {
			that.m_szSecretKey = $(xmlDoc).find("SecretKey").eq(0).text();
		} else {
			that.m_szSecretKey = "";
		}
		var iStreamType = parseInt($(xmlDoc).find('StreamType').eq(0).text());
		that.m_iProtocolType = parseInt($(xmlDoc).find('ProtocolType').eq(0).text());
		//本地配置去掉HTTP选项后，要判断非2就置0   add by tangzz
		if(that.m_iProtocolType != 2 && that.m_iProtocolType != 0) {
			$(xmlDoc).find('ProtocolType').eq(0).text('0');
			g_oCommon.m_PreviewOCX.HWP_SetLocalConfig(g_oCommon.xmlToStr(xmlDoc));
			that.m_iProtocolType = 0;
		}
		for(var i = 0; i < 256; i++) {
			that.m_iChannelStream[i] = iStreamType;
		}
		if(iStreamType === 1) {
			$("#sub_menu").find(".stream").attr("src", "../images/public/ICON/sub_stream.png");
			$("#sub_menu").find(".stream").attr("title", parent.translator.translateNode(that.m_lxdPreview, "streamTypeOpt2"));
		} else {
			$("#sub_menu").find(".stream").attr("title", parent.translator.translateNode(that.m_lxdPreview, "streamTypeOpt1"));
		}
		g_oCommon.isSupportShttp();
		var szUrl = document.URL;
		if(szUrl.indexOf("&") != -1) {
			if(szUrl.indexOf("slice=")!=-1) {
				if(szUrl.indexOf("&open=")!=-1) {
					var iWndType = Math.ceil(Math.sqrt(parseInt(szUrl.substring(szUrl.indexOf("slice=") + 6, szUrl.indexOf("&open=")),10)));
					var szOpenChan = szUrl.substring(szUrl.indexOf("&open={") + 7, szUrl.indexOf("}"));
					for(var i = 0; i < szOpenChan.split(",").length; i++) {
						setTimeout('g_oPreviewInstance.StartRealPlay('+szOpenChan.split(",")[i]+','+i+')', 100);
					}
				} else {
					var iWndType = Math.ceil(Math.sqrt(parseInt(szUrl.substring(szUrl.indexOf("slice=") + 6, szUrl.length),10)));
				}
				that.ChangeWnd(iWndType);
			}
			return;
		}
		if($(xmlDoc).find("RealPlayAll").eq(0).text() === "1") {
			that.RealPlayAll();
		}
	}
	
	//初始化树
	this.InitTree = function () {
		$("#DeviceName").html(window.parent.g_oMain.m_szDeviceName);
		$("#DeviceName").attr("title",window.parent.g_oMain.m_szDeviceName);
		g_oCommon.getChannelInfo();		//获取模拟通道数
		g_oCommon.getDigChannelInfo();    //获取数字通道
		g_oCommon.getZeroChannelInfo();   //获取零通道
		var innerHTML=$("#sub_menu").html();
		var szAltName0="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		
		//模拟通道
		for(var i = 0; i < g_oCommon.m_iAnalogChannelNum; i++) {
			var szChannelName = "";
			try {
				szChannelName = g_oCommon.m_oXmlDoc.documentElement.getElementsByTagName('VideoInputChannel')[i].getElementsByTagName('name')[0].childNodes[0].nodeValue
			} catch(err) {
				szChannelName = "";
			}
			if(szChannelName == "") {
				if(i<9) {
					szChannelName = "Camera 0"+(i+1);
				} else {
					szChannelName = "Camera "+(i+1);
				}
			}
			szChannelName=szChannelName.replace(/\s/g,"&nbsp;");
			innerHTML += "<div class='ellipsis' id='Camera"+(i+1)+"' style='height:25px; width:184px; white-space:nowrap;'>" + szAltName0 + "<img src='../images/public/ICON/main_stream.png' align='absmiddle' class='stream' id='Stream"+(i+1)+"Img' onclick='g_oPreviewInstance.switchStream(" + (i + 1) + ")' style='cursor:pointer'>&nbsp;" + "<img src='../images/public/ICON/Camera_1.png' align='absmiddle' id='Camera"+(i+1)+"Img' onClick='g_oPreviewInstance.StartRealPlay("+(i+1)+")'  style='cursor:pointer'>&nbsp;<img src='../images/public/ICON/record.png' align='absmiddle' id='Record"+(i+1)+"Img' onClick='g_oPreviewInstance.StartRecord("+(i+1)+",\"\")' style='cursor:pointer;'><span style='cursor:pointer;color:#000000;-moz-user-select:none;' id='Selected"+(i+1)+"color' onClick='g_oPreviewInstance.SetFontColor("+(i+1)+")' onDblClick='g_oPreviewInstance.StartRealPlay("+(i+1)+")' onselectstart='return false;' title='"+szChannelName+"'>&nbsp;"+szChannelName+"</span></div>";
		}
		//数字通道
		for(var j=0;j<g_oCommon.m_iDigitalChannelNum;j++) {
			var szIPChannelName="";
			try {
				szIPChannelName = g_oCommon.m_oDigXmlDoc.documentElement.getElementsByTagName('InputProxyChannel')[j].getElementsByTagName('name')[0].childNodes[0].nodeValue;
			} catch(err) {
				szIPChannelName = "";
			}
			if(szIPChannelName=="") {
				if(j<9) {
					szIPChannelName="IPCamera 0"+(j+1);
				} else {
					szIPChannelName="IPCamera "+(j+1);
				}
			}
			szIPChannelName = szIPChannelName.replace(/\s/g,"&nbsp;");
			innerHTML += "<div class='ellipsis' id='Camera"+(j+g_oCommon.m_iAnalogChannelNum+1)+"' style='height:25px; width:184px; white-space:nowrap;'>" + szAltName0 + 
			"<img src='../images/public/ICON/main_stream.png' align='absmiddle' class='stream' id='Stream"+(j+g_oCommon.m_iAnalogChannelNum+1)+"Img' onClick='g_oPreviewInstance.switchStream(" + (j+g_oCommon.m_iAnalogChannelNum+1) + ")' style='cursor:pointer'>&nbsp;" + "<img src='../images/public/ICON/Camera_1.png' align='absmiddle' id='Camera"+(j+g_oCommon.m_iAnalogChannelNum+1)+"Img' onClick='g_oPreviewInstance.StartRealPlay("+(j+g_oCommon.m_iAnalogChannelNum+1)+")'  style='cursor:pointer'>&nbsp;<img src='../images/public/ICON/record.png' align='absmiddle' id='Record"+(j+g_oCommon.m_iAnalogChannelNum+1)+"Img' onClick='g_oPreviewInstance.StartRecord("+(j+g_oCommon.m_iAnalogChannelNum+1)+",\"\")' style='cursor:pointer'><span style='cursor:pointer;color:#000000;-moz-user-select:none;' id='Selected"+(j+g_oCommon.m_iAnalogChannelNum+1)+"color' onClick='g_oPreviewInstance.SetFontColor("+(j+g_oCommon.m_iAnalogChannelNum+1)+")' onDblClick='g_oPreviewInstance.StartRealPlay("+(j+g_oCommon.m_iAnalogChannelNum+1)+")' href='#' class='aurl' onselectstart='return false;' title='"+szIPChannelName+"'>&nbsp;"+szIPChannelName+"</span></div>";
		}
		//零通道
		for(var k=0;k<g_oCommon.m_iZeroChanNum;k++) {
			var szZeroChannelName="";
			try {
				szZeroChannelName = g_oCommon.m_oZeroXmlDoc.documentElement.getElementsByTagName('ZeroVideoChannel')[k].getElementsByTagName('name')[0].childNodes[0].nodeValue;
			} catch(err) {
				szZeroChannelName = "";
			}
			if(szZeroChannelName == "") {
				if(k<9) {
					szZeroChannelName="ZeroChannel 0"+(k+1);
				} else {
					szZeroChannelName="ZeroChannel "+(k+1);
				}
			}
			szZeroChannelName = szZeroChannelName.replace(/\s/g,"&nbsp;");
			innerHTML += "<div class='ellipsis' id='Camera"+(k+g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+1)+"' style='padding-left:20px;height:25px; width:184px; white-space:nowrap;'>"+szAltName0+"<img src='../images/public/ICON/Camera_1.png' align='absmiddle' id='Camera"+(k+g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+1)+"Img' onClick='g_oPreviewInstance.StartRealPlay("+(k+g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+1)+")'  style='cursor:pointer'>&nbsp;<img src='../images/public/ICON/record.png' align='absmiddle' id='Record"+(k+g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+1)+"Img' onClick='g_oPreviewInstance.StartRecord("+(k+g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+1)+",\"\")' style='cursor:pointer'><span style='cursor:pointer;color:#000000;-moz-user-select:none;' id='Selected"+(k+g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+1)+"color' onClick='g_oPreviewInstance.SetFontColor("+(k+g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+1)+")' onDblClick='g_oPreviewInstance.StartRealPlay("+(k+g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+1)+")' href='#' class='aurl' onselectstart='return false;' title='"+szZeroChannelName+"'>&nbsp;"+szZeroChannelName+"</span></div>";
		}
		$("#sub_menu").html(innerHTML);
	}
	
	//初始化路径选择下拉框语言
	this.InitPatrolLan = function () {
		$("#selectPatrol").empty();
		var szName = parent.translator.translateNode(that.m_lxdPreview, 'laTrack');
		var szOptions = "";
		for(var i = 0; i < that.m_iPTZPatrolNum; i++) {
			szOptions += "<option value='" + (i+1) + "'>" + szName + " 0" + (i+1) + "</option>";
		}
		$(szOptions).appendTo("#selectPatrol");
	}
	
	//初始化预置点下拉框
	this.InitPresetList = function () {
		$("#SelectPreset").empty();
		var szName = parent.translator.translateNode(that.m_lxdPreview, 'laPreset');
		var szDivInfo = "";
		for(var i = 0; i < 256; i++) {
			szDivInfo += "<option value='"+ (i+1) +"'>"+szName+" "+(i+1)+"</option>";
		}
		$(szDivInfo).appendTo("#SelectPreset");
	}
	//初始化预置点下拉框语言
	this.InitPresetListLan = function () {
		var szPresetName = parent.translator.translateNode(that.m_lxdPreview, 'laPreset');
		$("#SelectPreset").find("option").each(function() {
			var szName = $(this).html();
			$(this).html(szPresetName+" "+szName.split(" ")[1]);
		});
	}
	
	//开始预览
	this.StartRealPlay = function (iChannelNum, iWndNum) {
		if(iChannelNum > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum)) {
			return;
		}
		if(g_oCommon.m_bSupportStreamSecret) {
		    g_oCommon.m_PreviewOCX.HWP_SetSecretKey(1, that.m_szSecretKey);
		}
		var iPlayChannelId = g_oCommon.m_iChannelId[iChannelNum-1];
		var iPreWndChannel = that.m_iCurWndChannel;
		var ObjImg=document.getElementById("Camera"+(iChannelNum)+"Img");
		if(g_oCommon.m_bSupportShttpsPlay) {
			var szPort = g_oCommon.m_lHttpPort;  //私有预览端口
			var szProtocol = g_oCommon.m_lHttp;
		} else {
			if(g_oCommon.m_lHttp === "https://") {
				var szPort = g_oCommon.m_szHttpPort;
			} else {
				var szPort = g_oCommon.m_lHttpPort;
			}
			var szProtocol = "http://";
		}
		if(that.m_bChannelPlay[iChannelNum-1]==0) {
			var szURL = "";
			if(iChannelNum <= (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)) {
				if(g_oCommon.m_bSupportShttpPlay && 0 == that.m_iProtocolType) {
					if(iChannelNum <= g_oCommon.m_iAnalogChannelNum) {
						if (0 == that.m_iChannelStream[iChannelNum - 1]) {  //主码流
							szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/" + (iPlayChannelId*100) +"/004";  //[能力可以得到支持那种封装]这里最后以为暂时使用RTP包
						} else if (1 == that.m_iChannelStream[iChannelNum - 1]) {  //子码流
							szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/" + (iPlayChannelId*100+1) + "/004";
						} else if (2 == that.m_iChannelStream[iChannelNum - 1]) {
							szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/" + (iPlayChannelId*100+3) + "/004";  //转码码流
						} else {
							szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/" + (iPlayChannelId*100) + "/004";
						}						
					} else {
						var iDigitalChanId = g_oCommon.m_iIpChanBase + iPlayChannelId - g_oCommon.m_iAnalogChannelNum - 1;
						if (0 == that.m_iChannelStream[iChannelNum - 1]) {  //主码流
							szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/" + (iDigitalChanId*100) +"/004";  //[能力可以得到支持那种封装]这里最后以为暂时使用RTP包
						} else if (1 == that.m_iChannelStream[iChannelNum - 1]) {  //子码流
							szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/" + (iDigitalChanId*100+1) + "/004";
						} else if (2 == that.m_iChannelStream[iChannelNum - 1]) {
							szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/" + (iDigitalChanId*100+3) + "/004";  //转码码流
						} else {
							szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/" + (iDigitalChanId*100) + "/004";
						}
					}
				} else {
					if(that.m_iChannelStream[iChannelNum - 1] == 0) {
						szURL = "rtsp://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_lRtspPort + "/PSIA/streaming/channels/" + (iPlayChannelId*100+1);
					} else if(that.m_iChannelStream[iChannelNum - 1] == 1) {
						szURL = "rtsp://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_lRtspPort + "/PSIA/streaming/channels/" + (iPlayChannelId*100+2);
					} else {
						if(g_oCommon.m_bSupportTransCode) {
							szURL = "rtsp://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_lRtspPort + "/PSIA/streaming/channels/" + (iPlayChannelId*100+4);
						} else {
							szURL = "rtsp://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_lRtspPort + "/PSIA/streaming/channels/" + (iPlayChannelId*100+1);
						}
					}
				}
			} else {
				if(g_oCommon.m_bSupportShttpPlay && that.m_iProtocolType == 0) {
					szURL = szProtocol + g_oCommon.m_szHostName + ":" + szPort + "/SDK/play/100/004/ZeroStreaming";
				} else {
					szURL = "rtsp://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_lRtspPort + "/PSIA/Custom/SelfExt/ContentMgmt/ZeroStreaming/channels/" + (iPlayChannelId*100+1);
				}
			}
			//pcnvr取流
			if(window.parent.g_oMain.m_szDeviceType.toLowerCase() === "ivms-4200 pcnvr") {
				if(that.m_iChannelStream[iChannelNum - 1] == 0) {
					szURL = "rtsp://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_lRtspPort + "/hikvision://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_szManagePort + ":" + (iPlayChannelId - 1) + ":0";
				} else if(that.m_iChannelStream[iChannelNum - 1] == 1) {
					szURL = "rtsp://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_lRtspPort + "/hikvision://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_szManagePort + ":" + (iPlayChannelId - 1) + ":1";
				} else {
					szURL = "rtsp://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_lRtspPort + "/hikvision://" + g_oCommon.m_szHostName + ":" + g_oCommon.m_szManagePort + ":" + (iPlayChannelId - 1) + ":0";
				}
			}
			
			if(!isNaN(iWndNum)) {
				if(0 == g_oCommon.m_PreviewOCX.HWP_Play(szURL,g_oCommon.m_szUserPwdValue,iWndNum,"","")) {
					ObjImg.src = "../images/public/ICON/Camera_2.png";
					ObjImg.title = parent.translator.translateNode(that.m_lxdPreview, 'stoppreview');
			
					that.m_bChannelPlay[iChannelNum-1]=1;
					that.m_bChannelRecord[iChannelNum-1]=0;
					that.m_iWndChannel[iWndNum]=iChannelNum;
					that.m_iChannelWindow[iChannelNum-1]=iWndNum;
					
					if(that.m_iCurWnd == iWndNum) {
						that.m_iCurWndChannel = iChannelNum;
						that.GetVideoParam(iChannelNum);
						that.SetFontColor(iChannelNum);
						$("#Ezoom").attr("src", "../images/public/VideoBottom/normal/Zoom_normal.png");
						$("#zoom3D").attr("src", "../images/public/VideoBottom/normal/3Dnormal.png");
					}
					if(!that.m_bAllPlay) {
						that.m_bAllPlay=true;
						$("#play").attr("src","../images/public/VideoBottom/normal/StopAll.png");
						$("#play").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'geStopAllViewing'));
					}
				} else {
					that.m_bChannelPlay[iChannelNum-1]=0;
					that.m_bChannelRecord[iChannelNum-1]=0;
					that.m_iWndChannel[iWndNum] = -1;
					that.m_iChannelWindow[iChannelNum-1]=-1;
				}
			} else {
				g_oPreviewInstance.m_bNoStreamSecret = false;
				if(iPreWndChannel>=0) {
					that.StopRealPlay(iPreWndChannel);
				}
				if(0!=g_oCommon.m_PreviewOCX.HWP_Play(szURL,g_oCommon.m_szUserPwdValue,that.m_iCurWnd,"","")) {
					that.m_iCurWndChannel = -1;
					that.SetFontColor(iChannelNum);
					alert(parent.translator.translateNode(that.m_lxdPreview, 'previewfailed'));
					return ;
				}
				that.m_iCurWndChannel=iChannelNum;
				ObjImg.src="../images/public/ICON/Camera_2.png";
				ObjImg.title=parent.translator.translateNode(that.m_lxdPreview, 'stoppreview');
				that.m_bChannelPlay[iChannelNum-1]=1;
				that.m_bChannelRecord[iChannelNum-1]=0;
				that.m_iWndChannel[that.m_iCurWnd]=iChannelNum;
				that.m_iChannelWindow[iChannelNum-1]=that.m_iCurWnd;
				that.SetFontColor(iChannelNum);
				that.GetVideoParam(that.m_iCurWndChannel);
				$("#Ezoom").attr("src", "../images/public/VideoBottom/normal/Zoom_normal.png");
				$("#zoom3D").attr("src", "../images/public/VideoBottom/normal/3Dnormal.png");
				if(!that.m_bAllPlay) {
					that.m_bAllPlay=true;
					$("#play").attr("src","../images/public/VideoBottom/normal/StopAll.png");
					$("#play").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'geStopAllViewing'));
				}
			}
		} else {
			that.StopRealPlay(iChannelNum);
		}
		that.GetPatrol(parseInt($('#selectPatrol').val()));
	}
	//停止预览
	this.StopRealPlay = function (iChannelNum) {
		if(that.m_bChannelRecord[iChannelNum-1]==1)	{
			that.StopRecord(iChannelNum);
		}
		
		if(0!=g_oCommon.m_PreviewOCX.HWP_Stop(that.m_iChannelWindow[iChannelNum-1])) {
			alert(parent.translator.translateNode(that.m_lxdPreview, 'previewfailed'));
			return;
		}
		document.getElementById("Camera"+(iChannelNum)+"Img").src="../images/public/ICON/Camera_1.png";
		document.getElementById("Camera"+(iChannelNum)+"Img").title=parent.translator.translateNode(that.m_lxdPreview, 'jsPreview');
		that.m_bChannelPlay[iChannelNum-1]=0;
		that.m_bChannelRecord[iChannelNum-1]=0;
		that.m_iWndChannel[that.m_iChannelWindow[iChannelNum-1]]=-1;
		
		//关闭电子放大
		try {
			g_oCommon.m_PreviewOCX.HWP_DisableZoom(that.m_iChannelWindow[iChannelNum-1]);
		} catch(e) {}
		that.m_bEnableEZoom[that.m_iChannelWindow[iChannelNum-1]] = false;
		that.m_bEnable3DZoom[that.m_iChannelWindow[iChannelNum-1]] = false;
		$("#Ezoom").prop("src", "../images/public/VideoBottom/disabled/DisZoom.png");
		$("#Ezoom").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'laEnableZoom'));
		$("#zoom3D").prop("src", "../images/public/VideoBottom/disabled/Dis3D.png");
		$("#zoom3D").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'Start3DZoom'));		
			
		that.m_iChannelWindow[iChannelNum-1]=-1;
		
		if(that.m_bSound[iChannelNum-1]) {
			$("#opensound").unbind();
			$("#opensound").bind({
				mouseover:function() {
					$(this).attr("src", '../images/public/VideoBottom/select/SelCloseSound.png');
				},
				mouseout:function() {
					$(this).attr("src", '../images/public/VideoBottom/normal/CloseSound.png');
				}
			});
			$("#opensound").attr("src",'../images/public/VideoBottom/normal/CloseSound.png');
			$("#opensound").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'opensound'));
			$("#Ezoom").attr('src','../images/public/VideoBottom/disabled/DisZoom.png');
			$("#zoom3D").attr('src','../images/public/VideoBottom/disabled/Dis3D.png');
			$(window.parent.document.getElementById("volumeDiv")).hide();
		}
		
		that.m_bSound[iChannelNum-1]=0;
		
		if(iChannelNum == that.m_iCurWndChannel) {  //如果关闭的是当前窗口的预览，去掉视频参数显示
			that.m_iCurWndChannel = -1;
			that.ResetVideoParam();     
		}
		for(var i = 0; i < (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum); i++) {
			if(that.m_bChannelPlay[i] ==  0) {
				continue;
			}
			return;
		}
		that.m_bAllPlay = false;
		$("#play").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'paStartAllView'));
		$("#play").attr("src","../images/public/VideoBottom/normal/RealPlayAll.png");
	}
	
	//开始录像
	this.StartRecord = function (iChannelNum) {
		var ObjImg=document.getElementById("Record"+(iChannelNum)+"Img");
		if(that.m_bChannelRecord[iChannelNum-1]==0) {
			if(that.m_bChannelPlay[iChannelNum-1] == 1) {
				var time = new Date();
				var szFileName = "";
				var szHostName = "";
				if(g_oCommon.m_szHostName.indexOf("[") < 0) {
					szHostName = g_oCommon.m_szHostName;
				} else {
					szHostName = g_oCommon.m_szHostName.substring(1, g_oCommon.m_szHostName.length - 1).replaceAll(":", ".");
				}
				if(iChannelNum <= 9) {
					szFileName = szHostName + "_0" + iChannelNum + "_" + time.Format("yyyyMMddhhmmssS");
				} else {
					szFileName = szHostName + "_" + iChannelNum + "_" + time.Format("yyyyMMddhhmmssS");
				}
				var iRes = g_oCommon.m_PreviewOCX.HWP_StartSave(that.m_iChannelWindow[iChannelNum-1],szFileName);
				if(0 == iRes) {
					ObjImg.src="../images/public/ICON/recording.png";
					ObjImg.title=parent.translator.translateNode(that.m_lxdPreview, 'stoprecord');
					that.m_bChannelRecord[iChannelNum-1]=1;
					
					that.m_bAllRecord = true;
					$("#record").attr("src","../images/public/VideoBottom/normal/StopRecordAll.png");
					$("#record").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'stopAllRecord'));
					
					that.m_bIsDiskFreeSpaceEnough = true;
				} else if(-1 == iRes) {
					var iError = g_oCommon.m_PreviewOCX.HWP_GetLastError();
					if(10 == iError || 9 == iError) {
						alert(parent.translator.translateNode(that.m_lxdPreview, 'jsCreateFileFailed'));
					} else {
						alert(parent.translator.translateNode(that.m_lxdPreview, 'recordfailed'));
					}
				} else if(-2 == iRes) {
					that.m_bIsDiskFreeSpaceEnough = false;
					alert(parent.translator.translateNode(that.m_lxdPreview, 'FreeSpaceTips'));
				} else if(-3 == iRes) {
					alert(parent.translator.translateNode(that.m_lxdPreview, 'jsCreateFileFailed'));
				}
			}
		} else {
			that.StopRecord(iChannelNum);
		}
	}
	
	//停止录像
	this.StopRecord = function (iChannelNum) {
		var szRecord=parent.translator.translateNode(that.m_lxdPreview, 'jsRecord');	//录像
		var iRes = g_oCommon.m_PreviewOCX.HWP_StopSave(that.m_iChannelWindow[iChannelNum-1]);
		if(0 == iRes) {
			document.getElementById("Record"+(iChannelNum)+"Img").src="../images/public/ICON/record.png";
			document.getElementById("Record"+(iChannelNum)+"Img").title=szRecord;
			that.m_bChannelRecord[iChannelNum-1]=0;
			window.parent.g_oMain.showTipsDiv("",parent.translator.translateNode(that.m_lxdPreview, 'jsRecordSucc'));
		}
		for(var i = 0; i < (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum); i++) {
			if(that.m_bChannelRecord[i] ==  0) {
				continue;
			}
			return;
		}
		that.m_bAllRecord = false;
		$("#record").attr("src","../images/public/VideoBottom/normal/RecordAll.png");
		$("#record").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'paStartAllRecord'));
	}
	
	//全部预览
	this.RealPlayAll = function () {
		g_oPreviewInstance.m_bNoStreamSecret = false;
		if(that.m_bAllPlay) {
			//全部停止预览
			that.StopRealPlayAll();
		} else {
			//全部开始预览
			var iPlayNumber = 0;
			if ((g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum) <= that.m_iCurWndNum) {
				iPlayNumber = (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum);
			} else {
				iPlayNumber = that.m_iCurWndNum;
			}
			for(var i = 0; i < iPlayNumber; i++) {
				that.StartRealPlay(i+1, i);
			}
			that.m_iCurWndChannel = that.m_iWndChannel[that.m_iCurWnd];
			if(that.m_iCurWndChannel != -1) {
				that.GetVideoParam(that.m_iCurWndChannel);
				that.SetFontColor(that.m_iCurWndChannel);
			} else {
				that.m_iCurWndChannel = -1;
				that.ResetVideoParam();
			}
		}
		for(var i = 0 ;i < 256; i++) {
			that.m_bSound[i] = 0;
		}
		$("#opensound").unbind();
		$("#opensound").bind({
			mouseover:function() {
				$(this).attr("src", '../images/public/VideoBottom/select/SelCloseSound.png');
			},
			mouseout:function() {
				$(this).attr("src", '../images/public/VideoBottom/normal/CloseSound.png');
			}
		});
		$("#opensound").attr("src",'../images/public/VideoBottom/normal/CloseSound.png');
		$("#opensound").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'opensound'));
		$(window.parent.document.getElementById("volumeDiv")).hide();
	}
	
	//全部停止预览
	this.StopRealPlayAll = function () {
		for(var j = 0; j < (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum); j++) {
			if(that.m_bChannelPlay[j] == 1) {
				var iChannelNum = j + 1;
				if(that.m_bChannelRecord[j]==1) {  //如果正在录像，先停止
					var szRecord=parent.translator.translateNode(that.m_lxdPreview, 'jsRecord');	//录像
					var iRes = g_oCommon.m_PreviewOCX.HWP_StopSave(that.m_iChannelWindow[j]);
					if(0 == iRes) {
						document.getElementById("Record"+(iChannelNum)+"Img").src="../images/public/ICON/record.png";
						document.getElementById("Record"+(iChannelNum)+"Img").title=szRecord;
						window.parent.g_oMain.showTipsDiv("",parent.translator.translateNode(that.m_lxdPreview, 'jsRecordSucc'));				
					}
				}
				if(0 != g_oCommon.m_PreviewOCX.HWP_Stop(that.m_iChannelWindow[j])) {
					continue;
				}
				//关闭电子放大
				try {
					g_oCommon.m_PreviewOCX.HWP_DisableZoom(that.m_iChannelWindow[j]);
				} catch(e) {}
				that.m_bEnableEZoom[that.m_iChannelWindow[j]] = false;
				that.m_bEnable3DZoom[that.m_iChannelWindow[j]] = false;
				
				document.getElementById("Camera"+(iChannelNum)+"Img").src="../images/public/ICON/Camera_1.png";
				document.getElementById("Camera"+(iChannelNum)+"Img").title=parent.translator.translateNode(that.m_lxdPreview, 'jsPreview');
				that.m_bChannelPlay[j]=0;
				that.m_bChannelRecord[j]=0;
				that.m_iWndChannel[that.m_iChannelWindow[j]]=-1;
				that.m_iChannelWindow[j]=-1;	
				if(that.m_bSound[j]) {
					$("#opensound").unbind();
					$("#opensound").bind({
						mouseover:function() {
							$(this).attr("src", '../images/public/VideoBottom/select/SelCloseSound.png');
						},
						mouseout:function() {
							$(this).attr("src", '../images/public/VideoBottom/normal/CloseSound.png');
						}
					});
					$("#opensound").attr("src",'../images/public/VideoBottom/normal/CloseSound.png');
					$("#opensound").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'opensound'));
					$(window.parent.document.getElementById("volumeDiv")).hide();
				}
				that.m_bSound[j]=0;
				if(iChannelNum == that.m_iCurWndChannel) {
					that.m_iCurWndChannel = -1;
					$("#Ezoom").attr('src','../images/public/VideoBottom/disabled/DisZoom.png');
					$("#Ezoom").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'laEnableZoom'));
					$("#zoom3D").attr('src','../images/public/VideoBottom/disabled/Dis3D.png');
					$("#zoom3D").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'Start3DZoom'));					
					that.ResetVideoParam();
				}
			}
		}
		
		//是否全部录像
		that.m_bAllRecord = false;
		that.m_bAllPlay = false;
		$("#play").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'paStartAllView'));
		$("#play").attr("src","../images/public/VideoBottom/normal/RealPlayAll.png");
	}
	
	//全部录像
	this.RecordAll = function () {
		if(!that.m_bAllRecord) {
			for(var j = 0; j < (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum); j++) {
				var iChannelNum = j + 1;
				var ObjImg=document.getElementById("Record"+(iChannelNum)+"Img");
				if(that.m_bChannelRecord[j]==0) {
					if(that.m_bChannelPlay[j] == 1) {
						var time = new Date();
						var szFileName = "";
						var szHostName = "";
						if(g_oCommon.m_szHostName.indexOf("[") < 0) {
							szHostName = g_oCommon.m_szHostName;
						} else {
							szHostName = g_oCommon.m_szHostName.substring(1, g_oCommon.m_szHostName.length - 1).replaceAll(":", ".");
						}
						if(iChannelNum <= 9) {
							szFileName = szHostName + "_0" + iChannelNum + "_" + time.Format("yyyyMMddhhmmssS");
						} else {
							szFileName = szHostName + "_" + iChannelNum + "_" + time.Format("yyyyMMddhhmmssS");
						}
						var iRes = g_oCommon.m_PreviewOCX.HWP_StartSave(that.m_iChannelWindow[j],szFileName);
						if(0 == iRes) {
							ObjImg.src="../images/public/ICON/recording.png";
							ObjImg.title=parent.translator.translateNode(that.m_lxdPreview, 'stoprecord');
							that.m_bChannelRecord[j]=1;
						} else if(-2 == iRes) {
							that.m_bIsDiskFreeSpaceEnough = false;
							alert(parent.translator.translateNode(that.m_lxdPreview, 'FreeSpaceTips'));
							return;
						}
					}
				}
			}
		} else {
			that.StopRecordAll();
		}
		//是否全部录像
		that.m_bAllRecord = false;
		for(var i = 0; i < (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum); i++) {
			if(that.m_bChannelRecord[i]) {
				that.m_bAllRecord=true;
				break;
			}
		}
		if(that.m_bAllRecord) {
			$("#record").attr("src","../images/public/VideoBottom/normal/StopRecordAll.png");
			$("#record").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'stopAllRecord'));
			that.m_bIsDiskFreeSpaceEnough = true;
		} else {
			$("#record").attr("src","../images/public/VideoBottom/normal/RecordAll.png");
			$("#record").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'paStartAllRecord'));
		}
	}
	
	//停止全部录像
	this.StopRecordAll = function () {
		for(var j = 0; j < (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum); j++) {
			var iChannelNum = j + 1;
			var szRecord=parent.translator.translateNode(that.m_lxdPreview, 'jsRecord');	//录像
			var iRes =g_oCommon.m_PreviewOCX.HWP_StopSave(that.m_iChannelWindow[j]);
			if(0 == iRes) {
				document.getElementById("Record"+(iChannelNum)+"Img").src="../images/public/ICON/record.png";
				document.getElementById("Record"+(iChannelNum)+"Img").title=szRecord;
				that.m_bChannelRecord[j]=0;
				window.parent.g_oMain.showTipsDiv("",parent.translator.translateNode(that.m_lxdPreview, 'jsRecordAllSucc'));
			}
		}
	}
	
	//抓图
	this.CapturePicture = function () {
		if(that.m_bChannelPlay[that.m_iCurWndChannel-1]) {
			var time = new Date();
			var szFileName = "";
			var szHostName = "";
			if(g_oCommon.m_szHostName.indexOf("[") < 0) {
				szHostName = g_oCommon.m_szHostName;
			} else {
				szHostName = g_oCommon.m_szHostName.substring(1, g_oCommon.m_szHostName.length - 1).replaceAll(":", ".");
			}
			if(that.m_iWndChannel[that.m_iCurWnd] <= 9) {
				szFileName = szHostName + "_0" + that.m_iWndChannel[that.m_iCurWnd] + "_" + time.Format("yyyyMMddhhmmssS");
			} else {
				szFileName = szHostName + "_" + that.m_iWndChannel[that.m_iCurWnd] + "_" + time.Format("yyyyMMddhhmmssS");
			}
			
			var iRes = g_oCommon.m_PreviewOCX.HWP_CapturePicture(that.m_iCurWnd,szFileName);
			if(iRes == 0) {
				window.parent.g_oMain.showTipsDiv("",parent.translator.translateNode(that.m_lxdPreview, 'jsCaptureSucc'));
			} else if(iRes == -1) {
				var iError = g_oCommon.m_PreviewOCX.HWP_GetLastError();
				if(10 == iError || 9 == iError) {
					alert(parent.translator.translateNode(that.m_lxdPreview, 'jsCreateFileFailed'));
				} else {
					alert(parent.translator.translateNode(that.m_lxdPreview, 'capturefailed'));
				}
			} else if(-2 == iRes) {
				alert(parent.translator.translateNode(that.m_lxdPreview, 'FreeSpaceTips'))
			} else if(-3 == iRes) {
				alert(parent.translator.translateNode(that.m_lxdPreview, 'jsCreateFileFailed'));
			} else {
				//未定义
			}
		}
	}
	
	//设置字体颜色
	this.SetFontColor = function (iNum) {
		for(var j=0;j<(g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum);j++) {
			if((j+1)==iNum) {
				document.getElementById("Selected"+(j+1)+"color").style.color="#FF0000";
			} else {
				document.getElementById("Selected"+(j+1)+"color").style.color="#000000";
			}
		}
	}
	
	//鼠标移到预览按钮上，改变图标
	this.MouseOverPlay = function () {
		if(that.m_bAllPlay) {
			$("#play").attr("src","../images/public/VideoBottom/select/SelStopAll.png");
		} else {
			$("#play").attr("src","../images/public/VideoBottom/select/SelRealPlayAll.png");
		}
	}
	
	//鼠标移出预览按钮上，改变图标
	this.MouseOutPlay = function () {
		if(that.m_bAllPlay) {
			$("#play").attr("src","../images/public/VideoBottom/normal/StopAll.png");
		} else {
			$("#play").attr("src","../images/public/VideoBottom/normal/RealPlayAll.png");
		}
	}
	
	//鼠标移到电子放大按钮上，改变图标
	this.MouseOverZoom = function () {
		if(that.m_bChannelPlay[[that.m_iWndChannel[that.m_iCurWnd]] - 1]) {
			if(!that.m_bEnableEZoom[that.m_iCurWnd]) {
				$("#Ezoom").attr("src","../images/public/VideoBottom/select/SelZoom.png");
			} else {
				$("#Ezoom").attr("src","../images/public/VideoBottom/select/SelZoomEnable.png");
			}
		} else {
			$("#Ezoom").attr("src","../images/public/VideoBottom/disabled/DisZoom.png");
		}
	}
	
	//鼠标移出电子放大按钮上，改变图标
	this.MouseOutZoom = function () {
		if(that.m_bChannelPlay[[that.m_iWndChannel[that.m_iCurWnd]] - 1]) {
			if(!that.m_bEnableEZoom[that.m_iCurWnd]) {
				$("#Ezoom").attr("src","../images/public/VideoBottom/normal/Zoom_normal.png");
			} else {
				$("#Ezoom").attr("src","../images/public/VideoBottom/normal/ZoomEnable_normal.png");
			}
		} else {
			$("#Ezoom").attr("src","../images/public/VideoBottom/disabled/DisZoom.png");
		}
	}
	
	//鼠标移到3D定位按钮上，改变图标
	this.MouseOver3DZoom = function () {
		if(that.m_bChannelPlay[[that.m_iWndChannel[that.m_iCurWnd]] - 1]) {
			if(!that.m_bEnable3DZoom[that.m_iCurWnd]) {
				$("#zoom3D").attr("src","../images/public/VideoBottom/select/Sel3Dnormal.png");
			} else {
				$("#zoom3D").attr("src","../images/public/VideoBottom/select/Sel3DEnable.png");
			}
		} else {
			$("#zoom3D").attr("src","../images/public/VideoBottom/disabled/Dis3D.png");
		}
	}
	
	//鼠标移出3D定位按钮上，改变图标
	this.MouseOut3DZoom = function () {
		if(that.m_bChannelPlay[[that.m_iWndChannel[that.m_iCurWnd]] - 1]) {
			if(!that.m_bEnable3DZoom[that.m_iCurWnd]) {
				$("#zoom3D").attr("src","../images/public/VideoBottom/normal/3Dnormal.png");
			} else {
				$("#zoom3D").attr("src","../images/public/VideoBottom/normal/3DEnable.png");
			}
		} else {
			$("#zoom3D").attr("src","../images/public/VideoBottom/disabled/Dis3D.png");
		}
	}	
	
	//鼠标移到预览按钮上，改变图标
	this.MouseOverPlayRec = function () {
		if(that.m_bAllRecord) {
			$("#record").attr("src","../images/public/VideoBottom/select/SelStopRecordAll.png");
		} else {
			$("#record").attr("src","../images/public/VideoBottom/select/SelRecordAll.png");
		}
	}
	
	//鼠标移出预览按钮上，改变图标
	this.MouseOutPlayRec = function () {
		if(that.m_bAllRecord) {
			$("#record").attr("src","../images/public/VideoBottom/normal/StopRecordAll.png");
		} else {
			$("#record").attr("src","../images/public/VideoBottom/normal/RecordAll.png");
		}
	}
	
	//鼠标移出分割按钮上
	this.MouseOutWnd = function (iWindowType) {
		if(that.m_iCurWndNum==iWindowType*iWindowType) {
			$(window.parent.document.getElementById("wnd"+that.m_iCurWndNum)).attr("src","../images/public/Arrange/PushWnd"+that.m_iCurWndNum+".png");
		} else {
			$(window.parent.document.getElementById("wnd"+iWindowType*iWindowType)).attr("src","../images/public/Arrange/Wnd"+iWindowType*iWindowType+".png");
		}
	}
	
	//改变窗口模式
	this.ChangeWnd = function (iWindowType) {
		if(that.m_iCurWndNum == iWindowType*iWindowType) {
			return ;
		}
		that.m_iCurWndNum=iWindowType*iWindowType;
		var iAllChannelNum = (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum); 
		if(iAllChannelNum <= that.m_iCurWndNum) {
			that.m_bIsSupportPage = false;
			$("#frontpage").attr("src",'../images/public/VideoBottom/disabled/Preview_DisFrontPage.png');
			$("#nextpage").attr("src",'../images/public/VideoBottom/disabled/Preview_DisNextPage.png');
		} else {
			that.m_bIsSupportPage = true;
			$("#frontpage").attr("src",'../images/public/VideoBottom/normal/Preview_FrontPage.png');
			$("#nextpage").attr("src",'../images/public/VideoBottom/normal/Preview_NextPage.png');
		}
		if (0 == (iAllChannelNum % that.m_iCurWndNum)) {
			that.m_iTotalPageNum = (iAllChannelNum / that.m_iCurWndNum);
		} else {
			that.m_iTotalPageNum = parseInt(iAllChannelNum / that.m_iCurWndNum, 10) + 1;
		}
		that.m_iCurrentPageNum = 0;
		g_oCommon.m_PreviewOCX.HWP_ArrangeWindow(iWindowType);
		for(var i = 1; i < 5; i++) {
			if(i!=iWindowType) {
				$(window.parent.document.getElementById("wnd"+i*i)).attr("src","../images/public/Arrange/Wnd"+i*i+".png");
			} else {
				$(window.parent.document.getElementById("wnd"+i*i)).attr("src","../images/public/Arrange/PushWnd"+i*i+".png");
			}
		}
	}
	
	//上一页
	this.Frontpage = function () {
		if((g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum) <= that.m_iCurWndNum) {
			return;
		}
		if (1 == that.m_iCurWndNum) {
			var iChannelNumber = that.m_iWndChannel[0];
			that.StopRealPlayAll();
			if (-1 == iChannelNumber) {
				that.m_iCurrentPageNum--;
			} else {
				that.m_iCurrentPageNum = iChannelNumber - 1;
			}
			if (that.m_iCurrentPageNum < 1) {
				that.m_iCurrentPageNum = that.m_iTotalPageNum;
			}
			that.StartRealPlay(that.m_iCurrentPageNum, 0);
		} else {
			that.StopRealPlayAll();
			that.m_iCurrentPageNum--;
			if (that.m_iCurrentPageNum < 1) {
				that.m_iCurrentPageNum = that.m_iTotalPageNum;
			}
			var iCurrentWindow = 0;
			for (var i = (that.m_iCurrentPageNum - 1) * that.m_iCurWndNum; i < (that.m_iCurrentPageNum * that.m_iCurWndNum); i++) {
				if (i < (g_oCommon.m_iAnalogChannelNum + g_oCommon.m_iDigitalChannelNum + g_oCommon.m_iZeroChanNum)) {
					that.StartRealPlay(i+1, iCurrentWindow);
				} else {
					break;
				}
				iCurrentWindow++;
			}
		}
	}
	
	//下一页
	this.Nextpage = function () {
		if((g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum+g_oCommon.m_iZeroChanNum) <= that.m_iCurWndNum) {
			return;
		}
		if (1 == that.m_iCurWndNum) {
			var iChannelNumber = that.m_iWndChannel[0];
			that.StopRealPlayAll();
			if (-1 == iChannelNumber) {
				that.m_iCurrentPageNum++;
			} else {
				that.m_iCurrentPageNum = iChannelNumber + 1;
			}
			if (that.m_iCurrentPageNum > that.m_iTotalPageNum) {
				that.m_iCurrentPageNum = 1;
			}
			that.StartRealPlay(that.m_iCurrentPageNum, 0);
		} else {
			that.StopRealPlayAll();
			that.m_iCurrentPageNum++;
			if (that.m_iCurrentPageNum > that.m_iTotalPageNum) {
				that.m_iCurrentPageNum = 1;
			}
			var iCurrentWindow = 0;
			for (var i = (that.m_iCurrentPageNum - 1) * that.m_iCurWndNum; i < (that.m_iCurrentPageNum * that.m_iCurWndNum); i++) {
				if (i < (g_oCommon.m_iAnalogChannelNum + g_oCommon.m_iDigitalChannelNum + g_oCommon.m_iZeroChanNum)) {
					that.StartRealPlay(i+1, iCurrentWindow);
				} else {
					break;
				}
				iCurrentWindow++;
			}
			that.SetFontColor(that.m_iWndChannel[that.m_iCurWnd]);
		}
	}
	
	//全屏控制
	this.FullScreen = function () {
		g_oCommon.m_PreviewOCX.HWP_FullScreenDisplay(true);
	}
	//声音控制
	this.OpenSound = function () {
		if(that.m_bChannelPlay[that.m_iCurWndChannel-1] == 1) {
			if(!that.m_bSound[that.m_iCurWndChannel-1]) {
				for(var i = 0 ;i < 256; i++) {
					if(that.m_bSound[i]) {
						g_oCommon.m_PreviewOCX.HWP_CloseSound();
						that.m_bSound[i] = 0;
					}
				}
				if(0 == g_oCommon.m_PreviewOCX.HWP_OpenSound(that.m_iCurWnd)) {
					$("#opensound").unbind();
					$("#opensound").bind({
						mouseover:function() {
							$(this).attr("src", '../images/public/VideoBottom/select/SelOpenSound.png');
							$(window.parent.document.getElementById("volumeDiv")).show();
						},
						mouseout:function() {
							$(this).attr("src", '../images/public/VideoBottom/normal/OpenSound.png');
						}
					});
					$("#opensound").attr("src",'../images/public/VideoBottom/normal/OpenSound.png');
					$("#opensound").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'closesound'));
					
					that.m_bSound[that.m_iCurWndChannel-1]=1;
					$(window.parent.document.getElementById("volumeDiv")).show();
					that.SetVolume(50);
				} else {
					var iError = g_oCommon.m_PreviewOCX.HWP_GetLastError();
					if(25 == iError) {  //声音设备被占用
						alert(parent.translator.translateNode(that.m_lxdPreview, 'jsOpenSoundFailed'));//提示语待定
					}
				}
			} else {
				g_oCommon.m_PreviewOCX.HWP_CloseSound();
				$("#opensound").unbind();
				$("#opensound").bind({
					mouseover:function() {
						$(this).attr("src", '../images/public/VideoBottom/select/SelCloseSound.png');
					},
					mouseout:function() {
						$(this).attr("src", '../images/public/VideoBottom/normal/CloseSound.png');
					}
				});
				$("#opensound").attr("src",'../images/public/VideoBottom/normal/CloseSound.png');
				$("#opensound").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'opensound'));
				that.m_bSound[that.m_iCurWndChannel-1]=0;
				$(window.parent.document.getElementById("volumeDiv")).hide();
			}
		}
	}
	
	//设置音量
	this.SetVolume = function (lVolume) {
		if(0==g_oCommon.m_PreviewOCX.HWP_SetVolume(that.m_iCurWnd,lVolume)) {
			window.parent.m_oSliderVolume.wsetValue(lVolume);
			window.parent.m_oSliderVolume.setTitle(''+lVolume);
		}
	}
	//改变页面语言
	var g_transStack = new parent.TransStack();
	this.changeLanguage = function (lan) {
		that.m_lxdPreview = parent.translator.getLanguageXmlDoc("Preview", lan);
		parent.translator.appendLanguageXmlDoc(that.m_lxdPreview, parent.g_oMain.m_lxdMain);
		parent.translator.translatePage(that.m_lxdPreview, document);
		window.parent.document.title = parent.translator.translateNode(that.m_lxdPreview, "title");
		g_oCommon.m_szExit = parent.translator.translateNode(that.m_lxdPreview, "exit");
		//添加云台操作提示语
		$("#ptzZoomIn").attr("title", g_oCommon.getNodeValue("laZoom")+" +");
		$("#ptzZoomOut").attr("title", g_oCommon.getNodeValue("laZoom")+" -");
		$("#laZoom").attr("title", g_oCommon.getNodeValue("laZoom"));
		$("#ptzFocusOut").attr("title", g_oCommon.getNodeValue("laFocus")+" +");
		$("#ptzFocusIn").attr("title", g_oCommon.getNodeValue("laFocus")+" -");
		$("#laFocus").attr("title", g_oCommon.getNodeValue("laFocus"));
		$("#ptzIrisOpen").attr("title", g_oCommon.getNodeValue("laIris")+" +");
		$("#ptzIrisClose").attr("title", g_oCommon.getNodeValue("laIris")+" -");
		$("#laIris").attr("title", g_oCommon.getNodeValue("laIris"));
		
		$("#ExcutePreset").attr("title", g_oCommon.getNodeValue("ExcutePreset"));
		$("#SetPreset").attr("title", g_oCommon.getNodeValue("SetPreset"));
		
		$("#ImgStartPatrol").attr("title", g_oCommon.getNodeValue("Start"));
		$("#ImgStopPatrol").attr("title", g_oCommon.getNodeValue("stop"));
		$("#ImgSavePatrol").attr("title", g_oCommon.getNodeValue("laSaveBtn"));
		
		$("#ImgStartPattern").attr("title", g_oCommon.getNodeValue("Start"));
		$("#ImgStopPattern").attr("title", g_oCommon.getNodeValue("stop"));
		$("#StartPatternRecord").attr("title", g_oCommon.getNodeValue("StartSave"));
		$("#StopPatternRecord").attr("title", g_oCommon.getNodeValue("StopSave"));	
		
		$("#light").attr("title", g_oCommon.getNodeValue("laLight"));
		$("#rain").attr("title", g_oCommon.getNodeValue("laWiper"));
		
		//翻译
		for(var i=0;i<(g_oCommon.m_iAnalogChannelNum + g_oCommon.m_iDigitalChannelNum + g_oCommon.m_iZeroChanNum);i++) {
			if(that.m_bChannelPlay[i] == 1) {
				$("#Camera"+(i+1)+"Img").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'stoppreview'));
			} else {
				$("#Camera"+(i+1)+"Img").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'jsPreview'));
			}
			if(that.m_bChannelRecord[i]) {
				$("#Record"+(i+1)+"Img").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'stoprecord'));
			} else {
				$("#Record"+(i+1)+"Img").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'jsRecord'));
			}
		}
		//是否全部预览
		if(that.m_bAllPlay) {
			$("#play").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'geStopAllViewing'));
		} else {
			$("#play").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'paStartAllView'));
		}
		//是否全部录像
		if(that.m_bAllRecord) {
			$("#record").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'stopAllRecord'));
		} else {
			$("#record").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'paStartAllRecord'));
		}
		if(that.m_bSound[that.m_iCurWndChannel-1]) {
			$("#opensound").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'closesound'));
		} else {
			$("#opensound").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'opensound'));
		}
		if(g_oCommon.m_bTalk == 0) {
			$("#voiceTalk").attr("title", g_oCommon.getNodeValue('voiceTalk') );
		} else {
			$("#voiceTalk").attr("title", g_oCommon.getNodeValue('StopvoiceTalk') );
		}
		if(that.m_bEnableEZoom[that.m_iCurWndChannel-1]) {
			$("#Ezoom").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'laDisableZoom'));
		} else {
			$("#Ezoom").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'laEnableZoom'));
		}
		if(that.m_bEnable3DZoom[that.m_iCurWndChannel-1]) {
			$("#zoom3D").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'Stop3DZoom'));
		} else {
			$("#zoom3D").attr("title",parent.translator.translateNode(that.m_lxdPreview, 'Start3DZoom'));
		}		
		
		$("#fullscreen").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'fullscreen') );
		that.m_oSliderPtzSpd.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'ptzSpeed') + ':' + (m_iPtzSpeed > 90 ? 7 : parseInt(m_iPtzSpeed/15)));  //云台活动条提示
		
		that.m_oSliderBright.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laBrightness') + ':' + that.m_oSliderBright.getValue());
		that.m_oSliderContrast.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laContrast') + ':' + that.m_oSliderContrast.getValue());
		that.m_oSliderSaturation.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSaturation') + ':' + that.m_oSliderSaturation.getValue());
		that.m_oSliderHue.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laHue') + ':' + that.m_oSliderHue.getValue());
		
		$('#VideoDefault').attr('title', parent.translator.translateNode(that.m_lxdPreview, 'geDefault'));
		$('#VideoDefault').html('&nbsp;&nbsp;' + parent.translator.translateNode(that.m_lxdPreview, 'geDefault'));
		
		that.InitPatrolLan();
		that.InitPresetListLan();
	}
	//获取视频参数
	this.GetVideoParam = function (iChannel) {
		if(-1 == iChannel) {
			return;
		}
		var iPlayChannelId = g_oCommon.m_iChannelId[iChannel-1];
		that.GetVideoParamCab(iChannel); //获取视频参数默认值
		var szURL='';
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/Image/channels/" + iPlayChannelId;
		} else if(iChannel <= (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)) {
			szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/ContentMgmt/ImageProxy/channels/" + iPlayChannelId;
		} else {
			that.ResetVideoParam();
			return;
		}
		$.ajax({
		    type: "get",
			url:  szURL,
			timeout: 15000,
			async: false,
			beforeSend: function (xhr) {
			    xhr.setRequestHeader("If-Modified-Since", 0);
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			success: function (xmlDoc, textStatus, xhr) {
				that.m_szXmlStr = xhr.responseText;
				if($(xmlDoc).find("brightnessLevel").length > 0) {
					that.m_iBright = parseInt($(xmlDoc).find("brightnessLevel").eq(0).text(), 10);
				} else {
					that.m_iBright = 0;
				}
				if($(xmlDoc).find("contrastLevel").length > 0) {
					that.m_iContrast = parseInt($(xmlDoc).find("contrastLevel").eq(0).text(), 10);
				} else {
					that.m_iContrast = 0;
				}
				if($(xmlDoc).find("saturationLevel").length > 0) {
					that.m_iSaturation = parseInt($(xmlDoc).find("saturationLevel").eq(0).text(), 10);
				} else {
					that.m_iSaturation = 0;
				}
				if($(xmlDoc).find("hueLevel").length > 0) {
					that.m_iHue = parseInt($(xmlDoc).find("hueLevel").eq(0).text(), 10);
				} else {
					that.m_iHue = 0;
				}
				if(that.m_bSupportScene) {
					$(document.getElementsByName("raVideoParamMode")).each(function() {
						if(this.value == $(xmlDoc).find('imageMode').eq(0).text()) {
							this.checked = true;

						}
					});
					that.m_iSharpness = parseInt($(xmlDoc).find("sharpnessLevel").eq(0).text(), 10);		
					that.m_iNoiseReduce = parseInt($(xmlDoc).find("generalLevel").eq(0).text(), 10);	
				} else {
					that.m_iSharpness = 0;
					that.m_iNoiseReduce = 0;
				}
				that.m_oSliderBright.wsetValue(that.m_iBright);
				that.m_oSliderContrast.wsetValue(that.m_iContrast);
				that.m_oSliderSaturation.wsetValue(that.m_iSaturation);
				that.m_oSliderHue.wsetValue(that.m_iHue);
				that.m_oSliderSharpness.wsetValue(that.m_iSharpness);
				that.m_oSliderNoiseReduce.wsetValue(that.m_iNoiseReduce);
				
				that.m_oSliderBright.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laBrightness') + ':' + that.m_oSliderBright.getValue());
				that.m_oSliderContrast.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laContrast') + ':' + that.m_oSliderContrast.getValue());
				that.m_oSliderSaturation.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSaturation') + ':' + that.m_oSliderSaturation.getValue());
				that.m_oSliderHue.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laHue') + ':' + that.m_oSliderHue.getValue());
				that.m_oSliderSharpness.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSharpness') + ':' + that.m_iSharpness);
				that.m_oSliderNoiseReduce.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laNoiseReduce') + ':' + that.m_iNoiseReduce);
			},
			error: function (xhr, textStatus, errorThrown) {
				that.m_szXmlStr = "";
			}
		});			
	}
	
	//设置视频参数的亮度
	this.SetVideoParamBri = function (iBright) {
		if(that.m_iCurWndChannel == -1 || that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)) {
			that.m_iBright = that.m_iBrightMin;
			return;
		}
		if(iBright > that.m_iBrightMax || iBright < that.m_iBrightMin) {
			return;
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(that.m_szXmlStr);
		if($(xmlDoc).find("brightnessLevel").length > 0) {
			$(xmlDoc).find("brightnessLevel").eq(0).text(iBright);
			that.SetVideoParam(that.m_iCurWndChannel,xmlDoc);
		} else {
			that.m_iBright = that.m_iBrightMin;
			that.m_oSliderBright.wsetValue(that.m_iBright);
			that.m_oSliderBright.setTitle(parent.translator.translateNode(that.m_lxdPreview, "laBrightness") + ":" + that.m_oSliderBright.getValue());

		}
	}
	//设置视频参数的对比度
	this.SetVideoParamCon = function (iContrast) {
		if(that.m_iCurWndChannel == -1 || that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)) {
			that.m_iContrast = that.m_iContrastMin;
			return;
		}
		if(iContrast > that.m_iContrastMax || iContrast < that.m_iContrastMin) {
			return;
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(that.m_szXmlStr);
		if($(xmlDoc).find("contrastLevel").length > 0) {
			$(xmlDoc).find("contrastLevel").eq(0).text(iContrast);
			that.SetVideoParam(that.m_iCurWndChannel,xmlDoc);
		} else {
			that.m_iContrast = that.m_iContrastMin;
			that.m_oSliderContrast.wsetValue(that.m_iContrast);
			that.m_oSliderContrast.setTitle(parent.translator.translateNode(that.m_lxdPreview, "laContrast") + ":" + that.m_oSliderContrast.getValue());

		}
	}
	//设置视频参数的饱和度
	this.SetVideoParamSat = function (iSaturation) {
		if(that.m_iCurWndChannel == -1 || that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)) {
			that.m_iSaturation = that.m_iSaturationMin;
			return;
		}
		if(iSaturation > that.m_iSaturationMax || iSaturation < that.m_iSaturationMin) {
			return;
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(that.m_szXmlStr);
		if($(xmlDoc).find("saturationLevel").length > 0) {
			$(xmlDoc).find("saturationLevel").eq(0).text(iSaturation);
			that.SetVideoParam(that.m_iCurWndChannel,xmlDoc);
		} else {
			that.m_iSaturation = that.m_iSaturationMin;
			that.m_oSliderSaturation.wsetValue(that.m_iSaturation);
			that.m_oSliderSaturation.setTitle(parent.translator.translateNode(that.m_lxdPreview, "laSaturation") + ":" + that.m_oSliderSaturation.getValue());

		}
	}
	//设置视频参数的色调
	this.SetVideoParamHue = function (iHue) {
		if(that.m_iCurWndChannel == -1 || that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)) {
			that.m_iHue = that.m_iHueMin;
			return;
		}
		if(iHue > that.m_iHueMax || iHue < that.m_iHueMin) {
			return;
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(that.m_szXmlStr);
		if($(xmlDoc).find("hueLevel").length > 0) {
			$(xmlDoc).find("hueLevel").eq(0).text(iHue);
			that.SetVideoParam(that.m_iCurWndChannel,xmlDoc);
		} else {
			that.m_iHue = that.m_iHueMin;
			that.m_oSliderHue.wsetValue(that.m_iHue);
			that.m_oSliderHue.setTitle(parent.translator.translateNode(that.m_lxdPreview, "laHue") + ":" + that.m_oSliderHue.getValue());

		}
	}
	//设置视频参数的锐度
	this.SetVideoParamSharp = function (iSharpness) {
		if(that.m_iCurWndChannel == -1 || that.m_iCurWndChannel > g_oCommon.m_iAnalogChannelNum) {
			that.m_iSharpness = that.m_iSharpnessMin;
			return;
		}
		if(iSharpness > that.m_iSharpnessMax || iSharpness < that.m_iSharpnessMin) {
			return;
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(that.m_szXmlStr);
		if($(xmlDoc).find("sharpnessLevel").length > 0) {
			$(xmlDoc).find("sharpnessLevel").eq(0).text(iSharpness);
			that.SetVideoParam(that.m_iCurWndChannel,xmlDoc);
		} else {
			that.m_iSharpness = that.m_iSharpnessMin;
			that.m_oSliderSharpness.wsetValue(that.m_iSharpness);
			that.m_oSliderSharpness.setTitle(parent.translator.translateNode(that.m_lxdPreview, "laSharpness") + ":" + that.m_oSliderSharpness.getValue());

		}
	}
	//设置视频参数的去噪
	this.SetVideoParamNoise = function (iReduceNoise) {
		if(that.m_iCurWndChannel == -1 || that.m_iCurWndChannel > g_oCommon.m_iAnalogChannelNum) {
			that.m_iNoiseReduce = that.m_iNoiseReduceMin;
			return;
		}
		if(iReduceNoise > that.m_iNoiseReduceMax || iReduceNoise < that.m_iNoiseReduceMin) {
			return;
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(that.m_szXmlStr);
		if($(xmlDoc).find("generalLevel").length > 0) {
			$(xmlDoc).find("generalLevel").eq(0).text(iReduceNoise);
			that.SetVideoParam(that.m_iCurWndChannel,xmlDoc);
		} else {
			that.m_iNoiseReduce = that.m_iNoiseReduceMin;
			that.m_oSliderNoiseReduce.wsetValue(that.m_iNoiseReduce);
			that.m_oSliderNoiseReduce.setTitle(parent.translator.translateNode(that.m_lxdPreview, "laNoiseReduce") + ":" + that.m_oSliderNoiseReduce.getValue());

		}
	}
	//恢复默认
	this.SetVideoDefault = function () {
		if(that.m_iCurWndChannel == -1 || that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)) {
			return;
		}
		if(!confirm(parent.translator.translateNode(that.m_lxdPreview, 'jsVideoDefault'),parent.translator.translateNode(that.m_lxdPreview, 'jsTrue'),parent.translator.translateNode(that.m_lxdPreview, 'jsFalse'))) {
			return;
		}
		if(that.m_bSupportScene){
			var iIndex = 0;
			$(document.getElementsByName("raVideoParamMode")).each(function(i) {
				if(this.checked) {
					iIndex = i;
					return;
				}
			});
			that.m_iBright = that.m_iSceneParamDef[iIndex][0];
			that.m_iContrast = that.m_iSceneParamDef[iIndex][1];
			that.m_iSaturation = that.m_iSceneParamDef[iIndex][2];
			that.m_iHue = that.m_iSceneParamDef[iIndex][3];
			that.m_iSharpness = that.m_iSceneParamDef[iIndex][4];
			that.m_iNoiseReduce = that.m_iSceneParamDef[iIndex][5];
		} else {
			that.m_iBright = that.m_iBrightDefault;
			that.m_iContrast = that.m_iContrastDefault;
			that.m_iSaturation = that.m_iSaturationDefault;
			that.m_iHue = that.m_iHueDefault;
			that.m_iSharpness = that.m_iSharpnessDefault;
			that.m_iNoiseReduce = that.m_iNoiseReduceDefault;
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(that.m_szXmlStr);
		if(xmlDoc === null) {
			return;
		}
		$(xmlDoc).find("brightnessLevel").eq(0).text(that.m_iBright);
		$(xmlDoc).find("contrastLevel").eq(0).text(that.m_iContrast);
		$(xmlDoc).find("saturationLevel").eq(0).text(that.m_iSaturation);
		$(xmlDoc).find("hueLevel").eq(0).text(that.m_iHue);
		$(xmlDoc).find("sharpnessLevel").eq(0).text(that.m_iSharpness);
		$(xmlDoc).find("generalLevel").eq(0).text(that.m_iNoiseReduce);
		that.m_oSliderBright.wsetValue(that.m_iBright);
		that.m_oSliderContrast.wsetValue(that.m_iContrast);
		that.m_oSliderSaturation.wsetValue(that.m_iSaturation);
		that.m_oSliderHue.wsetValue(that.m_iHue);
		that.m_oSliderBright.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laBrightness') + ':' + that.m_oSliderBright.getValue());
		that.m_oSliderContrast.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laContrast') + ':' + that.m_oSliderContrast.getValue());
		that.m_oSliderSaturation.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSaturation') + ':' + that.m_oSliderSaturation.getValue());
		that.m_oSliderHue.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laHue') + ':' + that.m_oSliderHue.getValue());
		if(that.m_bSupportScene) {
			that.m_oSliderSharpness.wsetValue(that.m_iSharpness);
			that.m_oSliderNoiseReduce.wsetValue(that.m_iNoiseReduce);		
			that.m_oSliderSharpness.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSharpness') + ':' + that.m_oSliderSharpness.getValue());
			that.m_oSliderNoiseReduce.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laNoiseReduce') + ':' + that.m_oSliderNoiseReduce.getValue());
		}
		that.SetVideoParam(that.m_iCurWndChannel,xmlDoc);
	}
	//设置视频参数
	this.SetVideoParam = function (iChannel, xmlDoc) {
		var iPlayChannelId = g_oCommon.m_iChannelId[iChannel-1];
		var szURL='';
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			szURL=g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/Image/channels/" + iPlayChannelId;
		} else if(iChannel <= (g_oCommon.m_iAnalogChannelNum + g_oCommon.m_iDigitalChannelNum)) {
			szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/ContentMgmt/ImageProxy/channels/" + iPlayChannelId;
		} else {
			that.ResetVideoParam();
			return;
		}
		that.m_szXmlStr = g_oCommon.xmlToStr(xmlDoc);
		$.ajax({
		    type: "put",
			url: szURL,
			timeout: 15000,
			async: false,
			processData: false,
			data: xmlDoc,
			beforeSend: function (xhr) {
			    xhr.setRequestHeader("If-Modified-Since", 0);
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.GetVideoParam(that.m_iCurWndChannel);
				that.setState(xhr);
			},
			success: function (xmlDoc, textStatus, xhr) {
				that.GetVideoParam(that.m_iCurWndChannel);  //设置成功也需要重新获取参数，存在默认值和设备不符或者设备不支持的情况
			}
		});
	}
	
	//SetZoomInStart
	this.SetZoomInStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" +
			"<zoom>" + (m_iPtzSpeed) + "</zoom>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}
		});
	}
	
	this.setState = function (xhr) {
		var xmlDoc = xhr.responseXML;
		var subState = $(xmlDoc).find("subStatusCode").eq(0).text();
		if(subState === "lowPrivilege") {
			alert(parent.translator.translateNode(that.m_lxdPreview, "jsNoOperationRight"));
		} else if(subState ===  "notSupport") {
			alert(parent.translator.translateNode(that.m_lxdPreview, "Error77"));
		} else {
			alert(parent.translator.translateNode(that.m_lxdPreview, "jsNetError"));
		}
	}
	
	//停止云台自转
	this.StopPTZAuto = function () {
		if(that.m_bPTZAuto[that.m_iCurWndChannel-1]) {
			that.ptzAuto();	//如果云台自转，就停止
		}
	}
	
	//SetZoomOutStart
	this.SetZoomOutStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" +
			"<zoom>" + (-m_iPtzSpeed) + "</zoom>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//停止PTZ操作
	this.SetPTZStop = function (iType) {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml;
		if(iType == 0) {
			szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + 0 + "</pan>" +
			"<tilt>" + 0 + "</tilt>" +
			"</PTZData>";
		} else {
			szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" +
			"<zoom>" + 0 + "</zoom>" +
			"</PTZData>";
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				//that.setState(xhr);
			}		
		});
	}
	
	//开始向左转
	this.SetPTZLeftStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + (-m_iPtzSpeed) + "</pan>" +
			"<tilt>" + 0 + "</tilt>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//开始向左上转
	this.SetPTZLeftUpStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + (-m_iPtzSpeed) + "</pan>" +
			"<tilt>" + (m_iPtzSpeed) + "</tilt>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//开始向左下转
	this.SetPTZLeftDownStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + (-m_iPtzSpeed) + "</pan>" +
			"<tilt>" + (-m_iPtzSpeed) + "</tilt>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//开始向右转
	this.SetPTZRightStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + (m_iPtzSpeed) + "</pan>" +
			"<tilt>" + 0 + "</tilt>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//开始向右上转
	this.SetPTZRightUpStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + (m_iPtzSpeed) + "</pan>" +
			"<tilt>" + (m_iPtzSpeed) + "</tilt>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//开始向右下转
	this.SetPTZRightDownStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + (m_iPtzSpeed) + "</pan>" +
			"<tilt>" + (-m_iPtzSpeed) + "</tilt>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}	
		});
	}
	
	
	//SetPTZUpStart
	this.SetPTZUpStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + 0 + "</pan>" +
			"<tilt>" + (m_iPtzSpeed) + "</tilt>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}
		});
	}
	
	//SetPTZDownStart
	this.SetPTZDownStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><PTZData version='1.0' xmlns='urn:psialliance-org'>" + 
			"<pan>" + 0 + "</pan>" +
			"<tilt>" + (-m_iPtzSpeed) + "</tilt>" +
			"</PTZData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/continuous";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/continuous";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//云台自动
	this.ptzAuto = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = '';
		if(!that.m_bPTZAuto[that.m_iCurWndChannel-1]) {
			szSetXml = "<?xml version='1.0' encoding='UTF-8'?><autoPanData version='1.0'><autoPan>" + (m_iPtzSpeed) + "</autoPan></autoPanData>";
		} else {
			szSetXml = "<?xml version='1.0' encoding='UTF-8'?><autoPanData version='1.0'><autoPan>0</autoPan></autoPanData>";
		}
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/autoPan";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/autoPan";
		}
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			success: function(xmlDoc, textStatus, xhr) {
				that.m_bPTZAuto[that.m_iCurWndChannel-1]=!that.m_bPTZAuto[that.m_iCurWndChannel-1];
				if(that.m_bPTZAuto[that.m_iCurWndChannel-1]) {
					$("#ptzAutoId").attr("src","../images/ptz/auto.png");
				} else {
					$("#ptzAutoId").attr("src","../images/ptz/ptz_normal/auto.png");
				}				
			},
			error:function (xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}
		});
	}
	/*************************************************
	Function:		SetFocusInStart
	Description:	
	Input:			无
	Output:			无
	return:			无
	*************************************************/
	this.SetFocusInStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><FocusData version='1.0' xmlns='urn:psialliance-org'>" +
			"<focus>" + (m_iPtzSpeed) + "</focus>" +
			"</FocusData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/Image/channels/" + iChannel + "/focus";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/ImageProxy/channels/" + iChannel + "/focus";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//SetFocusStop
	this.SetFocusStop = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><FocusData version='1.0' xmlns='urn:psialliance-org'>" +
			"<focus>" + 0 + "</focus>" +
			"</FocusData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/Image/channels/" + iChannel + "/focus";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/ImageProxy/channels/" + iChannel + "/focus";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//SetFocusOutStart
	this.SetFocusOutStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><FocusData version='1.0' xmlns='urn:psialliance-org'>" +
			"<focus>" + (-m_iPtzSpeed) + "</focus>" +
			"</FocusData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/Image/channels/" + iChannel + "/focus";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/ImageProxy/channels/" + iChannel + "/focus";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//IrisInStart
	this.IrisInStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><IrisData version='1.0' xmlns='urn:psialliance-org'>" +
			"<iris>" + (m_iPtzSpeed) + "</iris>" +
			"</IrisData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/Image/channels/"+iChannel+"/iris";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/ImageProxy/channels/"+iChannel+"/iris";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//IrisOutStart
	this.IrisOutStart = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><IrisData version='1.0' xmlns='urn:psialliance-org'>" +
			"<iris>" + (-m_iPtzSpeed) + "</iris>" +
			"</IrisData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/Image/channels/"+iChannel+"/iris";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/ImageProxy/channels/"+iChannel+"/iris";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//IrisStop
	this.IrisStop = function () {	
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szSetXml = "<?xml version='1.0' encoding='UTF-8'?><IrisData version='1.0' xmlns='urn:psialliance-org'>" +
			"<iris>" + 0 + "</iris>" +
			"</IrisData>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szSetXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/Image/channels/"+iChannel+"/iris";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/ImageProxy/channels/"+iChannel+"/iris";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//设置预置点
	this.SetPresetFun = function (iPresetId) {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var szXml = "<?xml version='1.0' encoding='UTF-8'?><PTZPreset version='1.0' xmlns='urn:psialliance-org'><id>"+iPresetId+"</id><presetName>Camera" + iChannel + "Preset" + iPresetId+"</presetName></PTZPreset>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szXml);
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/presets/"+ iPresetId;
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/presets/"+ iPresetId;
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//调用预置点
	this.GotoPreset = function (iPresetId) {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		that.StopPTZAuto();
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/presets/"+ iPresetId +"/goto";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/presets/"+ iPresetId +"/goto";
		}
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: null,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//初始化预览页面滑动条
	this.InitSlider = function () {
		var iStep = 1;
		that.m_oSliderBright = new neverModules.modules.slider({
			targetId: "VideoBright",
			sliderCss: "imageSlider1",
			barCss: "imageBar2",
			boxCss: "boxBar",
			bBox:true,
			step: iStep,
			min: that.m_iBrightMin,
			max: that.m_iBrightMax,
			hints:""
		}); 
		that.m_oSliderBright.create();
		that.m_oSliderBright.wsetValue(that.m_iBrightMin);
		that.m_oSliderBright.onchange = function () {
			if(that.m_iBright != that.m_oSliderBright.getValue()) {
				that.m_iBright = that.m_oSliderBright.getValue();
				if(that.m_iBright < 0) {
					that.m_iBright = that.m_oSliderBright.step;
					that.m_oSliderBright.wsetValue(that.m_iBright);
				}
				that.m_oSliderBright.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laBrightness') + ':' + that.m_oSliderBright.getValue());
			}
		};
		that.m_oSliderBright.onend = function () {	
			that.SetVideoParamBri(that.m_iBright);
		};
		
		that.m_oSliderContrast = new neverModules.modules.slider({
			targetId: "VideoContrast",
			sliderCss: "imageSlider1",
			barCss: "imageBar2",
			boxCss: "boxBar",
			bBox:true,			
			step: iStep,
			min: that.m_iContrastMin,
			max: that.m_iContrastMax,
			hints:""
		}); 
		that.m_oSliderContrast.create();
		that.m_oSliderContrast.wsetValue(that.m_iContrastMin);
		that.m_oSliderContrast.onchange = function () {
			if(that.m_iContrast != that.m_oSliderContrast.getValue()) {
				that.m_iContrast = that.m_oSliderContrast.getValue();
				if(that.m_iContrast < 0) {
					that.m_iContrast = that.m_oSliderContrast.step;
					that.m_oSliderContrast.wsetValue(that.m_iContrast);
				}
				that.m_oSliderContrast.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laContrast') + ':' + that.m_oSliderContrast.getValue());
			}
		};
		that.m_oSliderContrast.onend = function () {	
			that.SetVideoParamCon(that.m_iContrast);
		};
		
		that.m_oSliderSaturation = new neverModules.modules.slider({
			targetId: "VideoSaturation",
			sliderCss: "imageSlider1",
			barCss: "imageBar2",
			step: iStep,
			boxCss: "boxBar",
			bBox:true,			
			min: that.m_iSaturationMin,
			max: that.m_iSaturationMax,
			hints:""
		}); 
		that.m_oSliderSaturation.create();
		that.m_oSliderSaturation.wsetValue(that.m_iSaturationMin);
		that.m_oSliderSaturation.onchange = function () {
			if(that.m_iSaturation != that.m_oSliderSaturation.getValue()) {
				that.m_iSaturation = that.m_oSliderSaturation.getValue();
				if(that.m_iSaturation < 0) {
					that.m_iSaturation = that.m_oSliderSaturation.step;
					that.m_oSliderSaturation.wsetValue(that.m_iSaturation);
				}
				that.m_oSliderSaturation.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSaturation') + ':' + that.m_oSliderSaturation.getValue());
			}
		};
		that.m_oSliderSaturation.onend = function () {	
			that.SetVideoParamSat(that.m_iSaturation);
		};
		
		that.m_oSliderHue = new neverModules.modules.slider({
			targetId: "VideoHue",
			sliderCss: "imageSlider1",
			barCss: "imageBar2",
			boxCss: "boxBar",
			bBox:true,			
			step: iStep,
			min: that.m_iHueMin,
			max: that.m_iHueMax,
			hints:""
		}); 
		that.m_oSliderHue.create();
		that.m_oSliderHue.wsetValue(that.m_iHueMin);
		that.m_oSliderHue.onchange = function () {
			if(that.m_iHue != that.m_oSliderHue.getValue()) {
				that.m_iHue = that.m_oSliderHue.getValue();
				if(that.m_iHue < 0) {
					that.m_iHue = that.m_oSliderHue.step;
					that.m_oSliderHue.wsetValue(that.m_iHue);
				}
				that.m_oSliderHue.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laHue') + ':' + that.m_oSliderHue.getValue());
			}
		};
		that.m_oSliderHue.onend = function () {	
			that.SetVideoParamHue(that.m_iHue);
		};
		
		that.m_oSliderPtzSpd = new neverModules.modules.slider({
			targetId: "ptzSlider",
			sliderCss: "imageSlider2",
			barCss: "imageBar1",
			min: 1,
			max: 7,
			hints: ""
		}); 
		that.m_oSliderPtzSpd.create();
		that.m_oSliderPtzSpd.wsetValue(4);
		m_iPtzSpeed = 60;
		that.m_oSliderPtzSpd.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'ptzSpeed') + ':' + (m_iPtzSpeed > 90 ? 7 : parseInt(m_iPtzSpeed/15)));
		that.m_oSliderPtzSpd.onchange = function () {
			var spd= that.m_oSliderPtzSpd.getValue();
			if(spd < 7) {
			  m_iPtzSpeed = spd*15;
			} else {
			  m_iPtzSpeed = 100;
			}
			that.m_oSliderPtzSpd.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'ptzSpeed') + ':' + spd);  //云台活动条提示
		};
		
		that.m_oSliderSharpness = new neverModules.modules.slider({
			targetId: "VideoSharpness",
			sliderCss: "imageSlider1",
			barCss: "imageBar2",
			boxCss: "boxBar",
			bBox:true,			
			step: iStep,
			min: that.m_iSharpnessMin,
			max: that.m_iSharpnessMax,
			hints:""
		}); 
		that.m_oSliderSharpness.create();
		that.m_oSliderSharpness.wsetValue(that.m_iSharpnessMin);
		that.m_oSliderSharpness.onchange = function () {
			if(that.m_iSharpness != that.m_oSliderSharpness.getValue()) {
				that.m_iSharpness = that.m_oSliderSharpness.getValue();
				if(that.m_iSharpness < 0) {
					that.m_iSharpness = that.m_oSliderSharpness.step;
					that.m_oSliderSharpness.wsetValue(that.m_iSharpness);
				}
				that.m_oSliderSharpness.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSharpness') + ':' + that.m_oSliderSharpness.getValue());
			}
		};
		that.m_oSliderSharpness.onend = function () {
			that.SetVideoParamSharp(that.m_iSharpness);
		};
		
		that.m_oSliderNoiseReduce = new neverModules.modules.slider({
			targetId: "VideoNoiseReduce",
			sliderCss: "imageSlider1",
			barCss: "imageBar2",
			boxCss: "boxBar",
			bBox:true,			
			step: iStep,
			min: that.m_iNoiseReduceMin,
			max: that.m_iNoiseReduceMax,
			hints:""
		}); 
		that.m_oSliderNoiseReduce.create();
		that.m_oSliderNoiseReduce.wsetValue(that.m_iNoiseReduceMin);
		that.m_oSliderNoiseReduce.onchange = function () {
			if(that.m_iNoiseReduce != that.m_oSliderNoiseReduce.getValue()) {
				that.m_iNoiseReduce = that.m_oSliderNoiseReduce.getValue();
				if(that.m_iNoiseReduce < 0) {
					that.m_iNoiseReduce = that.m_oSliderNoiseReduce.step;
					that.m_oSliderNoiseReduce.wsetValue(that.m_iNoiseReduce);
				}
				that.m_oSliderNoiseReduce.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laNoiseReduce') + ':' + that.m_oSliderNoiseReduce.getValue());
			}
		};
		that.m_oSliderNoiseReduce.onend = function () {	

			that.SetVideoParamNoise(that.m_iNoiseReduce);
		};
	}
	
	//点击视频参数栏
	this.onClickVideoBar = function () {
		if(that.m_bVideoExpand) {
			//收缩视频栏
			$('#video_left').css('background-color', '#9b9b9b');
			$('#video_mid').css('background-color', '#c7c7c7');
			$('#video_right').css('background-color', '#9b9b9b');
			$('#video_direction').attr('src', '../images/ptz/direction_up.png');
			
			$('#videoParam').hide();
			$('#videoBottom').hide();
			$('#Preset').show();
			$('#presetParam').attr({height:1});
			$('#presetParam').attr({height:$(window).height() - $('#PTZ').height() - 63});
			that.m_bVideoExpand = false;
		} else {
			//展开视频栏
			$('#video_left').css('background-color', '#9b9b9b');
			$('#video_mid').css('background-color', '#c7c7c7');
			$('#video_right').css('background-color', '#9b9b9b');
			$('#video_direction').attr('src', '../images/ptz/direction_down.png');
			
			$('#videoParam').show();
			$('#videoBottom').show();
			$('#Preset').hide();
			that.m_bVideoExpand = true;
			//设置滑动条数值
			that.m_oSliderBright.wsetValue(that.m_iBright);
			that.m_oSliderContrast.wsetValue(that.m_iContrast);
			that.m_oSliderSaturation.wsetValue(that.m_iSaturation);
			that.m_oSliderHue.wsetValue(that.m_iHue);
			if($("#laSharpness_tr").css("display") !== "none") {
				that.m_oSliderSharpness.wsetValue(that.m_iSharpness);
				that.m_oSliderNoiseReduce.wsetValue(that.m_iNoiseReduce);
			}
		}
	}
	
	//选择预置点工具栏
	this.selectPresetBar = function (iMode) {
		if(0 == iMode) {
			$('#presetbg').css('backgroundImage', 'url(../images/ptz/tab_select.png)');
			$('#cruisebg').css('backgroundImage', 'url(../images/ptz/tab_normal.png)');
			$('#trackbg').css('backgroundImage', 'url(../images/ptz/tab_normal.png)');
			
			$("#PresetPic").attr("src","../images/ptz/preset-white.png");
			$("#PatrolPic").attr("src","../images/ptz/Cruise.png");
			$("#PatternPic").attr("src","../images/ptz/Track.png");
			
			$('#presetbg').width(56);
			$('#cruisebg').width(46);
			$('#trackbg').width(46);
			
			$('#PresetArea').show();
			$('#CruiseArea').hide();
			$('#TrackArea').hide();
		} else if(1 == iMode) {
			$('#presetbg').css('backgroundImage', 'url(../images/ptz/tab_normal.png)');
			$('#cruisebg').css('backgroundImage', 'url(../images/ptz/tab_select.png)');
			$('#trackbg').css('backgroundImage', 'url(../images/ptz/tab_normal.png)');
			
			$("#PresetPic").attr("src","../images/ptz/preset.png");
			$("#PatrolPic").attr("src","../images/ptz/Cruise-white.png");
			$("#PatternPic").attr("src","../images/ptz/Track.png");
			
			$('#presetbg').width(46);
			$('#cruisebg').width(56);
			$('#trackbg').width(46);
			
			$('#PresetArea').hide();
			$('#CruiseArea').show();
			$('#TrackArea').hide();
			
			that.GetPatrol(parseInt($('#selectPatrol').val()))
		} else {
			$('#presetbg').css('backgroundImage', 'url(../images/ptz/tab_normal.png)');
			$('#cruisebg').css('backgroundImage', 'url(../images/ptz/tab_normal.png)');
			$('#trackbg').css('backgroundImage', 'url(../images/ptz/tab_select.png)');
			
			$("#PresetPic").attr("src","../images/ptz/preset.png");
			$("#PatrolPic").attr("src","../images/ptz/Cruise.png");
			$("#PatternPic").attr("src","../images/ptz/Track-white.png");
			
			$('#presetbg').width(46);
			$('#cruisebg').width(46);
			$('#trackbg').width(56);
			
			$('#PresetArea').hide();
			$('#CruiseArea').hide();
			$('#TrackArea').show();
			
			that.selectPattern(document.getElementById('PatternTable').rows[1].childNodes[0].childNodes[0].rows[0]);
		}
	}
	
	//初始化预置点
	this.InitPreset = function () {
		var szName = parent.translator.translateNode(that.m_lxdPreview, 'laPreset');
		var innerHTML = '';
		for(var i = 1; i < 257; i++) {
			innerHTML+="<tr height='1' style='background-color:#CCC;'><td></td></tr><tr height='30'><td id='Preset"+(i)+"'><table cellspacing='0' cellpadding='0' width='100%' height='100%'><tr height='30' onClick='g_oPreviewInstance.selectPreset(this,"+i+")' style='cursor:pointer;' onMouseOver=\"javascript:if(this!=g_oPreviewInstance.m_oSelectPreset){this.style.backgroundColor='#FBFBC2';}\" onMouseOut=\"javascript:if(this!=g_oPreviewInstance.m_oSelectPreset){this.style.backgroundColor=''}\"><td width='7%' align='center' valign='middle'></td><td align='left' valign='middle' width='44%'><label name='laPreset'>"+ szName +"</label>"+" "+i+"</td><td width='17%' align='center' valign='middle'></td><td width='17%' align='center' valign='middle'></td></tr></table></td></tr>";
		}
		$('#PresetTable').html(innerHTML);	
	}
	
	//选择预置点
	this.selectPreset = function (obj, iIndex) {
		if(obj == that.m_oSelectPreset) {
			return;
		}
		if(null != that.m_oSelectPreset) {
			that.m_oSelectPreset.style.backgroundColor = '';
			//that.m_oSelectPreset.cells[0].innerHTML = "<img src='../images/ptz/preset_normal.png'/>";
			that.m_oSelectPreset.cells[1].style.color = '';
			that.m_oSelectPreset.cells[2].innerHTML= "";
			that.m_oSelectPreset.cells[3].innerHTML = "";
			//that.m_oSelectPreset.cells[4].childNodes[0].style.display = 'none';
		}
		obj.style.backgroundColor = '#762727';
		//obj.cells[0].innerHTML = "<img src='../images/ptz/preset_select.png'/>";
		obj.cells[1].style.color = '#FFFFFF';
		obj.cells[2].innerHTML= "<img id='ExcutePreset' src='../images/ptz/gotoPreset_normal.png' onClick='g_oPreviewInstance.GotoPreset("+iIndex+")' onMouseOver='this.src=\"../images/ptz/gotoPreset_push.png\"' onMouseOut='this.src=\"../images/ptz/gotoPreset_normal.png\"'/>";
		obj.cells[3].innerHTML = "<img id='SetPreset' src='../images/ptz/setPreset_normal.png' onClick='g_oPreviewInstance.SetPresetFun("+iIndex+")' onMouseOver='this.src=\"../images/ptz/setPreset_push.png\"' onMouseOut='this.src=\"../images/ptz/setPreset_normal.png\"''/>";
		//obj.cells[4].childNodes[0].style.display = '';
		that.m_oSelectPreset = obj;
		$("#ExcutePreset").attr("title", g_oCommon.getNodeValue("ExcutePreset"));
		$("#SetPreset").attr("title", g_oCommon.getNodeValue("SetPreset"));
	}
	
	//插入日志条目信息到List中
	this.InsertPresetList = function (iNo, iPresetID, iPatrolTime, iPatrolSpeed) {
		if(document.getElementById("CruiseTable").rows.length > 0 && that.m_iSelectPatrolPreset != -1) {
			var TrTempObj = document.getElementById("CruiseTable").rows[2*that.m_iSelectPatrolPreset - 1];
			TrTempObj.style.backgroundColor = '';
			TrTempObj.style.color = '';
			TrTempObj.cells[5].childNodes[0].style.display = 'none';
			$(document.getElementById("CruiseTable").rows[2*that.m_iSelectPatrolPreset - 1].cells[0].childNodes[0]).hide();
		}
		var ObjTr,ObjTrTemp;
		var ObjTd;
		ObjTrTemp = document.getElementById("CruiseTable").insertRow(document.getElementById("CruiseTable").rows.length);
		ObjTrTemp.style.height = '1px';
		for(var i = 0; i < 6; i++) {
			ObjTrTemp.insertCell(i);
		}
		ObjTrTemp.style.backgroundColor = '#CCCCCC';
		
		ObjTr = document.getElementById("CruiseTable").insertRow(document.getElementById("CruiseTable").rows.length);
		$(ObjTr).bind({
			mouseover:function() {
				if((this.rowIndex+1)/2 != that.m_iSelectPatrolPreset) {
					$(this).css("backgroundColor", "#FBFBC2");
				}
			},
			mouseout:function() {
				if((this.rowIndex+1)/2 != that.m_iSelectPatrolPreset) {
					$(this).css("backgroundColor", "");
				}
			},
			click:function() {
				that.SelectPresetList((this.rowIndex+1)/2);
			}
		});
		
		var szName = parent.translator.translateNode(that.m_lxdPreview, 'laPreset');
		that.m_iSelectPatrolPreset = (document.getElementById("CruiseTable").rows.length)/2;
		ObjTr.style.height = '30px';
		ObjTr.style.cursor = "pointer";
		ObjTr.align = "center";
		ObjTr.style.backgroundColor = '#762727';
		ObjTr.style.color = '#FFFFFF';
		
		for(var j = 0;j < document.getElementById("CruiseTable").rows[0].cells.length;j++) {
			ObjTd = ObjTr.insertCell(j);
			switch(j) {
				case 0:
					ObjTd.innerHTML = "<img src='../images/ptz/delete.png' style='cursor:pointer;' onClick='g_oPreviewInstance.DeletePresetList()'/>";
					ObjTd.id = "td"+ iNo;
					ObjTd.style.width = "10%";
					ObjTd.align = "center";
					break;
				case 1:
					ObjTd.innerHTML = ''+iNo;
					ObjTd.id = "tdA"+ iNo;
					ObjTd.style.width = "15%";
					break;
				case 2:
					ObjTd.innerHTML = '<label name="laPreset">'+szName+'</label> '+iPresetID;
					ObjTd.id = "tdB"+ iNo;
					ObjTd.style.width = "35%";
					break;
				case 3:
					ObjTd.innerHTML = iPatrolTime+'s';
					ObjTd.id = "tdC"+ iNo;
					ObjTd.align = "center";
					ObjTd.style.width = "15%";
					break;
				case 4:
					ObjTd.innerHTML = ''+iPatrolSpeed;
					ObjTd.id = "tdD"+ iNo;
					ObjTd.style.width = "10%";
					break;
				case 5:
					ObjTd.innerHTML = "<img src='../images/ptz/setPreset_normal.png' style='cursor:pointer;' onClick='g_oPreviewInstance.EditPresetListDlg(this, 1, "+iPresetID+", "+iPatrolTime+", "+iPatrolSpeed+")'/>";
					ObjTd.id = "tdE"+ iNo;
					ObjTd.style.width = "10%";
					break;
				default:
					break;
			}
		}
		$("#PatrolPresetList").scrollTop($("#PatrolPresetList").height());
	}
	
	//删除一条预置点
	this.DeletePresetList = function () {
		var iNo = that.m_iSelectPatrolPreset*2 - 1;
		var oTable = document.getElementById("CruiseTable");
		if(oTable.rows.length <= 0) {
			return;
		}
		oTable.deleteRow(iNo);
		oTable.deleteRow(iNo-1);
		if(oTable.rows.length <= 0) {
			return;
		}
		if(that.m_iSelectPatrolPreset > oTable.rows.length/2) {
			$(oTable.rows[oTable.rows.length - 1]).css('backgroundColor', '#762727');
			$(oTable.rows[oTable.rows.length - 1]).css('color', '#FFFFFF');
			$(oTable.rows[oTable.rows.length - 1].cells[0].childNodes[0]).show();
			$(oTable.rows[oTable.rows.length - 1].cells[5].childNodes[0]).show();
			that.m_iSelectPatrolPreset = oTable.rows.length/2;
		}
		var iLength = document.getElementById("CruiseTable").rows.length;
		for(var i = 1; i <= iLength/2; i++) {
			document.getElementById("CruiseTable").rows[i*2-1].cells[1].innerHTML = i;
		}
	}
	
	//选择一条预置点
	this.SelectPresetList = function (iNo) {
		var oTable = document.getElementById("CruiseTable");
		if(iNo <= oTable.rows.length/2 && iNo > 0) {
			if(that.m_iSelectPatrolPreset != -1) {
				$(oTable.rows[2*that.m_iSelectPatrolPreset-1]).css('backgroundColor','');
				$(oTable.rows[2*that.m_iSelectPatrolPreset-1]).css('color','');
				$(oTable.rows[2*that.m_iSelectPatrolPreset-1].cells[5].childNodes[0]).hide();
				$(oTable.rows[2*that.m_iSelectPatrolPreset-1].cells[0].childNodes[0]).hide();
			}
			
			$(oTable.rows[2*iNo-1]).css('backgroundColor','#762727');
			$(oTable.rows[2*iNo-1]).css('color','#FFFFFF');
			$(oTable.rows[2*iNo-1].cells[0].childNodes[0]).show();
			$(oTable.rows[2*iNo-1].cells[5].childNodes[0]).show();
			
			that.m_iSelectPatrolPreset = iNo;
		}
	}
	
	//弹出编辑窗口
	this.EditPresetListDlg = function (obj, iOperateMode, iPresetID, iPatrolTime, iPatrolSpeed) {
		if(0 == iOperateMode) {
			$("#patrol_mid").html("<label name='laAddPatrolPath'>" + g_oCommon.getNodeValue("laAddPatrolPath") + "</label>");
			if($('#CruiseTable tbody').children("tr").length >= 64) {
				$("#spanFootTips").html(g_oCommon.getNodeValue("CurrentAddTips") + "32 " + g_oCommon.getNodeValue("laPreset"));
				setTimeout(function () {
					$("#spanFootTips").html("");
				}, 1500);
				return;
			}
		} else {
			$("#patrol_mid").html("<label name='laModifyPatrolPath'>" + g_oCommon.getNodeValue("laModifyPatrolPath") + "</label>");
		}	
		that.m_iOperateMode = iOperateMode;
		that.m_oOperated = obj;
		that.InitPresetList();
		$('#SelectPreset').val(iPresetID);
		$('#PatrolTime').val(iPatrolTime);
		$('#PatrolSpeed').val(iPatrolSpeed);
		
		$('#EditPatrolPreset').css('right', '1px');   //2px change--> 1px
		$('#EditPatrolPreset').css('top', $(obj).offset().top - $('#EditPatrolPreset').height() + 5);
		
		$('#EditPatrolPreset').modal();
	}
	
	//路径编辑窗口确定键事件响应
	this.onPresetListDlgOk = function () {
		if(that.m_iOperateMode == 0) {
			that.InsertPresetList(document.getElementById("CruiseTable").rows.length/2 + 1, $('#SelectPreset').val(), $('#PatrolTime').val(), $('#PatrolSpeed').val());
		} else {
			var szName = parent.translator.translateNode(that.m_lxdPreview, 'laPreset');
			var trObj = that.m_oOperated.parentElement.parentElement;
			trObj.cells[2].innerHTML = '<label name="laPreset">'+szName+'</label> '+$('#SelectPreset').val();
			trObj.cells[3].innerHTML = $('#PatrolTime').val()+'s';
			trObj.cells[4].innerHTML = $('#PatrolSpeed').val();
			trObj.cells[5].innerHTML = "<img src='../images/ptz/setPreset_normal.png' style='cursor:pointer;' onClick='g_oPreviewInstance.EditPresetListDlg(this, 1, "+$('#SelectPreset').val()+", "+$('#PatrolTime').val()+", "+$('#PatrolSpeed').val()+")'/>";
		}
		$.modal.impl.close();
	}
	
	//获取一条路径
	this.GetPatrol = function (iPatrolID) {
		if($('#cruisebg').css("display") === "none") {
			return;
		}
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)/* || that.m_iCurWndChannel < 0*/) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel === undefined || iChannel === null) {
			$('#CruiseTable').html('');
			return;
		}
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/patrols/"+ iPatrolID;
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/patrols/"+ iPatrolID;
		}
		$.ajax({
			type: "get",
			url: szURL,
			async: false,
			timeout: 15000,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			success: function(xmlDoc, textStatus, xhr) {
				$("#CruiseTable").html("");
				var szName = parent.translator.translateNode(that.m_lxdPreview, "laPreset");
				var iPresetNum = $(xmlDoc).find("PatrolSequence").length;
				for(var i = 0; i < iPresetNum; i++) {
					that.InsertPresetList(i+1, $(xmlDoc).find('presetID').eq(i).text(), parseInt($(xmlDoc).find('delay').eq(i).text(), 10)/1000, $(xmlDoc).find('seqSpeed').eq(i).text())
				}
			}			
		});
	}
	
	//开始一条路径
	this.StartPatrol = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var iPatternID = $('#selectPatrol').val();
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/patrols/"+ iPatternID +"/start";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/patrols/"+ iPatternID +"/start";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: null,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//停止一条路径
	this.StopPatrol = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var iPatternID = $('#selectPatrol').val();
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/patrols/"+ iPatternID +"/stop";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/patrols/"+ iPatternID +"/stop";
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: null,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//保存一条路径
	this.SavePatrol = function () {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		var iPatternID = $('#selectPatrol').val();
		var szXml = '';
		var oRowSet = document.getElementById("CruiseTable").rows;
		var iPresetID = 0;
		var iPatrolTime = 0;
		var iPatrolSpeed = 0;
		for(var i = 0; i < oRowSet.length/2; i++) {
			iPresetID = parseInt($(oRowSet[2*i+1].cells[2]).text().split(" ")[1],10);
			iPatrolTime = parseInt($(oRowSet[2*i+1].cells[3]).text().split("s")[0],10)*1000;
			iPatrolSpeed = parseInt($(oRowSet[2*i+1].cells[4]).text(),10);
			szXml += "<PatrolSequence><presetID>"+iPresetID+"</presetID><seqSpeed>"+iPatrolSpeed+"</seqSpeed>"+"<delay>"+iPatrolTime+"</delay></PatrolSequence>";
		}
		szXml="<?xml version='1.0' encoding='UTF-8'?><PTZPatrol version='1.0' xmlns='urn:psialliance-org'><id>"+iPatternID+"</id><patrolName>patrol "+(iPatternID>9?iPatternID:("0"+iPatternID))+"</patrolName><PatrolSequenceList>"+szXml+"</PatrolSequenceList></PTZPatrol>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szXml); 
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/patrols/"+ iPatternID;
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/patrols/"+ iPatternID;
		}	
		$.ajax({
			type: "put",
			url: szURL,
			async: false,
			timeout: 15000,
			processData: false,
			data: xmlDoc,		
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}		
		});
	}
	
	//初始化轨迹
	this.InitPattern = function () {
		var szName = parent.translator.translateNode(that.m_lxdPreview, 'Pattern');
		var innerHTML = '';
		for(var i = 1; i < 2; i++) {
			innerHTML+="<tr height='1' style='background-color:#CCC;'><td></td></tr><tr><td id='Pattern"+(i)+"' height='30'><table cellspacing='0' cellpadding='0' width='100%' height='100%'><tr onClick='g_oPreviewInstance.selectPattern(this)' style='cursor:pointer;' onMouseOver=\"javascript:if(this!=g_oPreviewInstance.m_oSelectPattern){this.style.backgroundColor='#FBFBC2';}\" onMouseOut=\"javascript:if(this!=g_oPreviewInstance.m_oSelectPattern){this.style.backgroundColor=''}\"><td align='center' valign='middle' width='40%'><label name='Pattern'>"+ szName +"</label>"+" "+i+"</td><td width='15%' align='center' valign='middle'><img id='ImgStartPattern' src='../images/ptz/PatternStart.png' onClick='g_oPreviewInstance.StartPattern("+i+")'  style='display:none;'/></td><td width='15%' align='center' valign='middle'><img id='ImgStopPattern' src='../images/ptz/PatternStop.png' onClick='g_oPreviewInstance.StopPattern("+i+")' style='display:none;'/></td><td width='15%' align='center' valign='middle'><img id='StartPatternRecord' src='../images/ptz/setPreset_normal.png' onClick='g_oPreviewInstance.StartRecordPattern("+i+")' style='display:none;'/></td><td width='15%' align='center' valign='middle'><img src='../images/ptz/PatternSave.png' id='StopPatternRecord' onClick='g_oPreviewInstance.StopRecordPattern("+i+")' style='display:none;'/></td></tr></table></td></tr>";
		}
		$('#PatternTable').html(innerHTML);
	}
	
	//选择轨迹
	this.selectPattern = function (obj) {
		if(obj == that.m_oSelectPattern) {
			return;
		}
		if(null != that.m_oSelectPattern) {
			that.m_oSelectPattern.style.backgroundColor = '';
			that.m_oSelectPattern.cells[0].style.color = '';
			that.m_oSelectPattern.cells[1].childNodes[0].style.display = 'none';
			that.m_oSelectPattern.cells[2].childNodes[0].style.display = 'none';
			that.m_oSelectPattern.cells[3].childNodes[0].style.display = 'none';
			that.m_oSelectPattern.cells[4].childNodes[0].style.display = 'none';
		}
		obj.style.backgroundColor = '#762727';
		obj.cells[0].style.color = '#FFFFFF';
		obj.cells[1].childNodes[0].style.display = '';
		obj.cells[2].childNodes[0].style.display = '';
		obj.cells[3].childNodes[0].style.display = '';
		obj.cells[4].childNodes[0].style.display = '';
		that.m_oSelectPattern = obj;
	}
	
	//开始记录轨迹
	this.StartRecordPattern = function (iPatternID) {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/patterns/"+ iPatternID +"/recordstart";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/patterns/"+ iPatternID +"/recordstart";
		}	
		$.ajax({
			type: "PUT",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			async: true,
			timeout: 15000,
			url: szURL,
			processData: false,
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}
		});
	}
	
	//停止记录轨迹
	this.StopRecordPattern = function (iPatternID) {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/patterns/"+ iPatternID +"/recordstop";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/patterns/"+ iPatternID +"/recordstop";
		}	
		$.ajax({
			type: "PUT",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			async: true,
			timeout: 15000,
			url: szURL,
			processData: false,
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}
		});
	}
	
	//开始轨迹
	this.StartPattern = function (iPatternID) {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/patterns/"+ iPatternID +"/run";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/patterns/"+ iPatternID +"/run";
		}	
		$.ajax({
			type: "PUT",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			async: true,
	
			timeout: 15000,
			url: szURL,
			processData: false,
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}
		});
	}
	
	//停止轨迹
	this.StopPattern = function (iPatternID) {
		if(that.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum) || that.m_iCurWndChannel < 0) {
			return;
		}
		var iChannel = g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		if(iChannel < 0) {
			return;
		}
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/" + iChannel + "/patterns/"+ iPatternID +"/stop";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + iChannel + "/patterns/"+ iPatternID +"/stop";
		}	
		$.ajax({
			type: "PUT",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			async: true,
			timeout: 15000,
			url: szURL,
			processData: false,
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}
		});
	}
	//获取巡航路径的能力
	this.GetPatrolsCab = function () {
		if(g_oCommon.m_iAnalogChannelNum !== 0) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/1/patrols";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/1/patrols";
		}
		$.ajax({
			type: "get",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			async: false,
			url: szURL,
			success: function (xmlDoc, textStatus, xhr) {
				var iLen = $(xmlDoc).find("PTZPatrol").length;
				if(iLen > 0 || g_oCommon.m_bSupportPatrols) {
					$('#cruisebg').show();
					if(iLen > 0) {
						that.m_iPTZPatrolNum = iLen;
					} else {
						that.m_iPTZPatrolNum = 4;  //暂时写死默认值，后续需要区分通道获取
					}
				} else {
					$('#cruisebg').hide();
				}
			},
			error:function (xhr, textStatus, errorThrown) {
				$('#cruisebg').hide();
			}
		});
	}
	//获取轨迹的能力
	this.GetPatternCab = function () {
		if(g_oCommon.m_iAnalogChannelNum !== 0) {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/PTZCtrl/channels/1/patterns";
		} else {
			var szURL=g_oCommon.m_lHttp+g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort+"/ISAPI/ContentMgmt/PTZCtrlProxy/channels/1/patterns";
		}	
		$.ajax({
			type: "get",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			async: false,
			url: szURL,
			complete:function(xhr, textStatus) {
				if(xhr.status==200) {
					$('#trackbg').show();
				} else {
					$('#trackbg').hide();
				}
			}
		});
	}
	//获取视频参数能力
	this.GetVideoParamCab = function (iChannel) {
		var iPlayChannelId = g_oCommon.m_iChannelId[iChannel-1];
		var szURL='';
		if(iChannel <= g_oCommon.m_iAnalogChannelNum) {
			szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/Image/channels/" + iPlayChannelId + "/capabilities";
		} else if(iChannel <= (g_oCommon.m_iAnalogChannelNum+g_oCommon.m_iDigitalChannelNum)) {
			szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/ContentMgmt/ImageProxy/channels/" + iPlayChannelId + "/capabilities";
		} else {
			that.m_bSupportScene = false;		
			return;
		}
		$.ajax({
			type: "GET",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			async: false,
			url: szURL,
			success: function(xmlDoc, textStatus, xhr) {
				if($(xmlDoc).find("brightnessLevel").length > 0) {
					that.m_iBrightDefault = parseInt($(xmlDoc).find("brightnessLevel").eq(0).attr("def"), 10);
					that.m_iBrightMin = parseInt($(xmlDoc).find("brightnessLevel").eq(0).attr("min"), 10);
					that.m_iBrightMax = parseInt($(xmlDoc).find("brightnessLevel").eq(0).attr("max"), 10);
				}
				if($(xmlDoc).find("contrastLevel").length > 0) {
					that.m_iContrastDefault = parseInt($(xmlDoc).find("contrastLevel").eq(0).attr("def"), 10);
					that.m_iContrastMin = parseInt($(xmlDoc).find("contrastLevel").eq(0).attr("min"), 10);
					that.m_iContrastMax = parseInt($(xmlDoc).find("contrastLevel").eq(0).attr("max"), 10);
				}
				if($(xmlDoc).find("saturationLevel").length > 0) {
					that.m_iSaturationDefault = parseInt($(xmlDoc).find("saturationLevel").eq(0).attr("def"), 10);
					that.m_iSaturationMin = parseInt($(xmlDoc).find("saturationLevel").eq(0).attr("min"), 10);
					that.m_iSaturationMax = parseInt($(xmlDoc).find("saturationLevel").eq(0).attr("max"), 10);
				}
				if($(xmlDoc).find("hueLevel").length > 0) {
					that.m_iHueDefault = parseInt($(xmlDoc).find("hueLevel").eq(0).attr("def"), 10);
					that.m_iHueMin = parseInt($(xmlDoc).find("hueLevel").eq(0).attr("min"), 10);
					that.m_iHueMax = parseInt($(xmlDoc).find("hueLevel").eq(0).attr("max"), 10);
				}
				if($(xmlDoc).find("imageMode").length > 0) {
					that.m_bSupportScene = true;
					$("#VideoParamMode_tr1").css("display", 'block');
					$("#VideoParamMode_tr2").css("display", 'block');
					$("#divisionShortLine_tr").css("display", 'block');
					$("#laSharpness_tr").css("display", 'block');
					$("#laNoiseReduce_tr").css("display", 'block');
					that.m_iSharpnessMin = parseInt($(xmlDoc).find("sharpnessLevel").eq(0).attr("min"), 10);
					that.m_iSharpnessMax = parseInt($(xmlDoc).find("sharpnessLevel").eq(0).attr("max"), 10);
					that.m_iSharpnessDefault = parseInt($(xmlDoc).find("sharpnessLevel").eq(0).attr("def"), 10);
					that.m_iNoiseReduceMin = parseInt($(xmlDoc).find("generalLevel").eq(0).attr("min"), 10);
					that.m_iNoiseReduceMax = parseInt($(xmlDoc).find("generalLevel").eq(0).attr("max"), 10);
					that.m_iNoiseReduceDefault = parseInt($(xmlDoc).find("generalLevel").eq(0).attr("def"), 10);
					that.GetSceneParamDefault();
				} else {
					that.m_bSupportScene = false;
					$("#VideoParamMode_tr1").css("display", 'none');
					$("#VideoParamMode_tr2").css("display", 'none');
					$("#divisionShortLine_tr").css("display", 'none');
					$("#laSharpness_tr").css("display", 'none');
					$("#laNoiseReduce_tr").css("display", 'none');			
				}
				that.InitSlider();
			},
			error: function (xhr, textStatus, errorThrown) {
				that.m_bSupportScene = false;
				$("#VideoParamMode_tr1").css("display", 'none');
				$("#VideoParamMode_tr2").css("display", 'none');
				$("#divisionShortLine_tr").css("display", 'none');
				$("#laSharpness_tr").css("display", 'none');
				$("#laNoiseReduce_tr").css("display", 'none');				
			}
		});
	}
	
	//去掉视频参数显示
	this.ResetVideoParam = function () {
		that.m_iBright = that.m_iBrightMin;
		that.m_iContrast = that.m_iContrastMin;
		that.m_iSaturation = that.m_iSaturationMin;
		that.m_iHue = that.m_iHueMin;
		that.m_iSharpness = that.m_iSharpnessMin;
		that.m_iNoiseReduce = that.m_iNoiseReduceMin;
		
		that.m_oSliderBright.wsetValue(that.m_iBright);
		that.m_oSliderContrast.wsetValue(that.m_iContrast);
		that.m_oSliderSaturation.wsetValue(that.m_iSaturation);
		that.m_oSliderHue.wsetValue(that.m_iHue);
		
		that.m_oSliderBright.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laBrightness') + ':' + that.m_oSliderBright.getValue());
		that.m_oSliderContrast.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laContrast') + ':' + that.m_oSliderContrast.getValue());
		that.m_oSliderSaturation.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSaturation') + ':' + that.m_oSliderSaturation.getValue());
		that.m_oSliderHue.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laHue') + ':' + that.m_oSliderHue.getValue()); 
		
		if(that.m_bSupportScene) {
			$("#VideoParamMode_tr1").css("display", 'block');
			$("#VideoParamMode_tr2").css("display", 'block');
			$("#divisionShortLine_tr").css("display", 'block');
			$("#laSharpness_tr").css("display", 'block');
			$("#laNoiseReduce_tr").css("display", 'block');
			that.m_oSliderSharpness.wsetValue(that.m_iSharpness);
			that.m_oSliderNoiseReduce.wsetValue(that.m_iNoiseReduce);
		
			that.m_oSliderSharpness.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laSharpness') + ':' + that.m_oSliderSharpness.getValue());
			that.m_oSliderNoiseReduce.setTitle(parent.translator.translateNode(that.m_lxdPreview, 'laNoiseReduce') + ':' + that.m_oSliderNoiseReduce.getValue());
		} else {
			$("#VideoParamMode_tr1").css("display", 'none');
			$("#VideoParamMode_tr2").css("display", 'none');
			$("#divisionShortLine_tr").css("display", 'none');
			$("#laSharpness_tr").css("display", 'none');
			$("#laNoiseReduce_tr").css("display", 'none');
		}             
	}
	
	//获取每种场景下的默认值
	this.GetSceneParamDefault = function () {
		var szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/Image/channels/imageModes";
		$.ajax({
			type: "get",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			async: false,
			url: szURL,
			success: function(xmlDoc, textStatus, xhr) {
				for(var i = 0; i < $(xmlDoc).find('ImageMode').length; i++){
					var r = 0;
					var strType = $(xmlDoc).find('type').eq(i).text();
					if(strType == 'standard'){
						r = 0;
					} else if(strType == 'indoor') {
						r = 1;
					} else if(strType == 'outdoor') {
						r = 2;
					} else {
						r = 3;
					}
					that.m_iSceneParamDef[r][0] = parseInt($(xmlDoc).find('brightnessLevel').eq(i).attr("def"), 10);
					that.m_iSceneParamDef[r][1] = parseInt($(xmlDoc).find('contrastLevel').eq(i).attr("def"), 10);
					that.m_iSceneParamDef[r][2] = parseInt($(xmlDoc).find('saturationLevel').eq(i).attr("def"), 10);
					that.m_iSceneParamDef[r][3] = parseInt($(xmlDoc).find('hueLevel').eq(i).attr("def"), 10);
					that.m_iSceneParamDef[r][4] = parseInt($(xmlDoc).find('sharpnessLevel').eq(i).attr("def"), 10);
					that.m_iSceneParamDef[r][5] = parseInt($(xmlDoc).find('deNoiseLevel').eq(i).attr("def"), 10);
				}		
			}
		});
	}
	
	//设置场景
	this.setScene = function (iType) {
		var xmlDoc = g_oCommon.parseXmlFromStr(that.m_szXmlStr);
		var szVideoParamMode = "";
		$(document.getElementsByName("raVideoParamMode")).each(function() {
			if(this.checked) {
				szVideoParamMode = this.value;
				return;
			}
		});
		$(xmlDoc).find('imageMode').eq(0).text(szVideoParamMode);
		$(xmlDoc).find('brightnessLevel').eq(0).text(that.m_iSceneParamDef[iType][0]);
		$(xmlDoc).find('contrastLevel').eq(0).text(that.m_iSceneParamDef[iType][1]);
		$(xmlDoc).find('saturationLevel').eq(0).text(that.m_iSceneParamDef[iType][2]);
		$(xmlDoc).find('hueLevel').eq(0).text(that.m_iSceneParamDef[iType][3]);
		$(xmlDoc).find('sharpnessLevel').eq(0).text(that.m_iSceneParamDef[iType][4]);
		$(xmlDoc).find('generalLevel').eq(0).text(that.m_iSceneParamDef[iType][5]);
		that.SetVideoParam(that.m_iCurWndChannel,xmlDoc);
		that.GetVideoParam(that.m_iCurWndChannel);
	}
	
	//启用电子放大
	this.EnableEZoom = function () {
		var iRes = 0;
		if(that.m_bChannelPlay[that.m_iCurWndChannel-1]) {
			var bEnableEZoom = !that.m_bEnableEZoom[that.m_iCurWnd];
			if(bEnableEZoom) {
				iRes = g_oCommon.m_PreviewOCX.HWP_EnableZoom(that.m_iCurWnd, 0);
				if(iRes == 0) {
					that.m_bEnableEZoom[that.m_iCurWnd] = true;
					$("#Ezoom").attr("src", "../images/public/VideoBottom/normal/ZoomEnable_normal.png");
					$("#Ezoom").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'laDisableZoom'));
				}
			} else {
				g_oCommon.m_PreviewOCX.HWP_DisableZoom(that.m_iCurWnd);
				that.m_bEnableEZoom[that.m_iCurWnd] = false;
				$("#Ezoom").attr("src", "../images/public/VideoBottom/normal/Zoom_normal.png");
				$("#Ezoom").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'laEnableZoom'));
			}
		}
	}
	
	//开启3D放大
	this.Enable3DZoom = function () {
		var iRes = 0;
		if(that.m_bChannelPlay[that.m_iCurWndChannel-1]) {
			var bEnable3DZoom = !that.m_bEnable3DZoom[that.m_iCurWnd];
			if(bEnable3DZoom) {
				iRes = g_oCommon.m_PreviewOCX.HWP_EnableZoom(that.m_iCurWnd, 1);
				if(iRes == 0) {
					that.m_bEnable3DZoom[that.m_iCurWnd] = true;
					$("#zoom3D").attr("src", "../images/public/VideoBottom/normal/3DEnable.png");
					$("#zoom3D").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'Stop3DZoom'));
				}
			} else {
				g_oCommon.m_PreviewOCX.HWP_DisableZoom(that.m_iCurWnd);
				that.m_bEnable3DZoom[that.m_iCurWnd] = false;
				$("#zoom3D").attr("src", "../images/public/VideoBottom/normal/3Dnormal.png");
				$("#zoom3D").attr("title", parent.translator.translateNode(that.m_lxdPreview, 'Start3DZoom'));
			}
		}
	}
	
	//获取零通道放大状态
	this.GetZeroEnLargeState = function () {
		var iChannelID = 1;
		if(that.m_iCurWndChannel != -1) {
			iChannelID =  g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		}
		$.ajax({
			type: "get",
			url: g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/ContentMgmt/ZeroVideo/channels/"+ iChannelID +"/enlarge",
			async: false,
			timeout: 15000,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			success: function(xmlDoc, textStatus, xhr) {
				
				if($(xmlDoc).find('stat').length > 0) {
					if($(xmlDoc).find('stat').eq(0).text() == 'normal') {
						that.m_iEnLargeZeroChannel = 0;	
					} else {
						that.m_iEnLargeZeroChannel = 1;	
					}
				}
			}
		});		
	}
	
	//设置零通道放大状态
	this.SetZeroEnLargeState = function (iEnLarge, szMouseX, szMouseY) {
		var iChannelID = 1;
		if(that.m_iCurWndChannel != -1) {
			iChannelID =  g_oCommon.m_iChannelId[that.m_iCurWndChannel-1];
		}
		var szXml = "<?xml version='1.0' encoding='UTF-8'?><ZeroVideoEnlarge>" + 
		"<stat>"+ (parseInt(iEnLarge, 10) === 0 ? "normal" : "enlarge") + "</stat>" +
		"<mousePosition><x>" + szMouseX + "</x><y>" + szMouseY + "</y></mousePosition>" +
		"</ZeroVideoEnlarge>";
		var xmlDoc = g_oCommon.parseXmlFromStr(szXml);	
		$.ajax({
			type: "put",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			timeout: 15000,
			url: g_oCommon.m_lHttp + g_oCommon.m_szHostName+":"+g_oCommon.m_lHttpPort + "/ISAPI/ContentMgmt/ZeroVideo/channels/"+ iChannelID +"/enlarge",
			processData: false,
			data: xmlDoc,
			error:function(xhr, textStatus, errorThrown) {
				that.setState(xhr);
			}
		});
	}
	//切换主子码流
	this.switchStream = function (channelNum) {
		var szId = "#Stream" + channelNum + "Img";
		var iChannelWindow = that.m_iChannelWindow[channelNum - 1];
		that.m_iChannelStream[channelNum - 1] = (that.m_iChannelStream[channelNum - 1] === 1 ? 0:1);
		if (that.m_bChannelPlay[channelNum - 1]) {
			that.StopRealPlay(channelNum);
			that.StartRealPlay(channelNum, iChannelWindow);
		}
		if(that.m_iChannelStream[channelNum - 1] === 0) {
			$(szId).attr("src", "../images/public/ICON/main_stream.png").attr("title", parent.translator.translateNode(that.m_lxdPreview, "streamTypeOpt1"));
		} else {
			$(szId).attr("src", "../images/public/ICON/sub_stream.png").attr("title", parent.translator.translateNode(that.m_lxdPreview, "streamTypeOpt2"));
		}	
	}	
}
var g_oPreviewInstance = new Preview();

//获取选中窗口信息
function GetSelectWndInfo(SelectWndInfo) {
	var xmlDoc = g_oCommon.parseXmlFromStr(SelectWndInfo);
	g_oPreviewInstance.m_iCurWnd = parseInt(xmlDoc.documentElement.getElementsByTagName('SelectWnd')[0].childNodes[0].nodeValue);
	g_oPreviewInstance.m_iCurWndChannel = g_oPreviewInstance.m_iWndChannel[g_oPreviewInstance.m_iCurWnd];
	g_oPreviewInstance.GetPatrol(parseInt($('#selectPatrol').val()));
	//是否在播放
	if((g_oPreviewInstance.m_iCurWndChannel > -1) && (1 == g_oPreviewInstance.m_bChannelPlay[g_oPreviewInstance.m_iCurWndChannel - 1])) {
		//是否是零通道
		if( g_oPreviewInstance.m_iCurWndChannel > (g_oCommon.m_iAnalogChannelNum + g_oCommon.m_iDigitalChannelNum)) {

			g_oPreviewInstance.GetZeroEnLargeState();	//获取零通道配置，nomal/enlarge
			if(g_oPreviewInstance.m_iEnLargeZeroChannel !== -1) {
				try {
					g_oCommon.m_PreviewOCX.HWP_SetZeroChanInfo(1, g_oPreviewInstance.m_iEnLargeZeroChannel, g_oPreviewInstance.m_iCurWnd);
				} catch(e) {}
			}
		} else {
			try {
				g_oCommon.m_PreviewOCX.HWP_SetZeroChanInfo(0, 0, g_oPreviewInstance.m_iCurWnd); //非零通道	
			} catch(e) {}
		}
	}
	
	if(g_oPreviewInstance.m_bChannelPlay[g_oPreviewInstance.m_iCurWndChannel - 1]) {
		if(!g_oPreviewInstance.m_bEnableEZoom[g_oPreviewInstance.m_iCurWnd]) {
			$("#Ezoom").attr('src','../images/public/VideoBottom/normal/Zoom_normal.png');
			$("#Ezoom").attr("title", parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'laEnableZoom'));
		} else {
			$("#Ezoom").attr('src','../images/public/VideoBottom/normal/ZoomEnable_normal.png');
			$("#Ezoom").attr("title", parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'laDisableZoom'));
		}
		if(!g_oPreviewInstance.m_bEnable3DZoom[g_oPreviewInstance.m_iCurWnd]) {
			$("#zoom3D").attr('src','../images/public/VideoBottom/normal/3Dnormal.png');
			$("#zoom3D").attr("title", parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'Start3DZoom'));
		} else {
			$("#zoom3D").attr('src','../images/public/VideoBottom/normal/3DEnable.png');
			$("#zoom3D").attr("title", parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'Stop3DZoom'));
		}		
		if(g_oPreviewInstance.m_bPTZAuto[g_oPreviewInstance.m_iCurWndChannel - 1]) {
			$("#ptzAutoId").attr('src','../images/ptz/auto.png');
		} else {
			$("#ptzAutoId").attr('src','../images/ptz/ptz_normal/auto.png');
		}
	} else {
		$("#Ezoom").attr('src','../images/public/VideoBottom/disabled/DisZoom.png');
		$("#Ezoom").attr("title", parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'laEnableZoom'));
		$("#zoom3D").attr('src','../images/public/VideoBottom/disabled/Dis3D.png');
		$("#zoom3D").attr("title", parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'Start3DZoom'));		
		$("#ptzAutoId").attr('src','../images/ptz/ptz_normal/auto.png');
	}
	if(g_oPreviewInstance.m_iCurWndChannel>-1 && g_oPreviewInstance.m_bSound[g_oPreviewInstance.m_iCurWndChannel-1]) {
		$("#opensound").unbind();
		$("#opensound").bind({
			mouseover:function() {
				$(this).attr("src", '../images/public/VideoBottom/select/SelOpenSound.png');
				$(window.parent.document.getElementById("volumeDiv")).show();
			},
			mouseout:function() {
				$(this).attr("src", '../images/public/VideoBottom/normal/OpenSound.png');
			}
		});
		$("#opensound").attr("src",'../images/public/VideoBottom/normal/OpenSound.png');
		$("#opensound").attr("title",parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'closesound'));
		//$(window.parent.document.getElementById("volumeDiv")).show();
	} else {
		$("#opensound").unbind();
		$("#opensound").bind({
			mouseover:function() {
				$(this).attr("src", '../images/public/VideoBottom/select/SelCloseSound.png');
			},
			mouseout:function() {
				$(this).attr("src", '../images/public/VideoBottom/normal/CloseSound.png');
			}
		});
		$("#opensound").attr("src",'../images/public/VideoBottom/normal/CloseSound.png');
		$("#opensound").attr("title",parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'opensound'));
		$(window.parent.document.getElementById("volumeDiv")).hide();
	}
	//设置选中通道字体颜色
	g_oPreviewInstance.SetFontColor(g_oPreviewInstance.m_iCurWndChannel);
	if(g_oPreviewInstance.m_iCurWndChannel!=-1) {
		g_oPreviewInstance.GetVideoParam(g_oPreviewInstance.m_iCurWndChannel);
	} else {
		g_oPreviewInstance.ResetVideoParam();
	}
}

//回放事件响应
function PluginEventHandler(iEventType, iParam1, iParam2) {
	if(21 == iEventType) {
		if(g_oPreviewInstance.m_bIsDiskFreeSpaceEnough) {
			g_oPreviewInstance.m_bIsDiskFreeSpaceEnough = false;
			setTimeout(function() {alert(parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'FreeSpaceTips'));}, 2000);
		}
		g_oPreviewInstance.StopRecord(g_oPreviewInstance.m_iWndChannel[iParam1]);
	} else if(3 == iEventType) {
		g_oCommon.m_bTalk = 0;
		document.getElementById("voiceTalk").src="../images/public/ICON/speak_normal.png";
		document.getElementById("voiceTalk").title = parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'voiceTalk');
		g_oCommon.m_PreviewOCX.HWP_StopVoiceTalk();
		setTimeout(function() {alert(parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'VoiceTalkFailed'));}, 2000);
	} else if(7 == iEventType) {
		if(!g_oPreviewInstance.m_bNoStreamSecret) {
			g_oPreviewInstance.m_bNoStreamSecret = true;
		    alert(parent.translator.translateNode(g_oPreviewInstance.m_lxdPreview, 'jsNoStreamSecret'));
		}
    }
}
//设置零通道放大状态
function SetZeroChanEnlarge (EnlargeInfo) {
	var xmlDoc = g_oCommon.parseXmlFromStr(EnlargeInfo);
	if($(xmlDoc).find('MCP_x').eq(0).text() != -1 && $(xmlDoc).find('MCP_y').eq(0).text() != -1 && $(xmlDoc).find('BeState').eq(0).text() == 1) {
		g_oPreviewInstance.SetZeroEnLargeState($(xmlDoc).find('BeState').eq(0).text(), $(xmlDoc).find('MCP_x').eq(0).text(), $(xmlDoc).find('MCP_y').eq(0).text());
	} else {	
		if($(xmlDoc).find('BeState').eq(0).text() == 0) {
			g_oPreviewInstance.SetZeroEnLargeState($(xmlDoc).find('BeState').eq(0).text(), $(xmlDoc).find('MCP_x').eq(0).text(), $(xmlDoc).find('MCP_y').eq(0).text());
		}
	}
}
/*************************************************
Function:		ZoomInfoCallback
Description:	区域信息回调
Input:			无			
Output:			无
return:			无				
*************************************************/
function ZoomInfoCallback(szZoomInfo) {
	var xmlDoc = g_oCommon.parseXmlFromStr(szZoomInfo);
	var szURL = g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/ContentMgmt/PTZCtrlProxy/channels/" + g_oPreviewInstance.m_iWndChannel[g_oPreviewInstance.m_iCurWnd] + "/set3DZoom";
	$.ajax({
		type: "put",
		beforeSend: function(xhr) {
			xhr.setRequestHeader("If-Modified-Since", "0");
			xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
		},
		url: szURL,
		processData: false,
		data: xmlDoc,
		success: function(xmlDoc, textStatus, xhr) {
		}
	});
}