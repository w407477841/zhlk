var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'shenpijilu/findByPage.shtml',
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
			field : 'gsaApplyBill',
			title : '申请单编号',
			width: 150
		}, {
			field : 'userName',
			title : '审批人',
			width: 150
		}, {
			field : 'gsaAuditingDate',
			title : '审批时间',
			width: 150
		}, {
			field : 'gsaProcess',
			title : '审批状态',
			width: 150,
			formatter:function formatprice(val,row){ 
				if (val == "审批未通过"){  
					return '<span style="color:red;">'+val+'</span>';  
				}else if(val == "等待审批"){
					return '<span style="color:blue;">'+val+'</span>'; 
				}else if(val == "审批通过"){
					return '<span style="color:green;">'+val+'</span>'; 
				}else {  
					return val; 
				}
			}
		}, {
			field : 'gsaRemark',
			title : '审批意见',
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

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
