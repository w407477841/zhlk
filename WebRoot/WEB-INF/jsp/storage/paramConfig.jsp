<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
<style>
.form-control {
	padding: 0px 12px
}

* {
	margin: 0;
	padding: 0;
}


.btn{
font-size: 12px;
}
#page {
	font: 16px/1 'Open Sans', sans-serif;
	color: #555;
	background: #e5e5e5;
}

#page {
	
}

.togglebox {
	width: 100%;
	margin: 0 auto;
	background: #fff;
	transform: translateZ(0);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .1);
}

input[type="radio"] {
	position: absolute;
	opacity: 0;
}

label {
	position: relative;
	display: block;
	height: 50px;
	line-height: 50px;
	padding: 0 20px;
	font-size: 14px;
	font-weight: 700;
	border-top: 1px solid #ddd;
	background: #fff;
	cursor: pointer;
	margin: 0;
}

label[for *='1'] {
	border: 0;
}

 label:after {
	content: '\e113';
	position: absolute;
	top: 0px;
	right: 20px;
	font-family: 'Glyphicons Halflings';
	transform: rotate(-90deg);
	transition: 0.3s transform;
} 

section{
	height: 0;
	transition: 0.3s all;
	overflow: hidden;
	background: #f6f6f6;
}
#content1>div,#content2>div:nth-child(2),#content3,#content4,#content5>form{
	display:flex;
	flex-flow:row wrap;
	align-items:center;
	justify-content:flex-start;
	align-content:flex-start
}
#content2>div::nth-child(2){

}

#toggle1:checked  ~ label[for *='1']:after,#toggle2:checked  ~ label[for
	*='2']:after,#toggle3:checked  ~ label[for *='3']:after,#toggle4:checked 
	~ label[for *='4']:after,#toggle5:checked  ~ label[for *='5']:after {
	transform: rotate(-180deg);
}

#toggle1:checked  ~ #content1,#toggle2:checked  ~ #content2,#toggle3:checked 
	~ #content3,#toggle5:checked  ~ #content5
	{
	height: 400px;
}
#toggle3:checked ~ #content3{
height: 120px
}
#toggle4:checked  ~ #content4{
height:600px
}
#toggle5:checked  ~ #content5{
height:550px
}

p {
	margin: 15px 0;
	padding: 0 20px;
	font-size: 12px;
	line-height: 1.5;
}
.form-group{
width:270px;
display:flex;
margin:10px;
align-items:center;
justify-content:space-around;
}
.form-group-w{
width:100%;
display:flex;
justify-content:center;
}
.form-group-short{
width: 100px;
}
.form-group-w>textarea{
width:100%;
height:100px;
}
.form-group-w>button{
margin: 0 10px
}
#content1 input,#content2 input,#content3 input,#content4 input{
height:32px;
}
.chosen-single{
height: 32px;
border-radius:4px;

}
.s-detil-inst{
height: 0;
padding:0;
min-height: 0px;
display: flex;
flex-flow:row wrap;
align-items:center;
margin: 0 4px;
transition:all .5s;
overflow: hidden;
}
.desc-span{
font-weight: bold;
}
.output{
    display: flex;
    justify-content: flex-end;
    width: 100%;
    color:red;
}
</style>
    <div id="content" class="col-lg-12 col-sm-12">
                <div>
        
    </div>
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-list"></i> 参数配置</h2>

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content " id="page">

	<div class="togglebox">
    <input id="toggle1" type="radio" name="toggle" />
    <label for="toggle1" class=''>地磅设置</label> 

    <section id="content1">
    	<div>
    	
    	  <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">所属粮库： </span>
          <div class="col-md-7">
			<select id="selectLocation1" data-rel="chosen" class="chosen form-control"  data-placeholder="所属粮库">
					<option value=""></option>
			</select>
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">地磅编号： </span>
          <div class="col-md-7">
          <input id="number" type="text"   value="" class=" form-control" placeholder="唯一标识码">
          </div>
          </div>
    	
    	
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">串口号： </span>
          <div class="col-md-7">
          <select id="ComName" class=" chosen form-control " data-rel="chosen" data-placeholder="串口号" >
          <option value="1">COM1</option>
          <option value="2">COM2</option>
          <option value="3">COM3</option>
          <option value="4">COM4</option>
          <option value="5">COM5</option>
          <option value="6">COM6</option>
          <option value="7">COM7</option>
          <option value="8">COM8</option>
          <option value="9">COM9</option>
          <option value="10">COM10</option>
          </select>
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">波特率： </span>
          <div class="col-md-7">
          <select id="BaudRate" class=" chosen form-control" data-rel="chosen" data-placeholder="波特率">
          <option value="9600">9600</option>
          <option value="57600">57600</option>
          <option value="115200">115200</option>
          </select>
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">校验位： </span>
          <div class="col-md-7">
          <select id="CheckBit" class=" chosen form-control" data-rel="chosen" data-placeholder="校验位">
          <option value="N">无NONE</option>
          <option value="O">奇ODD</option>
          <option value="E">偶EVEN</option>
          </select>
          </div>
          </div>
          
          
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">数据位： </span>
          <div class="col-md-7">
          <input id="DataBits" type="text" id=""  value="8" class=" form-control">
          </div>
          </div>
          
       	 <div class="form-group">
       	 <span class="col-md-5 control-label no-padding-right" for="form-field-1" >停止位： </span>
       	 <div class="col-md-7">
         <input id="StopBits" type="text" id=""  value="8" class=" form-control">
       	 </div>
         </div>
          
          <div class="form-group form-group-w">
        	<textarea id="txtReceive" class="textarea col-md-12 form-control"></textarea>          
          </div>
          
          <div class="form-group form-group-w">
        	<button id="testCOM" class="btn btn-default radius" type="button">测试</button>
			<button id="saveSetting" class="btn btn-primary radius" type="button"><i class="fa fa-save "></i>保存</button>        
          </div>
    </div>
          <%--
    <div>
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">称重先后： </span>
          <div class="col-md-7">
          <select id="order" class=" chosen form-control" data-rel="chosen" data-placeholder="称重先后">
          <option value="1">先毛后皮</option>
          <option value="2">先皮后毛</option>
          </select>
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">称重方式： </span>
          <div class="col-md-7">
          <select id="way" class=" chosen form-control" data-rel="chosen" data-placeholder="称重方式">
          <option value="1">直接称重</option>
          <option value="2">按流程称重</option>
          </select>
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-6 control-label no-padding-right" for="form-field-1">散户称重方式： </span>
          <div class="col-md-6">
          <select id="allow" class=" chosen form-control" data-rel="chosen" data-placeholder="散户称重方式">
          <option value="1">不允许反复称重</option>
          <option value="2">允许反复称重</option>
          </select>
          </div>
          </div>
          
           <div class="form-group form-group-w">
				<button id="" class="btn btn-primary radius" type="button"><i class="fa fa-save "></i>保存</button>           
          </div>

    </div>
           --%>
    </section>

    <input id="toggle2" type="radio" name="toggle" />
    <label for="toggle2">驳车设置</label>

    <section id="content2">
    <div style="margin: 10px">
	 <table id="grid"  style="width:99%;height:200px;"></table>
	</div>
		 <div  >
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">车牌号： </span>
          <div class="col-md-7">
          <input id="CaNum" type="text"   value="" class=" form-control">
          </div>
          </div>
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">车型： </span>
          <div class="col-md-7">
          <input id="Model" type="text"   value="" class=" form-control">
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">司机： </span>
          <div class="col-md-7">
          <input id="Driver" type="text"   value="" class=" form-control">
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">驾驶证： </span>
          <div class="col-md-7">
          <input id="DrivingLcence" type="text"   value="" class=" form-control">
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">电话： </span>
          <div class="col-md-7">
          <input id="Phone" type="text"   value="" class=" form-control">
          </div>
          </div>	
          
          <div class="form-group form-group-w">
				<button id="insertCar" class="btn btn-primary radius" type="button"><i class="fa fa-save "></i>保存</button>           
          </div>
	</div>
	
    </section>

    <input id="toggle3" type="radio" name="toggle" />
    <label for="toggle3">LED屏初始化</label>

    <section id="content3">
       
         <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">初始字幕： </span>
          <div class="col-md-7">
          <input id="" type="text"   value="欢迎光临" class=" form-control">
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">字体大小： </span>
          <div class="col-md-7">
          <input id="" type="text"   value="12" class=" form-control">
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">停留时间： </span>
          <div class="col-md-7">
          <input id="" type="text"   value="8000" class=" form-control">
          </div>
          </div>	
          
          <div class="form-group form-group-w">
				<button id="" class="btn btn-primary radius" type="button"><i class="fa fa-save "></i>保存</button>           
          </div>
	</div>
       
       
    </section>
    

    <input id="toggle4" type="radio" name="toggle" />
    <label for="toggle4">数据修改</label>

    <section id="content4">
          <div class="form-group " style="width: 400px">
          <span class="col-md-3 control-label no-padding-right" for="form-field-1">单据号： </span>
          <div class="col-md-9">
          <input id="billID" type="text"   value="" class=" form-control" placeholder="请输入单据号...">
          </div>
          </div>
          <div class="form-group " style="" >
            	<button id="search" class="btn btn-primary radius" type="button"><i class="fa fa-save "></i>查询</button> 
            	<button id="add" class="btn btn-danger radius" type="button"><i class="fa fa-save "></i>补录</button>
            	<button id="edit" class="btn btn-warning radius" type="button"><i class="fa fa-save "></i>修正</button>   
          </div>
          
           <div class="form-group form-group-short" >
         		<span class="output"></span>
          </div>         
          
          
          <div class="col-md-12 s-detil-inst" >
          
           <div class="form-group">
	          <span class="col-md-5 control-label no-padding-right" for="form-field-1">买售人： </span>
			  <span class="col-md-7 control-label no-padding-right desc-span"  data-tag="OWNER"></span>
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">身份证号： </span>
		  <span class="col-md-7 control-label no-padding-right desc-span" data-tag="Identity"></span>
          </div>
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">手机号： </span>
		  <span class="col-md-7 control-label no-padding-right desc-span" data-tag="Phone"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">仓库号： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="StorageID"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">库点： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="wName"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">粮食种类： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="text"></span>
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">粮食性质： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="Property"></span>
          </div>

           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">等级： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="LEVEL"></span>
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">扣量： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="amountPercent"></span>
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">价格： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="price"></span>
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">容重出糙： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="rz"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">水分： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="sf"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">杂质： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="zz"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">矿物质： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="kwz"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-6 control-label no-padding-right" for="form-field-1">不完善粒度： </span>
          <span class="col-md-6 control-label no-padding-right desc-span" data-tag="Bwsld"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">整精米： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="zjml"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">谷外糙米： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="gwcm"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">黄粒： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="hl"></span>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">互混： </span>
          <span class="col-md-7 control-label no-padding-right desc-span" data-tag="hh"></span>
          </div>
          </div>
          
		 <div class="col-md-12" style="margin: 4px;padding: 0">
			 <table id="magazine"  style="width:100%;height:200px;display: block"></table>
		</div>
          
    </section>
    
        <input id="toggle5" type="radio" name="toggle" />
    <label for="toggle5">数据补录</label>

    <section id="content5">
    <form id="form" name="form" method="post" action="${ctx}/storage/addInstorage_tween.shtml">
    <input type="hidden" name="StorageFormMap.State" value="3">
    <input type="hidden" name="StorageFormMap.Payway" value="3">
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">粮户姓名： </span>
          <div class="col-md-7">
          <input id="form-name" type="text" class="form-control"name="StorageFormMap.Owner" value="" placeholder="粮户姓名">
          </div>
          </div>
          
                    <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">身份证号： </span>
          <div class="col-md-7">
          <input  id="form-identity"  type="text" class="form-control"name="StorageFormMap.Identity" value="" placeholder="身份证号">
          </div>
          </div>
          
                    <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">手机号码： </span>
          <div class="col-md-7">
          <input id="form-phone"  type="text" class="form-control"name="StorageFormMap.Phone" value="" placeholder="手机号码">
          </div>
          </div>
          
          
                    <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">地址： </span>
          <div class="col-md-7">
          <input id="form-address"  type="text" class="form-control"name="StorageFormMap.Address" value="" placeholder="地址">
          </div>
          </div>
          
          <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">车船号： </span>
          <div class="col-md-7">
          <input  id="form-carid"  type="text" class="form-control"name="StorageFormMap.CarID" value="" placeholder="车船号">
          </div>
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">出入库： </span>
          <div class="col-md-7">
							<select id="" data-rel="chosen" class="chosen form-control" data-placeholder="出入库" name="StorageFormMap.inorout">
								<option value=""></option>
								<option value="1" selected="selected">入库</option>
								<option value="0">出库</option>
							</select>
          </div>
          </div>
          
                    <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">粮食品种： </span>
          <div class="col-md-7">
			<select id="selectBreed" data-rel="chosen" class="chosen form-control" data-placeholder="粮食品种" name="StorageFormMap.Breed">
				<option value=""></option>
				<option value="1114">混合小麦</option>
				<option value="1132002">晚粳稻谷</option>
				</select>
          </div>
          </div>
          
         <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">粮食性质： </span>
          <div class="col-md-7">
          <select id="selectxz"  data-rel="chosen" data-placeholder="粮食性质" class="chosen form-control" name="StorageFormMap.Property">
								<option value=""></option>
								<option  value="31">最低收购价粮</option>
								<option value="11">国家储备粮</option>
								<option value="121">省级储备粮</option>
								<option value="122">地市级储备粮</option>
								<option value="123">县级储备粮</option>
								<option value="2">商品粮</option>
								<option value="34">地方临时存储粮 </option>
			</select>
          </div>
          </div>
          
         <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">所属粮库： </span>
          <div class="col-md-7">
			<select id="selectLocation2" data-rel="chosen" class="chosen form-control"  name="StorageFormMap.location" data-placeholder="所属粮库">
			<option value=""></option>
			</select>
          </div>
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">所属仓号： </span>
          <div class="col-md-7">
          <select id="selectHouseid" data-rel="chosen" name="StorageFormMap.StorageID" class="chosen form-control" data-placeholder="所属仓号">
			<option value=""></option>
		  </select>
          </div>
          </div>
          
          <div class="form-group">
          </div>
          
          <div class="form-group">
          </div>
          
          <div class="form-group">
          <span class="col-md-12 control-label no-padding-right" for="form-field-1">质检信息 </span>
          </div>
          
          <div style="margin: 25px;width: 100%">
           <table id="magazineGrid"  style="width:100%;height:70px"></table>
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">价格: </span>
          <input type="text" id="price" class="form-control col-md-7"name=""  value="" placeholder="收购价格">
          </div>
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">等级： </span>
         <input type="text" id="level" class="form-control col-md-7"name="" disabled="disabled" value="3" placeholder="等级">
          </div>
          
          
           <div class="form-group">
          <span class="col-md-5 control-label no-padding-right" for="form-field-1">扣量： </span>
         <input type="text" id="percentage" class="form-control col-md-7"name="" disabled="disabled" value="0.00" placeholder="总扣量">
          </div>
          
          <div class="form-group">
          <span class="col-md-6 control-label no-padding-right" for="form-field-1">毛量： </span>
          <input type="text" id="percentage" class="form-control col-md-4"name="weight_tween_t"  value="0.00" placeholder="总重量">
          <span class="col-md-1">KG</span>
          </div>
          
          <div class="form-group">
          <span class="col-md-6 control-label no-padding-right" for="form-field-1">皮重： </span>
          <input type="text" id="percentage" class="form-control col-md-4"name="weight_tween_c"  value="0.00" placeholder="总重量">
          <span class="col-md-1">KG</span>
          </div>
          
          <div class=" col-md-12" style="text-align: center;">
				<button type="button" class="btn btn-info bt-submit"onclick="_submit()">提交</button>
			</div>
                  
          </form>
    </section>
	</div>
    
			

    </div>
    </div>
    </div>
    </div>

    </div>
	</div>
<SCRIPT   ID=clientEventHandlersJS   LANGUAGE=javascript> 
  function   MSComm1_OnComm()   
  {     
      switch(MSComm1.CommEvent)
     {
       case 1:{ window.alert("Send OK！"); break;}  //发送事件
      //接收事件 case 2: { Receive();break;} 
       
      }       
 } 
</SCRIPT>
<SCRIPT   LANGUAGE=javascript   FOR=MSComm1   EVENT=OnComm> 
     MSComm1_OnComm();
</SCRIPT> 


<script type="text/javascript" src="js/storage/paramConfig.js"></script>
 <script type="text/javascript" src="js/storage/register_add.js"></script> 
<script type="text/javascript">

function Receive(){
document.getElementById("txtReceive").innerHTML+=MSComm1.Input;
}

var ifDisabled="${disable}";
	if(ifDisabled=="true"){
	document.getElementById("toggle1").disabled=true;
	document.getElementById("toggle2").disabled=true;
	document.getElementById("toggle3").disabled=true;
	}



bulidCarChart();

initLocation1()

$(".chosen").chosen();
$(".chosen-single").css("height", "32px").css("borderRadius", "4px");


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

function startTour(){
	if ($('.tour').length && typeof(tour) == 'undefined') {
	    var tour = new Tour();
	    tour.addStep({
	        element: "#addFun", /* html element next to which the step popover should be shown */
	        placement: "top",
	        title: "添加用户", /* title of the popover */
	        content: "你可以点击此按钮，进入添加页面" /* content of the popover */
	    });

	    tour.addStep({
	        element: ".glyphicon-edit:first",
	        placement: "top",
	        title: "修改用户",
	        content: "修改该行内容。"
	    });
	    
	    tour.restart();
	}
	
}


</script>

<OBJECT id=MSComm1 CLASSID="clsid:648A5600-2C6E-101B-82B6-000000000014" 
codebase="MSCOMM32.OCX" type="application/x-oleobject"  style="LEFT:54px;TOP:14px" >
       <PARAM   NAME="CommPort"   VALUE="1"/> 
     <PARAM   NAME="DataBits"   VALUE="8"/> 
     <PARAM   NAME="StopBits"   VALUE="1"/> 
     <PARAM   NAME="BaudRate"   VALUE="9600"/> 
     <PARAM   NAME="Settings"   VALUE="9600,N,8,1"/>     

     <PARAM   NAME="RTSEnable"   VALUE="1"/> 
     <PARAM   NAME="DTREnable"   VALUE="1"/> 
     <PARAM   NAME="Handshaking"   VALUE="0"/> 
     <PARAM   NAME="NullDiscard"   VALUE="0"/> 
     <PARAM   NAME="ParityReplace"   VALUE="?"/> 

     <PARAM   NAME="EOFEnable"   VALUE="0"/>       
     <PARAM   NAME="InputMode"   VALUE="0"/>    
     <PARAM   NAME="InBufferSize"   VALUE="1024"/>       
     <PARAM   NAME="InputLen"   VALUE="0"/>     
     <PARAM   NAME="OutBufferSize"   VALUE="512"/> 
    
     <PARAM   NAME="SThreshold"   VALUE="0"/> 
     <PARAM   NAME="RThreshold"   VALUE="1"/> 

</OBJECT> 
