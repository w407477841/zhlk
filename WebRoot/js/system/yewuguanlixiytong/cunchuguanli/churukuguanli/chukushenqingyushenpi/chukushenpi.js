var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'chukushenpi/findByPage.shtml',
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
			field : 'gsaApplyBill',
			title : '单编号',
			width: 150
		}, {
			field : 'gsaSendOutDate',
			title : '发货日期',
			width: 150
		}, {
			field : 'gsaPurchaser',
			title : '买受人(需方)',
			width: 150
		}, {
			field : 'agreementID',
			title : '合同号',
			width: 150
		}, {
			field : 'gsaPaymentSituation',
			title : '货款到账情况',
			width: 150
		}, {
			field : 'gsaPlanOutWeight',
			title : '计划出库数量（kg）',
			width: 150
		}, {
			field : 'gsaCurrentWeight',
			title : '当前数量（kg）',
			width: 150
		}, {
			field : 'gsaApplyPerson',
			title : '申请人',
			width: 150
		}, {
			field : 'department',
			title : '所属部门',
			width: 150
		}, {
			field : 'gsaAddDate',
			title : '创建时间',
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
	$("#approveFun").click("click",function(){
		approveFun();
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
 * 打开审批页面
 */
function approveFun(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>审批<h5>",
			type : 2,
			maxmin :true,
			area : [ "1200px", "600px" ],
			offset:"40px",
			content : rootPath + '/chukushenpi/approveUI.shtml?id='+selectRow.id,
			end :function(){
				grid.datagrid("reload");
			}
		});
	}
	else{
		layer.msg("未选择一行");
		
	}
}