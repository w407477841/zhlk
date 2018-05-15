var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/reportHarbor/findSettleAccountByPage.shtml',
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
			field : 'bId',
			title : '单据号',
			sortable : true,
			width: 80
		}, {
			field : 'userName',
			title : '客户姓名',
			sortable : true,
			width: 80
		}, {
			field : 'payPlanId',
			title : '资金计划编号',
			sortable : true,
			width: 80
		},{
			field : 'grossWeight',
			title : '总毛重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'tare',
			title : '总皮重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'trueWeight',
			title : '结算重量(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'buyPrice',
			title : '单价(元/kg)',
			sortable : true,
			width: 80,
			formatter:function formatprice(val,row){ 
				return parseFloat(val/50);
			}
		}, {
			field : 'sumMoney',
			title : '结算金额',
			sortable : true,
			width: 60
		}, {
			field : 'inOrOut',
			title : '出库/入库',
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
		]]
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
	$("#editFun").click("click",function(){
		editUI();
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
			content : rootPath + '/ziJinJieSuan/editUI.shtml?id='+selectRow.id,
			end :function(){
				grid.datagrid("reload");
			}
		});
	}
	else{
		layer.msg("请选择一行");
	}
}
