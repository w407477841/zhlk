var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'storage/queryInstorages.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'basicid',   
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : '',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [{
			field : 'ID',
			title : '流水单号',
			width: 200
		},{
			field : 'Owner',
			title : '货主姓名',
			width: 150
		},{
			field : 'CarID',
			title : '车船号',
			width: 150
		},{
			field : 'inorout',
			title : '出入库',
			width: 150,
			formatter:function(value){
				return value=="0"?"出库":"入库"
			}
		},{
			field : 'Breed',
			title : '粮食品种',
			width: 150,
			formatter:function(value){
				return CONFIGURE.BREED[value];
			}
		},{
			field : 'Property',
			title : '粮食性质',
			width: 150,
			formatter:function(value){
				return CONFIGURE.PROPERTY[value];
			}
		},{
			field : 'Price',
			title : '粮食单价（元）',
			width: 150
		},{
			field : 'AmountPercent',
			title : '总扣量',
			width: 150,
			formatter:function(value){
				return value+"%"
			}
		},{
			field : 'useCar',
			title : '驳车',
			width: 150,
			formatter:function(value){
				return CONFIGURE.USECAR[value];
			}
		},{
			field : 'State',
			title : '流水单状态',
			width: 150,
			formatter:function(value){
				return CONFIGURE.ISTATUS[value];
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
	
	/**
	 * 打开add页面
	 */
	$(".add").click("click", function() {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>报港<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : rootPath + "/storage/register/add.shtml?inorout="+$(this).data("inorout"),
			end : function() {
				grid.datagrid("reload");
			}
		});
	});
	//导出
	$("#export").click("click", function() {
		 window.selectRow = grid.datagrid('getSelected');
		if(!selectRow){
			layer.alert("未选择一行") ;return false
		} 
		if(selectRow.useCar==1){
			layer.open({
					title : "<h5><i class='glyphicon glyphicon-link'></i>选择驳车<h5>",
					type : 2,
					maxmin : true,
					area : [ "1100px", "500px" ],
					content : rootPath + "/storage/carPrint/listUI.shtml",
					end : function() {
						grid.datagrid("reload");
					}
				});
			return ;
		}
		//window.open(rootPath + "/storage/toPrint/listUI.shtml?id="+selectRow.ID)
		var href="/zhlk/gridReport/shouchuxitong/mm.jsp?id="+selectRow.ID;
		window.open(href);
	});
	//删除
	$("#remove").click("click", function() {
		 selectRow = grid.datagrid('getSelected');
		if(!selectRow){
			layer.alert("未选择一行") ;return false
		}
		if(selectRow.State!="1"){
			layer.alert("不能删除!");
			return false;
		}
		var url = rootPath + '/storage/removeInstorage.shtml';
		var s = CommnUtil.ajax(url, {id : selectRow.basicid}, "json");
		if (s == "success") {
			grid.datagrid('deleteRow', grid.datagrid('getRowIndex', selectRow));
			layer.msg('删除成功');
			
		}
	});
});




