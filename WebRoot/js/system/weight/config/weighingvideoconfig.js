var gridv;
var pageii;
$(function() {
	gridv = $('#magazine').datagrid({
		url : rootPath+'/config/findWeighingVideoByPage.shtml',
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
			field : 'ipAddr',
			title : 'IP地址',
			sortable : true,
			width: 120
		}, {
			field : 'ipPort',
			title : 'IP端口号',
			sortable : true,
			width: 60
		}, {
			field : 'userName',
			title : '用户名',
			sortable : true,
			width: 80
		}, {
			field : 'throughPort',
			title : '通道号',
			sortable : true,
			width: 60
		}, {
			field : 'turnWeighing',
			title : '轮询称重',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if(val == '1'){
					return "<font color='green'>启用</font>";
				} else if(val == '2'){
					return "<font color='red'>禁止</font>";
				}
			}
		},{
			field : 'printType',
			title : '逐条打印',
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
		width: 150
		}, {
			field : '_operate',
			title : '操作',
			sortable : true,
			width: 100,
			formatter:function formatprice(val,row){ 
				return "<button type='button' class='btn btn-danger' onclick='deleteFunv("+row.id+")'>删除</button>";
			}
			}
		] ],
		onDblClickRow: function(index,row){
			$("#ipAddress").val(row.ipAddr);
			$("#ipPort").val(row.ipPort);
			$("#userName").val(row.userName);
			$("#password").val(row.password);
			$("#szRemark").val(row.remark);
			$("#macaddress").val(row.mac);
			$("#throughPort").val(row.throughPort);
			$("#screenshotPath").val(row.screenshotPath);
			$("#weighingVideoid").val(row.id);
			if(row.turnWeighing == '1'){
				//当移除之后在添加，属性添加，但补显示选中状态
				//$("#turnweighing").attr("checked",true);
				//$("#turnweighing").prop("checked","checked");
				
				$('#turnweighing').bootstrapSwitch('state', true);
			}else if(row.turnWeighing == '2'){
				$('#turnweighing').bootstrapSwitch('state', false);
			}
			if(row.printType == '1'){
				//$("#printType").prop("checked","checked");
				$('#printType').bootstrapSwitch('state', true);
			}else if(row.printType == '2'){
				//$("#printType").attr("checked",false);
				$('#printType').bootstrapSwitch('state', false);
			}
		}
	});
});

gridv.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

function deleteFunv(id){
	layer.confirm('确认删除？', function(index) {
		var url = rootPath + '/config/deleteWeighingVideoConfig.shtml';
		var s = CommnUtil.ajax(url, {id:id
		}, "json");
		if (s == "success") {
			gridv.datagrid('acceptChanges');
			layer.msg('删除成功');
			gridv.datagrid("reload");
		} else {
			gridv.datagrid('rejectChanges');
			layer.msg('删除失败');
		}
	});
}
