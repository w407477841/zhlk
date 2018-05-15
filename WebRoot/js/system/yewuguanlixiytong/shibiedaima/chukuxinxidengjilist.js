var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'chukuxinxidengji/findByPage.shtml',
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
			field : 'code',
			title : '货位编码',
			align : 'left',
			editor : 'text',
			width: 100
		}, {
			field : 'location',
			title : '粮库地点',
			sortable : true,
			width: 150
		}, {
			field : 'houseid',
			title : '仓号',
			width: 100
		}, {
			field : 'roomName',
			title : '厫间名称',
			width: 100
		}, {
			field : 'positionName',
			title : '货位名称',
			width: 100
		}, {
			field : 'amounts',
			title : '出库时间',
			width: 150,
			formatter:function(value){
				return new Date(value).format("yyyy-MM-dd hh:mm:ss")
			}
		}, {
			field : 'amounts',
			title : '出库数量(kg)',
			width: 100
		}, {
			field : 'loginIP6',
			title : '详细信息',
			width: 70,
			formatter:function(value,row,index){
				return "<button class='btn btn-sm btn-info' onclick='shibiema("+row.id+")' ><i class='fa fa-qrcode'></i> </button> " ;
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
			content : rootPath + "/chukuxinxidengji/addUI.shtml",
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
				content : rootPath + '/chukuxinxidengji/editUI.shtml?id='+ selectRow.id,
				end : function() {
					grid.datagrid("reload");
				}
			});
		} else {
			layer.msg("请选择一行");

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
				var url = rootPath + '/chukuxinxidengji/deleteOne.shtml';
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
	layer.msg("请选择一行");

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

function shibiema(id){
	pageii = layer.open({
		title : "<h5><i class='fa fa-qrcode'></i>识别码<h5>",
		type : 2,
		maxmin :true,
		area : [ "400px", "400px" ],
		content : rootPath + '/chukuxinxidengji/shibiemaUI.shtml?id='+id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}
