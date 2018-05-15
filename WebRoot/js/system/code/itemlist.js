
$(function(){
	

	$("#addFun").click("click",function(){
		codeItemadd();
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
function codeItemadd(){
	var  node = treeTable.treegrid('getSelected');
	 var parentId;
	 if(node){
		 parentId=node.id;
	 }
	 else{
		 parentId="0";
	 }
	var url = rootPath + '/code/editCodeItemListOne.shtml';
	var s = CommnUtil.ajax(url, {parentId:parentId,codeid:$("#codeid").val()}, "json");
		if (s == "success") {
		treeTable.treegrid("reload");
		} 
	
}
function codeItemEdit(value,btn){
	var saved=$(btn).attr("data-saved");
	if(saved=='beginEdit'){
		treeTable.treegrid("beginEdit",value);
	$(btn).html("<i class='glyphicon glyphicon-save glyphicon-white'></i>保存");
	$(btn).attr("data-saved","endEdit");
	}else{
		treeTable.treegrid("endEdit",value);
		$(btn).html("<i class='glyphicon glyphicon-edit glyphicon-white'></i>修改");
		$(btn).attr("data-saved","beginEdit");	
		
		var row = treeTable.treegrid('find',value);
		layer.confirm('确认修改？', function(index) {
			var url = rootPath + '/code/editCodeItemListOne.shtml';
			var s = CommnUtil.ajax(url, {id:row.id,text:row.text,value:row.value,codeid:row.codeid,parentId:row.parentId}, "json");
			if (s == "success") {
				layer.msg('修改成功');
				treeTable.treegrid("reload");
			} else {
				layer.msg('修改失败');
			}
		});
		
		
	}
	
}


/**
 * 打开修改页面
 */
function deleteAll(id){
	
	arrayid=[];
	var selectRow;
	if(id){
		
	selectRow=treeTable.treegrid('find',id);
	}else{
	 selectRow= treeTable.treegrid('getSelected');
	 }
	if(selectRow)
	{	
		
		//将本身及所有child的id装入arrayid
		hasChild(selectRow);
		layer.confirm('是否删除？', function(index) {
			var url = rootPath + '/code/deleteCodeItemAll.shtml';
			var s = CommnUtil.ajax(url, {
				id : arrayid.join(",")
			}, "json");
			if (s == "success") {
				layer.msg('删除成功');
				treeTable.treegrid("reload");
				treeTable.treegrid("unselectAll");
			} else {
				layer.msg('删除失败');
			}
		});
	
}
	else{
		layer.msg('未选中一行');
		
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
	
	arrayid.push(obj.value);
}



	