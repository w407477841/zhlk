var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'daocangguanli/findByPage.shtml',
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
			field : 'wgtBill',
			title : '倒仓单号',
			width: 150
		}, {
			field : 'wNameO',
			title : '原仓号',
			width: 150
		}, {
			field : 'wNameT',
			title : '目标仓号',
			width: 150
		}, {
			field : 'wgtTransferDate',
			title : '倒仓时间',
			width: 150
		}, {
			field : 'wgtCause',
			title : '倒仓原因',
			width: 150
		}, {
			field : 'wgtNumber',
			title : '倒仓数量(kg)',
			width: 150
		}, {
			field : 'paNameO',
			title : '原保管员',
			width: 150
		}, {
			field : 'paNameT',
			title : '目标保管员',
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
	$("#addFun").click("click",function(){
		addUI();
	});
	
	$("#lookFun").click("click",function(){
		lookUI();
	});
});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/daocangguanli/addUI.shtml',
		end :function(){
			grid.datagrid("reload");
		}
	});
}

function lookUI(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/daocangguanli/lookUI.shtml?id='+selectRow.id,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("请选择一行");
		
	}
}