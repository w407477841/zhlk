var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'windowConfig/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'location',
		sortOrder : 'asc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'name',
			title : '名称',
			width : 180,
			align : 'left'
		}, {
			field : 'direction',
			title : '方向',
			width : 150,
			formatter : function(value) {
				if (value == 'E')
					return '东';
				else if (value == 'W')
					return '西';
				else if (value == 'S')
					return '南';
				else if (value == 'N')
					return '北';
				else if (value == 'ES')
					return '东南';
				else if (value == 'EN')
					return '东北';
				else if (value == 'WS')
					return '西南';
				else if (value == 'WN')
					return '西北';
			}

		}, {
			field : 'open1',
			width : 150,
			title : '开启(闭合)'
		}, {
			field : 'open2',
			width : 150,
			title : '开启(断开)'
		}, {
			field : 'needClosedBeforeOpen',
			title : '开附属',
			width : 150,
			formatter : function(value) {
				if (value == '0') {
					return '开启前不需要先关闭';
				} else if (value == '1') {
					return '开启前需要关闭';
				}
			}
		}, {
			field : 'close1',
			width : 150,
			title : '关闭(闭合)'
		}, {
			field : 'close2',
			width : 150,
			title : '关闭(断开)'
		}, {
			field : 'needOpenBeforeClose',
			title : '关附属',
			width : 150,
			formatter : function(value) {
				if (value == '0')
					return '关闭前不需要先开启';
				else if (value == '1')
					return '关闭前需要开启';
			}
		}, {
			field : 'duration',
			width : 150,
			title : '开启总时间(毫秒)'
		}, {
			field : 'ip',
			title : 'ip',
			width : 150
		}, {
			field : 'port',
			title : 'port',
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

			if (rowIndex != lastIndex) { // 当选中的不是该行
				if (lastIndex != -1)
					grid.datagrid('endEdit', lastIndex);// 不是第一次点击时
				if (!CommnUtil.in_array(updateColumn, field)) {
					grid.datagrid('unselectAll');
					return;
				} // 不是需要修改的字段
				grid.datagrid('beginEdit', rowIndex);
				lastIndex = rowIndex;
			} else {// 当选中的还是该行，但不是需要修改的字段，则结束修改。
				if (!CommnUtil.in_array(updateColumn, field)) {
					grid.datagrid('endEdit', lastIndex);
					grid.datagrid('unselectAll');
					lastIndex = -1;
				}
			}
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
			}
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

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

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
			var url = rootPath + '/windowConfig/deleteOne.shtml';
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
	} else {
		layer.msg("请选择一行");
	}
}

/**
 * 打开add页面
 */
function addUI() {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "880px", "600px" ],
		content : rootPath + '/windowConfig/addUI.shtml',
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
			area : [ "880px", "600px" ],
			content : rootPath + '/windowConfig/editUI.shtml?id='
					+ selectRow.id,
			end : function() {
				grid.datagrid("reload");
			}
		});
	} else {
		layer.msg("请选择一行");
	}
}
