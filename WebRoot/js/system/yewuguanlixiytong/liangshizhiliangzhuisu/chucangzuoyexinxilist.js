var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'chucangzuoyexinxi/findByPage.shtml',
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
		columns : [ [{
			field : 'wName',
			title : '库点位置',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'houseid',
			title : '仓号',
			align : 'left',
			editor : 'text',
			width: 150,
			formatter:function(value){
				return value.split(",")[1]
			}
		}, {
			field : 'title',
			title : '作业标题',
			width: 150
		}, {
			field : 'content',
			title : '作业内容',
			width: 150
		}, {
			field : 'stime',
			title : '开始时间',
			width: 250,
			formatter:function(value){
				
				return new Date(value).format("yyyy-MM-dd hh:mm:ss");
			}
		}, {
			field : 'etime',
			title : '结束时间',
			width: 250,
			formatter:function(value){
				
				return new Date(value).format("yyyy-MM-dd hh:mm:ss");
			}
		}, {
			field : 'operator',
			title : '操作人',
			width: 150
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
			content : rootPath + "/chucangzuoyexinxi/messageAddPage.shtml",
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
				content : rootPath + '/chucangzuoyexinxi/messageEditPage.shtml?id='+ selectRow.id,
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
				var url = rootPath + '/chucangzuoyexinxi/deleteStoreMsg.shtml';
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

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
