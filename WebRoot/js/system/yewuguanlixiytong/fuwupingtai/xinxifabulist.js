var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'xinxifabu/findByPage.shtml',
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
			field : 'irTitle',
			title : '信息标题',
			sortable : true,
			width: 300
		}, {
			field : 'itName',
			title : '信息类型',
			sortable : true,
			width: 150
		}, {
			field : 'userName',
			title : '发布人',
			sortable : true,
			width: 100
		}, {
			field : 'irAddDate',
			title : '发布日期',
			sortable : true,
			width: 100
		}, {
			field : 'irLevel',
			title : '状态',
			sortable : true,
			width: 100,
			formatter:function formatprice(val,row){ 
				if (val > 0){  
					return '<span style="color:red;">置顶</span>';  
				}else{  
					return '<span style="color:green;">正常</span>';  
				}
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
	$("#addFun").click("click",function(){
		addUI();
		});
	
	$("#editFun").click("click",function(){
		editUI();
		});
	$("#deleFun").click("click",function(){
		del();
	});
	$("#upFun").click("click",function(){
		up();
	});
	$("#downFun").click("click",function(){
		down();
	});
	$("#lookFun").click("click",function(){
		look();
	});
});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "85%", "600px"],
		offset:"40px",
		content : rootPath + '/xinxifabu/addUI.shtml',
		end :function(){
			grid.datagrid("reload");
		}
	});
}
/**
 * 打开edit页面
 */
function editUI(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/xinxifabu/editUI.shtml?id='+selectRow.id,
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
function del(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	layer.confirm('确认删除？', function(index) {
		var url = rootPath + '/xinxifabu/delete.shtml';
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
function look(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/xinxifabu/lookUI.shtml?id='+selectRow.id,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("请选择一行");
		
	}
}
function up(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		var process = selectRow.irLevel;
		if(process > 0){
			layer.msg("数据无法进行置顶操作");
		}else{
			layer.confirm('确认置顶？', function(index) {
				var url = rootPath + '/xinxifabu/up.shtml';
				var s = CommnUtil.ajax(url, {id:selectRow.id
				}, "json");
				if (s == "success") {
					grid.datagrid('acceptChanges');
					layer.msg('置顶成功');
					grid.datagrid("reload");
				} else {
					grid.datagrid('rejectChanges');
					layer.msg('置顶失败');
				}
			});
		}
	
	}else{
		layer.msg("请选择一行");
	}
}

function down(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		var process = selectRow.irLevel;
		if(process < 1){
			layer.msg("数据无法取消置顶操作");
		}else{
			layer.confirm('确认取消置顶？', function(index) {
				var url = rootPath + '/xinxifabu/down.shtml';
				var s = CommnUtil.ajax(url, {id:selectRow.id
				}, "json");
				if (s == "success") {
					grid.datagrid('acceptChanges');
					layer.msg('取消置顶成功');
					grid.datagrid("reload");
				} else {
					grid.datagrid('rejectChanges');
					layer.msg('取消置顶失败');
				}
			});
		}
	
	}else{
		layer.msg("请选择一行");
	}
}