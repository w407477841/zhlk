var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath + '/reportHarbor/findNotCheckByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : false,
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
		frozenColumns : [ [ {
			field : 'bId',
			title : '单据号',
			sortable : true,
			width : 110
		}, {
			field : 'userName',
			title : '单位',
			sortable : true,
			width : 150
		}, {
			field : 'shipId',
			title : '车船号',
			sortable : true,
			width : 100
		} ] ],
		columns : [ [ {
			field : 'wlName',
			title : '仓库地点',
			sortable : true,
			width : 120
		}, {
			field : 'wName',
			title : '仓号',
			sortable : true,
			width : 80
		}, {
			field : 'grainVariety',
			title : '粮食品种',
			sortable : true,
			width : 110
		}, {
			field : 'grainProperty',
			title : '粮食性质',
			sortable : true,
			width : 110
		}, {
			field : 'IDCard',
			title : '身份证',
			sortable : true,
			width : 150
		}, {
			field : 'phoneNumber',
			title : '电话号码',
			sortable : true,
			width : 100
		}, {
			field : 'address',
			title : '联系地址',
			sortable : true,
			width : 150
		}, {
			field : 'inOrOut',
			title : '出/入库',
			sortable : true,
			width : 90,
			formatter : function formatprice(val, row) {
				if (val == '1') {
					return '<span style="color:green;">出库</span>';
				} else {
					return '<span style="color:blue;">入库</span>';
				}
			}
		}, {
			field : 'usedCar',
			title : '是否驳车',
			sortable : true,
			width : 90,
			formatter : function formatprice(val, row) {
				if (val == '1') {
					return '<span style="color:green;">驳车</span>';
				} else {
					return '<span style="color:blue;">不驳车</span>';
				}
			}
		}, {
			field : 'cardId',
			title : '一卡通',
			sortable : true,
			width : 90,
			formatter : function formatprice(val, row) {
				if (val != null) {
					return '<span style="color:green;">绑定</span>';
				} else {
					return '<span style="color:blue;">未绑定</span>';
				}
			}
		} ] ],
		onBeforeLoad : function(param) {

		},
		onSortColumn : function(sort, order) {

		},
		onLoadSuccess : function(data) {

		},
		onLoadError : function() {

		},
		onClickCell : function(rowIndex, field, value) {// 点击单元格触发事件

		},
		onDblClickRow : function(index, row) {
			// look(row.id);
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
	$("#check").click("click", function() {
		checkFun();
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
 * 质检
 */
function checkFun() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>报港质检<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			offset : "40px",
			content : rootPath + '/reportHarbor/addCheckUI.shtml?pId='+selectRow.bId,
			end : function() {
				grid.datagrid("reload");
			}
		});
	} else {
		layer.msg("请选择一行");
	}
}
function printQualityCheck(bId) {
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : rootPath + '/reportHarbor/findPrintCheckByBId.shtml',
		data : {
			bId : bId
		},
		success : function(data) {
			if (data != null) {
				qualityCheckPrint(data);
			} else {
				layer.alert("打印异常！", {
					icon : 7
				});
			}
		},
		error : function(data) {
			layer.alert("打印异常！", {
				icon : 7
			});
		}
	});
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
		url:rootPath+'/reportHarbor/findIsCheckByCardId.shtml',
		data:{cardId:oneCard},
		success:function(data){
			console.log(data);
			if(data == null || data == ''){
				layer.alert("获取信息失败！",{icon: 5});
			}else{
				if(data.rz == null || data.rz == ''){
					open_check(data.bId);
				}else{
					layer.alert("数据已质检！",{icon: 5});
				}
			}
		},
		error:function(data){
			layer.alert("获取信息失败！",{icon: 5});
		}
	});
}

function open_check(id){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>报港质检<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		offset : "40px",
		content : rootPath + '/reportHarbor/addCheckUI.shtml?pId='+id,
		end : function() {
			grid.datagrid("reload");
		}
	});
}