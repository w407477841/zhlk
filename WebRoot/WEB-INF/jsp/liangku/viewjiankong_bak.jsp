<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <script src="${ctx}/bower_components/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="${ctx}/common/common.js"></script>
<script type="text/javascript">
//全局变量定义

//var url='${ctx}/warehouse/jkInfo.shtml?wno=${param.name}';
//var configProp=CommnUtil.ajax(url, null,'json');

//var configProp={"1000001":{"szDevIp":"218.91.235.70","szDevPort":"8003","szDevUser":"lq","szDevPwd":"369258147"}}



var m_iNowChanNo = -1;                           //当前通道号
var m_iLoginUserId = -1;                         //注册设备用户ID
var m_iChannelNum = -1; 						 //模拟通道总数
var m_iIPChannelNum = -1;                        //IP通道总数
var m_bDVRControl = null;						 //OCX控件对象
var m_iProtocolType = 0;                         //协议类型，0 – TCP， 1 - UDP
var m_iStreamType = 0;                           //码流类型，0 表示主码流， 1 表示子码流
var m_iPlay = 0;                                 //当前是否正在预览
var m_iRecord = 0;                               //当前是否正在录像
var m_iTalk = 0;                                 //当前是否正在对讲 
var m_iVoice = 0;                                //当前是否打开声音
var m_iAutoPTZ = 0;                              //当前云台是否正在自转
var m_iPTZSpeed = 4;                             //云台速度
var m_szDeviceType = 0;                          //设备类型
var m_iPlayback = 0;                             //是否回放状态 
var m_iDownload = 0;                             //是否下载状态 
/*************************************************
  Function:    	onload
  Description:	页面加载完后判断系统日期是否在1971-2037范围
  Input:        无
  Output:      	无
  Return:		无
*************************************************/
window.onload = function()
{ 
	var myDate = new Date();
	var iYear = myDate.getFullYear();        
	if(iYear < 1971 || iYear > 2037)
	{
		alert("为了正常使用本软件，请将系统日期年限设置在1971-2037范围内！");
		//parent.location.href = "../login.php";
	}
	if(document.getElementById("HIKOBJECT1").object == null)
	{
		alert("请先下载控件并注册！");
		m_bDVRControl = null;
	}
	else
	{
		m_bDVRControl = document.getElementById("HIKOBJECT1");
	//	window.parent.dVRControl=m_bDVRControl;
		ChangeStatus(1);
		ArrangeWindow(1);
		zhuce();
		yulan('${param.ipNum}');
	}
} 

function zhuce(){
	
				m_iLoginUserId = m_bDVRControl.Login('${param.ip}','${param.port}','${param.userName}','${param.password}');
}
function yulan(No){
		var m_iNowChanNo=No;
        if (m_iNowChanNo > -1) {

            if (m_iPlay == 1) {

                m_bDVRControl.StopRealPlay();
                m_iPlay = 0;

            }


            var bRet = m_bDVRControl.StartRealPlay(m_iNowChanNo, m_iProtocolType, m_iStreamType);

            if (bRet) {

           
                m_iPlay = 1;

            }

            else {

           

                var dRet = m_bDVRControl.GetLastError();
          		alert("错误号"+dRet);

            }

        }

    
}

function kongzhi( direction){
	
	if(m_iPlay == 1)
	{
		if(m_iAutoPTZ == 1) //自动旋转中
		{
			m_bDVRControl.PTZCtrlStop(10,m_iPTZSpeed);
			m_iAutoPTZ = 0;
		}
		if(m_bDVRControl.PTZCtrlStart(direction,m_iPTZSpeed)){
			window.setTimeout(function(){
				m_bDVRControl.PTZCtrlStop(direction,m_iPTZSpeed);	
			},200);
			
			
		}
		else
	{
		alert("操作失败")
	}
}
	else
	{
		alert("预览失败")
	}
	
}
//document.oncontextmenu = rightclick;
/*************************************************
  Function:    	rightclick
  Description:	网页禁用右键
  Input:        无
  Output:      	无
  Return:		bool:   true false
*************************************************/
function rightclick()
{
	return false;
}
/*************************************************
  Function:    	rightclick
  Description:	网页禁用右键
  Input:        无
  Output:      	无
  Return:		bool:   true false
*************************************************/

//window.onbeforeunload = onbeforeunload_handler;
window.onunload = onunload_handler;
/*
function onbeforeunload_handler(){
    var warning="确认退出?";   
	return warning;
    }
  */ 
function onunload_handler(){
	m_bDVRControl.Logout()
//    var warning="已退出";
//    alert(warning);
    }
</script>
<script type="text/javascript" for="HIKOBJECT1" event="SelectWindow()">
	ChangeStatus(1);
</script>

</head>
<body style="background:#999999">


  
    <div id="BodyRight" align="center" style="width:800px;height:600px">
    <div id="OCXBody">



    <table  style="width:800px;height:600px" >
    <tr>
    <td width="580px" height="600px">
      
        <div class="smallocxdiv" id="NetPlayOCX1">
          <object classid="CLSID:CAFCF48D-8E34-4490-8154-026191D73924"  standby="Waiting..." id="HIKOBJECT1" width="100%" height="100%" name="HIKOBJECT1" ></object>
        </div>
    </td>
    <td width="120px">
    <table style="border:1px solid">
<tr><td><img width="30px" height="30px" src="../img/ptzctrl/left_up.png" onclick="kongzhi(13)"></td>
<td><img width="30px" height="30px" src="../img/ptzctrl/up.png" onclick="kongzhi(0)"></td>
<td><img width="30px" height="30px" src="../img/ptzctrl/right_up.png" onclick="kongzhi(14)"></td>
</tr>
<tr><td><img width="30px" height="30px" src="../img/ptzctrl/left.png" onclick="kongzhi(2)"></td>
<td><img width="30px" height="30px" src="../img/ptzctrl/auto.png" ></td>
<td><img width="30px" height="30px" src="../img/ptzctrl/right.png" onclick="kongzhi(3)"></td>
</tr>
<tr>
<td><img width="30px" height="30px" src="../img/ptzctrl/left_down.png" onclick="kongzhi(15)"></td>
<td><img width="30px" height="30px" src="../img/ptzctrl/down.png" onclick="kongzhi(1)"></td>
<td><img width="30px" height="30px" src="../img/ptzctrl/right_down.png" onclick="kongzhi(16)"></td></tr>

<tr>
<td><img width="30px" height="30px" src="../img/ptzctrl/add.png" onclick="kongzhi(4)"></td>
<td><img width="30px" height="30px" src="../img/ptzctrl/zoom.png" ></td>
<td><img width="30px" height="30px" src="../img/ptzctrl/reduce.png" onclick="kongzhi(5)"></td></tr>

</table>
    </td>
    </tr>
        </table>
</div>
</div>
</body>
</html>
<script type="text/javascript">
/*************************************************
Function:		ArrangeWindow
Description:	画面分割为几个窗口
Input:			x : 窗口数目			
Output:			无
return:			无				
*************************************************/
function ArrangeWindow(x)
{
	var iMaxWidth = document.getElementById("OCXBody").offsetWidth;
	var iMaxHeight = document.getElementById("OCXBody").offsetHeight;
	for(var i = 1; i <= 1; i ++)
	{
		if(i <= x)
		{
			document.getElementById("NetPlayOCX" + i).style.display = "";
		}
		else
		{
			document.getElementById("NetPlayOCX" + i).style.display = "none";	
		}
	}
	var d = Math.sqrt(x);
	var iWidth = iMaxWidth/d;
	var iHight = iMaxHeight/d;
	for(var j = 1; j <= x; j ++)
	{
		document.getElementById("NetPlayOCX" + j).style.width = iWidth;
		document.getElementById("NetPlayOCX" + j).style.height = iWidth/16*9-50;
	}
}
/*************************************************
Function:		ChangeStatus
Description:	选中窗口时，相应通道的状态显示
Input:			iWindowNum : 	选中窗口号		
Output:			无
return:			无				
*************************************************/
function ChangeStatus(iWindowNum)
{  
	m_bDVRControl = document.getElementById("HIKOBJECT" + iWindowNum);
	for(var i = 1; i <= 1; i ++)
	{
		if(i == iWindowNum)
		{
			document.getElementById("NetPlayOCX" + i).style.border = "1px solid #00F";
		}
		else
		{
			document.getElementById("NetPlayOCX" + i).style.border = "1px solid #EBEBEB";	
		}
	}

}
</script>
