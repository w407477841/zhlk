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
			field : 'status',
			title : '状态',
			width: 150,
			formatter:function(value){
				return CONFIGURE.STATUS[value];
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
			content : rootPath + "/foodStorageManager/project/addPage.shtml",
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
			if(selectRow.status!="2"&&selectRow.status!=3){
				layer.msg("请选择未提交或退回的记录!");
				return false;
			}
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
				type : 2,
				maxmin : true,
				area : [ "1200px", "600px" ],
				content : rootPath + '/foodStorageManager/project/editPage.shtml?id='+ selectRow.id,
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
				var url = rootPath + '/foodStorageManager/deleteProject.shtml';
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
	
	/**
	 * 更新数据状态
	 * 
	 * @param rowindex
	 * @param id
	 */
	$("#confirm").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if(!selectRow) {
			layer.msg("请选择一行");;
			return false;
		}
		if(selectRow.status!="3"&&selectRow.status!="2"){
			layer.msg("请选择未审批的方案");
			return false;
		}
		layer.confirm('确认提交审批？', function(index) {
			var url = rootPath + '/foodStorageManager/updateProject.shtml';
			var formData = new Object();
			formData["FoodStorageProjectFormMap.id"]=selectRow.id;
			formData["FoodStorageProjectFormMap.version"]=selectRow.version;
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
	
	/**
	 * 查看未通过原因
	 */
	$("#overview").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			$("#intext").val(selectRow.reason);
			layer.open({											
				title : "<h5><i class='glyphicon glyphicon-link'></i>退回原因<h5>",
				type : 1,
				maxmin : true,
				offset : '40px',
				area : [ "600px", "300px" ],
				content : $("#back")
			});
		} else {
			layer.msg("请选择一行");

		}
	});
	
	$("#print").click("click",function(){
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			if(selectRow.status == '1'){
				$.ajax({
					type : 'post',
					dataType : 'json',
					url : rootPath
							+ '/foodStorageManager/findProjrctPrintById.shtml',
					data : {
						id : selectRow.id
					},
					success : function(data) {
						if (data != null) {
							steamApplyPrint(data);
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
			}else{
				layer.msg("未经审核通过，不予打印！");
			}
		} else {
			layer.msg("请选择一行");
		}
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
		"0" : "<font color='blue'>审批中..</font>",
		"1" : "<font color='green'>通过</font>",
		"2" : "<font color='red'>退回</font>",
		"3":"<font color='blue'>未提交</font>"
	},
	list : function(type, index) {

	}
};