var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath + '/reportHarbor/findByPage.shtml',
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
	$("#inAddFun").click("click", function() {
		addInUI();
	});
	$("#outAddFun").click("click", function() {
		addOutUI();
	});
	$("#deleFun").click("click", function() {
		del();
	});
	$("#repairFun").click("click", function() {
		repairFun();
	});
	$("#usedCarFun").click("click", function() {
		editUsedCar();
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
 * 入库报港
 */

function addInUI() {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		offset : "40px",
		content : rootPath + '/reportHarbor/addInUI.shtml',
		end : function() {
			grid.datagrid("reload");
		}
	});
}
/**
 * 出库报港
 */
function addOutUI() {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		offset : "40px",
		content : rootPath + '/reportHarbor/addOutUI.shtml',
		end : function() {
			grid.datagrid("reload");
		}
	});
}

/**
 * 补二维码或一卡通
 */
function repairFun() {
	var selectRow = grid.datagrid('getSelected');
	var bId = '';
	if (selectRow) {
		bId = selectRow.bId;
	}
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>补二维码(一卡通)<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		offset : "40px",
		content : rootPath + '/reportHarbor/repair.shtml?bId=' + bId,
		end : function() {
			grid.datagrid("reload");
		}
	});
}
/**
 * 删除
 */
function del() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		layer.confirm('确认删除？', function(index) {
			var url = rootPath + '/reportHarbor/delete.shtml';
			var s = CommnUtil.ajax(url, {
				id : selectRow.id
			}, "json");
			if (s == "success") {
				grid.datagrid('acceptChanges');
				layer.msg('删除成功');
				grid.datagrid("reload");
			} else {
				grid.datagrid('rejectChanges');
				layer.msg('删除失败');
			}
		});
	} else {
		layer.msg("请选择一行");
	}
}
/**
 * 查看
 * 
 * @param id
 */
function look(id) {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		offset : "40px",
		content : rootPath + '/car/look.shtml?id=' + id,
		end : function() {
			grid.datagrid("reload");
		}
	});
}
/**
 * 报港时添加驳车
 * 
 * @param bId
 */
function usedCar(bId, usedOrNot) {
	layer.close(pageii);
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>添加<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		offset : "40px",
		content : rootPath + '/reportHarbor/usedCar.shtml?bId=' + bId,
		end : function() {
			if (usedOrNot != '1') {
				createQRC(bId);
			}
		}
	});
}
/**
 * 没有一卡通，生成二维码
 * 
 * @param bId
 */
function createQRC(bId) {
	layer.close(pageii);
	layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>报港二维码<h5>",
		type : 2,
		maxmin : true,
		area : [ "400px", "530px" ],
		offset : "40px",
		content : rootPath + '/reportHarbor/createQRC.shtml?bId=' + bId,
		end : function() {
			// grid.datagrid("reload");
		}
	});
}
/**
 * 根据单据号进行驳车修改
 */
function editUsedCar() {
	var selectRow = grid.datagrid('getSelected');
	var bId = '';
	if (selectRow) {
		bId = selectRow.bId;
	}
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>修改驳车信息<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		offset : "40px",
		content : rootPath + '/reportHarbor/editUsedCar.shtml?bId=' + bId,
		end : function() {
			grid.datagrid("reload");
		}
	});
}
