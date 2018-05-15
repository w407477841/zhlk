var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/reportForms/threeReportFormsByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		sortName : 'reportDate',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'reportDate',
			title : '收购日期',
			sortable : true,
			width: 150
		}, {
			field : '_sumMoney',
			title : '结算金额(元)',
			sortable : true,
			width: 130,
			formatter:function formatprice(val,row){
				var temp = row.payStatus;
				var temArr = temp.split(",");
				
				var money = row.sumMoney;
				var moneyArr = money.split(",");
				
				for(var i = 0;i<temArr.length;i++){
					if(temArr[i] == '结算完成'){
						return moneyArr[i];
					}
				}
				return "";
			}
		}, {
			field : '_count',
			title : '结算笔数',
			sortable : true,
			width: 80,
			formatter:function formatprice(val,row){
				var temp = row.payStatus;
				var temArr = temp.split(",");
				
				var count = row.count;
				var countArr = count.split(",");
				
				for(var i = 0;i<temArr.length;i++){
					if(temArr[i] == '结算完成'){
						return countArr[i];
					}
				}
				return "";
			}
		},{
			field : '_money',
			title : '待结算金额(元)',
			sortable : true,
			width: 130,
			formatter:function formatprice(val,row){
				var temp = row.payStatus;
				var temArr = temp.split(",");
				
				var money = row.sumMoney;
				var moneyArr = money.split(",");
				
				for(var i = 0;i<temArr.length;i++){
					if(temArr[i] == '待结算'){
						return moneyArr[i];
					}
				}
				return "";
			}
		}, {
			field : '_notcount',
			title : '待结算笔数',
			sortable : true,
			width: 80,
			formatter:function formatprice(val,row){
				var temp = row.payStatus;
				var temArr = temp.split(",");
				
				var count = row.count;
				var countArr = count.split(",");
				
				for(var i = 0;i<temArr.length;i++){
					if(temArr[i] == '待结算'){
						return countArr[i];
					}
				}
				return "";
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