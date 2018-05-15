var grid;
var pageii;
var searchParams;
var lastColumn;
var lastIndex = -1;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : 'user/findUserByPage.shtml',
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
			field : 'description',
			title : '描述',
			width : 150,
			sortable : true,
			resizable : true,
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
		}, {
			field : 'text',
			title : '部门名称',
			sortable : true,
			width : 150
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

	$("#addFun").click("click", function() {
		addUI();
	});

	$("#editFun").click("click", function() {
		editUI();
	});
	$("#delFun").click("click", function() {
		del();
	});
	$("#initpwd").click("click", function() {
		initpwd();
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
/**
 * 修改当前点击行数据 修改失败后还原。 ps如果 有修改但未提交的数据，也会还原。
 * 
 * @param rowindex
 */
function edit(rowindex) {
	var row = grid.datagrid('getData').rows[rowindex];
	layer.confirm('确认修改？', function(index) {
		var url = rootPath + '/user/editListOne.shtml';
		var s = CommnUtil.ajax(url, {
			id : row.id,
			name : row.name,
			roleKey : row.roleKey,
			description : row.description
		}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('修改成功');
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('修改失败');
		}
	});

}

/**
 * 删除行，失败后还原。 ps如果 有修改但未提交的数据，也会还原。
 * 
 * @param rowindex
 * @param id
 */
function del() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		layer.confirm('确认删除？', function(index) {
			var url = rootPath + '/user/deleteOne.shtml';
			var s = CommnUtil.ajax(url, {
				id : selectRow.id
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
function initpwd() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		layer.confirm('确认初始化密码？', function(index) {
			var url = rootPath + '/user/initPwd.shtml';
			var s = CommnUtil.ajax(url, {
				id : selectRow.id
			}, "json");
			if (s == "success") {
				grid.datagrid('acceptChanges');
				layer.msg('初始化成功');
				grid.datagrid("reload");
			} else {
				grid.datagrid('rejectChanges');
				layer.msg('初始化失败');
			}
		});
	}else{
		layer.msg("请选择一行");
	}
}

/**
 * 插销 插销更改后未保存的所有记录
 */
function cancel() {
	grid.datagrid('rejectChanges');
}
/**
 * 打开add页面
 */
function addUI() {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		content : rootPath + '/user/addUI.shtml',
		end : function() {
			grid.datagrid("reload");
		}
	});
}

/**
 * 打开edit页面
 */
function editUI() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : rootPath + '/user/editUI.shtml?id=' + selectRow.id,
			end : function() {
				grid.datagrid("reload");
			}
		});
	} else {
		layer.msg("请选择一行");

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
					content : rootPath + '/role/editResUI.shtml?userId='
							+ selectRow.id,
					end : function() {
						grid.datagrid("reload");
					}
				});

	} else {
		layer.msg("未选择一行");

	}
}
