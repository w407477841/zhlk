
var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'zuoyejihua/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		nowrap : false,
		sortName : 'loginTime',
		sortOrder : 'desc',
		multiSort : true,
		showFooter : true,
		columns : [ [ {
			field : 'accountName',
			title : '仓号',
			align : 'left',
			width: 150
		}, {
			field : 'loginTime',
			title : '仓温',
			width: 150
		}, {
			field : 'loginIP',
			title : '仓湿',
			width: 150
		}, {
			field : 'loginIP1',
			title : '气温',
			width: 150
		}, {
			field : 'loginIP1',
			title : '气湿',
			width: 150
		}, {
			field : 'loginIP1',
			title : '更新时间',
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
	});

});


