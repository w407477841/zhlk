var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/qualityManager/findOutputByPage.shtml',
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
		frozenColumns:[[{
			field : 'wlName',
			title : '库点名称',
			sortable : true,
			width: 130
		},{
			field : 'wName',
			title : '仓号',
			sortable : true,
			width: 80
		}, {
			field : 'grainProperty',
			title : '粮食性质',
			sortable : true,
			width: 130
		}, {
			field : 'grainVariety',
			title : '粮食品种',
			sortable : true,
			width: 130
		}]],
		columns : [ [ {
			field : 'addDate',
			title : '检测日期',
			sortable : true,
			width: 140
		}, {
			field : 'totalWeight',
			title : '当前重量',
			sortable : true,
			width: 100
		}, {
			field : 'rz',
			title : '容重/出糙',
			sortable : true,
			width: 100
		}, {
			field : 'sf',
			title : '水分',
			sortable : true,
			width: 60
		}, {
			field : 'zz',
			title : '杂质',
			sortable : true,
			width: 80
		}, {
			field : 'kwz',
			title : '矿物质',
			sortable : true,
			width: 100
		}, {
			field : 'bwsld',
			title : '不完善粒度',
			sortable : true,
			width:120
		}, {
			field : 'zjml',
			title : '整精米粒',
			sortable : true,
			width: 80
		}, {
			field : 'gwcm',
			title : '谷外糙米',
			sortable : true,
			width: 80
		}, {
			field : 'hlm',
			title : '黄粒米',
			sortable : true,
			width: 80
		}, {
			field : 'hh',
			title : '互混',
			sortable : true,
			width: 80
		}, {
			field : 'cmbl',
			title : '赤霉病粒',
			sortable : true,
			width: 80
		}, {
			field : 'ydzs',
			title : '硬度指数',
			sortable : true,
			width: 80
		}, {
			field : 'szqw',
			title : '色泽气味',
			sortable : true,
			width: 80
		}
		] ],
		onBeforeLoad : function(param) {

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
		content : rootPath + '/qualityManager/addOutputCheckUI.shtml',
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
		content : rootPath + '/qualityManager/editOutputCheckUI.shtml?id='+selectRow.id,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("未选择一行");
		
	}
}
/**
 * 删除
 */
function del(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	layer.confirm('确认删除？', function(index) {
		var url = rootPath + '/qualityManager/deleteQualityCheck.shtml';
		var s = CommnUtil.ajax(url, {id:selectRow.id
		}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('删除成功');
			grid.datagrid("reload");
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('删除失败');
		}
	});
	}else{
		layer.msg("未选择一行");
	}
}