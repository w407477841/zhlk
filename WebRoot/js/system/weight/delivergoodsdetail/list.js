var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/deliverGoodsDetail/findByPage.shtml',
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
			field : 'agreementBill',
			title : '合同编号',
			sortable : true,
			width: 60
		}, {
			field : 'getoutBill',
			title : '出库单据号',
			sortable : true,
			width: 60
		}, {
			field : 'warehouseName',
			title : '仓号',
			sortable : true,
			width: 30
		}, {
			field : 'deliverGoodsNumberLower',
			title : '发货数量(吨)',
			sortable : true,
			width: 30
		}, {
			field : 'deliverGoodsDate',
			title : '发货日期',
			sortable : true,
			width: 30
		}, {
			field : 'takeDeliveryName',
			title : '收货单位',
			sortable : true,
			width: 80
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
	$("#print").click("click",function(){
		printFun();
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
				content : rootPath + '/deliverGoodsDetail/uploadFilesUI.shtml',
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
			if(selectRow.imagePath==null) {
				layer.msg("明细未上传!");
				return false;
			}else{
				location.href=rootPath + "/deliverGoodsDetail/download.shtml?id="+selectRow.imagePath;
				
			}
		} else {
			layer.msg("请选择一行");
		}
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
		content : rootPath + '/deliverGoodsDetail/addUI.shtml',
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
			content : rootPath + '/deliverGoodsDetail/editUI.shtml?id='+selectRow.id,
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
			var url = rootPath + '/deliverGoodsDetail/delete.shtml';
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
		content : rootPath + '/deliverGoodsDetail/look.shtml?id='+id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}
/**
 * 打印
 */
function printFun() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : rootPath
					+ '/deliverGoodsDetail/findById.shtml',
			data : {
				id : selectRow.id
			},
			success : function(data) {
				if (data != null) {
					deliverGoodsDetailPrint(data);
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
	} else {
		layer.msg("请选择一行");
	}
}
