var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/qitibaobiao/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'cjsj',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'wlName',
			title : '仓库地点',
			sortable : true,
			width: 150
		}, {
			field : 'wName',
			title : '仓号',
			sortable : true,
			width: 150
		}, {
			field : '_o2',
			title : '氧气',
			sortable : true,
			width: 150,
			formatter:function formatprice(val,row){ 
				var keys = row.lx.split(",");
				var values = row.datas.split(",");
				for(var i=0;i<keys.length;i++){
					if(keys[i] == 'o2'){
						return values[i];
					}
				}
			}
		}, {
			field : '_co2',
			title : '二氧化碳',
			sortable : true,
			width: 150,
			formatter:function formatprice(val,row){ 
				var keys = row.lx.split(",");
				var values = row.datas.split(",");
				for(var i=0;i<keys.length;i++){
					if(keys[i] == 'co2'){
						return values[i];
					}
				}
			}
		}, {
			field : '_ph3',
			title : '磷化氢(1)',
			sortable : true,
			width: 150,
			formatter:function formatprice(val,row){ 
				var keys = row.lx.split(",");
				var values = row.datas.split(",");
				for(var i=0;i<keys.length;i++){
					if(keys[i] == 'h3p'){
						return values[i];
					}
				}
			}
		}, {
			field : '_ph32',
			title : '磷化氢(2)',
			sortable : true,
			width: 150,
			formatter:function formatprice(val,row){ 
				var keys = row.lx.split(",");
				var values = row.datas.split(",");
				var flag = false;
				for(var i=0;i<keys.length;i++){
					if(keys[i] == 'h3p'){
						if(flag){
							return values[i];
						}else{
							flag = true;
						}
					}
				}
			}
		}, {
			field : 'cjsj',
			title : '采集时间',
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
	$("#createPDF").click("click", function() {
		var location = $("#location").val();
		var ck = $("#ck").val() || "";
		var cjsj = $("#cjsj").val();
		window.location.href = rootPath+ "/qitibaobiao/pdfExport.shtml?location="+ location + "&ck=" + ck+ "&cjsj=" + cjsj;
	});

});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
