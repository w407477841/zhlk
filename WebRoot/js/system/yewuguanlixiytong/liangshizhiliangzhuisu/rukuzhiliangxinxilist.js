var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'rukuzhiliangxinxi/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
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
			field : 'ID',
			title : '入库单号',
			align : 'left',
			editor : 'text',
			width: 230
		}, {
			field : 'StorageID',
			title : '仓号',
			sortable : true,
			width: 120,
			formatter:function(value){
				return value&&value.split(",")[1];
			}
		}, {
			field : 'Breed',
			title : '粮食品种',
			sortable : true,
			width: 150,formatter:function(value){
				return CONFIGURE.BREED[value];
			}
		}, {
			field : 'Property',
			title : '粮食性质',
			sortable : true,
			width: 150
		}, {
			field : 'OWNER',
			title : '发粮单位',
			sortable : true,
			width: 150
		}, {
			field : 'CarID',
			title : '车号(船号)',
			sortable : true,
			width: 120
		}, {
			field : 'weights',
			title : '实收数量(公斤)',
			sortable : true,
			width: 150,
			formatter:function(value){
				return !isNaN(value)&&Math.abs(value)||0
			}
		}, {
			field : 'sf',
			title : '水分(%)',
			sortable : true,
			width: 80
		}, {
			field : 'Zz',
			title : '杂质(%)',
			sortable : true,
			width: 80
		}, {
			field : 'CCL',
			title : '出糙(%)',
			sortable : true,
			width: 80
		}, {
			field : 'rz',
			title : '容重(g/l)',
			sortable : true,
			width: 90
		}, {
			field : 'CreateTime',
			title : '入库日期',
			sortable : true,
			width: 190,
			formatter:function(value){
				return new Date(value).format("yyyy-MM-dd")
			}
		}, {
			field : 'inorout',
			title : '出入库',
			sortable : true,
			width: 190,
			formatter:function(value){
				return ~~value&&"入库"||"出库"
			}
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
			content : rootPath + "/rukuzhiliangxinxi/messageAddPage.shtml",
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
				content : rootPath + '/rukuzhiliangxinxi/messageEditPage.shtml?id='+ selectRow.basicid,
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
				var url = rootPath + '/rukuzhiliangxinxi/deleteInstanceMsg.shtml';
				var s = CommnUtil.ajax(url, {id : selectRow.ID,basicid:selectRow.basicid}, "json");
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
	

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
