var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'liangwenliangqing/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'loginTime',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'accountName',
			title : '货位编码',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'loginTime',
			title : '库点名称',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP1',
			title : '仓房名称',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP2',
			title : '厫间名称',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP3',
			title : '货位名称',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP4',
			title : '出库时间',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP5',
			title : '出库数量(公斤)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP6',
			title : '详细信息',
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

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
