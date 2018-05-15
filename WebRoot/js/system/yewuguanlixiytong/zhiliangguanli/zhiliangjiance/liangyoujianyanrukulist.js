var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'liangyoujianyanruku/findByPage.shtml',
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
			title : '检验日期',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'loginTime',
			title : '仓号',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP1',
			title : '品种',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP3',
			title : '检验性质',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP2',
			title : '生产年度',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP4',
			title : '代表数量(公斤)',
			sortable : true,
			width: 150
		},{
			field : 'loginIP7',
			title : '水分(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP8',
			title : '杂质(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP9',
			title : '出糙(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginI1',
			title : '容重(g/l)',
			sortable : true,
			width: 150
		}, {
			field : 'loginI2',
			title : '不完善粒(%)',
			sortable : true,
			width: 150
		}, {
			field : 'loginI3',
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
