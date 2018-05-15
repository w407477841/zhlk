var codeGrid;
var pageii;
var codeSearchParams;
var lastColumn;
var lastIndex=-1;
var resType = [{ "value": "0", "text": "目录" }, { "value": "1", "text": "菜单" }, { "value": "2", "text": "按钮" }];
var updateColumn=['name'];

var treeTable;
var codeItemSearchParams;
var selectedId;

$(function(){
	

	
	codeSearchParams= $("#searchCodeForm").serializeJson();
	
		codeGrid=$('#codeGrid').datagrid({
	    url: 'code/findCodeByPage.shtml',
	    method: 'POST',
	    queryParams: codeSearchParams,
	    idField: 'id',
	    striped: true,
	    fitColumns: true,
	    singleSelect: true,
	    rownumbers: true,
	    pagination: true,
	    nowrap: false,
	    sortName:'name',
	    sortOrder:'asc',
	    multiSort:true,
	    pageSize: 20,
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
	    columns: [[
	        { 
	        		field: 'name',
	        		title: '名称',
	        		width: 250,
	        		align: 'left',
	        		editor:'text'
	        			}, { 
	    	        		field: 'id',
	    	        		title: 'codeid',
	    	        		width: 80,
	    	        		align: 'left'
	    	        			},
	   
	        					   {  						
	        						field: '_option',
	        						title: '操作',
	        						width: '50%', 
	        						align: 'left',
	        						formatter:function(value,row,index){
	        							return "<button class='btn btn-warning btn-sm' data-saved='beginEdit' onclick='codeEdit("+index+",this)' ><i class='glyphicon glyphicon-edit glyphicon-white'></i>修改</button> " +
	        									"<button class='btn btn-danger btn-sm' onclick='codeDel("+index+","+row.id+")' ><i class='glyphicon glyphicon-remove glyphicon-white'></i>删除</button>" ;
	        									
	        						}
	        					}
	        					
	 
	    ]],
	    onBeforeLoad: function (param) {
	    	
	    },
	    onSortColumn: function (sort, order) {

        } ,
	    onLoadSuccess: function (data) {
	    	
	    	if(data.rows.length>0){
	    	codeGrid.datagrid("selectRow",0);
	    	  $("#codeid").val(data.rows[0].id);
	    	  codeItemSearchParams= $("#searchCodeItemForm").serializeJson();
	    		treeTable=$('#itemGrid').treegrid({
	    				url: 'code/findCodeItemTreeGrid.shtml',
	    			    idField:'value',
	    			    treeField:'text',
	    			    fitColumns:true,
	    			    queryParams: codeItemSearchParams,
	    			    striped: true,
	    			    nowrap: false,
	    			    columns:[[
	    					{title:'名称',field:'text',width:250,editor:'text'},
	    					{title:'编码',field:'id',width:80,editor:'text'},
	    					 {  						
	    						field: '_option',
	    						title: '操作',
	    						width: 200, 
	    						align: 'left',
	    						formatter:function(value,row,index){
	    							return "<button class='btn btn-warning btn-sm' data-saved='beginEdit' onclick='codeItemEdit("+row.value+",this)' ><i class='glyphicon glyphicon-edit glyphicon-white'></i>修改</button> " +
	    									"<button class='btn btn-danger btn-sm' onclick='deleteAll("+row.value+")' ><i class='glyphicon glyphicon-remove glyphicon-white'></i>删除</button>" ;
	    									
	    						}
	    					}
	    			    ]],onLoadSuccess:function(row,data){
	    			    },
	    			     onSelect: function (rowIndex, rowData) {
	    			    	 if(selectedId){//已被选中
	    			    		 if( selectedId==rowIndex.value)//与之前选择一致
	    			    		 {
	    			    			 if(treeTable.treegrid('find',selectedId)){//排除被删除可能
	    				    			 treeTable.treegrid("unselect",selectedId);
	    				    			}
	    			    			 selectedId=null;
	    			    		 }
	    			    		 else {//与之前选择不一致，代码顺序不能换
	    			    			if(treeTable.treegrid('find',selectedId)){//排除被删除可能
	    			    			 treeTable.treegrid("unselect",selectedId);
	    			    			}
	    			    			 selectedId=null;
	    			    			 treeTable.treegrid("select",rowIndex.value);//该语句会执行OnSelect事件
	    			    			 
	    			    		 }
	    			    	 }else{
	    			    		 selectedId=rowIndex.value;
	    			    	 }
	    			    }
	    			});
	    		
	    	
	    	
	    	
	    	}
	    	
	    	
	    	
	    	
	    	
	    	
	    },
	    onLoadError: function () {
	        
	    },
	    onClickCell: function (rowIndex, field, value) {//点击单元格触发事件
	    var row = codeGrid.datagrid('getData').rows[rowIndex];
	    if(row&&row.id){
	    $("#codeid").val(row.id);
	    $("#itemGrid").treegrid({ queryParams: $("#searchCodeItemForm").serializeJson() }); 
	    $("#itemGrid").treegrid("unselectAll");
	    }
	    }
	});
	
		
	
		
	
	$("#searchCode").click("click", function() {// 绑定查询按扭
		 codeSearchParams = $("#searchCodeForm").serializeJson();
		 codeGrid.datagrid({ queryParams: codeSearchParams }); 
			codeGrid.datagrid('getPager').pagination({
			    displayMsg:'当前显示从{from}到{to},共{total}记录',
			    onBeforeRefresh:function(pageNumber, pageSize){
			     $(this).pagination('loading');
			     $(this).pagination('loaded');
			    },
			   });
	});
	
	$("#codeAddFun").click("click",function(){
		codeAdd();
		});
});


	codeGrid.datagrid('getPager').pagination({
    displayMsg:'当前显示从{from}到{to},共{total}记录',
    onBeforeRefresh:function(pageNumber, pageSize){
     $(this).pagination('loading');
     $(this).pagination('loaded');
    },
   });
	/**
	 * 修改当前点击行数据
	 */
function codeEdit(rowindex,btn){
	var saved=$(btn).attr("data-saved");
	if(saved=='beginEdit'){
		codeGrid.datagrid("beginEdit",rowindex);
	$(btn).html("<i class='glyphicon glyphicon-save glyphicon-white'></i>保存");
	$(btn).attr("data-saved","endEdit");
	}else{
		codeGrid.datagrid("endEdit",rowindex);
		$(btn).html("<i class='glyphicon glyphicon-edit glyphicon-white'></i>修改");
		$(btn).attr("data-saved","beginEdit");	
	
		var row = codeGrid.datagrid('getData').rows[rowindex];
		layer.confirm('确认修改？', function(index) {
			var url = rootPath + '/code/editCodeListOne.shtml';
			var s = CommnUtil.ajax(url, {id:row.id,name:row.name}, "json");
			if (s == "success") {
				layer.msg('修改成功');
				codeGrid.datagrid("reload");
			} else {
				layer.msg('修改失败');
			}
		});
		
		
	}
	}



/**
 * 删除行，失败后还原。 
 * ps如果 有修改但未提交的数据，也会还原。
 * @param rowindex
 * @param id
 */
function codeDel(rowindex,id){
	if(id){
	
	layer.confirm('确认删除？', function(index) {
		//添加保存点
		codeGrid.datagrid('acceptChanges');
		codeGrid.datagrid('deleteRow',rowindex);
		var url = rootPath + '/code/deleteCodeOne.shtml';
		var s = CommnUtil.ajax(url, {id:id
		}, "json");
		if (s == "success") {
			layer.msg('删除成功');
			layer.close(index);
		} else {
			//返回保存点
			codeGrid.datagrid('rejectChanges');
			layer.msg('删除失败');
			layer.close(index);
		}
		
	});
	}else{
		layer.confirm('确认删除？', function(index) {
			codeGrid.datagrid('acceptChanges');
			codeGrid.datagrid('deleteRow',rowindex);
			layer.close(index);
		});
		
	}
	
}
	
/**
 * 打开添加页面
 */
function codeAdd(){
codeGrid.datagrid("appendRow",{});
}


	function formatType(val,row){
		if (val ==0){
			return  '<font color="red">目录</font>';
		} else if(val==1){
			return '<font color="blue">菜单</font>';}
			else {
				return '<font color="green">按钮</font>';	
			}
	}
