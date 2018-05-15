var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/reportForms/twoReportFormsByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		sortName : 'payDate',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 200,1000,5000 ],
		showFooter : true,
		columns : [ [ {
			field : 'payDate',
			title : '结算日期',
			sortable : true,
			width: 150
		}, {
			field : 'sumMoney',
			title : '结算金额(元)',
			sortable : true,
			width: 130
		}, {
			field : 'count',
			title : '结算笔数',
			sortable : true,
			width: 80
		}, {
			field : 'inOrOut',
			title : '款型',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == '1'){  
					return '<span style="color:green;">收款</span>';  
				}else{
					return '<span style="color:blue;">付款</span>'; 
				}
			}
		}
		] ],
		onBeforeLoad : function(param) {

		},
		onLoadSuccess : function() {
			compute("sumMoney");
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

function compute(colName) {
    var rows = grid.datagrid('getRows');
    var total = 0;
    for (var i = 0; i < rows.length; i++) {
        total += parseFloat(rows[i][colName]);
    }
    $("#totalValue").html(total.toFixed(1));
}