var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'businessManager/queryAgreements.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'loginTime',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'agreementID',
			title : '合同编号',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'soldOnes',
			title : '出卖人',
			sortable : true,
			width: 150
		}, {
			field : 'buyOnes',
			title : '买售人',
			sortable : true,
			width: 150
		}, {
			field : 'varietyName',
			title : '品种',
			sortable : true,
			width: 150
		}, {
			field : 'propertyName',
			title : '粮食性质',
			sortable : true,
			width: 150
		}, {
			field : 'amounts',
			title : '粮食数量(公斤)',
			sortable : true,
			width: 150
		}, {
			field : 'signTime',
			title : '签订时间',
			sortable : true,
			width: 150
		}, {
			field : 'results',
			title : '履行结果',
			sortable : true,
			width: 150,
			formatter:function(value,row,index){
				switch (value){
				case "0": 
					return "未履行";
				case "1": 
					return	 "履行中";
				case "2": 
					return	 "已完成";
				
				}
				
			}
		}, {
			field : 'states',
			title : '合同状态',
			sortable : true,
			width: 150,
			formatter:function(value,row,index){
				switch (value){
				case "0": 
					return "未上传";
				case "1": 
					return	 "已上传";
				
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
	 * 打开上传文件页面
	 */
	$("#upload").click("click", function() {
		window.selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>文件上传<h5>",
				type : 2,
				maxmin : true,
				offset:['200px','400px'],
				area : [ "800px", "400px" ],
				content : rootPath + '/businessManager/uploadFiles.shtml?id='+ selectRow.id,
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
		if(selectRow.states=="0") {
			layer.msg("合同未上传!");
			return false;
		}
		if (selectRow) {
			location.href=rootPath + "/businessManager/download.shtml?id="+selectRow.files;
		} else {
			layer.msg("请选择一行");
		}
	});
	/**
	 * 生成合同
	 */
	$("#generate").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			var temp = selectRow.templates;
			if(temp != null && temp != ''){
				//var url = rootPath + '/businessManager/report.shtml';
				//CommnUtil.ajax(url, {id : selectRow.id}, "json");
				window.open(rootPath+"/businessManager/report.shtml?id="+selectRow.id);
			}else{
				layer.msg("此合同未选择模版");
			}
			
		} else {
			layer.msg("请选择一行");
		}
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
		content : rootPath + "/businessManager/agreementadd.shtml",
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
			content : rootPath + '/businessManager/agreementedit.shtml?id='+ selectRow.id,
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
			var url = rootPath + '/businessManager/deleteAgreement.shtml';
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
