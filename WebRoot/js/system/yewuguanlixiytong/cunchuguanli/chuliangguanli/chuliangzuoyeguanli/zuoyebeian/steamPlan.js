var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'foodStorageManager/querySteamPlan.shtml',
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
			field : 'bill',
			title : '备案编号',
			width: 170
		}, {
			field : 'mName',
			title : '药剂名称',
			width: 120,
			formatter:function(value){
				if(value !=null){
					return value.split(",")[1];
				}
			}
		}, {
			field : 'mType',
			title : '类型/型号',
			width: 120
		}, {
			field : 'mAmount',
			title : '领取数量',
			width: 100
		}, {
			field : 'mUseAmount',
			title : '施药量(kg)',
			width: 100
		}, {
			field : 'mPerson',
			title : '领取人',
			width: 100
		}, {
			field : 'charge',
			title : '负责人',
			width: 100
		}, {
			field : 'cconcator',
			title : '联系电话',
			width: 150
		}, {
			field : 'filler',
			title : '填表人',
			width: 100
		}, {
			field : 'fconcator',
			title : '填表人联系电话',
			width: 170
		}, {
			field : 'timeCreate',
			title : '创建时间',
			width: 150
		}, {
			field : 'status',
			title : '备案状态',
			width: 150,
			formatter:function(value){
				switch(value){
				case "0":return "<font color='red'>未上传</font>"; break;
				case "1": return "<font color='green'>已上传</font>"; break;
				}
			}
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
		onClickCell : function(rowIndex, field, value) {

		}
	});

	$("#search").click("click", function() {
		// 绑定查询按扭
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
			content : rootPath + "/foodStorageManager/steamPlan/addPage.shtml",
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
				content : rootPath + '/foodStorageManager/steamPlan/editPage.shtml?id='+ selectRow.id,
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
	$("#delete").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			layer.confirm('确认删除？', function(index) {
				var url = rootPath + '/foodStorageManager/deleteSteamPlan.shtml';
				var s = CommnUtil.ajax(url, {id : selectRow.id}, "json");
				if (s == "success") {
					grid.datagrid('acceptChanges');
					layer.msg('删除成功');
					
				} else {
					grid.datagrid('rejectChanges');
					layer.msg('删除失败');
				}
				grid.datagrid("reload");
			});
			
		} else {
			layer.msg("请选择一行");

		}
	});	

	/**
	 * 打开上传文件页面
	 */
	$("#upload").click("click", function() {
		selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>文件上传<h5>",
				type : 2,
				maxmin : true,
				offset:['200px','400px'],
				area : [ "800px", "400px" ],
				content : rootPath + '/foodStorageManager/uploadFiles.shtml?id='+ selectRow.id,
				end : function() {
					grid.datagrid("reload");
				}
			});
		} else {
			layer.msg("请选择一行");

		}
	});
	
	/**
	 * 打开下载文件页面
	 */
	$("#download").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			if(selectRow.status=="0") {
				layer.msg("备案未上传!");
				return false;
			}else{
				location.href=rootPath + "/foodStorageManager/download.shtml?id="+selectRow.files;
			}
		} else {
			layer.msg("请选择一行");
		}
	});
});





