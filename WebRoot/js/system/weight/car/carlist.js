var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/car/findByPage.shtml',
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
			field : 'cId',
			title : '车牌号',
			sortable : true,
			width: 60
		}, {
			field : 'carType',
			title : '车型',
			sortable : true,
			width: 60
		}, {
			field : 'driver',
			title : '驾驶员',
			sortable : true,
			width: 60
		}, {
			field : 'driveLicense',
			title : '驾驶证',
			sortable : true,
			width: 80
		}, {
			field : 'phoneNumber',
			title : '联系方式',
			sortable : true,
			width: 60
		}, {
			field : 'RFID',
			title : '使用状态',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == null){  
					return '<span style="color:green;">未分配</span>';  
				}else{
					return '<span style="color:red;">分配使用中...</span>'; 
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

		},
		onDblClickRow: function(index,row){
			look(row.id);
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
	$("#createQCFun").click("click",function(){
		createQCFun();
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
 * 添加
 */

function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/car/addUI.shtml',
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
		if(selectRow.RFID != null){
			layer.msg("车辆正在使用中");
		}else{
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
				type : 2,
				maxmin :true,
				area : [ "1200px", "600px" ],
				offset:"40px",
				content : rootPath + '/car/editUI.shtml?id='+selectRow.id,
				end :function(){
					grid.datagrid("reload");
				}
			});
		}
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
		if(selectRow.RFID != null){
			layer.msg("车辆正在使用中");
		}else{
			layer.confirm('确认删除？', function(index) {
				var url = rootPath + '/car/delete.shtml';
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
		}
	}else{
		layer.msg("请选择一行");
	}
}
/**
 * 查看
 * @param id
 */
function look(id){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/car/look.shtml?id='+id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}
function createQCFun(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		if(selectRow.RFIDName=='二维码'){
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>分配<h5>",
				type : 2,
				maxmin :true,
				area : [ "400px", "530px" ],
				offset:"40px",
				content : rootPath + '/car/printQC.shtml?id='+selectRow.id,
				end :function(){
					grid.datagrid("reload");
				}
			});
		}else{
			layer.msg("未绑定二维码");
		}
	}else{
		layer.msg("请选择一行");
	}
}