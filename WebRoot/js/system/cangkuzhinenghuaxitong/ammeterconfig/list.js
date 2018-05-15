var grid;
var pageii;
var searchParams;

$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid')
			.datagrid(
					{
						url : 'cangkuzhinenghuaxitong/ammeterConfig/findByPage.shtml',
						method : 'POST',
						queryParams : searchParams,
						idField : 'id',
						striped : true,
						fitColumns : true,
						singleSelect : true,
						rownumbers : true,
						pagination : true,
						nowrap : false,
						sortName : 'name',
						sortOrder : 'asc',
						multiSort : true,
						pageSize : 20,
						pageList : [ 10, 20, 50, 100, 150, 200 ],
						showFooter : true,
						columns : [ [
								{
									field : 'name',
									title : '名称',
									width : 180,
									align : 'left'
								},
								{
									field : 'ip',
									title : 'ip',
									width : 150
								},
								{
									field : 'port',
									title : 'port',
									width : 150
								},
								{
									field : 'cangkudianwei',
									title : '仓库点位',
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
			var url = rootPath
					+ '/cangkuzhinenghuaxitong/ammeterConfig/deleteOne.shtml';
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

/**
 * 打开add页面
 */
function addUI() {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "880px", "600px" ],
		content : rootPath
				+ '/cangkuzhinenghuaxitong/ammeterConfig/addUI.shtml',
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
			area : [ "660px", "600px" ],
			content : rootPath
					+ '/cangkuzhinenghuaxitong/ammeterConfig/editUI.shtml?id='
					+ selectRow.id,
			end : function() {
				grid.datagrid("reload");
			}
		});
	} else {
		layer.msg("请选择一行");
	}
}
