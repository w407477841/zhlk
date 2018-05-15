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
		nowrap : true,
		sortName : 'bId',
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
			title : '单位',
			sortable : true,
			width: 110
		}, {
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
			field : 'totalWeight',
			title : '净重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'totalReduce',
			title : '总扣量(kg)',
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
			width: 60,
			formatter:function formatprice(val,row){ 
				return parseFloat(val/50);
			}
		}, {
			field : 'sumMoney',
			title : '结算金额(元)',
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
		]],
		onLoadSuccess : function() {
			
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
	$("#editFun").click("click",function(){
		editUI();
		});
	$("#readCard").click("click",function(){
		ReadOneCard_onclick();
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
		if(selectRow.payStatus == '结算完成'){
			layer.msg("已结算完成");
		}else{
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>资金结算<h5>",
				type : 2,
				maxmin :true,
				area : [ "1200px", "600px" ],
				offset:"40px",
				content : rootPath + '/reportHarbor/settleAccountUI.shtml?id='+selectRow.id,
				end :function(){
					grid.datagrid("reload");
				}
			});
		}
	}
	else{
		layer.msg("请选择一行");
	}
}
function auto_search(){
	var bId = $("#bill").val();
	if(bId != null && bId.length == 12){
		$.ajax({
			type:'post',
			dataType:'json',
			data:{bId:bId},
			url:rootPath+'/reportHarbor/findByBId.shtml',
			success:function(data){
				if(data != null){
					if(data.payStatus == '待结算'){
						open_settle(data.id);
					}else{
						layer.alert("不能进行结算！",{icon: 5});
					}
				}else{
					layer.alert("获取信息失败！",{icon: 5});
				}
			},
			error:function(data){
				layer.alert("获取信息失败！",{icon: 5});
			}
		});
	}
}



//读取一卡通
function ReadOneCard_onclick(){
	$.ajax({
		async:false,
		type:'GET',
		dataType:'jsonp',
		url:'http://127.0.0.1:9898/websocket/websocket/OneCard',
		jsonpCallback:"oneCardCallback",
		error:function(){
			layer.alert("网络配置失败！",{icon: 5});
		}
	});	
}
//回调函数
function oneCardCallback(data){
	if(data.result == 'success'){
		findCardId(data.oneCard);
	}else{
		layer.alert(data.result,{icon: 5});
	}
}
//根据读取一卡通获取报港信息
function findCardId(oneCard){
	$.ajax({
		type:'post',
		dataType:'json',
		url:rootPath+'/reportHarbor/findByCardId.shtml',
		data:{cardId:oneCard},
		success:function(data){
			console.log(data);
			if(data == null || data == ''){
				layer.alert("获取信息失败！",{icon: 5});
			}else{
				if(data.payStatus == '待结算'){
					open_settle(data.id);
				}else{
					layer.alert("不能进行结算！",{icon: 5});
				}
			}
		},
		error:function(data){
			layer.alert("获取信息失败！",{icon: 5});
		}
	});
}

function open_settle(id){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>资金结算<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/reportHarbor/settleAccountUI.shtml?id='+id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}