var grid;
var pageii;
var searchParams;
function queryWeight(id) {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'storage/billList_Page.shtml?id1='+id,
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
			field : 'id',
			title : '流水单号',
			width: 200
		}, {
			field : 'TotalWeight',
			title : '毛重(KG)',
			width: 150,
			formatter:function(value){
				return Math.abs(value)
			}
		}, {
			field : 'CarWeight',
			title : '皮重(KG)',
			width: 150,
			formatter:function(value){
				return Math.abs(value)
			}
		}, {
			field : 'CarID',
			title : '车牌号',
			width: 150
		}, {
			field : 'OWNER',
			title : '货主',
			width: 150
		}, {
			field : 'TotalWeightingTime',
			title : '称毛重时间',
			width: 250
		}, {
			field : 'CarWeightingTime',
			title : '称皮重时间',
			width: 250
		}, {
			field : 'Payway',
			title : '是否补录',
			width: 250,
			formatter:function(value){
				
				return value=="3"?"补录数据":"--"
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
			content : rootPath + "/foodStorageManager/wind/addPage.shtml",
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
				content : rootPath + '/foodStorageManager/wind/editPage.shtml?id='+ selectRow.id,
				end : function() {
					grid.datagrid("reload");
				}
			});
		} else {
			alert("未选择一行");

		}
	});
	
	/**
	 * 导出
	 */
	$("#export").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if(!selectRow){
			layer.alert("未选择一行") ;return false
		} 
		window.open("/zhlk/gridReport/records/wind.jsp?id="+selectRow.id)
	});

	

	
}

/**
 * 删除行，失败后还原。 ps如果 有修改但未提交的数据，也会还原。
 * 
 * @param rowindex
 * @param id
 */
function deleteWind(rowindex, id) {
	layer.confirm('确认删除？', function(index) {
		grid.datagrid('deleteRow', rowindex);
		var url = rootPath + '/foodStorageManager/deleteWind.shtml';
		var s = CommnUtil.ajax(url, {id : id}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('删除成功');
			
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('删除失败');
		}
	});
	
}



