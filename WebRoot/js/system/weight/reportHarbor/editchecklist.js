var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/reportHarbor/findAllCheckByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		sortName : 'bId',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'bId',
			title : '单据号',
			sortable : true,
			width: 120
		}, {
			field : 'rz',
			title : '容重/出糙',
			sortable : true,
			width: 60
		}, {
			field : 'sf',
			title : '水分',
			sortable : true,
			width: 60
		}, {
			field : 'zz',
			title : '杂质',
			sortable : true,
			width: 60
		}, {
			field : 'kwz',
			title : '矿物质',
			sortable : true,
			width: 60
		}, {
			field : 'bwsld',
			title : '不完善粒度',
			sortable : true,
			width: 60
		}, {
			field : 'zjml',
			title : '整精米粒',
			sortable : true,
			width: 60
		}, {
			field : 'gwcm',
			title : '谷外糙米',
			sortable : true,
			width: 60
		}, {
			field : 'hlm',
			title : '黄粒米',
			sortable : true,
			width: 60
		}, {
			field : 'hh',
			title : '互混',
			sortable : true,
			width: 60
		}, {
			field : 'cmbl',
			title : '赤霉病粒',
			sortable : true,
			width: 60
		}, {
			field : 'ydzs',
			title : '硬度指数',
			sortable : true,
			width: 60
		}, {
			field : 'szqw',
			title : '色泽气味',
			sortable : true,
			width: 60
		}, {
			field : 'otherReduce',
			title : '其他扣量',
			sortable : true,
			width: 60
		}, {
			field : 'totalReduce',
			title : '总扣量',
			sortable : true,
			width: 60
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

		},
		onDblClickRow: function(index,row){
			//look(row.id);
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
	$("#editFun").click("click",function(){
		editUI();
		});
	
});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

/**
 * 打开edit页面
 */
function editUI(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
			type : 2,
			maxmin :true,
			area : [ "1200px", "600px" ],
			offset:"40px",
			content : rootPath + '/reportHarbor/editCheckUI.shtml?id='+selectRow.id,
			end :function(){
				grid.datagrid("reload");
			}
		});
	}
	else{
		layer.msg("请选择一行");
	}
}



