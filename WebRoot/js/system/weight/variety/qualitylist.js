var grid;
var pageii;
$(function() {
	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/quality/findByVarietyId.shtml?id='+vId,
		method : 'POST',
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : false,
		nowrap : false,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'tName',
			title : '检测类型编号',
			sortable : true,
			width: 160
		}, {
			field : 'standard',
			title : '标准值',
			sortable : true,
			width: 160
		}, {
			field : 'miniValue',
			title : '最小区间',
			sortable : true,
			width: 160
		}, {
			field : 'maxiValue',
			title : '最大区间',
			sortable : true,
			width: 160
		}, {
			field : 'rank',
			title : '等级差',
			sortable : true,
			width: 160
		}, {
			field : 'reduceStandard',
			title : '扣量标准',
			sortable : true,
			width: 160
		}, {
			field : 'increaseRange',
			title : '增量幅度',
			sortable : true,
			width: 160
		}, {
			field : 'reduceValue',
			title : '扣量值',
			sortable : true,
			width: 160
		}, {
			field : 'increaseValue',
			title : '增量值',
			sortable : true,
			width: 160
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

		},
		onDblClickRow: function(index,row){
			look(row.id);
		}
	});
});
