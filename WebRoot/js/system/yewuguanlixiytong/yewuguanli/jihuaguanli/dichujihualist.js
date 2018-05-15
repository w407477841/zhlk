var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'businessManager/queryPlans.shtml',
		method : 'POST',
		queryParams : searchParams,
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
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'planId',
			title : '计划编号',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'text',
			title : '粮食品种',
			width: 150
		}, {
			field : 'department',
			title : '下达单位',
			width: 150
		}, {
			field : 'totalAmount',
			title : '计划数量(kg)',
			width: 150
		}, {
			field : 'planedPrice',
			title : '价格(元/kg)',
			width: 150
		}, {
			field : 'type',
			title : '业务类型',
			width: 150,
			formatter:function(value,row){
				if(value=='1'){
					return "出库";
				}else if(value=='2'){
					return "入库";
				}
			}
		}, {
			field : 'planedTimeEnd',
			title : '计划完成时间',
			width: 150
		}, {
			field : 'loginIP5',
			title : '时间进度',
			width: 150,
			formatter:function(value,row,index){
				var d1=new Date(row.planedTimeStart+" 00:00:00");
				var d2=new Date(row.planedTimeEnd+" 23:59:59");
				var now=new Date();
				now=now>d2?d2:now;
				 return (now<d1)? "0.00%": ((now-d1)*100/(d2-d1)).toFixed(2)+"%";
			}
		}, {
			field : 'loginIP6',
			title : '数量进度',
			width: 150,
			formatter:function(value,row,index){
				var rate = (row.completedAmount*100/row.totalAmount).toFixed(2);
				if(rate>100){
					rate = 100;
				}else if(rate<0){
					rate = 0;
				}
				return rate+"%";
			}
		}
		] ],
		onBeforeLoad : function(param) {

		},
		onSortColumn : function(sort, order) {

		},
		onLoadSuccess : function(data) {
			grid.datagrid('getPager').pagination({
				displayMsg : '当前显示从{from}到{to},共{total}记录',
				onBeforeRefresh : function(pageNumber, pageSize) {
					$(this).pagination('loading');
					$(this).pagination('loaded');
				},
			});
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
	
	$("#addFun").click("click", function() {
		addUI();
	});

	$("#editFun").click("click", function() {
		editUI();
	});
	$("#delFun").click("click", function() {
		del();
	});

});

/**
 * 打开add页面
 */
function addUI() {
	var plan=document.getElementById("plans").value;
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		content : rootPath + "/businessManager/dichuadd.shtml?planType="+plan,
		end : function() {
			grid.datagrid("reload");
		}
	});
}

/**
 * 打开edit页面
 */
function editUI() {
	var selectRow = grid.datagrid('getSelected');
	var plan=document.getElementById("plans").value;
	if (selectRow) {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : rootPath + '/businessManager/dichuedit.shtml?id='+ selectRow.id+"&planType="+plan,
			end : function() {
				grid.datagrid("reload");
			}
		});
	} else {
		layer.msg("请选择一行");
	}
}

/**
 * 删除行，失败后还原。 ps如果 有修改但未提交的数据，也会还原。
 * 
 * @param rowindex
 * @param id
 */
function del(rowindex, id) {
	var selectRow = grid.datagrid('getSelected');
	if (selectRow) {
		layer.confirm('确认删除？', function(index) {
			var url = rootPath + '/businessManager/deleteOne.shtml';
			var s = CommnUtil.ajax(url, {id : selectRow.id}, "json");
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
		layer.msg("请选择一行");
	}
}

