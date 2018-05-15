<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/common/common.jspf"%>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-6">
		<div class=" col-md-6">
			<h3 class="animated">
			<a class="btn btn-info" href="javascript:void(0)" id="printView"
			style="text-shadow: black 5px 3px 3px;"> <i class="fa fa-print"></i> 打印</a>
			</h3>
		</div>
	</div>
	<div class=" col-md-6">
	</div>
	<div class="col-md-12">
	<div id= "tableHead" >
	<div style="text-align: center;">
	 <h3>南通市城供粮油购销总公司张垛储备库粮食过磅单</h3>
	</div>
	<div style="width: 50%; float: left;text-align: right">
	日期：${reportHarbor.createDate}
	</div>
	<div style="width: 50%; float: left;text-align: center">
	总页号：<font color='#0000ff' format='ChineseNum'><span tdata='pageNO'>第##页</span>/<span tdata='pageCount'>共##页</span></font>
	</div>
	</div>
	<div id= "tableBody">
		<table cellpadding="1" cellspacing="0" border="1" width="100%" style="text-align: center;">
		<thead>
		<tr>
		  <td colspan="2">发货单位</td>
		  <td colspan="2" style="font-size: 11px;">${reportHarbor.getOutCompany}</td>
		  <td colspan="2">收货单位</td>
		  <td colspan="2" style="font-size: 11px;">${reportHarbor.putInCompany}</td>
		  <td colspan="2">运输单位(船号)</td>
		  <td colspan="2" style="font-size: 11px;">${reportHarbor.shipId}</td>
		</tr>
		<tr>
		  <td colspan="2">品  名</td>
		  <td colspan="2" style="font-size: 11px;">${reportHarbor.grainVariety}</td>
		  <td colspan="2">仓  号</td>
		  <td colspan="2" style="font-size: 11px;">${reportHarbor.wName}</td>
		  <td colspan="2">装卸工班</td>
		  <td colspan="2"></td>
		</tr>
		<tr>
		  <td>车号</td>
		  <td colspan="3">${carList.size()>0?carList.get(0).get("carName"):''}</td>
		  <td colspan="3">${carList.size()>1?carList.get(1).get("carName"):''}</td>
		  <td colspan="3">${carList.size()>2?carList.get(2).get("carName"):''}</td>
		  <td colspan="2"></td>
		</tr>
		<tr>
		  <td width="7%"></td>
		  <td width="9%">毛重</td><td width="9%">皮重</td><td width="9%">净重</td>
		  <td width="9%">毛重</td><td width="9%">皮重</td><td width="9%">净重</td>
		  <td width="9%">毛重</td><td width="9%">皮重</td><td width="9%">净重</td>
		  <td colspan="2" width="12%">备注</td>
		</tr>
		</thead>
		<tbody>
		<c:forEach begin="0" end="${maxLength -1}" var="ind">
		    <tr>
		       <td>${ind+1 }</td>
		      <td>${carList.size()>0?carList.get(0).get("weighingList").size()>ind?carList.get(0).get("weighingList").get(ind).get("grossWeight"):'':''}</td>
		      <td>${carList.size()>0?carList.get(0).get("weighingList").size()>ind?carList.get(0).get("weighingList").get(ind).get("tare"):'':''}</td>
		      <td>${carList.size()>0?carList.get(0).get("weighingList").size()>ind?carList.get(0).get("weighingList").get(ind).get("trueWeight"):'':''}</td>
		      
		      <td>${carList.size()>1?carList.get(1).get("weighingList").size()>ind?carList.get(1).get("weighingList").get(ind).get("grossWeight"):'':''}</td>
		      <td>${carList.size()>1?carList.get(1).get("weighingList").size()>ind?carList.get(1).get("weighingList").get(ind).get("tare"):'':''}</td>
		      <td>${carList.size()>1?carList.get(1).get("weighingList").size()>ind?carList.get(1).get("weighingList").get(ind).get("trueWeight"):'':''}</td>
		      
		      <td>${carList.size()>2?carList.get(2).get("weighingList").size()>ind?carList.get(2).get("weighingList").get(ind).get("grossWeight"):'':''}</td>
		      <td>${carList.size()>2?carList.get(2).get("weighingList").size()>ind?carList.get(2).get("weighingList").get(ind).get("tare"):'':''}</td>
		      <td>${carList.size()>2?carList.get(2).get("weighingList").size()>ind?carList.get(2).get("weighingList").get(ind).get("trueWeight"):'':''}</td>
		     <c:if test="${ind % 10 == 0 }">
		     <td colspan="2" rowspan="10"></td>
		     </c:if>
		    </tr>
		</c:forEach>
		</tbody>
		<tfoot>
		<tr>
		  <td>小计</td>
		  <c:if test="${carList.size()>0}">
		    <td tdata="subSum" format="#,##0">
		  <font id="id01" color="#0000FF">###</font>
		  </td>  <td tdata="subSum" format="#,##0" >
		  <font id="id11" color="#0000FF">###</font>
		  </td>  <td tdata="subSum" format="#,##0">
		  <font id="id21" color="#0000FF">###</font>
		  </td>
		  </c:if>
		  <c:if test="${carList.size()<=0}">
		    <td ></td> <td ></td> <td ></td> 
		  </c:if>
		  
		  <c:if test="${carList.size()>1}">
		    <td tdata="subSum" format="#,##0">
		  <font id="id02" color="#0000FF">###</font>
		  </td>  <td tdata="subSum" format="#,##0">
		  <font id="id12" color="#0000FF">###</font>
		  </td>  <td tdata="subSum" format="#,##0">
		  <font id="id22" color="#0000FF">###</font>
		  </td>
		  </c:if>
		  <c:if test="${carList.size()<=1}">
		    <td ></td> <td ></td> <td ></td> 
		  </c:if>
		  
		  <c:if test="${carList.size()>2}">
		    <td tdata="subSum" format="#,##0">
		  <font id="id03" color="#0000FF">###</font>
		  </td>  <td tdata="subSum" format="#,##0">
		  <font id="id13" color="#0000FF">###</font>
		  </td>  <td tdata="subSum" format="#,##0">
		  <font id="id23" color="#0000FF">###</font>
		  </td>
		  </c:if>
		  <c:if test="${carList.size()<=2}">
		    <td ></td> <td ></td> <td ></td> 
		  </c:if>
		 <td></td>
		</tr>
		<tr>
		  <td>合计</td>
		  <td>泡数</td><td></td>
		  <td>毛重</td>
		  <td colspan="2" tdata="(id01+id02+id03)"  format="#,##0">
		   <font color="#0000FF">###</font>
		  </td>
		  <td>皮重</td>
		  <td colspan="2" tdata="(id11+id12+id13)" tclass="class2"  format="#,##0">
		   <font color="#0000FF">###</font>
		  </td>
		  <td>净重</td>
		  <td colspan="2" tdata="(id21+id22+id23)" tclass="class1" format="#,##0">
		   <font color="#0000FF">###</font>
		  </td>
		</tr>
		</tfoot>
		</table>
		</div>
		<div id="tablefoot">
		<div style="width: 33%;float: left;text-align: center;">复核</div>
		<div style="width: 33%;float: left;text-align: center;">司磅 </div>
		<div style="width: 33%;float: left;text-align: center;">监磅</div>
		</div>
	</div>
	<div class=" col-md-6">
		<div class=" col-md-6">
			<h3 class="animated">
			</h3>
		</div>
	</div>
<script type="text/javascript" src="${ctx}/js/LodopFuncs.js">
</script>
		<script type="text/javascript">
		$("#printView").click("click",function(){
			PreviewMytable();
		});
		function PreviewMytable(){
			var LODOP=getLodop();
			//设置页面大小
			LODOP.SET_PRINT_PAGESIZE(1,2110,1400,'A4');
			//LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_分页打印综合表格");
			//var strStyle="<style> table,td,th {border-width: 1px;border-style: solid;border-collapse: collapse}</style>"
			//增加表格打印项（超文本模式）
			//(Top,Left,Width,Heigh,strHtml)
			
		    LODOP.ADD_PRINT_TABLE(93,"5%","90%",314,document.getElementById("tableBody").innerHTML);
			
			LODOP.SET_PRINT_STYLEA(0,"Vorient",3);		
			LODOP.ADD_PRINT_HTM(26,"5%","90%",109,document.getElementById("tableHead").innerHTML);
			
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);	
		    LODOP.ADD_PRINT_HTM(473,"5%","90%",24,document.getElementById("tablefoot").innerHTML);
		    //LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			//LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);
		    
			//LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
			//LODOP.SET_PRINT_STYLEA(0,"FontColor","#FF0000");
			LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.SET_PRINT_STYLEA(0,"Horient",3);	
			//LODOP.ADD_PRINT_HTM(1,600,300,100,"总页号：<font color='#0000ff' format='ChineseNum'><span tdata='pageNO'>第##页</span>/<span tdata='pageCount'>共##页</span></font>");
	
			LODOP.PREVIEW();
			//LODOP.PRINT_DESIGN();
		};	
		</script>
</body>
</html>
