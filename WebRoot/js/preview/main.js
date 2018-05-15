/*************************************************
Function:		Main
Description:	主页面类			
*************************************************/
function Main() {
    this.m_szDeviceName = "Embedded Net DVR";
	this.m_szDeviceType = "";
	this.m_lxdMain = null;
    this._m_iTime = 0;
    this._m_iTimerID = 0;	
}

Main.prototype = {
	
	//事件绑定函数
	_mainEventBind: function () {
		var that = this;
		$(window).bind({
			resize: function () {
				that.iframeAutoFit(); 
			}
		});
		$("#spanHelp").bind({
			click: function (e) {
				e.stopPropagation();
				if($("#softwareEdition").css("display") !== "none") {
				   $("#softwareEdition").hide();
				} else {
					$("#softwareEdition").show();
				}
			}
		});
		$("body").bind({
			click: function (e) {
				if($("#softwareEdition").css("display") !== "none") {
					$("#softwareEdition").hide();
				}			
			}
		});		
	},
	
	//获取设备名称
	_getDeviceInfo: function () {
		var that = this;
		$.ajax({
			type: "get",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("If-Modified-Since", "0");
				xhr.setRequestHeader("Authorization", "Basic " + g_oCommon.m_szUserPwdValue);
			},
			timeout: 15000,
			async: false,
			url: g_oCommon.m_lHttp + g_oCommon.m_szHostName + ":" + g_oCommon.m_lHttpPort + "/ISAPI/System/deviceInfo",
			success: function(xmlDoc, textStatus, xhr) {
				that.m_szDeviceType = $(xmlDoc).find("deviceType").eq(0).text();
				$("#main_type").html($(xmlDoc).find("model").eq(0).text());
				that.m_szDeviceName = $(xmlDoc).find("deviceName").eq(0).text();
				if(that.m_szDeviceName == "") {
					that.m_szDeviceName = "Embedded Net DVR";
				}
			}
		});	
	},
	
    //主页面初始化函数
	initMain: function () {
		g_oCommon.m_szUserPwdValue = "lq:369258147";
		if(g_oCommon.m_szUserPwdValue === null) {
			window.location.href="login.shtml";
			return;
		}
	//	translator.initLanguageSelect($.cookie("language"));
		//var lxd = translator.getLanguageXmlDoc("Main");
		//translator.translatePage($(lxd).children("Main")[0], document);
		//this.m_lxdMain = $(lxd).children("Common")[0];
		var curpage = $.cookie("page");
		if(null == curpage) {
			this.changeFrame("preview.asp", 1);
		} else {
			this.changeFrame(curpage.split("%")[0], curpage.split("%")[1]);
		}
		$("#softwareEdition").find("div").eq(0).html("Web:&nbsp;" + global_config.web_version);
		$("#softwareEdition").find("div").eq(1).html("Plugin:&nbsp;" + global_config.plugin_version);
		//事件绑定
		this._mainEventBind();
		$(window).resize();
	},
	
	//主页面加载时，获取cookie，跳转到刷新前的界面
	changeFrame: function (src, index) {
		$("#volumeDiv").remove();
		$("#WndArrangePart").remove();
		//切换界面时实时获取设备名称
		this._getDeviceInfo();
		if(src.indexOf("?") !== -1) {
			var szTemp = src.split("?");
			src = szTemp[0].concat("?version=" + global_config.web_version + "&").concat(szTemp[1]);
		} else {
			src = src + "?version=" + global_config.web_version;
		}
		if($.browser.mozilla || ($.browser.msie && parseInt($.browser.version, 10) >= 9)) {
			$("#mainFrame").html('<iframe frameborder="0" scrolling="no" id="ContentFrame" name="ContentFrame" src="' + src + '" style="width:' + 
			(document.body.clientWidth - 28) + 'px' + ';height:' + (document.body.clientHeight - 138) + 'px' + ';"></iframe>');
		} else {
			$("#ContentFrame").attr("src", src);
		}
	},
	
	//改变主页菜单栏
	changeMenu: function (index) {
		for(var i = 1; i < 5; i++) {
			if($("#iMenu" + i).hasClass("menuBackground")) {
				$("#iMenu" + i).removeClass("menuBackground");
			}
		}
		$("#iMenu" + index).addClass("menuBackground");	
	},
	
	//iframe高度自适应
    iframeAutoFit: function () {
		try {
			if(document.body.clientWidth < 993) {
				$("#headRight").hide();	
			} else {
				$("#headRight").show();	
			}	
			$("#ContentFrame").css("height", document.body.clientHeight - 138 + "px");
			$("#ContentFrame").css("width", document.body.clientWidth - 28 + "px");
		} catch(e) {}
	},
	
	//显示滑动提示框
    showTipsDiv: function (szTitle, szTips) {
		var that = this;
		if(this._m_iTime == 0) {
			$("#CurTips").show();
			$("#TipsIframe").show();
		}
		if(0 != arguments.length) {
			if(this._m_iTimerID) {
				clearTimeout(this._m_iTimerID);
				this._m_iTimerID = 0;
			}
			$("#CurTips").css("bottom", "-106px");
			if(navigator.appName === "Microsoft Internet Explorer") {
				$("#TipsIframe").css("bottom", "-106px");
			}
			this._m_iTime = 0;
			$("#CurTips").html(szTips);
		}
		if(this._m_iTime >= 20) {
			this._m_iTimerID= setTimeout(that.hideTipsDiv, 1000);
			return;
		}
		var iBottom = parseInt($("#CurTips").css("bottom").replace("px", ""), 10);
		$("#CurTips").css("bottom", (iBottom + 5) + "px");
		if(navigator.appName === "Microsoft Internet Explorer") {
			var iframeBottom = parseInt($("#TipsIframe").css("bottom").replace("px", ""), 10);
			$("#TipsIframe").css("bottom", (iframeBottom + 5) + "px");
		}
		this._m_iTime++;
		this._m_iTimerID = setTimeout(function () {
		    g_oMain.showTipsDiv();
		}, 20);
    },
	
    //隐藏滑动提示框
    hideTipsDiv: function () {
		var that = this;
		if(this._m_iTime <= 0) {
			this._m_iTime = 0;
			this._m_iTimerID = 0;
			return;
		}
		var iBottom = parseInt($("#CurTips").css("bottom").replace("px", ""), 10);
		$("#CurTips").css("bottom", (iBottom - 5) + "px");
		if(navigator.appName === "Microsoft Internet Explorer") {
			var iframeBottom = parseInt($("#TipsIframe").css("bottom").replace("px", ""), 10);
			$("#TipsIframe").css("bottom", (iframeBottom - 5) + "px");
		}
		this._m_iTime--;
		this._m_iTimerID = setTimeout(function () {
		    g_oMain.hideTipsDiv();
		},  20);
		if(this._m_iTime == 0) {
			$("#CurTips").hide();
			$("#TipsIframe").hide();
		}
    }	
}
var g_oMain = new Main();