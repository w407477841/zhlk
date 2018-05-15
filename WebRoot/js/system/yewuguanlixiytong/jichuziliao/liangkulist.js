var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'warehouseLocation/findByPage.shtml',
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
			field : 'id',
			title : '库点编号',
			sortable : true,
			width: 100
		}, {
			field : 'wName',
			title : '库点名称',
			sortable : true,
			width: 100
		}, {
			field : 'wFullName',
			title : '库点全称',
			sortable : true,
			width: 150
		}, {
			field : 'wLog',
			title : '经度',
			sortable : true,
			width: 70
		}, {
			field : 'wLat',
			title : '纬度',
			sortable : true,
			width: 70
		}, {
			field : 'wImage',
			title : '库点门户图',
			sortable : true,
			width: 100,
			formatter:function formatprice(val,row){ 
				if(val == null || val == ''){
					return "<font color='#A8A8A8'>暂无图片</font>";
				}else{
					return "<a href='javascript:void(0)' _href='"+val+"' onClick='layerImg(this)'>查看图片</a>";
				}
			}
		}, {
			field : 'wPlaneImage',
			title : '库点平面图',
			sortable : true,
			width: 100,
			formatter:function formatprice(val,row){ 
				if(val == null || val == ''){
					return "<font color='#A8A8A8'>暂无图片</font>";
				}else{
					return "<a href='javascript:void(0)' _href='"+val+"' onClick='layerImg(this)'>查看图片</a>";
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
	$("#upload1").click("click",function(){
		upload("1");
	});
	$("#upload2").click("click",function(){
		upload("2");
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
 * 打开添加页面
 */
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/warehouseLocation/addUI.shtml',
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
		content : rootPath + '/warehouseLocation/editUI.shtml?id='+selectRow.id,
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
		var url = rootPath + '/warehouseLocation/delete.shtml';
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


function upload(type){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>文件上传<h5>",
		type : 2,
		maxmin :true,
		offset:['200px','400px'],
		area : [ "800px", "400px" ],
		content : rootPath + '/warehouseLocation/upload.shtml?id='+selectRow.id+"&type="+type,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("请选择一行");
		
	}
}

function layerImg(obj){
	var path = $(obj).attr("_href");
	$("#showImg").show();
	$("#showImg").attr("src",rootPath+'/'+path);
	layer.open({
		  type: 1,
		  title: false,
		  area : [ "600px", "400px" ],
		  skin: 'layui-layer-nobg', //没有背景色
		  shadeClose: true,
		  content: $('#showImg')
	});
}