var grid;
var pageii;
$(function() {
	grid = $('#sbfjGrid').datagrid({
		url : rootPath + '/daXingSheBeiFuJian/findByPage.shtml',
		method : 'POST',
		queryParams : {'daXingSheBeiFuJianFormMap.leSon':$("#fjid").val()},
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		nowrap : false,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		columns : [ [{
			field : 'leaName',
			title : '设备名称',
			sortable : true,
			width: 150
		}, {
			field : 'leaStandard',
			title : '设备规格',
			sortable : true,
			width: 150
		},{
			field : 'leaNumber',
			title : '数量',
			sortable : true,
			width: 150
		}
		] ],
		onBeforeLoad : function(param) {

		},
		onSortColumn : function(sort, order) {

		},
		onLoadSuccess : function(data) {

		},
		onLoadError : function() {

		},
		onClickCell : function(rowIndex, field, value) {// 点击单元格触发事件

		}
		
		
	});

	$("#addsuFun").click("click",function(){
		addUI();
		});

	$("#delesuFun").click("click",function(){
		del();
	});
});

function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "300px", "400px"],
		offset:"40px",
		content : rootPath + '/daXingSheBeiFuJian/addUI.shtml',
		end :function(){
			grid.datagrid("reload");
		}
	});
}

/**
 * 删除
 */
function del(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	layer.confirm('确认删除？', function(index) {
		var url = rootPath + '/daXingSheBeiFuJian/delete.shtml';
		var s = CommnUtil.ajax(url, {id:selectRow.id
		}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('删除成功');
			grid.datagrid('reload');
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('删除失败');
		}
	});
	}else{
		layer.msg("请选择一行");
	}
}
