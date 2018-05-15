var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'yewujiesuandan/findByPage.shtml',
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
			title : '结算单号',
			width: 150
		}, {
			field : 'loginTime',
			title : '结算形式',
			width: 150
		}, {
			field : 'loginIP',
			title : '结算方式',
			width: 150
		}, {
			field : 'loginIP1',
			title : '结算类型',
			width: 150
		}, {
			field : 'loginIP2',
			title : '结算金额(元)',
			width: 150
		}, {
			field : 'loginIP3',
			title : '关联单据类型',
			width: 150
		}, {
			field : 'loginIP4',
			title : '关联单据号码',
			width: 150
		}, {
			field : 'loginIP5',
			title : '创建时间',
			width: 150
		}, {
			field : 'loginIP6',
			title : '单据状态',
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
