var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'kucunzhiliangjiance/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'loginTime',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'wName',
			title : '库点名称',
			align : 'left',
			editor : 'text',
			width: 100
		},{
			field : 'houseid',
			title : '仓号',
			align : 'left',
			editor : 'text',
			width: 60,
			formatter:function(value){
				
				return value&&value.split(",")[1]
			}
		}, {
			field : 'breed',
			title : '粮食品种',
			sortable : true,
			width: 100
		}, {
			field : 'property',
			title : '粮食性质',
			sortable : true,
			width: 100
		}, {
			field : 'bornDate',
			title : '收获年度',
			sortable : true,
			width: 60
		}, {
			field : 'amounts',
			title : '当前重量',
			sortable : true,
			width: 80
		}, {
			field : 'sf',
			title : '水分(%)',
			sortable : true,
			width: 60
		}, {
			field : 'Zz',
			title : '杂质(%)',
			sortable : true,
			width: 60
		}, {
			field : 'CCL',
			title : '出糙(%)',
			sortable : true,
			width: 60
		}, {
			field : 'Rz',
			title : '容重(g/l)',
			sortable : true,
			width: 60
		}, {
			field : 'Bwsld',
			title : '不完善粒(%)',
			sortable : true,
			width: 60
		}, {
			field : 'Hl',
			title : '黄粒(%)',
			sortable : true,
			width: 60
		}, {
			field : 'Gwcm',
			title : '谷外糙米(%)',
			sortable : true,
			width: 60
		}, {
			field : 'Zjml',
			title : '整精米粒(%)',
			sortable : true,
			width: 60
		}, {
			field : 'Szqw',
			title : '色泽气味',
			sortable : true,
			width: 60
		}
		] ],
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
	
	/**
	 * 打开add页面
	 */
	$("#add").click("click", function() {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : rootPath + "/kucunzhiliangjiance/messageAddPage.shtml",
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
				content : rootPath + '/kucunzhiliangjiance/messageEditPage.shtml?id='+ selectRow.id,
				end : function() {
					grid.datagrid("reload");
				}
			});
		} else {
			alert("未选择一行");

		}
	});
	
	/**
	 * 删除
	 */
	$("#remove").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			layer.confirm('确认删除？', function(index) {
				grid.datagrid('deleteRow', grid.datagrid('getRowIndex', selectRow));
				var url = rootPath + '/kucunzhiliangjiance/deleteInstanceMsg.shtml';
				var s = CommnUtil.ajax(url, {id : selectRow.id}, "json");
				if (s == "success") {
					grid.datagrid('acceptChanges');
					layer.msg('删除成功');
					
				} else {
					grid.datagrid('rejectChanges');
					layer.msg('删除失败');
				}
			});
			
} else {
			alert("未选择一行");

		}
	});
	
	$("#export").click("click", function() {
		var json=JSON.stringify($("#searchForm").serializeJson());
		window.open("gridReport/all-quality/reps.jsp?key="+json)
	});

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
