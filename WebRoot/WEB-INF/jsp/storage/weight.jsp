<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE>
<head>
  <link rel="stylesheet" href="<%=path %>/css/bootstrap-cerulean.min.css" />
  <script type="text/javascript"  src="<%=path %>/bower_components/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="<%=path %>/bower_components/bootstrap/dist/js/bootstrap.js"></script>
  <script type="text/javascript" src="<%=path %>/js/EventUtil.js"></script>
  <script type="text/javascript" src="<%=path %>/js/layer-v1.9.2/layer/layer.js"></script>
</head>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
<style>
* {
	margin: 0 auto;
	box-sizing: border-box
}

.container {
	width: 100%;
	padding: 0 50px;
	background: #99abaa;
	min-height: 100vh;
}

.box-content:first-child {
	width: 100%;
	background: #fff;
	box-shadow:0px 0px 20px 3px #164b56;
}

.box-content:not (:first-child ){
	width: 50%;
	float: left;
	padding: 8px
}

.l_f {
	float: left;
	padding-right: 30px;
}

.div_1  ul {
	list-style: none;
	margin: auto;
	display: block;
	padding-left: 0px;
	padding-top: 10px;
}

.div_1  ul li {
	line-height: 25px;
	height: 35px
}

.l_f {
	width: 25%
}

.div_h1 {
	text-align: left;
	margin: 24;
	width: 40%;
	font-size: 36px;
	display: inline-block;
	color: red;
	vertical-align: sub;
}

.div_h3 {
	text-align: left;
	display: inline-block;
	width: 20%;
	font-size: 24px;
	vertical-align: super;
}

.table {
	margin-bottom: 10px;
}

.div_radio {
	text-align: center;
	display: inline-block;
	width: 20%;
	font-size: 12px;
	vertical-align: super;
}

.weighting_div {
	padding: 10px;
}

.border {
	border: 1px solid #ddd;
	padding: 10px;
	height: auto;
	line-height: 36px;
	/*  
  margin-bottom: 20px;
  */
	background-color: white;
}

.btn{
margin-right: 10px;
}
.div_table {
	border: 1px solid #ddd;
	border-top-width: 0;
}

.table_pane {
	height: 218px;
	overflow: auto;
	display: block;
	padding: 0 10 0 10
}

.btn-disable {
	color: #fff;
	background-color: grey;
	cursor: default;
	translation: all 1.5s;
	-webkit-translation:all 1.5s;
	-ms-translation:all 1.5s;
	-moz-translation:all 1.5s;
}

.btn-disable:HOVER,.btn-disable:FOCUS {
	color: #fff;
	background-color: grey;
	cursor: default;
}

.btn-confirm {
	color: #fff;
	background-color: #FE6C60;
	border: #FE6C60;
}

.btn-confirm:HOVER,.btn-confirm:FOCUS {
	color: #fff;
	background-color: #FE6C60;
	border: #FE6C60;
}

div.flickr {
	padding: 3px;
	margin: 3px;
	text-align: right;
}

blockquote span {
	color: #bce8f1;
	text-align: center;
	line-height: 290px;
	display: block;
	font: 18px;
}

.col-md-6,.col-md-4,.col-md-8,.col-md-12 {
	padding: 0
}

.cont {
	margin: 0 30px;
}

.cont>div:not(:FIRST-CHILD) {
	float: left;
	display: block;
	margin: 15px 0;
}

#OCXBody {
	height: 290px;
	background: #000;
	margin: 10px
}

.nav.nav-tabs {
	margin: 0
}
.form-control{
height: 32px
}
.download{
height: 70px;
width:0px;
background: #a37dbf;
border-radius:3px;
transition:width .4s cubic-bezier(0, 0.25, 0.58, 1);
display: flex;
align-items:center;
justify-content:center;
}
.download-show{
width:100%;
height: 70px;
}
.download a{
text-decoration: none;
color:#fff ;
font-size: 26px;
}

.or-spacer {
    margin-top: 100px;
    margin-left: 100px;
    width: 100%;
    position: relative;
}
.or-spacer .mask {
    overflow: hidden;
    height: 20px;
}
.or-spacer .mask:after {
    content: '';
    display: block;
    margin: -25px auto 0;
    width: 100%;
    height: 25px;
    border-radius: 125px/12px;
    box-shadow: 0 0 8px black;
}

</style>
<script type="text/javascript">
$(document).ready(function(){
	var dom=document.getElementById("input_id");
	dom.focus();
	EventUtil.addHandler(dom,"keyup",handle);//激活读取流水号事处理程序
})	
	var gloal={};
	function weighting(){
	var weight=$("#weight").text();
//	var weight=~~(Math.random()*1000);
	var id=$("#input_id").val();
	var carid=$("#input_carid").text();
	var ifchecked=document.getElementById("lastWeight").checked
	//alert(id.substring(0,14));
 				$.ajax({	
				url:rootPath+"/storage/weighting.shtml",
				data:{"id":id,"weight":weight,"carid":carid,"ifchecked":ifchecked},
				async:true,
				type:"post",
				success:function(rs){
					$("#input_id").val("");
						var currClass=$("#confirm_weight").attr("class","btn btn-disable");
								   if(gloal.unbind_w)	gloal.unbind_w();
								   if(rs.last) {
								   layer.confirm("称重结束,是否打印凭证?",function(i){
								   window.open(rootPath+"/gridReport/shouchuxitong/w.jsp?id="+id.substring(0,14)+"","报表下载");
								   layer.close(i);
								   })
								   }
 						$.ajax({	
						url:rootPath+"/storage/singleBill.shtml",
						data:{"id":id},
						type:"post",
						success:function(rs){
							if(rs.success||rs.complete){
							$("#singleShow tbody").empty();
							for(var i=0;i<rs.map.length;i++){
							$("#singleShow tbody").append("<tr>"+
												"<td>"+rs.map[i].id+"</td>"+
												"<td>"+Math.abs(rs.map[i].TotalWeight)+"</td>"+
												"<td>"+rs.map[i].TotalWeightingTime+"</td>"+
												"<td>"+Math.abs(rs.map[i].CarWeight)+"</td>"+
												"<td>"+rs.map[i].CarWeightingTime+"</td>"+
												"<td>"+rs.map[i].Price+"</td>"+
											"</tr>")
											}
						}

							}
				});  
				}
		}); 
	}
//流水号事处理程序	
var handle=function(){
			var dom=document.getElementById("input_id");
			var reg=/^[0-9]{14,18}$/;
			$("#confirm_weight").attr("class","btn btn-disable");
			$(" #print").attr("class","btn btn-disable");
			//EventUtil.removeHandler(document.getElementById("print"),"click",print);
			if(typeof(gloal.unbind) == 'function'){
				gloal.unbind();
			}
			document.getElementById("lastWeight").checked=false;
		if(reg.test(dom.value)){
		$.ajax({	
			url:rootPath+"/storage/singleBill.shtml",
			async:false,
			data:{"id":dom.value},
			type:"post",
			success:function(rs){
			//称重未完成
			if(rs.success){
				$("#confirm_weight").removeClass("btn-disable").addClass("btn-confirm");
		   //确认称重添加事件处理程序
		   if(gloal.unbind_w){
		   gloal.unbind_w();
		   }
				gloal.unbind_w=EventUtil.addParamHandler(document.getElementById("confirm_weight"),"click",weightingHandle);
			}else{
				$("#input_name").empty();	$("#input_carid").empty();
			  }
				$("#singleShow tbody").empty();
 				for(var i=0;i<rs.map.length;i++){
				$("#singleShow tbody").append("<tr>"+
									"<td>"+rs.map[i].id+"</td>"+
									"<td>"+Math.abs(rs.map[i].TotalWeight)+"</td>"+
									"<td>"+rs.map[i].TotalWeightingTime+"</td>"+
									"<td>"+Math.abs(rs.map[i].CarWeight)+"</td>"+
									"<td>"+rs.map[i].CarWeightingTime+"</td>"+
									"<td>"+rs.map[i].Price+"</td>"+
								"</tr>")
								} 
					if(rs.list!=null){
						$("#input_carid").text(rs.list[0].carid);
						$("#input_name").text(rs.list[0].owner);
						//不启用驳车
						if(rs.list[0].usercar=="0"){
						document.getElementById("lastWeight").checked=true
						}
					}
					//打印票据
					if(rs.list[0].state=="2"){
						$("#print").removeClass("btn-disable").addClass("btn-success");
						gloal.unbind=EventUtil.addParamHandler(document.getElementById("print"),"click",print,dom.value);
					}
				
				}
	}); 
		}
			
}
//打印是处理程序
function print(){
window.open(rootPath+"/gridReport/shouchuxitong/w.jsp?id="+arguments[0].substring(0,14)+"","报表下载");
}
//称重事处理程序	
function weightingHandle(){	
			if(!MSComm1.PortOpen)	ConfigPort(); //如果不初始化直接称重
				//$('.timer').each(count);  
				weighting();
		}
function totalBill(){
					$.ajax({	
						url:rootPath+"/storage/totalBill.shtml",
						type:"post",
						success:function(rs){
							if(rs.success){
											$("#totalShow tbody").empty();
												for(var i=0;i<rs.list.length;i++){
													$("#totalShow tbody").append("<tr id='"+rs.list[i].id+"'>"+
													"<td>"+rs.list[i].id+"</td>"+
													"<td>"+rs.list[i].Owner+"</td>"+
													"<td>"+rs.list[i].Name+"</td>"+
													"<td>"+Math.abs(rs.list[i].TotalWeight)+"</td>"+
													"<td>"+Math.abs(rs.list[i].CarWeight)+"</td>"+
													"<td>"+rs.list[i].BuyPrice+"</td>"+
													"<td>"+rs.list[i].count+"</td>"+
												"</tr>");
												}
										   clickHandle();}
							}
				}); 
	}
function singleBill(){
		$(".flickr").empty()
	}
	function clickHandle(){
		$("#totalShow tbody tr").on("click",function(){
		var id1=$(this).attr("id");
		$.ajax({	
			url:rootPath+"/storage/billList.shtml",
			data:{"id1":id1},
			type:"post",
			success:function(rs){
				if(rs.success){
				$("#singleBillList").empty();
				for(var i=0;i<rs.map.length;i++){
				$("#singleBillList").append("<tr>"+
									"<td>"+(parseInt(i)+1)+"</td>"+
									"<td>"+rs.map[i].id+"</td>"+
									"<td>"+Math.abs(rs.map[i].TotalWeight)+"</td>"+
									"<td>"+rs.map[i].TotalWeightingTime+"</td>"+
									"<td>"+Math.abs(rs.map[i].CarWeight)+"</td>"+
									"<td>"+rs.map[i].CarWeightingTime+"</td>"+
									"<td>"+rs.map[i].CarID+"</td>"+
								"</tr>")

	}
					layer.open({
								type : 1,
								title : '称重明细',
								maxmin : true,
								offset : ['10%'],
								shadeClose : true, //点击遮罩关闭层
								area : [ '900px' ],
								content : $('#weightinglist'),
								btn : [ '打印凭证','返回' ],
								yes:function(index){
								window.open(rootPath+"/gridReport/shouchuxitong/w.jsp?id="+id1+"","报表下载");
								layer.close(index);
								}
							});
									}
										}
									});
						})
	}
	
function page(){
	laypage({
	  cont: $('.flickr'), 
	  pages: 2, 
	  skin: 'molv',
	  groups: 3 ,
	  jump: function(obj, first){ 
        if(!first){ 
          alert(obj.curr);
        }
      }
	});
}	
</script>
<body>
	<div class="container">
		<div class="box-content">
			<div class="page-content clearfix cont">
			<div  	class="col-md-12 column download">
			<a href="#">点这里下载最新报表插件</a>
			</div>
				<div class="col-md-12 column ">
					<div class="col-md-6 column" style="width: 40%">
						<div class="div_1">
							<ul>
								<li><label class="l_f">流水号 :</label>
								<input name="" type="text" class="form-control" placeholder="" id="input_id" style=" width:200px" /></li>
								<li><label class="l_f">姓名 :</label><label id="input_name"></label></li>
								<li><label class="l_f">车牌号 :</label><label id="input_carid"></label></li>
							</ul>
						</div>
					</div>
					<div class="col-md-6 column" style="width: 60%;padding: 5px 0;">
						<div class="alert alert-dismissable alert-info">
							<span class="div_radio"><input id="lastWeight"
								name="weight" type="checkbox" style="vertical-align: sub;" />
								最后一次称 </span> <span class="div_h1 timer" id="weight">00.00</span> <span
								class="div_h3">kg</span>
						</div>
					</div>
				</div>
				<div class="col-md-12 column">
					<a id="initMSComm" href="javascript:void(0)" title="初始化"
						class="btn btn-warning Order_form"><i class="icon-plus"></i>初始化</a>
					<a id="confirm_weight" href="javascript:void(0)"
						class="btn btn-disable"><i class="icon-trash"></i>确认称重</a>
					<a id="print" href="javascript:void(0)" class="btn btn-disable">打印凭证</a>
					<a href="javascript:void(0)" class="btn btn-success">复位</a>
				</div>
				<div class="col-md-12 column">
					<div class="tabbable" id="tabs-435228">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#panel-861281" data-toggle="tab"
								onclick="singleBill()">逐条显示</a>
							</li>
							<li><a href="#panel-891936" data-toggle="tab"
								onclick=totalBill();>汇总展示</a>
							</li>
						</ul>
						<div class="tab-content div_table">
							<div class="tab-pane active" id="panel-861281">
								<div class="table_pane">
									<table class="table table-hover table-condensed table-striped"
										id="singleShow">
										<thead>
											<tr>
												<th>流水号</th>
												<th>毛重(kg)</th>
												<th>称毛重时间</th>
												<th>皮重(kg)</th>
												<th>称皮重时间</th>
												<th>单价</th>
											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane" id="panel-891936">
								<div class="table_pane">
									<table class="table table-hover table-condensed table-striped"
										id="totalShow">
										<thead>
											<tr>
												<th>流水号</th>
												<th>货主姓名</th>
												<th>品种</th>
												<th>总毛重(kg)</th>
												<th>总皮重(kg)</th>
												<th>单价(元)</th>
												<th>称重次数</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

				</div>
				
		<div class="col-md-12 column">
				<div class="col-md-6 column">
					<div id="OCXBody" class="ocxBody">
						<div id="NetPlayOCX1" style="box-shadow:0px 0px 20px 2px #ccc1c1">
							<object classid="CLSID:CAFCF48D-8E34-4490-8154-026191D73924"
								standby="Waiting..." id="HIKOBJECT1" width="100%" height="290px"
								name="HIKOBJECT1"></object>
						</div>
					</div>
				</div>

				<div class="col-md-6 column">
					<textarea id="text_content" cols="40" class="form-control"
						rows="10" style="width: 100%;height: 290px;margin: 10px"></textarea>
				</div>
			</div>
			<div class="or-spacer"><div class="mask"></div></div>	
<footer>
		<div class="col-md-12 column" style="text-align: center;">	
        <p class=" copyright">&copy; <a href="http://www.jszyiot.com/" target="_blank">江苏中源物联网技术发展有限公司
                </a> 2016 - 2017</p>
    </footer>	
			</div>
			
			
			</div>





			<div id="weightinglist" style="display:none;margin: 10px">
				<div class="table_menu_list">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>编号</th>
								<th>流水号</th>
								<th>毛重(kg)</th>
								<th>称毛重时间</th>
								<th>皮重(kg)</th>
								<th>称皮重时间</th>
								<th>车牌号</th>
							</tr>
						</thead>
						<tbody id="singleBillList">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		
	</div>

</body>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript> 
    //<!--   
    function   MSComm1_OnComm()   
    {      
       switch(MSComm1.CommEvent)
       {
         case 1:{ window.alert("Send OK！"); break;}  //发送事件
         case 2: { Receive();break;} //接收事件
         default: console.log("Event Raised!"+MSComm1.CommEvent);;
       }       
  }  
  </SCRIPT>

<SCRIPT LANGUAGE=javascript FOR=MSComm1 EVENT=OnComm> 
           MSComm1_OnComm()
   </SCRIPT>

<script type="text/javascript"> 
   
   
   Element.prototype.writeContent=function(text){
	var node=document.createElement("FONT");
	node.style.color="red";
	node.appendChild(document.createTextNode(text));
	this.appendChild(node);
}
  	function ConfigPort(){
 	var dom=document.getElementById("text_content");
 	try{   
 	      	var   obj = new ActiveXObject("MSCOMMLib.MSComm.1"); 
 			dom.innerHTML="MSCOMM控件安装成功\n";
 			$.ajax({
			url:rootPath+"/storage/applySettings.shtml",
			type:"post",
			async:false,
			data:{code:'${code}'},
			success:function(rs){
			if(rs.success){

 				var obj=JSON.parse(rs.rs[0].parameterValue);
 				  port=obj.CommPort;
				  settings=obj.Settings;
 				//  MSComm1.CommPort=port;
			    ///  MSComm1.Settings=settings;
			    //  MSComm1.OutBufferCount =0;           //清空发送缓冲区
			    //  MSComm1.InBufferCount = 0;              //滑空接收缓冲区      
        	      dom.innerHTML+="已配置串口COM:"+MSComm1.CommPort+" 参数:"+MSComm1.Settings+"\n";   
        		  MSComm1.PortOpen=true; 
			}
			}
		})
 	 	}   
	  catch(e)   
	  {   
	     	dom.innerHTML="未检测到MSCOMM控件,请重新安装或调整设置...\n";
	  }
 	} 
 	

 function Receive(){
		var receiveMSG= MSComm1.Input;
		document.getElementById("text_content").innerHTML+=receiveMSG+"\n";
		//数据稳定的时候的长度
	if(receiveMSG.length==17){
	var arr=receiveMSG.split(":")[1];
	//document.getElementById("txtReceive").innerHTML="长度是"+str.length+"     数据是:"+(arr.slice(0,8))+"<br/>"
	document.getElementById("text_content").innerHTML=arr.slice(0,8);
}
	}
	  
	$("#initMSComm").on("click",function(){
		ConfigPort();
	})
	$("#openWay").on("click",function(){
	if(m_iPlay){
		//alert(m_bDVRControl.BMPCapturePicture("D:/1",true))
		//alert(new Date().getHours()+":"+new Date().getMinutes()+":"+new Date().getSeconds())
	}
	})
	
	$(".download>a").on("click",function(e){
	e.preventDefault();
	location.href="/zhlk/gridReport/grbsctl6.exe";
	$(".download").css("width","0px")
	$(this).css("font-size","0px");
	})
	
/*  window.onbeforeunload = function(){
if(MSComm1.PortOpen==true) {
	MSComm1.PortOpen=false
}
}  */

</script>

<script type="text/javascript">
//全局变量定义
var szDevIp = "218.91.235.70"; 
var szDevPort ="8003"; 
var szDevUser ="lq"; 
var szDevPwd ="369258147"; 
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
$(function(){
  var myDate = new Date();
	var iYear = myDate.getFullYear();        
	if(iYear < 1971 || iYear > 2037)
	{
		alert("为了正常使用本软件，请将系统日期年限设置在1971-2037范围内！");
		//parent.location.href = "../login.php";
	}
	if(document.getElementById("HIKOBJECT1").object == null)
	{
 		layer.confirm("检测到相关控件未安装",function(index){
 		document.getElementsByClassName("download")[0].style.width="100%";
 		layer.close(index);
 		})
		m_bDVRControl = null;
	}
	else
	{
		m_bDVRControl = document.getElementById("HIKOBJECT1");
		ChangeStatus(1);
		ArrangeWindow(1);
		zhuce();
		yulan();
	}

})

/*************************************************
Function:		ArrangeWindow
Description:	画面分割为几个窗口
Input:			x : 窗口数目			
Output:			无
return:			无				
*************************************************/
function ArrangeWindow(x)
{
	document.getElementById("NetPlayOCX1").style.display = "block";
	document.getElementById("NetPlayOCX1").style.width = "auto";
	document.getElementById("NetPlayOCX1").style.height = "auto";
	
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
	
}
function zhuce(){
				
				m_iLoginUserId = m_bDVRControl.Login(szDevIp,szDevPort,szDevUser,szDevPwd);
				
}
function yulan(){


		var m_iNowChanNo=51;
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

            }

        }

}

$('.btn-close').click(function (e) {
    e.preventDefault();
    $(this).parent().parent().parent().fadeOut();
});
$('.btn-minimize').click(function (e) {
    e.preventDefault();
    var $target = $(this).parent().parent().next('.box-content');
    if ($target.is(':visible')) $('i', $(this)).removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
    else                       $('i', $(this)).removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
    $target.slideToggle();
});

</script>
<script type="text/javascript" for="HIKOBJECT1" event="SelectWindow()">
	ChangeStatus(1);
</script>
<script type="text/javascript" for="HIKOBJECT2" event="SelectWindow()">
	ChangeStatus(2);
</script>
<script type="text/javascript" for="HIKOBJECT3" event="SelectWindow()">
	ChangeStatus(3);
</script>
<script type="text/javascript" for="HIKOBJECT4" event="SelectWindow()">
	ChangeStatus(4);
</script>


<OBJECT id=MSComm1 CLASSID="clsid:648A5600-2C6E-101B-82B6-000000000014"
	codebase="MSCOMM32.OCX" type="application/x-oleobject" style="LEFT:54px;TOP:14px;display: none">
	<PARAM NAME="CommPort" VALUE="1" />
	<PARAM NAME="DataBits" VALUE="8" />
	<PARAM NAME="StopBits" VALUE="1" />
	<PARAM NAME="BaudRate" VALUE="9600" />
	<PARAM NAME="Settings" VALUE="9600,N,8,1" />

	<PARAM NAME="RTSEnable" VALUE="1" />
	<PARAM NAME="DTREnable" VALUE="1" />
	<PARAM NAME="Handshaking" VALUE="0" />
	<PARAM NAME="NullDiscard" VALUE="0" />
	<PARAM NAME="ParityReplace" VALUE="?" />

	<PARAM NAME="EOFEnable" VALUE="0" />
	<PARAM NAME="InputMode" VALUE="0" />
	<PARAM NAME="InBufferSize" VALUE="1024" />
	<PARAM NAME="InputLen" VALUE="0" />
	<PARAM NAME="OutBufferSize" VALUE="512" />

	<PARAM NAME="SThreshold" VALUE="0" />
	<PARAM NAME="RThreshold" VALUE="1" />

</OBJECT>
</html>

