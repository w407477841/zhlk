var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'storage/quailtyDetail.shtml',
		method : 'POST',
		queryParams : {inorout:1},
		idField : 'id',
		striped : true,
		fitColumns : false,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'loginTime',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'createTime',
			title : '检验日期',
			align : 'left',
			editor : 'text',
			width: 150,
			formatter:function(value){
				return new Date(value).format("yyyy-MM-dd hh:mm:ss")
			}
		}, {
			field : 'breed',
			title : '品种',
			sortable : true,
			width: 70
		}, {
			field : 'loginIP2',
			title : '收获年度',
			sortable : true,
			width: 70,
			formatter:function(value){
				return "2016"
			}
		}, {
			field : 'carID',
			title : '车号(船号)',
			sortable : true,
			width: 100
		}, {
			field : 'weight',
			title : '实收数量(公斤)',
			sortable : true,
			width: 100
		}, {
			field : 'ID',
			title : '入库单编号',
			sortable : true,
			width: 110
		}, {
			field : 'Sf',
			title : '水分(%)',
			sortable : true,
			width: 50
		}, {
			field : 'Zz',
			title : '杂质(%)',
			sortable : true,
			width: 50
		}, {
			field : 'CCL',
			title : '出糙(%)',
			sortable : true,
			width: 50
		}, {
			field : 'Rz',
			title : '容重(g/l)',
			sortable : true,
			width: 50
		}, {
			field : 'Bwsld',
			title : '不完善粒(%)',
			sortable : true,
			width: 50
		}, {
			field : 'Hl',
			title : '黄粒(%)',
			sortable : true,
			width: 50
		}, {
			field : 'Gwcm',
			title : '谷外糙米(%)',
			sortable : true,
			width: 50
		}, {
			field : 'Zjml',
			title : '整精米粒(%)',
			sortable : true,
			width: 50
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
	
	$("#export").click("click", function() {
		var selectRow = grid.datagrid('getSelected');
		if (selectRow) {
			var href="/zhlk/gridReport/shouchuxitong/mm.jsp?id="+selectRow.ID;
			window.open(href);
		} else {
			alert("未选择一行");

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
