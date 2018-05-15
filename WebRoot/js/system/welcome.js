var gridjc;
var searchParamsjc;
$(function() {
	searchParamsjc = $("#searchForm").serializeJson();
	gridjc = $('#magazineGridjc').datagrid({
		url : 'sensorManager/getCurrentDatas.shtml',
		method : 'POST',
		queryParams : searchParamsjc,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'kd',
			title : '库点',
			width: 140
		},{
			field : 'ck',
			title : '仓号',
			width: 80
		}, {
			field : 'cjsj',
			title : '采集时间',
			width: 200
		},{
			field:'yq',
			title : '氧气',
			width: 60
		}, {
			field:'eyht',
			title : '二氧化碳',
			width: 90
		}, {
			field:'lhq',
			title : '磷化氢',
			width: 80
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
		searchParamsjc = $("#searchForm").serializeJson();
		gridjc.datagrid({
			queryParams : searchParamsjc
		});
		gridjc.datagrid('getPager').pagination({
			displayMsg : '当前从{from}到{to},共{total}条记录',
			onBeforeRefresh : function(pageNumber, pageSize) {
				$(this).pagination('loading');
				$(this).pagination('loaded');
			},
		});
	});

});

gridjc.datagrid('getPager').pagination({
	displayMsg : '当前从{from}到{to},共{total}条记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

//
var gridbj;
var searchParamsbj;
$(function() {
	searchParamsbj = $("#searchForm").serializeJson();
	gridbj = $('#magazineGridbj').datagrid({
		url : 'sensorManager/getCurrentBaoJing.shtml',
		method : 'POST',
		queryParams : searchParamsbj,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'common',
			title : '报警内容',
			width: 200
		}, {
			field : 'cjsj',
			title : '报警时间',
			width: 100
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
		searchParamsbj = $("#searchForm").serializeJson();
		gridbj.datagrid({
			queryParams : searchParamsbj
		});
		gridbj.datagrid('getPager').pagination({
			displayMsg : '当前从{from}到{to},共{total}条记录',
			onBeforeRefresh : function(pageNumber, pageSize) {
				$(this).pagination('loading');
				$(this).pagination('loaded');
			},
		});
	});

});

gridbj.datagrid('getPager').pagination({
	displayMsg : '当前从{from}到{to},共{total}条记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

//
var gridkc;
var searchParamskc;
$(function() {
	searchParamskc = $("#searchForm").serializeJson();
	gridkc = $('#magazineGridkc').datagrid({
		url : 'store/findByPage.shtml',
		method : 'POST',
		queryParams : searchParamskc,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [{
			field : 'wlName',
			title : '库点',
			width: 140
		}, {
			field : 'wName',
			title : '仓号',
			width: 100
		}, {
			field : 'varity',
			title : '类别',
			width: 160
		}, {
			field : 'category',
			title : '粮食性质',
			width: 160
		}, {
			field : 'cangKu',
			title : '数量(kg)',
			width: 100
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
		searchParamskc = $("#searchForm").serializeJson();
		gridkc.datagrid({
			queryParams : searchParamskc
		});
		gridkc.datagrid('getPager').pagination({
			displayMsg : '当前从{from}到{to},共{total}条记录',
			onBeforeRefresh : function(pageNumber, pageSize) {
				$(this).pagination('loading');
				$(this).pagination('loaded');
			},
		});
	});

});

gridkc.datagrid('getPager').pagination({
	displayMsg : '当前从{from}到{to},共{total}条记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

