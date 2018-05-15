var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : 'warehouseInterface/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'warehose_id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'wlName',
			title : '粮库地点',
			align : 'left',
			editor : 'text',
			width: 150
		},{
			field : 'wName',
			title : '仓号',
			align : 'left',
			editor : 'text',
			width: 150
		},{
			field : 'warehose_id',
			title : '仓号编号',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'huoweibianhao',
			title : '货位编号',
			sortable : true,
			width: 150
		}, {
			field : 'cangfangbianhao',
			title : '仓房编号',
			sortable : true,
			width: 150
		}
		] ],
		onBeforeLoad : function(param) {

		}
	});

	$("#addFun").click("click",function(){
		addUI();
	});
	$("#editFun").click("click",function(){
		editUI();
	});
	$("#deleFun").click("click",function(){
		 del();
	});

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
/**
 * 打开添加页面
 */
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/warehouseInterface/addUI.shtml',
		end :function(){
			grid.datagrid("reload");
		}
	});
}

/**
 * 打开edit页面
 */
function editUI(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/warehouseInterface/editUI.shtml?id='+selectRow.warehose_id,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("请选择一行");
		
	}
}
/**
 * 删除
 */
function del(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	layer.confirm('确认删除？', function(index) {
		var url = rootPath + '/warehouseInterface/delete.shtml';
		var s = CommnUtil.ajax(url, {id:selectRow.warehose_id
		}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('删除成功');
			grid.datagrid("reload");
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('删除失败');
		}
	});
	}else{
		layer.msg("请选择一行");
	}
}
