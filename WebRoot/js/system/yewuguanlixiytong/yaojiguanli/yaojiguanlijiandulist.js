var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'yaojiguanlijiandu/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'wName',
			title : '粮库地点',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'mrName',
			title : '药剂名称',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'mrBrand',
			title : '品牌',
			sortable : true,
			width: 150
		}, {
			field : 'mrStandard',
			title : '规格',
			sortable : true,
			width: 150
		}, {
			field : 'text',
			title : '单位',
			sortable : true,
			width: 150
		}, {
			field : 'mrNumber',
			title : '库存数量',
			sortable : true,
			width: 100
		}, {
			field : 'mrManufactureDate',
			title : '生产时间',
			sortable : true,
			width: 100
		}, {
			field : 'mrProductCompany',
			title : '生产厂家',
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
