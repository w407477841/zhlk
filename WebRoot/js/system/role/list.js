var grid;
var pageii;
var searchParams;
var lastColumn;
var lastIndex=-1;
var updateColumn=['name','roleKey','description'];
$(function(){
	searchParams= $("#searchForm").serializeJson();
		grid=$('#magazineGrid').datagrid({
	    url: 'role/findRoleByPage.shtml',
	    method: 'POST',
	    queryParams: searchParams,
	    idField: 'id',
	    striped: true,
	    fitColumns: true,
	    singleSelect: true,
	    rownumbers: true,
	    pagination: true,
	    nowrap: false,
	    sortName:'roleKey',
	    sortOrder:'asc',
	    multiSort:true,
	    pageSize: 20,
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
	    columns: [[
	        { 
	        		field: 'name',
	        		title: '名称',
	        		width: 180,
	        		align: 'left',
	        		editor:'text'
	        			},
	        {
	        				field: 'roleKey',
	        				title: 'url',
	        				width: 150,
	        				sortable: true,
	        				align: 'left',
    						editor:'text'
	        					},
	        {  						
	        						field: 'description',
	        						title: '描述',
	        						width: 150,
	        						sortable: true,
	        						resizable:true,
	        						align: 'left',
	        						editor:{type:'text'}
	        					},
	        					   {  						
	        						field: '_option',
	        						title: '操作',
	        						width: 150, 
	        						align: 'left',
	        						formatter:function(value,row,index){
	        							return "<button class='btn btn-sm btn-warning' onclick='edit("+index+")' ><i class='glyphicon glyphicon-edit glyphicon-white'></i>修改</button> " +
	        									"<button class='btn btn-sm btn-danger' onclick='del("+index+","+row.id+")' ><i class='glyphicon glyphicon-remove glyphicon-white'></i>删除</button> " +
	        									"<button class='btn btn-sm btn-info' onclick='cancel()' ><i class='glyphicon glyphicon-arrow-left glyphicon-white'></i>撤销</button>";
	        						}
	        					}
	        					
	 
	    ]],
	    onBeforeLoad: function (param) {
	    	
	    },
	    onSortColumn: function (sort, order) {

        } ,
	    onLoadSuccess: function (data) {
	        
	    },
	    onLoadError: function () {
	        
	    },
	    onClickCell: function (rowIndex, field, value) {//点击单元格触发事件
	    	
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
		 grid.datagrid({ queryParams: searchParams }); 
			grid.datagrid('getPager').pagination({
			    displayMsg:'当前显示从{from}到{to},共{total}记录',
			    onBeforeRefresh:function(pageNumber, pageSize){
			     $(this).pagination('loading');
			     $(this).pagination('loaded');
			    },
			   });
	});
	
	$("#addFun").click("click",function(){
		addUI();
		});
	
	$("#editRes").click("click",function(){
			editResUI();
	});
	
});


	grid.datagrid('getPager').pagination({
    displayMsg:'当前显示从{from}到{to},共{total}记录',
    onBeforeRefresh:function(pageNumber, pageSize){
     $(this).pagination('loading');
     $(this).pagination('loaded');
    },
   });
	/**
	 * 修改当前点击行数据
	 * 修改失败后还原。
	 * ps如果 有修改但未提交的数据，也会还原。
	 * @param rowindex
	 */
function edit(rowindex){
	var row = grid.datagrid('getData').rows[rowindex];
	layer.confirm('确认修改？', function(index) {
		var url = rootPath + '/role/editListOne.shtml';
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
function del(rowindex,id){
	layer.confirm('确认删除？', function(index) {
		grid.datagrid('deleteRow',rowindex);
		var url = rootPath + '/role/deleteOne.shtml';
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
		content : rootPath + '/role/addUI.shtml',
		end :function(){
			grid.datagrid("reload");
		}
	});
}

function editResUI(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>角色授权<h5>",
			type : 2,
			maxmin :true,
			area : [ "800px", "600px" ],
			content : rootPath + '/role/editResUI.shtml?roleId='+selectRow.id,
			end :function(){
				grid.datagrid("reload");
			}
		});
		
	}else{
		layer.msg("请选择一行");
		
	}
}
