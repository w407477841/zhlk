var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath + '/reportHarbor/findPrintByPage.shtml',
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
	$("#print").click("click", function() {
		printFun();
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
 * 打印
 */
function printFun() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : rootPath + '/reportHarbor/findPrintCheckByBId.shtml',
			data : {
				bId : selectRow.bId
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
	} else {
		layer.msg("请选择一行");
	}
}
