var grid;
var pageii;
var searchParams;

$(function() {
	searchParams= $("#searchForm").serializeJson();
	
	grid=$('#datagrid1').datagrid({
    url: 'cangkuzhinenghuaxitong/ammeterData/findDayList.shtml',
    method: 'POST',
    queryParams: searchParams,
    idField: 'id',
    striped: true,
    fitColumns: true,
    singleSelect: true,
    rownumbers: true,
    pagination: false,
    nowrap: false,
    sortName:'name',
    sortOrder:'asc',
    multiSort:true,
    pageSize: 20,
    pageList: [10, 20, 50, 100, 150, 200],
    showFooter: true,
    columns: [[
        { 
        		field: 'time',
        		title: '时间',
        		width: 180,
        		align: 'left'
        			},{field:'wName',title:'仓号',width:150},
        			{field:'energy0',title:'电表1',width:150},
        			{field:'energy1',title:'电表2',width:150},
        			{field:'energysum',title:'合计',width:150}
        					  
    ]],
    onBeforeLoad: function (param) {
    	
    },
    onSortColumn: function (sort, order) {

    } ,
    onLoadSuccess: function (data) {
    	//CommnUtil.exportgrid(grid);
    },
    onLoadError: function () {
        
    },
    onClickCell: function (rowIndex, field, value) {//点击单元格触发事件
    
    }
	});
	
	$("#search1").click("click", function() {// 绑定查询按扭
		 searchParams = $("#searchForm").serializeJson();
		 console.debug(searchParams);
		 grid.datagrid({ queryParams: searchParams,columns:[[
		                                                     { 
		                                                 		field: 'time',
		                                                 		title: '时间',
		                                                 		width: 180,
		                                                 		align: 'left'
		                                                 			},{field:'wName',title:'仓号',width:150},
		                                                 			{field:'energy0',title:'电表1能耗',width:150},
		                                                 			{field:'energy1',title:'电表2能耗',width:150},
		                                                 			{field:'energysum',title:'合计',width:150}
		                                                 					  
		                                             ]] }); 
		
	});
	
	$("#search2").click("click", function() {// 绑定查询按扭
		 searchParams = $("#searchForm").serializeJson();
		 console.debug(searchParams);
		 grid.datagrid({ queryParams: searchParams,columns:[[
		                                                     { 
		                                                 		field: 'time',
		                                                 		title: '时间',
		                                                 		width: 180,
		                                                 		align: 'left'
		                                                 			},{field:'wName',title:'仓号',width:150},
		                                                 			{field:'reading0',title:'电表1读数',width:150},
		                                                 			{field:'reading1',title:'电表2读数',width:150},
		                                                 			{field:'readingsum',title:'合计读数',width:150}
		                                                 					  
		                                             ]] }); 
		
	});
	$("#addFun").click("click",function(){
		addUI();
		});
	
	$("#editFun").click("click",function(){
		editUI();
		});
	
});


	
	


/**
* 删除行，失败后还原。 
* ps如果 有修改但未提交的数据，也会还原。
* @param rowindex
* @param id
*/
function del(rowindex,id){
	layer.confirm('确认删除？', function(index) {
		grid.datagrid('deleteRow',rowindex);
		var url = rootPath + '/cangkuzhinenghuaxitong/ammeterConfig/deleteOne.shtml';
		var s = CommnUtil.ajax(url, {id:id
		}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('删除成功');
			
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('删除失败');
		}
	});
	
}
	

/**
* 打开add页面
*/
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "880px", "600px" ],
		content : rootPath + '/cangkuzhinenghuaxitong/ammeterConfig/addUI.shtml',
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
		area : [ "660px", "600px" ],
		content : rootPath + '/cangkuzhinenghuaxitong/ammeterConfig/editUI.shtml?id='+selectRow.id,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("未选择一行");
		
	}
}
