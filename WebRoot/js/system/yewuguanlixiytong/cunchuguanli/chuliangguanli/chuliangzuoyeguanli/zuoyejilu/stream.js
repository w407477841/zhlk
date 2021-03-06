var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'foodStorageManager/querySteam.shtml',
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
			field : 'type',
			title : '熏蒸类型',
			width : 150,
			formatter : function(value) {
				return value == "0" ? "常规熏蒸" : "环流熏蒸";
			}
		}, {
			field : 'wlName',
			title : '粮库地点',
			width : 100
		}, {
			field : 'wName',
			title : '仓号',
			width : 100
		}, {
			field : 'text',
			title : '粮食品种',
			width : 150
		}, {
			field : 'amount',
			title : '数量',
			width : 80
		}, {
			field : 'weather',
			title : '天气',
			width : 150
		}, {
			field : 'temperature',
			title : '气温',
			width : 150
		}, {
			field : 'houseTemperature',
			title : '仓温',
			width : 150
		}, {
			field : 'recordOne',
			title : '记录人',
			width : 150
		}, {
			field : 'timecreate',
			title : '记录时间',
			width : 150
		}

		] ],
		onBeforeLoad : function(param) {

		},
		onSortColumn : function(sort, order) {

		},
		onLoadSuccess : function(data) {
			grid.datagrid('getPager').pagination({
				displayMsg : '当前显示从{from}到{to},共{total}记录',
				onBeforeRefresh : function(pageNumber, pageSize) {
					$(this).pagination('loading');
					$(this).pagination('loaded');
				},
			});
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

	/**
	 * 打开add页面
	 */
	$("#add").click("click", function() {
		add();
	});
	/**
	 * 打开edit页面
	 */
	$("#edit")
			.click(
					"click",
					function() {
						var selectRow = grid.datagrid('getSelected');
						if (selectRow) {
							if(selectRow.type == '1'){
								pageii = layer
								.open({
									title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
									type : 2,
									maxmin : true,
									area : [ "1200px", "600px" ],
									content : rootPath
											+ '/foodStorageManager/circleSteam/editPage.shtml?id='
											+ selectRow.id,
									end : function() {
										grid.datagrid("reload");
									}
								});
							}else{
								pageii = layer
								.open({
									title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
									type : 2,
									maxmin : true,
									area : [ "1200px", "600px" ],
									content : rootPath
											+ '/foodStorageManager/steam/editPage.shtml?id='
											+ selectRow.id,
									end : function() {
										grid.datagrid("reload");
									}
								});
							}
							
						} else {
							layer.msg("请选择一行");
						}
					});

	$("#del").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			layer.confirm('确认删除？', function(index) {
				var url = rootPath + '/foodStorageManager/deleteSteam.shtml';
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
	});
});


function add(){
	var title = "";
	var url = "";
	layer.confirm('请选择熏蒸方式？', {
		btn : [ '常规熏蒸', '环流熏蒸'],
		title:'熏蒸方式'
	// 按钮
	}, function(index, layero) {
		title = "<h5><i class='glyphicon glyphicon-link'></i>常规熏蒸新增<h5>";
		url = rootPath + "/foodStorageManager/steam/addPage.shtml";
		pageii = layer.open({
			title : title,
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : url,
			end : function() {
				grid.datagrid("reload");
			}
		});
		layer.close(index);
	}, function(index) {
		title = "<h5><i class='glyphicon glyphicon-link'></i>环流熏蒸新增<h5>";
		url = rootPath + "/foodStorageManager/circleSteam/addPage.shtml";
		pageii = layer.open({
			title : title,
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : url,
			end : function() {
				grid.datagrid("reload");
			}
		});
	}
	
	);
}
