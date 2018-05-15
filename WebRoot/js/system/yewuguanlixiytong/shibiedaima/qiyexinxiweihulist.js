var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'qiyexinxiweihu/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		
		multiSort : false,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'eName',
			title : '企业名称',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'eGroupCode',
			title : '组织机构代码',
			width: 150
		}, {
			field : 'eAddrCode',
			title : '行政区划代码',
			
			width: 150
		}, {
			field : 'eNature',
			title : '企业性质',
			width: 150
		}, {
			field : 'eClassify',
			title : '企业经营种类',
			width: 150
		}, {
			field : 'eLocation',
			title : '联系地址',
			width: 150
		}, {
			field : 'ePerson',
			title : '法人名称',
			width: 150
		}, {
			field : 'ePhone',
			title : '联系电话',
	
			width: 150
		}, {
			field : 'eCredit',
			title : '资信情况',
			width: 150
		},{  						
			field: '_code',
			title: '识别码',
			width: 150, 
			align: 'left',
			formatter:function(value,row,index){
				return "<button class='btn btn-info btn-sm' onclick='shibiema("+row.id+")' ><i class='fa fa-qrcode'></i> </button> " ;
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
			if(rowIndex!=lastIndex) { //当选中的不是该行 
	    		if(lastIndex!=-1) grid.datagrid('endEdit',lastIndex);//不是第一次点击时
	    		if(!CommnUtil.in_array(updateColumn,field)) { grid.datagrid('unselectAll');    return;} //不是需要修改的字段
	    		grid.datagrid('beginEdit', rowIndex);
	    		lastIndex=rowIndex;
	    	}
	    	else{//当选中的还是该行，但不是需要修改的字段，则结束修改。
	    		if(!CommnUtil.in_array(updateColumn,field)){
	    			grid.datagrid('endEdit',lastIndex);
	    			grid.datagrid('unselectAll');
	    			lastIndex=-1;
	    		}
	    	}
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
	
	$("#del").click("click",function(){
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
function edit(rowindex){
	var row = grid.datagrid('getData').rows[rowindex];
	layer.confirm('确认修改？', function(index) {
		var url = rootPath + '/user/editListOne.shtml';
		var s = CommnUtil.ajax(url, {id:row.id,name:row.name,roleKey:row.roleKey,description:row.description
		}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('修改成功');
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('修改失败');
		}
	});
	
}



/**
 * 删除行，失败后还原。 
 * ps如果 有修改但未提交的数据，也会还原。
 * @param rowindex
 * @param id
 */
function del(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		layer.confirm('确认删除？', function(index) {
			var url = rootPath + '/qiyexinxiweihu/deleteOne.shtml';
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
 * 插销
 * 插销更改后未保存的所有记录
 */
function cancel(){
	grid.datagrid('rejectChanges');
}
/**
 * 打开add页面
 */
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		content : rootPath + '/qiyexinxiweihu/addUI.shtml',
		end :function(){
			grid.datagrid("reload");
		}
	});
}

function shibiema(id){
	pageii = layer.open({
		title : "<h5><i class='fa fa-qrcode'></i>识别码<h5>",
		type : 2,
		maxmin :true,
		area : [ "400px", "400px" ],
		content : rootPath + '/qiyexinxiweihu/shibiemaUI.shtml?id='+id,
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
		content : rootPath + '/qiyexinxiweihu/editUI.shtml?id='+selectRow.id,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("请选择一行");
		
	}
}



