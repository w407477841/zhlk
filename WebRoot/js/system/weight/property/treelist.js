var treeTable;
$(function() {
	treeTable = $('#treeTable').treegrid({
		url : rootPath +'/property/findAll.shtml',
		idField : 'id',
		treeField : 'text',
		fitColumns : true,
		striped : true,
		nowrap : false,
		columns : [ [ {
			title : '性质名称',
			field : 'text',
			width : 180
		}, {
			title : '是否启用',
			field : 'isEnable',
			width : 100,
			formatter: function (value, row, index) {
				if(value == '2'){
					return "<span style='color:green;'>启用</span>";
				} else {
					return "<span style='color:red;'>禁止</span>";
				}
			}
		}, {
			title : '启用/禁止',
			field : '_operator',
			width : 100,
			formatter: function (value, row, index) {
                if(row.children.length==0){
                	if(row.isEnable == '2'){
    					return '<button type="button" class="btn btn-xs btn-warning" onclick="changeStatus('+row.id+',1)">禁止</button>';
    				} else {
    					return '<button type="button" class="btn btn-xs btn-info" onclick="changeStatus('+row.id+',2)">启用</button>';
    				}
				}
			}
		}
		] ],
		onLoadSuccess : function(row, data) {
			treeTable.treegrid('collapseAll');
		}
	});
});


function changeStatus(id,status){
	var str = status =='1'?"禁用":"启用";
	
	layer.confirm('确认'+str+'？', function(index) {
		var url = rootPath + '/property/edit.shtml';
		var s = CommnUtil.ajax(url, {id:id,isEnable:status
		}, "json");
		if (s == "success") {
			layer.msg(str+'成功');
			treeTable.treegrid("reload");
		} else {
			layer.msg(str+'失败');
		}
	});
}
