var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'businessManager/queryAgreementForm.shtml',
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
			field : 'fName',
			title : '模版名称',
			width: 150
		}, {
			field : 'fFile',
			title : '模版文件',
			sortable : true,
			width: 150,
			formatter:function(value,row,index){
				if(value == null || value == ''){
					return "未上传模版";
				}else{
					return "已上传模版";					
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
		onClickCell : function(rowIndex, field, value) {// 点击单元格触发事件

		}
	});
	
	$("#addFun").click("click", function() {
		addUI();
	});
	$("#editFun").click("click", function() {
		editUI();
	});
	$("#delFun").click("click", function() {
		deleteAgreement();
	});
	$("#upload").click("click", function() {
		uploadFile();
	});
	$("#download").click("click", function() {
		downloadFile();
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
	

	
	

});

/**
 * 打开add页面
 */
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		content : rootPath + "/businessManager/agreementFormAdd.shtml",
		end : function() {
			grid.datagrid("reload");
		}
	});
}


/**
 * 打开edit页面
 */
function editUI(){
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : rootPath + '/businessManager/agreementFormEdit.shtml?id='+ selectRow.id,
			end : function() {
				grid.datagrid("reload");
			}
		});
	} else {
		layer.msg("请选择一行");

	}
}

/**
 * 删除行，失败后还原。 
 * 
 * @param rowindex
 * @param id
 */
function deleteAgreement() {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		layer.confirm('确认删除？', function(index) {
			var url = rootPath + '/businessManager/deleteAgreementForm.shtml';
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
			content : rootPath + '/businessManager/uploadFormFiles.shtml',
			end : function() {
				grid.datagrid("reload");
			}
		});
	} else {
		layer.msg("请选择一行");

	}
}

function downloadFile(){
	var selectRow = grid.datagrid('getSelected');
	
	if (selectRow) {
		if(selectRow.fFile != null && selectRow.fFile != ''){
			location.href=rootPath + "/businessManager/downloadFormFile.shtml?fileName="+selectRow.fFile;			
		}else{
			layer.msg("未上传模版!");
		}
		//location.href=rootPath + "/businessManager/download.shtml?id="+selectRow.files;
	} else {
		layer.msg("请选择一行");
	}
}