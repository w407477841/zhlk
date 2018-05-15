var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'dingxingguanli/findByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'qChangeTime',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'warehouse_location',
			title : '粮库地点',
			width: 150
		},{
			field : 'warehouse_id',
			title : '仓号',
			width: 150
		},  {
			field : 'qChangeTime',
			title : '转换时间',
			width: 150,
			sortable:true
		}, {
			field : 'qOldQualitative',
			title : '原性质',
			width: 150
		}, {
			field : 'qNewQualitative',
			title : '转后性质',
			width: 150
		}
		, {
			field : 'qComment',
			title : '备注',
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
	
	/**
	 * 打开add页面
	 */
	function addUI(){
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>定性<h5>",
			type : 2,
			maxmin :true,
			area : [ "1200px", "450px" ],
			content : rootPath + '/dingxingguanli/addUI.shtml',
			offset :'50px',
			end :function(){
				grid.datagrid("reload");
			}
		});
	}
	
});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});
