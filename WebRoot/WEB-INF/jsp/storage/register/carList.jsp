<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}

.laydate-icon {
	height: 38px;
	line-height: 38px
}

.div_lable1 {
	text-align: center;
	height: 56px;
	line-height: 56px
}

.form-control {
	padding: 0px 12px
}

.form-control {
	padding: 0px 12px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12" style="margin-bottom: 15px">
		<table id="magazineGrid" style="width:99%;height:300px"></table>
	</div>
	<div class=" col-md-12" >
		<button type="button" class="btn btn-info bt-submit"onclick="confirm()">提交</button>
	</div>
</body>
<script type="text/javascript">
function gengerateChart(data){
	var grid = $('#magazineGrid').datagrid({
		rownumbers : false,
		pagination:true,
		data : data,
		columns : [ [ {
			field:'ck',
			checkbox:true
		},{
			field : 'ID',
			title : '车牌号',
			width : 150
		}, {

			field : 'Model',
			title : '车型',
			width : 150
		} , {

			field : 'Driver',
			title : '司机',
			width : 150
		}, {

			field : 'DrivingLcence',
			title : '驾驶证',
			width : 150
		}, {

			field : 'Phone',
			title : '电话',
			width : 150
		} , {

			field : 'Inuse',
			title : '状态',
			width : 150
		}   ] ]

	});
}
	
	
	$.ajax({
		url : rootPath + "/storage/queryCars.shtml",
		type : "post",
		success : function(rs) {
			if(!rs.success) console.error("....");
			gengerateChart(rs.cars);
		}
	})
	
	
	
	
	function confirm(){
	parent.params["car"]=[];
	var arr=$("#magazineGrid").datagrid('getSelections');
	arr.map(function(item){
		parent.params["car"].push(item.ID);
	})
	parent.layer.closeAll();
	}
	
</script>
</html>
