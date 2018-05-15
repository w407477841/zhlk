var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'store/findStorageByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'source',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [{
			field : 'wlName',
			title : '粮库地点',
			width: 110,
			sortable:true
		}, {
			field : 'wName',
			title : '仓号',
			width: 110,
			sortable:true
		}, {
			field : 'category',
			title : '粮食性质',
			width: 110
		}, {
			field : 'varity',
			title : '粮食品种',
			width: 110
		}, {
			field : 'cangKu',
			title : '库存数量(kg)',
			width: 110,
			formatter:function formatprice(val,row){ 
				return parseFloat(val);  
			}
		}, {
			field : 'buyYear',
			title : '收获年度',
			width: 110
		}, {
			field : 'package',
			title : '包装方式',
			width: 110
		}
		] ]
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
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/store/addUI.shtml',
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
			content : rootPath + '/store/editUI.shtml?wId='+selectRow.storageID,
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
		if(selectRow.cangKu == null || selectRow.cangKu == '0'){
			layer.confirm('确认删除？', function(index) {
				var url = rootPath + '/store/delete.shtml';
				var s = CommnUtil.ajax(url, {wId:selectRow.storageID
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
			layer.msg("无法进行删除操作");
		}
	
	}else{
		layer.msg("请选择一行");
	}
}