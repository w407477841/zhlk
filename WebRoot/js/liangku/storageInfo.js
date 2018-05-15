var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : 'kcxx/queryData.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'storageID',
		sortOrder : 'asc',
		multiSort : true,
		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'storageID',
			title : '仓号',
			width : 180,
			align : 'left',
			editor : 'text'
		}, {
			field : 'name',
			title : '粮食品种',
			width : 150,
			align : 'left'
		}, {
			field : 'quanzhong',
			title : '粮食性质',
			width : 150,
			align : 'left',
		}, {
			field : 'cangKu',
			title : '库存量(kg)',
			width : 150,
			align : 'left',
		}
		] ],
		onBeforeLoad : function(param) {

		},
		onSortColumn : function(sort, order) {

		},
		onLoadSuccess : function(data) {
			grid.datagrid('getPager').pagination({
				displayMsg : '当前显示从{from}到{to},共{total}记录',
				onBeforeRefresh : function(pageNumber, pageSize) {
					$(this).pagination('loading');
					$(this).pagination('loaded');
				},
			});

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