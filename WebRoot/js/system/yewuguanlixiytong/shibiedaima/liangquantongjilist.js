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
		fitColumns : true,
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
		columns : [ [ {
			field : 'wlName',
			title : '粮库地点',
			width: 150
		}, {
			field : 'wName',
			title : '仓号',
			width: 150
		}, {
			field : 'variety',
			title : '粮食品种',
			width: 150
		}, {
			field : 'property',
			title : '粮食性质',
			width: 150
		}, {
			field : 'cangKu',
			title : '数量(kg)',
			width: 150
		}, {
			field : 'buyYear',
			title : '收获年度',
			width: 100
		}, {  						
			field: '_code',
			title: '识别码',
			width: 150, 
			align: 'left',
			formatter:function(value,row,index){
				return "<button class='btn btn-info btn-sm' onclick='shibiema("+row.storageID+")' ><i class='fa fa-qrcode'></i> </button> " ;
			}
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
function shibiema(id){
	pageii = layer.open({
		title : "<h5><i class='fa fa-qrcode'></i>识别码<h5>",
		type : 2,
		maxmin :true,
		area : [ "400px", "400px" ],
		content : rootPath + '/store/shibiema.shtml?id='+id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}