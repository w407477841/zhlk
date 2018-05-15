var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/reportHarbor/findAdditionalByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		sortName : 'bId',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'bId',
			title : '单据号',
			sortable : true,
			width: 80
		}, {
			field : 'userName',
			title : '单位',
			sortable : true,
			width: 150
		}, {
			field : 'grainVariety',
			title : '粮食品种',
			sortable : true,
			width: 110
		}, {
			field : 'grossWeight',
			title : '毛重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'tare',
			title : '皮重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'trueWeight',
			title : '结算总量(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'sumMoney',
			title : '结算金额(元)',
			sortable : true,
			width: 60
		}, {
			field : 'inOrOut',
			title : '出库/入库',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == '1'){  
					return '<span style="color:green;">出库</span>';  
				}else{
					return '<span style="color:blue;">入库</span>'; 
				}
			}
		}, {
			field : 'payStatus',
			title : '结算状态',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == '待结算'){  
					return '<span style="color:blue;">'+val+'</span>';  
				}else{
					return '<span style="color:green;">'+val+'</span>'; 
				}
			}
		}
		] ]
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
	$("#inAddFun").click("click",function(){
		addInUI();
		});
	$("#outAddFun").click("click",function(){
		addOutUI();
	});
	$("#deleFun").click("click",function(){
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
/**
 * 入库报港
 */

function addInUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/reportHarbor/additionalAddUI.shtml?inOrOut=2',
		end :function(){
			grid.datagrid("reload");
		}
	});
}
/**
 * 出库报港
 */
function addOutUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/reportHarbor/additionalAddUI.shtml?inOrOut=1',
		end :function(){
			grid.datagrid("reload");
		}
	});
}


/**
 * 删除
 */
function del(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		if(selectRow.payStatus == '待结算'){
			layer.confirm('确认删除？', function(index) {
				var url = rootPath + '/reportHarbor/additionalDelete.shtml';
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
			layer.msg("数据不允许删除");
		}
	}else{
		layer.msg("请选择一行");
	}
}
/**
 * 查看
 * @param id
 */
function look(id){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/car/look.shtml?id='+id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}

