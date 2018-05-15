var grid;
var pageii;
var searchParams;
var lastColumn;
var lastIndex = -1;
var updateColumn = [ 'name', 'roleKey', 'description' ];
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url :  rootPath + '/mobile/user/findUserByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'accountName',
		sortOrder : 'asc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'userName',
			title : '名称',
			width : 180,
			sortable : true,
			align : 'left'
		}, {
			field : 'accountName',
			title : '账户',
			width : 150,
			sortable : true,
			align : 'left'
		}, {
			field : 'locked',
			title : '状态',
			sortable : true,
			width : 150,
			formatter : function(value, row, index) {
				if (value == 0 || value == 1)
					return "<font color='green'>正常</font>";
				else if (value == 2)
					return "<font color='red'>锁定</font>";
			}
		}, {
			field : 'name',
			title : '角色名称',
			sortable : true,
			width : 150
		}] ],
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

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

function editResUI() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		pageii = layer
				.open({
					title : "<h5><i class='glyphicon glyphicon-link'></i>修改用户权限<h5>",
					type : 2,
					maxmin : true,
					area : [ "400px", "500px" ],
					content : rootPath + '/mobile/user/editUI.shtml?id='+ selectRow.id+'&roleId='+selectRow.roleId,
					end : function() {
						grid.datagrid("reload");
					}
				});
	} else {
		layer.msg("未选择一行");
	}
}
