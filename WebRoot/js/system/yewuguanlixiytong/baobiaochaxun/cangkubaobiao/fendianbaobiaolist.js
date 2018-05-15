var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : 'fendianmingxi/findDetailStorageByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		singleSelect : true,
		fitColumns:true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'qiyemingcheng',
			title : '单位',
			width: 150
		}, {
			field : 'wlName',
			title : '粮库地点',
			width: 120
		}, {
			field : 'wName',
			title : '仓号',
			width: 90
		}, {
			field : 'grainVariety',
			title : '粮食品种',
			width: 120
		}, {
			field : 'grainProperty',
			title : '粮食性质',
			width: 100
		}, {
			field : 'cangKu',
			title : '库存量(kg)',
			width: 90,
			formatter:function formatprice(val,row){ 
				return parseFloat(val);  
			}
		}, {
			field : 'price',
			title : '单价',
			width: 80,
			formatter:function formatprice(val,row){ 
				if(val != null)
				return parseFloat(val).toFixed(2);  
			}
		}, {
			field : 'totalMoney',
			title : '金额',
			width: 80
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
		
		searchParams.station=  searchParams.station instanceof Array?searchParams.station.join(","):searchParams.station;
		
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
	
	$("#export").click("click", function() {
		var mingcheng = $("#selectmingcheng").val();
		var locationId = $("#locationId").val();
		var propertyList = $("#propertyList").val();
		var varietyList = $("#varietyList").val();
		window.open(rootPath+"/fendianmingxi/show.shtml?locationId="+locationId+"&propertyList="+propertyList+"&mingcheng="+mingcheng+"&varietyList="+varietyList);
	});
//	$("#export").click("click", function() {
//		var mingcheng = $("#selectmingcheng").val();
//		var locationId = $("#locationId").val();
//		var propertyList = $("#propertyList").val();
//		var varietyList = $("#varietyList").val();
//		window.open(rootPath+"/fendianmingxi/export.shtml?locationId="+locationId+"&propertyList="+propertyList+"&mingcheng="+mingcheng+"&varietyList="+varietyList);
//	});

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
