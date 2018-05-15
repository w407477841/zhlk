var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'liangshilunhuanchukubaoguanhao/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : false,
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
			field : 'wlName',
			title : '粮库地点',
			width: 150
		},{
			field : 'wName',
			title : '仓号',
			width: 150
		},{
			field : 'category',
			title : '粮食品种',
			width: 150
		}, {
			field : 'gslPutInDate',
			title : '进仓日期 ',
			width: 150
		}, {
			field : 'gslGetOutDate',
			title : '出仓日期',
			width: 150
		}, {
			field : 'gslSaveDays',
			title : '保管天数',
			width: 150
		}, {
			field : 'gslPutInFluid',
			title : '入库水分(%)',
			width: 150
		}, {
			field : 'gslPutInImpurity',
			title : '入库杂质(%)',
			width: 150
		}, {
			field : 'gslPutInWeight',
			title : '入库数量(kg)',
			width: 150
		}, {
			field : 'gslGetOutFluid',
			title : '出库水分(%)',
			width: 150
		}, {
			field : 'gslGetOutImpurity',
			title : '出库杂质(%)',
			width: 150
		}, {
			field : 'gslGetOutWeight',
			title : '出库数量(kg)',
			width: 150
		}, {
			field : 'gslTotalReduce',
			title : '损耗总量(kg)',
			width: 150
		}, {
			field : 'gslLossRate',
			title : '保管自然耗比率(%)',
			width: 150
		}, {
			field : 'gslLossWeight',
			title : '保管自然耗数量(kg) ',
			width: 150
		}, {
			field : 'gslCleanUpWeight',
			title : '整理水杂耗数量(kg) ',
			width: 150
		}, {
			field : 'gslOverrateWeight',
			title : '超定额耗损(kg) ',
			width: 150
		}, {
			field : 'gslOverflowWeight',
			title : '溢余(kg) ',
			width: 150
		}, {
			field : 'gslAddDate',
			title : '添加时间(kg) ',
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
	
	$("#editFun").click("click",function(){
		editUI();
		});
	$("#deleFun").click("click",function(){
		del();
	});
	$("#export").click("click",function(){
		exportFun();
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
 * 打开新增页面
 */
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/liangshilunhuanchukubaoguanhao/addUI.shtml',
		end :function(){
			grid.datagrid("reload");
		}
	});
}
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
		content : rootPath + '/liangshilunhuanchukubaoguanhao/editUI.shtml?id='+selectRow.id,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("请选择一行");
		
	}
}
function exportFun(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		window.open(rootPath+"/liangshilunhuanchukubaoguanhao/show.shtml?pId="+selectRow.id);
	}
	else{
		layer.msg("请选择一行");
	}
}
