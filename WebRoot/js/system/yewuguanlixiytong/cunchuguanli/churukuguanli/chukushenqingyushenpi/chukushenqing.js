var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'chukushenqing/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : false,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'wlName',
			title : '粮库地点',
			width: 100
		},{
			field : 'wName',
			title : '仓号',
			width: 100
		},{
			field : 'gsaApplyBill',
			title : '申请单编号',
			width: 150
		}, {
			field : 'gsaSendOutDate',
			title : '发货日期',
			width: 150
		}, {
			field : 'gsaPurchaser',
			title : '买受人(需方)',
			width: 150
		}, {
			field : 'agreementID',
			title : '合同号',
			width: 150
		}, {
			field : 'gsaPaymentSituation',
			title : '货款到账情况',
			width: 150
		}, {
			field : 'gsaPlanOutWeight',
			title : '计划出库数量(kg)',
			width: 150
		}, {
			field : 'gsaCurrentWeight',
			title : '当前数量(kg)',
			width: 150
		}, {
			field : 'gsaApplyPerson',
			title : '申请人',
			width: 100
		}, {
			field : 'department',
			title : '所属部门',
			width: 150
		}, {
			field : 'gsaProcess',
			title : '状态',
			width: 100,
			formatter:function formatprice(val,row){ 
				if (val == "审批未通过"){  
					return '<span style="color:red;">'+val+'</span>';  
				}else if(val == "等待审批"){
					return '<span style="color:blue;">'+val+'</span>'; 
				}else if(val == "审批通过"){
					return '<span style="color:green;">'+val+'</span>'; 
				}else {  
					return val; 
				}
			}
		}, {
			field : 'gsaAddDate',
			title : '创建时间',
			width: 150
		}

		] ],
		onBeforeLoad : function(param) {

		},
		onSortColumn : function(sort, order) {

		},
		onLoadSuccess : function(data) {

		},
		onLoadError : function() {

		},
		onClickCell : function(rowIndex, field, value) {// 点击单元格触发事件

		}
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
	$("#addFun").click("click",function(){
		addUI();
		});
	
	$("#editFun").click("click",function(){
		editUI();
		});
	$("#deleFun").click("click",function(){
		del();
	});
	$("#approveFun").click("click",function(){
		approveFun();
	});
	$("#throughFun").click("click",function(){
		throughUI();
	});
	$("#lookFun").click("click",function(){
		look();
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
 * 打开新增页面
 */
function addUI(){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px"],
		offset:"40px",
		content : rootPath + '/chukushenqing/addUI.shtml',
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
		var process = selectRow.gsaProcess;
		if(process == '等待审批' || process =='审批通过'){
			layer.msg("数据无法进行编辑");
		}else{
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
				type : 2,
				maxmin :true,
				area : [ "1200px", "600px" ],
				offset:"40px",
				content : rootPath + '/chukushenqing/editUI.shtml?id='+selectRow.id,
				end :function(){
					grid.datagrid("reload");
				}
			});
		}
	}
	else{
		layer.msg("请选择一行");
		
	}
}
/**
 * 删除
 */
function del(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		var process = selectRow.gsaProcess;
		if(process =='审批通过'){
			layer.msg("数据无法进行删除");
		}else{
			layer.confirm('确认删除？', function(index) {
				var url = rootPath + '/chukushenqing/delete.shtml';
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
		}
	}else{
		layer.msg("请选择一行");
	}
}
/**
 * 提交审批
 */
function approveFun(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		var process = selectRow.gsaProcess;
		if(process == '等待审批' || process =='审批通过'){
			layer.msg("数据无法进行提交");
		}else{
			layer.confirm('确认提交？', function(index) {
				var url = rootPath + '/chukushenqing/approveById.shtml';
				var s = CommnUtil.ajax(url, {id:selectRow.id
				}, "json");
				if (s == "success") {
					grid.datagrid('acceptChanges');
					layer.msg('提交成功');
					grid.datagrid("reload");
				} else {
					grid.datagrid('rejectChanges');
					layer.msg('提交失败');
				}
			});
		}
		
	}else{
		layer.msg("请选择一行");
	}
}
/**
 * 打开审批意见
 */
function throughUI(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		var process = selectRow.gsaProcess;
		if(process == '审批未通过' || process =='审批通过'){
			pageii = layer.open({
				title : "<h5><i class='glyphicon glyphicon-link'></i>审批意见<h5>",
				type : 2,
				maxmin :true,
				area : [ "500px", "250px" ],
				offset:"40px",
				content : rootPath + '/chukushenqing/throughUI.shtml?id='+selectRow.id,
				end :function(){
					grid.datagrid("reload");
				}
			});
		}else{
			layer.msg("数据无审批意见");
		}
	}
	else{
		layer.msg("请选择一行");
		
	}
}
function look(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/chukushenqing/look.shtml?id='+selectRow.id,
		end :function(){
			grid.datagrid("reload");
		}
	});
	}
	else{
		layer.msg("请选择一行");
		
	}
}
