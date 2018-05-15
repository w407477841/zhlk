var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : 'foodStorageManager/queryProjects.shtml',
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
			field : 't',
			title : '标题',
			align : 'left',
			editor : 'text',
			width: 150,
			formatter:function(value,row,index){
				return row.wName+CONFIGURE.TYPE[row.type]+"方案";
			}
		}, {
			field : 'wlName',
			title : '粮库地点',
			width: 150
		}, {
			field : 'wName',
			title : '仓号',
			width: 150
		}, {
			field : 'text',
			title : '粮食品种',
			width: 150
		}, {
			field : 'type',
			title : '方案类型',
			width: 150,
			formatter:function(value){
				return CONFIGURE.TYPE[value];
			}
		}, {
			field : 'ctime',
			title : '创建时间',
			width: 190
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
	
	/**
	 * 打开确认页面
	 */
	$("#view").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			window.pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>审核<h5>",
				type : 2,
				maxmin : true,
				area : [ "1200px", "600px" ],
				content : rootPath + '/foodStorageManager/approve/approvePage.shtml?id='+ selectRow.id,
				end : function() {
					grid.datagrid("reload");
				}
			});
		} else {
			layer.msg("请选择一行");

		}
	});
	
	/**
	 * 更新数据状态
	 * 
	 * @param rowindex
	 * @param id
	 */
	$("#confirm").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if(!selectRow) {
			layer.msg("请选择一行");
			return false;
		}
		if(selectRow.status!="3"){
			layer.msg("请选择未审批的方案");
			return false;
		}
		layer.confirm('确认提交审批？', function(index) {
			var url = rootPath + '/foodStorageManager/updateProject.shtml';
			var formData = new Object();
			formData["FoodStorageProjectFormMap.id"]=selectRow.id;
			formData["FoodStorageProjectFormMap.status"]="0";
			var s = CommnUtil.ajax(url, formData, "json");
			if (s == "success") {
				grid.datagrid("reload");
				layer.msg('提交成功');
				
			} else {
				grid.datagrid('rejectChanges');
				layer.msg('提交失败');
			}
		});
		
});
	
});


/**
 * 获取类型和性质
 */
var CONFIGURE = {
	TYPE : {
		"0" : "通风",
		"1" : "熏蒸",
		"2" : "冷却",
	},
	STATUS : {
		"0" : "审批中",
		"1" : "通过",
		"2" : "退回",
		"3":"未提交"
	},
};