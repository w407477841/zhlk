<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>

</head>
<body style="background-color:#d9edf7">
<div class=" col-md-12"><h3 class="animated rubberBand">视频预览</h3></div>
<div class=" col-md-12"> 
<div id="divPlugin" class="col-md-9">
</div>
<div class="col-md-3">
	<fieldset class="ptz">
		<legend>云台控制</legend>
		<table cellpadding="0" cellspacing="3" border="0" class="left">
			<tr style="height: 45px;">
				<td>
					<img width="40px" height="40px" src="../img/ptzctrl/left_up.png" onmousedown="mouseDownPTZControl(5);" onmouseup="mouseUpPTZControl();">
					<img width="40px" height="40px" src="../img/ptzctrl/up.png" onmousedown="mouseDownPTZControl(1);" onmouseup="mouseUpPTZControl();" >
					<img width="40px" height="40px" src="../img/ptzctrl/right_up.png" onmousedown="mouseDownPTZControl(7);" onmouseup="mouseUpPTZControl();">
				</td>
			</tr>
			<tr style="height: 45px;">
				<td>
				<img width="40px" height="40px" src="../img/ptzctrl/left.png" onmousedown="mouseDownPTZControl(3);" onmouseup="mouseUpPTZControl();">
				<img width="40px" height="40px" src="../img/ptzctrl/auto.png" >
				<img width="40px" height="40px" src="../img/ptzctrl/right.png" onmousedown="mouseDownPTZControl(4);" onmouseup="mouseUpPTZControl();">
				</td>
			</tr>
			<tr style="height: 45px;">
				<td>
					<img width="40px" height="40px" src="../img/ptzctrl/left_down.png" onmousedown="mouseDownPTZControl(6);" onmouseup="mouseUpPTZControl();">
					<img width="40px" height="40px" src="../img/ptzctrl/down.png"  onmousedown="mouseDownPTZControl(2);" onmouseup="mouseUpPTZControl();" >
					<img width="40px" height="40px" src="../img/ptzctrl/right_down.png" onmousedown="mouseDownPTZControl(8);" onmouseup="mouseUpPTZControl();">
				</td>
			</tr>
		</table>
        <table cellpadding="0" cellspacing="3" border="0" class="left">
            <tr style="height: 70px;">
                <td>
                <img width="40px" height="40px" src="../img/ptzctrl/add.png" onmousedown="PTZZoomIn()" onmouseup="PTZZoomStop()">
                <img width="40px" height="40px" src="../img/ptzctrl/zoom.png" >
                <img width="40px" height="40px" src="../img/ptzctrl/reduce.png" onmousedown="PTZZoomout()" onmouseup="PTZZoomStop()">
                </td>
            </tr>
        </table>
	</fieldset>
	<div id="opinfo" style="height: 140px; overflow: scroll;"></div>
</div>
	</div>
	<script src="${ctx}/js/webVideoCtrl.js"></script>
<script type="text/javascript">
//初始化插件
//全局保存当前选中窗口
var g_iWndIndex = 0; //可以不用设置这个变量，有窗口参数的接口中，不用传值，开发包会默认使用当前选择窗口
$(function () {
	// 检查插件是否已经安装过
 var iRet = WebVideoCtrl.I_CheckPluginInstall();
	if (-2 == iRet) {
		alert("您的Chrome浏览器版本过高，不支持NPAPI插件！");
		return;
	} else if (-1 == iRet) {
    // alert("您还未安装过插件，双击开发包目录里的WebComponentsKit.exe安装！");
     	var div=document.getElementById("divPlugin");
     	var downloadA=document.createElement('a');
     	downloadA.setAttribute("href","${ctx}/codebase/WebComponentsKit.exe" );
     	var text=document.createTextNode('还未装插件，请点击下载,安装完后重新打开浏览器');
     	downloadA.appendChild(text);
     	div.appendChild(downloadA);
		return;
 }
	
	// 初始化插件参数及插入插件
	WebVideoCtrl.I_InitPlugin(650, 400, {
     bWndFull: true,//是否支持单窗口双击全屏，默认支持 true:支持 false:不支持
     iWndowType: 2,
		cbSelWnd: function (xmlDoc) {
			g_iWndIndex = $(xmlDoc).find("SelectWnd").eq(0).text();
		//	var szInfo = "当前选择的窗口编号：" + g_iWndIndex;
		//	showCBInfo(szInfo);
		}
	});
	WebVideoCtrl.I_InsertOBJECTPlugin("divPlugin");

	// 检查插件是否最新
	if (-1 == WebVideoCtrl.I_CheckPluginVersion()) {
		alert("检测到新的插件版本，双击开发包目录里的WebComponentsKit.exe升级！");
		return;
	}

	// 窗口事件绑定
	$(window).bind({
		resize: function () {
			var $Restart = $("#restartDiv");
			if ($Restart.length > 0) {
				var oSize = getWindowSize();
				$Restart.css({
					width: oSize.width + "px",
					height: oSize.height + "px"
				});
			}
		}
	});

 //初始化日期时间
 var szCurTime = dateFormat(new Date(), "yyyy-MM-dd");
 $("#starttime").val(szCurTime + " 00:00:00");
 $("#endtime").val(szCurTime + " 23:59:59");
	WebVideoCtrl.I_ChangeWndNum(1);
	clickLogin(clickStartRealPlay);

	

});

//显示操作信息
function showOPInfo(szInfo) {
	szInfo = "<div>" + dateFormat(new Date(), "yyyy-MM-dd hh:mm:ss") + " " + szInfo + "</div>";
	$("#opinfo").html(szInfo + $("#opinfo").html());
}

//显示回调信息
function showCBInfo(szInfo) {
	szInfo = "<div>" + dateFormat(new Date(), "yyyy-MM-dd hh:mm:ss") + " " + szInfo + "</div>";
	$("#cbinfo").html(szInfo + $("#cbinfo").html());
}

//格式化时间
function dateFormat(oDate, fmt) {
	var o = {
		"M+": oDate.getMonth() + 1, //月份
		"d+": oDate.getDate(), //日
		"h+": oDate.getHours(), //小时
		"m+": oDate.getMinutes(), //分
		"s+": oDate.getSeconds(), //秒
		"q+": Math.floor((oDate.getMonth() + 3) / 3), //季度
		"S": oDate.getMilliseconds()//毫秒
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (oDate.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for (var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
}

//获取窗口尺寸
function getWindowSize() {
	var nWidth = $(this).width() + $(this).scrollLeft(),
		nHeight = $(this).height() + $(this).scrollTop();

	return {width: nWidth, height: nHeight};
}

//打开选择框 0：文件夹  1：文件
function clickOpenFileDlg(id, iType) {
	var szDirPath = WebVideoCtrl.I_OpenFileDlg(iType);
	
	if (szDirPath != -1 && szDirPath != "" && szDirPath != null) {
		$("#" + id).val(szDirPath);
	}
}

//获取本地参数
function clickGetLocalCfg() {
	var xmlDoc = WebVideoCtrl.I_GetLocalCfg();

	$("#netsPreach").val($(xmlDoc).find("BuffNumberType").eq(0).text());
	$("#wndSize").val($(xmlDoc).find("PlayWndType").eq(0).text());
	$("#rulesInfo").val($(xmlDoc).find("IVSMode").eq(0).text());
	$("#captureFileFormat").val($(xmlDoc).find("CaptureFileFormat").eq(0).text());
	$("#packSize").val($(xmlDoc).find("PackgeSize").eq(0).text());
	$("#recordPath").val($(xmlDoc).find("RecordPath").eq(0).text());
	$("#downloadPath").val($(xmlDoc).find("DownloadPath").eq(0).text());
	$("#previewPicPath").val($(xmlDoc).find("CapturePath").eq(0).text());
	$("#playbackPicPath").val($(xmlDoc).find("PlaybackPicPath").eq(0).text());
	$("#playbackFilePath").val($(xmlDoc).find("PlaybackFilePath").eq(0).text());
 $("#protocolType").val($(xmlDoc).find("ProtocolType").eq(0).text());

	showOPInfo("本地配置获取成功！");
}

//设置本地参数
function clickSetLocalCfg() {
	var arrXml = [],
		szInfo = "";
	
	arrXml.push("<LocalConfigInfo>");
	arrXml.push("<PackgeSize>" + $("#packSize").val() + "</PackgeSize>");
	arrXml.push("<PlayWndType>" + $("#wndSize").val() + "</PlayWndType>");
	arrXml.push("<BuffNumberType>" + $("#netsPreach").val() + "</BuffNumberType>");
	arrXml.push("<RecordPath>" + $("#recordPath").val() + "</RecordPath>");
	arrXml.push("<CapturePath>" + $("#previewPicPath").val() + "</CapturePath>");
	arrXml.push("<PlaybackFilePath>" + $("#playbackFilePath").val() + "</PlaybackFilePath>");
	arrXml.push("<PlaybackPicPath>" + $("#playbackPicPath").val() + "</PlaybackPicPath>");
	arrXml.push("<DownloadPath>" + $("#downloadPath").val() + "</DownloadPath>");
	arrXml.push("<IVSMode>" + $("#rulesInfo").val() + "</IVSMode>");
	arrXml.push("<CaptureFileFormat>" + $("#captureFileFormat").val() + "</CaptureFileFormat>");
 arrXml.push("<ProtocolType>" + $("#protocolType").val() + "</ProtocolType>");
	arrXml.push("</LocalConfigInfo>");

	var iRet = WebVideoCtrl.I_SetLocalCfg(arrXml.join(""));

	if (0 == iRet) {
		szInfo = "本地配置设置成功！";
	} else {
		szInfo = "本地配置设置失败！";
	}
	showOPInfo(szInfo);
}

//窗口分割数
function changeWndNum(iType) {
	iType = parseInt(iType, 10);
	WebVideoCtrl.I_ChangeWndNum(iType);
}

//登录
function clickLogin(callback) {
	
	
	var szIP = '${param.ip}',
		szPort = '${param.port}',
		szUsername = '${param.userName}',
		szPassword = '${param.password}';

	if ("" == szIP || "" == szPort) {
		return;
	}

	var iRet = WebVideoCtrl.I_Login(szIP, 1, szPort, szUsername, szPassword, {
		success: function (xmlDoc) {
	if(!callback){//为空
		}else{//不为空
				callback();
	}	
		},
		error: function () {
			showOPInfo(szIP + " 登录失败！");
		}
	});

	if (-1 == iRet) {
		showOPInfo(szIP + " 已登录过！");
	}
}

//退出
function clickLogout() {
	var szIP = $("#ip").val(),
		szInfo = "";

	if (szIP == "") {
		return;
	}

	var iRet = WebVideoCtrl.I_Logout(szIP);
	if (0 == iRet) {
		szInfo = "退出成功！";

	} else {
		szInfo = "退出失败！";
	}
	showOPInfo(szIP + " " + szInfo);
}

//获取设备信息
function clickGetDeviceInfo() {
	var szIP = $("#ip").val();

	if ("" == szIP) {
		return;
	}

	WebVideoCtrl.I_GetDeviceInfo(szIP, {
		success: function (xmlDoc) {
			var arrStr = [];
			arrStr.push("设备名称：" + $(xmlDoc).find("deviceName").eq(0).text() + "\r\n");
			arrStr.push("设备ID：" + $(xmlDoc).find("deviceID").eq(0).text() + "\r\n");
			arrStr.push("型号：" + $(xmlDoc).find("model").eq(0).text() + "\r\n");
			arrStr.push("设备序列号：" + $(xmlDoc).find("serialNumber").eq(0).text() + "\r\n");
			arrStr.push("MAC地址：" + $(xmlDoc).find("macAddress").eq(0).text() + "\r\n");
			arrStr.push("主控版本：" + $(xmlDoc).find("firmwareVersion").eq(0).text() + " " + $(xmlDoc).find("firmwareReleasedDate").eq(0).text() + "\r\n");
			arrStr.push("编码版本：" + $(xmlDoc).find("encoderVersion").eq(0).text() + " " + $(xmlDoc).find("encoderReleasedDate").eq(0).text() + "\r\n");
			
			showOPInfo(szIP + " 获取设备信息成功！");
			alert(arrStr.join(""));
		},
		error: function () {
			showOPInfo(szIP + " 获取设备信息失败！");
		}
	});
}





//开始预览
function clickStartRealPlay() {

	var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
		szIP = '${param.ip}',
		
		szInfo = "";
	
	if ("" == szIP) {
		return;
	}

	if (oWndInfo != null) {// 已经在播放了，先停止
		WebVideoCtrl.I_Stop();
	}
	var iRet = WebVideoCtrl.I_StartRealPlay(szIP, {
		iStreamType: 1,
		iChannelID: (parseInt('${param.ipNum}')-31),
		bZeroChannel: false
	});

	if (0 == iRet) {
		szInfo = "开始预览成功！";
	} else {
		szInfo = "开始预览失败！";
	}

	
}



//PTZ控制 9为自动，1,2,3,4,5,6,7,8为方向PTZ
var g_bPTZAuto = false;
function mouseDownPTZControl(iPTZIndex) {
	var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex),
		bZeroChannel =false,
		iPTZSpeed = '1';

	if (bZeroChannel) {// 零通道不支持云台
		return;
	}
	
	if (oWndInfo != null) {
		if (9 == iPTZIndex && g_bPTZAuto) {
			iPTZSpeed = 0;// 自动开启后，速度置为0可以关闭自动
		} else {
			g_bPTZAuto = false;// 点击其他方向，自动肯定会被关闭
		}

		WebVideoCtrl.I_PTZControl(iPTZIndex, false, {
			iPTZSpeed: iPTZSpeed,
			success: function (xmlDoc) {
				if (9 == iPTZIndex) {
					g_bPTZAuto = !g_bPTZAuto;
				}
				showOPInfo(oWndInfo.szIP + " 开启云台成功！");
			},
			error: function () {
				showOPInfo(oWndInfo.szIP + " 开启云台失败！");
			}
		});
	}
}

//方向PTZ停止
function mouseUpPTZControl() {
	var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

	if (oWndInfo != null) {
		WebVideoCtrl.I_PTZControl(1, true, {
			success: function (xmlDoc) {
				//showOPInfo(oWndInfo.szIP + " 停止云台成功！");
			},
			error: function () {
				//showOPInfo(oWndInfo.szIP + " 停止云台失败！");
			}
		});
	}
}



//检查插件版本
function clickCheckPluginVersion() {
	var iRet = WebVideoCtrl.I_CheckPluginVersion();
	if (0 == iRet) {
		alert("您的插件版本已经是最新的！");
	} else {
		alert("检测到新的插件版本！");
	}
}

//远程配置库
function clickRemoteConfig() {
	var szIP = $("#ip").val(),
		iDevicePort = parseInt($("#deviceport").val(), 10) || "",
		szInfo = "";
	
	if ("" == szIP) {
		return;
	}

	var iRet = WebVideoCtrl.I_RemoteConfig(szIP, {
		iDevicePort: iDevicePort,
		iLan: 1
	});

	if (-1 == iRet) {
		szInfo = "调用远程配置库失败！";
	} else {
		szInfo = "调用远程配置库成功！";
	}
	showOPInfo(szIP + " " + szInfo);
}

function clickRestoreDefault() {
 var szIP = $("#ip").val(),
     szMode = "basic";
 WebVideoCtrl.I_RestoreDefault(szIP, szMode, {
     timeout: 30000,
     success: function (xmlDoc) {
         $("#restartDiv").remove();
         showOPInfo(szIP + " 恢复默认参数成功！");
         //恢复完成后需要重启
         WebVideoCtrl.I_Restart(szIP, {
             success: function (xmlDoc) {
                 $("<div id='restartDiv' class='freeze'>重启中...</div>").appendTo("body");
                 var oSize = getWindowSize();
                 $("#restartDiv").css({
                     width: oSize.width + "px",
                     height: oSize.height + "px",
                     lineHeight: oSize.height + "px",
                     left: 0,
                     top: 0
                 });
                 setTimeout("reconnect('" + szIP + "')", 20000);
             },
             error: function () {
                 showOPInfo(szIP + " 重启失败！");
             }
         });
     },
     error: function () {
         showOPInfo(szIP + " 恢复默认参数失败！");
     }
 });
}

function PTZZoomIn() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(10, false, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 调焦+成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  调焦+失败！");
         }
     });
 }
}

function PTZZoomout() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(11, false, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 调焦-成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  调焦-失败！");
         }
     });
 }
}

function PTZZoomStop() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(11, true, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 调焦停止成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  调焦停止失败！");
         }
     });
 }
}

function PTZFocusIn() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(12, false, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 聚焦+成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  聚焦+失败！");
         }
     });
 }
}

function PTZFoucusOut() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(13, false, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 聚焦-成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  聚焦-失败！");
         }
     });
 }
}

function PTZFoucusStop() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(12, true, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 聚焦停止成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  聚焦停止失败！");
         }
     });
 }
}

function PTZIrisIn() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(14, false, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 光圈+成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  光圈+失败！");
         }
     });
 }
}

function PTZIrisOut() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(15, false, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 光圈-成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  光圈-失败！");
         }
     });
 }
}

function PTZIrisStop() {
 var oWndInfo = WebVideoCtrl.I_GetWindowStatus(g_iWndIndex);

 if (oWndInfo != null) {
     WebVideoCtrl.I_PTZControl(14, true, {
         iWndIndex: g_iWndIndex,
         success: function (xmlDoc) {
             showOPInfo(oWndInfo.szIP + " 光圈停止成功！");
         },
         error: function () {
             showOPInfo(oWndInfo.szIP + "  光圈停止失败！");
         }
     });
 }
}

dateFormat = function (oDate, fmt) {
 var o = {
     "M+": oDate.getMonth() + 1, //月份
     "d+": oDate.getDate(), //日
     "h+": oDate.getHours(), //小时
     "m+": oDate.getMinutes(), //分
     "s+": oDate.getSeconds(), //秒
     "q+": Math.floor((oDate.getMonth() + 3) / 3), //季度
     "S": oDate.getMilliseconds()//毫秒
 };
 if(/(y+)/.test(fmt)) {
     fmt = fmt.replace(RegExp.$1, (oDate.getFullYear() + "").substr(4 - RegExp.$1.length));
 }
 for (var k in o) {
     if(new RegExp("(" + k + ")").test(fmt)) {
         fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
     }
 }
 return fmt;
};

//切换模式
function changeIPMode(iType) {
	var arrPort = [0, 7071, 80];

	$("#serverport").val(arrPort[iType]);
}

//获取设备IP
function clickGetDeviceIP() {
	var iDeviceMode = parseInt($("#devicemode").val(), 10),
		szAddress = $("#serveraddress").val(),
		iPort = parseInt($("#serverport").val(), 10) || 0,
		szDeviceID = $("#deviceid").val(),
		szDeviceInfo = "";

	szDeviceInfo = WebVideoCtrl.I_GetIPInfoByMode(iDeviceMode, szAddress, iPort, szDeviceID);

	if ("" == szDeviceInfo) {
		showOPInfo("设备IP和端口解析失败！");
	} else {
		showOPInfo("设备IP和端口解析成功！");

		var arrTemp = szDeviceInfo.split("-");
		$("#loginip").val(arrTemp[0]);
		$("#deviceport").val(arrTemp[1]);
	}
}


</script>
