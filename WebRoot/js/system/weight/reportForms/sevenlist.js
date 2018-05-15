var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/reportForms/sevenReportFormsByPage.shtml',
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
		pageList : [ 10, 20, 50, 100, 200,1000,5000 ],
		showFooter : true,
		columns : [ [ {
			field : 'bId',
			title : '单据号',
			sortable : true,
			width: 110
		}, {
			field : 'userName',
			title : '单位',
			sortable : true,
			width: 150
		}, {
			field : 'shipId',
			title : '车船号',
			sortable : true,
			width: 120
		}, {
			field : 'wName',
			title : '仓号',
			sortable : true,
			width: 80
		}, {
			field : 'grossWeight',
			title : '毛重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'tare',
			title : '皮重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'grossWeightDate',
			title : '称毛时间',
			sortable : true,
			width: 150
		}, {
			field : 'tarDate',
			title : '称皮时间',
			sortable : true,
			width: 150
		}, {
			field : 'inOrOut',
			title : '出/入库',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == '1'){  
					return '<span style="color:green;">出库</span>';  
				}else{
					return '<span style="color:blue;">入库</span>'; 
				}
			}
		}
		] ],
		onBeforeLoad : function(param) {

		},
		onLoadSuccess : function() {
			compute();
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
	$("#print").click("click", function() {// 绑定查询按扭
		var bId = $("#bId").val();
		var beginDate = $("#beginDate").val();
		var endDate = $("#endDate").val();
		var inOrOut = $("#inOrOut").val();
		if(beginDate == null || beginDate == 'undefined' || beginDate == ''){
			beginDate = "";
		}
		if(beginDate == null || beginDate == 'undefined' || beginDate == ''){
			endDate = "";
		}
		if(bId == null || bId == ''){
			layer.msg("无单据号！");
		}else{
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>打印<h5>",
				type : 2,
				maxmin : true,
				area : [ "1200px", "650px" ],
				offset : "40px",
				content : rootPath + '/reportForms/sevenReportFormsByPrint.shtml?bId='+bId+'&beginDate='+beginDate+'&endDate='+endDate+'&inOrOut='+inOrOut,
				end : function() {
					grid.datagrid("reload");
				}
			});
		}
		
	});
});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

function compute() {
    var rows = grid.datagrid('getRows');
    var gross = 0,tare = 0 ;
    for (var i = 0; i < rows.length; i++) {
    	gross += rows[i]['grossWeight'] == null?0:rows[i]['grossWeight'];
    	tare += rows[i]['tare']== null?0:rows[i]['tare'];
    }
    
    $("#gross").html(gross.toFixed(0));
    $("#tare").html(tare.toFixed(0));
    $("#total").html(gross - tare);
}

