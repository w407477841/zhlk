var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'zijinbaobiao/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
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
			field : 'accountName',
			title : '流水号',
			align : 'left',
			editor : 'text',
			width: 150
		}, {
			field : 'loginTime',
			title : '结算金额',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP1',
			title : '结算时间',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP2',
			title : '结算类型',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP3',
			title : '结算帐号',
			sortable : true,
			width: 150
		}, {
			field : 'loginIP4',
			title : '结算人员',
			sortable : true,
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

//	$("#search").click("click", function() {// 绑定查询按扭
//		searchParams = $("#searchForm").serializeJson();
//		grid.datagrid({
//			queryParams : searchParams
//		});
//		grid.datagrid('getPager').pagination({
//			displayMsg : '当前显示从{from}到{to},共{total}记录',
//			onBeforeRefresh : function(pageNumber, pageSize) {
//				$(this).pagination('loading');
//				$(this).pagination('loaded');
//			},
//		});
//	});
	$("#search").click("click", function() {
		//$("#searchForm").attr("action",rootPath + '/zijinbaobiao/createReport.shtml');
		//$("#searchForm").submit();
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: rootPath + '/zijinbaobiao/createReport.shtml',
		        data:$("#searchForm").serializeJson(),
		        success: function(data) {
		        	$("#pageIndex").attr("src",rootPath+data);
		        },
		        error: function(err) {
		        	
		        }
		    });
		
	});
	$("#createPDF").click("click", function() {
		$("#searchForm").attr("action",rootPath + '/zijinbaobiao/createPDFReport.shtml');
		$("#searchForm").submit();
	});
	$("#createExcel").click("click", function() {
		$("#searchForm").attr("action",rootPath + '/zijinbaobiao/createExcelReport.shtml');
		$("#searchForm").submit();
	});
	$("#createWord").click("click", function() {
		$("#searchForm").attr("action",rootPath + '/zijinbaobiao/createWordReport.shtml');
		$("#searchForm").submit();
	});
});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
