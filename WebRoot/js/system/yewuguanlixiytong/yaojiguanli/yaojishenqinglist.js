var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'yaojilingyongshenqing/findByPage.shtml',
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
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'maBill',
			title : '申请单编号',
			align : 'left',
			editor : 'text',
			width : 150
		}, {
			field : 'wName',
			title : '粮库地点',
			sortable : true,
			width : 150
		}, {
			field : 'maName',
			title : '药剂名称',
			sortable : true,
			width : 150
		}, {
			field : 'maBrand',
			title : '品牌',
			sortable : true,
			width : 100
		}, {
			field : 'maStandard',
			title : '规格',
			sortable : true,
			width : 100
		}, {
			field : 'text',
			title : '单位',
			sortable : true,
			width : 100
		}, {
			field : 'maQuantity',
			title : '领用数量',
			sortable : true,
			width : 100
		}, {
			field : 'maApplicant',
			title : '申请人',
			sortable : true,
			width : 100
		}, {
			field : 'maProcess',
			title : '状态',
			sortable : true,
			width : 100,
			formatter : function formatprice(val, row) {
				if (val == "审批未通过") {
					return '<span style="color:red;">' + val + '</span>';
				} else if (val == "等待审批") {
					return '<span style="color:blue;">' + val + '</span>';
				} else if (val == "审批通过") {
					return '<span style="color:green;">' + val + '</span>';
				} else {
					return val;
				}
			}
		}, {
			field : 'maApplyDate',
			title : '创建时间',
			sortable : true,
			width : 150
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

	$("#addFun").click("click", function() {
		addUI();
	});

	$("#editFun").click("click", function() {
		editUI();
	});

	$("#deleFun").click("click", function() {
		del();
	});
	$("#approveFun").click("click", function() {
		approve();
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

function addUI() {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		offset : "40px",
		content : rootPath + '/yaojilingyongshenqing/addUI.shtml',
		end : function() {
			grid.datagrid("reload");
		}
	});
}
function editUI() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		var process = selectRow.maProcess;
		if (process == '等待审批' || process == '审批通过') {
			layer.msg("数据无法进行编辑");
		} else {
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
				type : 2,
				maxmin : true,
				area : [ "1200px", "600px" ],
				offset : "40px",
				content : rootPath + '/yaojilingyongshenqing/editUI.shtml?id='
						+ selectRow.id,
				end : function() {
					grid.datagrid("reload");
				}
			});
		}
	} else {
		layer.msg("请选择一行");

	}
}
function approve() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		var process = selectRow.maProcess;
		if (process == '等待审批' || process == '审批通过') {
			layer.msg("数据无法进行提交");
		} else {
			layer.confirm('确认提交审核？',
					function(index) {
						var url = rootPath
								+ '/yaojilingyongshenqing/approveById.shtml';
						var s = CommnUtil.ajax(url, {
							id : selectRow.id
						}, "json");
						if (s == "success") {
							grid.datagrid('acceptChanges');
							layer.msg('提交成功');
							grid.datagrid("reload");
						} else {
							grid.datagrid('rejectChanges');
							layer.msg('提交失败');
						}
					});
		}
	} else {
		layer.msg("请选择一行");
	}
}
function del() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		var process = selectRow.maProcess;
		if (process == '审批通过') {
			layer.msg("数据无法删除");
		} else {
			layer.confirm('确认删除？', function(index) {
				var url = rootPath + '/yaojilingyongshenqing/delete.shtml';
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
		}
	} else {
		layer.msg("请选择一行");
	}
}
/**
 * 打印
 */
function printFun() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		var process = selectRow.maProcess;
		if (process != '审批通过') {
			layer.msg("未审核通过！");
		} else {
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : rootPath
						+ '/yaojilingyongshenqing/findYaoJiShenQingById.shtml',
				data : {
					bId : selectRow.id
				},
				success : function(data) {
					if (data != null) {
						medicamentApplyPrint(data);
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
	} else {
		layer.msg("请选择一行");
	}
}
