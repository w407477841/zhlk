var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'yaojilingyongguanli/findByPage.shtml',
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
			field : 'wName',
			title : '粮库地点',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'muName',
			title : '药剂名称',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'muBrand',
			title : '品牌',
			sortable : true,
			width: 150
		}, {
			field : 'muStandard',
			title : '规格',
			sortable : true,
			width: 150
		}, {
			field : 'text',
			title : '单位',
			sortable : true,
			width: 150
		}, {
			field : 'muManufactureDate',
			title : '生产日期',
			sortable : true,
			width: 150
		}, {
			field : 'muQuantity',
			title : '领用数量',
			sortable : true,
			width: 150
		}, {
			field : 'muApplicant',
			title : '经办人',
			sortable : true,
			width: 150
		}, {
			field : 'muAuditor',
			title : '批核人',
			sortable : true,
			width: 150
		}, {
			field : 'muSupervisor',
			title : '使用监督人',
			sortable : true,
			width: 150
		}, {
			field : 'muUsedDate',
			title : '领用日期',
			sortable : true,
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
	
	$("#viewFun").click("click",function(){
		view();
	});
	$("#deleFun").click("click",function(){
		dele();
	});

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
/**
 * 查看
 */
function view(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
			type : 2,
			maxmin :true,
			area : [ "1200px", "600px" ],
			offset:"40px",
			content : rootPath + '/yaojilingyongguanli/view.shtml?id='+selectRow.id,
			end :function(){
				grid.datagrid("reload");
			}
		});
	}
	else{
		layer.msg("请选择一行");
		
	}
}
/**
 * 删除
 */
function dele(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	console.debug(layer.offset);
	layer.confirm('确认删除？<br><span style="color:red;">删除后领用数量将累加到药剂库存</span>', function(index) {
		//grid.datagrid('deleteRow',rowindex);
		var url = rootPath + '/yaojilingyongguanli/delete.shtml';
		var s = CommnUtil.ajax(url, {id:selectRow.id
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
	}else{
		layer.msg("请选择一行");
	}
}