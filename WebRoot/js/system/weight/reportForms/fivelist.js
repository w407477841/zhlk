var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/reportForms/fiveReportFormsByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 200,1000,5000 ],
		showFooter : true,
		frozenColumns:[[{
			field : 'wlName',
			title : '粮库',
			sortable : true,
			width: 150
		},{
			field : 'wName',
			title : '仓号',
			sortable : true,
			width: 80
		}, {
			field : 'grainVariety',
			title : '粮食品种',
			sortable : true,
			width: 110
		}, {
			field : 'grainProperty',
			title : '粮食性质',
			sortable : true,
			width: 110
		}]],
		columns : [ [ {
			field : 'totalWeight',
			title : '收购数量(kg)',
			sortable : true,
			width: 100
		}, {
			field : 'trueWeight',
			title : '结算净数(kg)',
			sortable : true,
			width: 100
		}, {
			field : 'reduceWeight',
			title : '总扣量(kg)',
			sortable : true,
			width: 100
		}, {
			field : 'buyPrice',
			title : '单价(元/kg)',
			sortable : true,
			width: 100
		}, {
			field : 'sumMoney',
			title : '结算金额(元)',
			sortable : true,
			width: 100
		}, {
			field : 'payStatus',
			title : '结算状态',
			sortable : true,
			width: 80,
			formatter:function formatprice(val,row){ 
				if (val == '待结算'){ 
					return '<span style="color:blue;">'+val+'</span>';  
				}else{
					return '<span style="color:green;">'+val+'</span>'; 
				}
			}
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
    var total = 0,totalpay=0,notpay=0;
    for (var i = 0; i < rows.length; i++) {
    	if(rows[i]["payStatus"] == '待结算'){
    		notpay += parseFloat(rows[i][colName]);
    	}else if(rows[i]["payStatus"] == '结算完成'){
    		totalpay += parseFloat(rows[i][colName]);
    	}
        total += parseFloat(rows[i][colName]);
    }
    $("#totalValue").html(total.toFixed(1));
    $("#notpay").html(notpay.toFixed(1));
    $("#totalpay").html(totalpay.toFixed(1));
}