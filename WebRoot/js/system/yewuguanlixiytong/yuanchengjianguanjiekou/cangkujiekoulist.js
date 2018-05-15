var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : 'warehouseLocationInterface/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'location_no',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'wName',
			title : '粮库地点',
			align : 'left',
			editor : 'text',
			width: 150
		},{
			field : 'qiyemingcheng',
			title : '企业名称',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'location_no',
			title : '库点编码',
			sortable : true,
			width: 150
		}, {
			field : 'kuqubianma',
			title : '库区编码',
			sortable : true,
			width: 150
		}, {
			field : 'tongyixinyongdaima',
			title : '统一信用代码',
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
		content : rootPath + '/warehouseLocationInterface/addUI.shtml',
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
		content : rootPath + '/warehouseLocationInterface/editUI.shtml?id='+selectRow.location_no,
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
		var url = rootPath + '/warehouseLocationInterface/delete.shtml';
		var s = CommnUtil.ajax(url, {id:selectRow.location_no
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
