var gridr;
var pageii;
$(function() {
	gridr = $('#magazineGrid').datagrid({
		url : rootPath+'/config/findRFIDByPage.shtml',
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
			width: 120
		}, {
			field : 'COMNum',
			title : '串口号',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				return 'COM'+val;  
			}
		}, {
			field : 'baudRate',
			title : '波特率',
			sortable : true,
			width: 80,
			formatter:function formatprice(val,row){ 
				if(val == 0){
					return "9600bps";
				} else if(val == 1){
					return "19200bps";
				} else if(val == 2){
					return "38400bps";
				} else if(val == 5){
					return "57600bps";
				} else if(val == 6){
					return "115200bps";
				}  
			}
		}, {
			field : 'startAddress',
			title : '起始地址',
			sortable : true,
			width: 60
		}, {
			field : 'wordNum',
			title : '数字',
			sortable : true,
			width: 60
		}, {
			field : 'remark',
			title : '备注',
			sortable : true,
			width: 150
		},{
			field : '_operate',
			title : '操作',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				return "<button type='button' class='btn btn-danger' onclick='deleteRFID("+row.id+")'>删除</button>";
			}
		}
		] ]
	});
});

gridr.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
function deleteRFID(id){
	layer.confirm('确认删除？', function(index) {
		var url = rootPath + '/config/deleteRFIDConfig.shtml';
		var s = CommnUtil.ajax(url, {id:id
		}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('删除成功');
			gridr.datagrid("reload");
		} else {
			gridr.datagrid('rejectChanges');
			layer.msg('删除失败');
		}
	});
}