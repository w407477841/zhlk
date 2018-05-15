var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'canzhachuli/findByPage.shtml',
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
			title : '仓号',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'loginTime',
			title : '粮食品种',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP2',
			title : '收获年度',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP3',
			title : '出库数量(公斤)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP4',
			title : '水分(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP5',
			title : '杂质(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP6',
			title : '出糙(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP7',
			title : '容重(g/l)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP8',
			title : '不完善粒(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP9',
			title : '黄粒(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginI4',
			title : '谷外糙米(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginI5',
			title : '整精米粒(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginI6',
			title : '色泽气味',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP1',
			title : '出库日期',
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
