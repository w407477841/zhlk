var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'store/findCurrentStorageByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : false,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'source',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [{
			field : 'source',
			title : '库点位置',
			width: 110
		}, {
			field : 'storageID',
			title : '仓号',
			width: 70
		}, {
			field : 'name',
			title : '类别',
			width: 110
		}, {
			field : 'quanZhong',
			title : '粮食性质',
			width: 100
		}, {
			field : 'cangKu',
			title : '数量(公斤)',
			width: 80
		}, {
			field:"sdLevel",
			title:"等级",
			width:60
		},{
			field:"sdMoisture",
			title:"水份（%）",
			width:60
		},{
			field:"sdImpurity",
			title:"杂质",
			width:60
		},{
			field:"sdUnitweight",
			title:"容重(g/l)",
			width:60
		},{
			field:"sdUnsoundgrain",
			title:"不完善粒(%）",
			width:60
		},{
			field:"sdYellowrice",
			title:"黄粒",
			width:60
		},{
			field:"sdHeadricerate",
			title:"整精米率（%）",
			width:70
		},{
				field:"sdBrownricerate",
				title:"出糙(%）",
				width:60
				},{
					field:"sdHuskedriceinpeddy",
					title:"谷外糙米",
					width:60
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
