var grid;
var pageii;
$(function() {
	grid = $('#magazineSpeck').datagrid({
		url : rootPath+'/config/findWeighingSpeckByPage.shtml',
		method : 'POST',
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
		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'mac',
			title : 'MAC地址',
			sortable : true,
			width: 100
		}, {
			field : 'speechRate',
			title : '播放速度',
			sortable : true,
			width: 60
		}, {
			field : 'content',
			title : '播放格式',
			sortable : true,
			width: 200
		}, {
			field : 'isOpen',
			title : '是否开启',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if(val == '1'){
					return "<font color='green'>启用</font>";
				} else if(val == '2'){
					return "<font color='red'>禁止</font>";
				}
			}
		}, {
			field : 'remark',
			title : '备注',
			sortable : true,
			width: 100
		},{
			field : '_operate',
			title : '操作',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				return "<button type='button' class='btn btn-danger' onclick='deleteFun("+row.id+")'>删除</button>";
			}
			}
		] ],
		onDblClickRow: function(index,row){
			$("#macAddress").val(row.mac);
			$("#speechContent").val(row.content);
			$("#speechRemark").val(row.remark);
			$("#speechRate").attr("data-value",row.speechRate);
			$('#speechRate').slider({value:row.speechRate });
			
			if(row.isOpen == '1'){
				$('#isOpen').bootstrapSwitch('state', true);
			}else if(row.isOpen == '2'){
				$('#isOpen').bootstrapSwitch('state', false);
			}
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

function deleteFun(id){
	layer.confirm('确认删除？', function(index) {
		var url = rootPath + '/config/deleteWeighingSpeckConfig.shtml';
		var s = CommnUtil.ajax(url, {id:id
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
}
