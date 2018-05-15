var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/version/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'cjsj',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'version',
			title : '版本号',
			sortable : true,
			width: 40
		}, {
			field : 'url',
			title : '下载地址',
			sortable : true,
			width: 180
		}, {
			field : 'type',
			title : '类型',
			sortable : true,
			width: 60
		}, {
			field : 'cre_time',
			title : '上传时间',
			sortable : true,
			width: 80
		}, {
			field : 'download_num',
			title : '下载量',
			sortable : true,
			width: 40
		}, {
			field : 'scription',
			title : '工程描述',
			sortable : true,
			width:100,
			formatter:function formatprice(val,row){ 
				if (val.length>15){  
					return val.substring(0,15)+"...";  
				}else{
					return val; 
				}
			}
		}
		] ],
		onDblClickRow: function(index,row){
			lookUI(row);
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
	$("#upload").click("click",function(){
		uploadFile();
	});
	$("#code").click("click",function(){
		code();
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
		content : rootPath + '/version/addUI.shtml',
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
		content : rootPath + '/version/editUI.shtml?id='+selectRow.id,
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
		var url = rootPath + '/version/delete.shtml';
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

/**
 * 打开上传文件页面
 */
function uploadFile(){
	window.selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>文件上传<h5>",
			type : 2,
			maxmin : true,
			offset:['200px','400px'],
			area : [ "800px", "400px" ],
			content : rootPath + '/version/uploadFormFiles.shtml',
			end : function() {
				grid.datagrid("reload");
			}
		});
	} else {
		layer.msg("请选择一行");
	}
}
/**
 * 打开上传文件页面
 */
function code(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>二维码<h5>",
		type : 2,
		maxmin : true,
		offset:['200px','400px'],
		area : [ "360px", "400px" ],
		content : rootPath + '/version/code.shtml',
		end : function() {
			grid.datagrid("reload");
		}
	});
}
