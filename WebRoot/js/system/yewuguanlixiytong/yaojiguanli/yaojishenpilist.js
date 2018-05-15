var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'yaojilingyongshenpi/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'maApplyDate',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'maBill',
			title : '申请单编号',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'wName',
			title : '粮库地点',
			sortable : true,
			width: 150
		}, {
			field : 'maName',
			title : '药剂名称',
			sortable : true,
			width: 150
		}, {
			field : 'maBrand',
			title : '品牌',
			sortable : true,
			width: 100
		}, {
			field : 'maStandard',
			title : '规格',
			sortable : true,
			width: 100
		}, {
			field : 'text',
			title : '单位',
			sortable : true,
			width: 100
		}, {
			field : 'maQuantity',
			title : '领用数量',
			sortable : true,
			width: 100
		}, {
			field : 'maApplicant',
			title : '申请人',
			sortable : true,
			width: 100
		}, {
			field : 'maApplyDate',
			title : '申请时间',
			sortable : true,
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
	
	$("#audFun").click("click",function(){
		auditing();
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
 * 审批
 */
function auditing(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>审批<h5>",
			type : 2,
			maxmin :true,
			area : [ "1200px", "600px" ],
			offset:"40px",
			content : rootPath + '/yaojilingyongshenpi/addUI.shtml?id='+selectRow.id,
			end :function(){
				grid.datagrid("reload");
			}
		});
	}
	else{
		layer.msg("请选择一行");
		
	}
}
