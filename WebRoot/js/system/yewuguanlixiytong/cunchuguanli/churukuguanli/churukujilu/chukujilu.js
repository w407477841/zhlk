var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'chukujilu/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : false,
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
			title : '出库单编号',
			width: 150
		}, {
			field : 'loginTime',
			title : '所出仓号',
			width: 150
		}, {
			field : 'loginIP',
			title : '出库日期',
			width: 150
		}, {
			field : 'loginIP1',
			title : '提货单位',
			width: 150
		}, {
			field : 'loginIP2',
			title : '车船号',
			width: 150
		}, {
			field : 'loginIP3',
			title : '粮食性质',
			width: 150
		}, {
			field : 'loginIP4',
			title : '粮食品种',
			width: 150
		}, {
			field : 'loginIP5',
			title : '收货年度',
			width: 150
		}, {
			field : 'loginIP6',
			title : '发往省份',
			width: 150
		}, {
			field : 'loginIP7',
			title : '包装方式',
			width: 150
		}, {
			field : 'loginIP8',
			title : '出库原有',
			width: 150
		}, {
			field : 'loginIP9',
			title : '实收数量(公斤)',
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
