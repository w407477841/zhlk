var treeTable;
$(function(){
	treeTable=$('#treeTable').treegrid({
			url:rootPath + '/mobile/resource/findResTreeGrid.shtml',
		    idField:'id',
		    treeField:'name',
		    fitColumns:true,
		    striped: true,
		    nowrap: false,
		    columns:[[
				{title:'菜单名称',field:'name',width:180},
				{title:'菜单顺序',field:'level',width:150},
				{title:'菜单描述',field:'description',width:180}
		    ]],onLoadSuccess:function(row,data){
		    	treeTable.treegrid('collapseAll');		    	
		    }
		});
	$("#addFun").click("click",function(){
		addUI();
		});

	$("#editFun").click("click",function(){
		editUI();
		});
	$("#deleteFun").click("click",function(){
		deleteAll();
		});
	
});


/**
 * 打开add页面
 */
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		content : rootPath + '/mobile/resource/addUI.shtml',
		end :function(){//关闭时执行
			treeTable.treegrid("reload");
		}
	});
}
/**
 * 打开修改页面
 */
function editUI(){
	var selectRow= treeTable.treegrid('getSelected');
	if(selectRow)
	{
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		content : rootPath + '/mobile/resource/editUI.shtml?id='+selectRow.id,
		end :function(){//关闭时执行
			treeTable.treegrid("reload");
		}
	});
}
	else{
		layer.msg('请选择一行');
		
	}
}


/**
 * 打开修改页面
 */
function deleteAll(){
	arrayid=[];
	var selectRow= treeTable.treegrid('getSelected');
	if(selectRow)
	{
		//将本身及所有child的id装入arrayid
		hasChild(selectRow);
		layer.confirm('是否删除？', function(index) {
			var url = rootPath + '/mobile/resource/deleteAll.shtml';
			var s = CommnUtil.ajax(url, {
				id : arrayid.join(",")
			}, "json");
			if (s == "success") {
				layer.msg('删除成功');
				treeTable.treegrid("reload");
			} else {
				layer.msg('删除失败');
			}
		});
		
}
	else{
		layer.msg('请选择一行');
		
	}
}

var arrayid=[];
function hasChild(obj){
	var childs= obj.children;
	if(childs.length>0){
		for(var i=0;i< childs.length;i++){
			hasChild(childs[i]);
		}
		
	}
	
	arrayid.push(obj.id);
}

	