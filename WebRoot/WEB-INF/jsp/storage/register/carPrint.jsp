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
		<table id="magazineGrid" style="width:99%;height:450px"></table>
	</div>
</body>
<script type="text/javascript">
function gengerateChart(data){
	var grid = $('#magazineGrid').datagrid({
		rownumbers : false,
		data : data,
		columns : [ [ {
			field : 'id',
			title : '流水单号',
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

			field : 'caNum',
			title : '车牌号',
			width : 150
		}, {

			field : 'ex',
			title : '操作',
			width : 150,
			formatter:function(value,row){
			return 	"<button class='btn btn-success' onclick=goPrint('"+row.id+"') ><i class='glyphicon glyphicon-download glyphicon-white'></i>导出</button> " 
			}
		}   ] ]

	});
}
	
	$.ajax({
		url : rootPath + "/storage/queryCars.shtml",
		data:{id:parent.selectRow.ID},
		type : "post",
		success : function(rs) {
			if(!rs.success) console.error("....");
			gengerateChart(rs.pList);
		}
	})
	
	function goPrint(id){
		window.open("/zhlk/gridReport/shouchuxitong/mm.jsp?id="+id)
	}
	
</script>
</html>
