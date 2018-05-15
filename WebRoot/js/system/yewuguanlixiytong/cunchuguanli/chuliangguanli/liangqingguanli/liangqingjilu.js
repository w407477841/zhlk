var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'liangqingjilu/findByPage.shtml',
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
		frozenColumns:[[ {
			field : 'accountName',
			title : '仓号',
			align : 'left',
			width: 80
		}, {
			field : 'loginTime',
			title : '检查日期',
			width: 80
		}, {
			field : 'loginIP',
			title : '存量数量(公斤)',
			width: 80
		}, {
			field : 'loginIP1',
			title : '保管员',
			width: 80
		}]],
		columns : [ [ {
			field : 'loginIP2',
			title : '天气',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP3',
			title : '气温(°C)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP4',
			title : '气湿(%RH)',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP5',
			title : '仓问(°C)',
			width: 150
		}, {
			field : 'loginIP6',
			title : '仓湿(%RH)',
			width: 150
		}, {
			field : 'loginIP7',
			title : '最高量温(部位)',
			width: 150
		}, {
			field : 'loginIP8',
			title : '最低量温(部位)',
			width: 150
		}, {
			field : 'loginIP9',
			title : '上层平均粮温',
			width: 150
		}
		, {
			field : 'loginIP10',
			title : '中层平均粮温',
			width: 150
		}, {
			field : 'loginIP11',
			title : '中下层平均粮温',
			width: 150
		}
		, {
			field : 'loginIP12',
			title : '鼠雀情况',
			width: 150
		}
		, {
			field : 'loginIP13',
			title : '虫害情况',
			width: 150
		}, {
			field : 'loginIP14',
			title : '霉变情况',
			width: 150
		}, {
			field : 'loginIP15',
			title : '事故情况',
			width: 150
		}, {
			field : 'loginIP16',
			title : '仓房情况',
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
