var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : 'fendianmingxi/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		singleSelect : true,
		rownumbers : true,
		fitColumns : true,
		pagination : true,
		nowrap : false,
		sortName : 'location',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'location',
			title : '单位',
			width: 90
		},{
			field : 'position',
			title : '站点',
			width: 90
		}, {
			field : 'houseid',
			title : '仓库名称',
			width: 90
		}, {
			field : 'breed',
			title : '品种',
			width: 90
		},{
			field : 'property',
			title : '性质',
			width: 90
		}, {
			field : 'weight',
			title : '数量',
			width: 80,
			formatter:function(value){
				return isNaN(value)?value:(value*1).toFixed(2);
			}
		}, {
			field : 'sdPrice',
			title : '单价（元/千克）',
			width: 100
		}, {
			field : 'total',
			title : '金额（元）',
			width: 100,
			formatter:function(value){
				return isNaN(value)?value:(value*1).toFixed(2);
			}
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
		searchParams.station=  searchParams.station instanceof Array?searchParams.station.join(","):searchParams.station;
		grid.datagrid({
			queryParams : searchParams
		});
		
	});
	
	$("#export").click("click", function() {
		var json=JSON.stringify($("#searchForm").serializeJson());
		window.open("gridReport/fendian/reps.jsp?key="+json)
	});

});

