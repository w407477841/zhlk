var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'foodStorageManager/queryAirCold.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : '',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'wlName',
			title : '粮库地点',
			width: 100
		},  {
			field : 'wName',
			title : '仓号',
			width: 100
		}, {
			field : 'text',
			title : '粮食品种',
			width: 150
		}, {
			field : 'amount',
			title : '数量(kg)',
			width: 150
		}, {
			field : 'thick',
			title : '粮层厚度(米)',
			width: 150
		}, {
			field : 'height',
			title : '空间高度',
			width: 150
		}, {
			field : 'deviceAmount',
			title : '空调数量',
			width: 150
		}, {
			field : 'totlePower',
			title : '空调机总功率',
			width: 150
		}, {
			field : 'timeTotal',
			title : '累计降温时间',
			width: 150
		}, {
			field : 'operator',
			title : '操作人',
			width: 100
		}, {
			field : 'timecreate',
			title : '记录时间',
			width: 150
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
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : rootPath + "/foodStorageManager/airCold/addPage.shtml",
			end : function() {
				grid.datagrid("reload");
			}
		});
	});
	/**
	 * 打开edit页面
	 */
	$("#edit").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
				type : 2,
				maxmin : true,
				area : [ "1200px", "600px" ],
				content : rootPath + '/foodStorageManager/airCold/editPage.shtml?id='+ selectRow.id,
				end : function() {
					grid.datagrid("reload");
				}
			});
		} else {
			layer.msg("请选择一行");

		}
	});
	$("#del").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			layer.confirm('确认删除？', function(index) {
				var url = rootPath + '/foodStorageManager/deleteAirCold.shtml';
				var s = CommnUtil.ajax(url, {id : selectRow.id}, "json");
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