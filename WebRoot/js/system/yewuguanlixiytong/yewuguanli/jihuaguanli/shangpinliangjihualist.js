var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'businessManager/queryPlans.shtml?planType=4',
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
			field : 'planId',
			title : '计划编号',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'breed',
			title : '粮食品种',
			sortable : true,
			width: 150
		}, {
			field : 'department',
			title : '下达单位',
			sortable : true,
			width: 150
		}, {
			field : 'completedAmount',
			title : '计划数量',
			sortable : true,
			width: 150
		}, {
			field : 'planedPrice',
			title : '价格',
			sortable : true,
			width: 150
		}, {
			field : 'type',
			title : '业务类型',
			sortable : true,
			width: 150
		}, {
			field : 'planedTimeEnd',
			title : '计划完成时间',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP5',
			title : '时间进度',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP6',
			title : '数量进度',
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
