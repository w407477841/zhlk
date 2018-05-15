var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'yijiaoguanli/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'wlName',
			title : '粮库地点',
			width: 150
		},{
			field : 'wName',
			title : '仓号',
			width: 150
		},  {
			field : 'wtTransferDate',
			title : '移交日期',
			width: 150
		}, {
			field : 'poName',
			title : '原保管员',
			width: 150
		}, {
			field : 'pnName',
			title : '移交后保管员',
			width: 150
		}, {
			field : 'wtAddDate',
			title : '创建日期',
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

	$("#search").click("click", function() {// 绑定查询按扭
		searchParams = $("#searchForm").serializeJson();
		grid.datagrid({
			queryParams : searchParams
		});
		grid.datagrid('getPager').pagination({
			displayMsg : '当前显示从{from}到{to},共{total}记录',
			onBeforeRefresh : function(pageNumber, pageSize) {
				$(this).pagination('loading');
				$(this).pagination('loaded');
			},
		});
	});
	
	$("#tranFun").click("click",function(){
		addUI();
	});
	$("#lookFun").click("click",function(){
		lookUI();
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
 * 打开新增页面
 */
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/yijiaoguanli/addUI.shtml',
		end :function(){
			grid.datagrid("reload");
		}
	});
}
/**
 * 打开look页面
 */
function lookUI(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/yijiaoguanli/look.shtml?id='+selectRow.id,
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
		var url = rootPath + '/yijiaoguanli/delete.shtml';
		var s = CommnUtil.ajax(url, {id:selectRow.id
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