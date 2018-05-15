var grid;
var pageii;
var searchParams;
var lastColumn;
var lastIndex = -1;
var updateColumn = [ 'name', 'roleKey', 'description' ];
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : rootPath + '/mobile/role/findByPage.shtml',
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
		sortOrder : 'asc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'name',
			title : '角色名',
			width : 180,
			sortable : true,
			align : 'left'
		}, {
			field : 'roleKey',
			title : '角色键值',
			width : 150,
			sortable : true,
			align : 'left'
		}, {
			field : 'description',
			title : '描述',
			width : 150,
			sortable : true,
			resizable : true,
			align : 'left'
		} ] ],
		onBeforeLoad : function(param) {

		},
		onSortColumn : function(sort, order) {

		},
		onLoadSuccess : function(data) {
			CommnUtil.exportgrid(grid);
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
	$("#editRes").click("click", function() {
		editResUI();
	});
	$("#addFun").click("click",function(){
		addUI();
		});

	$("#editFun").click("click",function(){
		editUI();
		});
	$("#deleteFun").click("click",function(){
		deleteAll();
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
 * 打开add页面
 */
function addUI() {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		content : rootPath + '/mobile/role/addUI.shtml',
		end : function() {// 关闭时执行
			grid.datagrid("reload");
		}
	});
}
/**
 * 打开修改页面
 */
function editUI() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		pageii = layer
				.open({
					title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
					type : 2,
					maxmin : true,
					area : [ "1200px", "600px" ],
					content : rootPath + '/mobile/role/editUI.shtml?id='
							+ selectRow.id,
					end : function() {// 关闭时执行
						grid.datagrid("reload");
					}
				});
	} else {
		layer.msg('请选择一行');

	}
}

/**
 * 打开修改页面
 */
function deleteAll() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		layer.confirm('是否删除？', function(index) {
			var url = rootPath + '/mobile/role/delete.shtml';
			var s = CommnUtil.ajax(url, {
				id : selectRow.id
			}, "json");
			if (s == "success") {
				layer.msg('删除成功');
				grid.datagrid("reload");
			} else {
				layer.msg('删除失败');
			}
		});
	} else {
		layer.msg('请选择一行');

	}
}

function editResUI() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		pageii = layer
				.open({
					title : "<h5><i class='glyphicon glyphicon-link'></i>修改用户权限<h5>",
					type : 2,
					maxmin : true,
					area : [ "800px", "600px" ],
					content : rootPath + '/mobile/role/editResUI.shtml?roleId='
							+ selectRow.id,
					end : function() {
						grid.datagrid("reload");
					}
				});
	} else {
		layer.msg("未选择一行");
	}
}
