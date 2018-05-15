var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'wendubaojingshezhi/findByPage.shtml',
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
			field : 'wlName',
			title : '粮库地点',
			sortable : true,
			width: 150
		}, {
			field : 'wName',
			title : '仓号',
			sortable : true,
			width: 100
		}, {
			field : 'cjsj',
			title : '采集时间',
			sortable : true,
			width: 150
		}, {
			field : 'alarmDate',
			title : '报警时间',
			sortable : true,
			width: 150
		}, {
			field : 'alarmTemperature',
			title : '报警温度',
			sortable : true,
			width: 100
		}, {
			field : 'position',
			title : '报警点位',
			sortable : true,
			width: 250,
			formatter: function(value,row,index){
				if (value.length>20){
					return value.substring(0,20)+"...";
				} else {
					return value;
				}
			}
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
		onDblClickRow:function(index,row){
			lookUI(row.id);
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
	
	
	$("#setFun").click("click",function(){
		var val = $("#maxTemp").val();
		$.ajax({
			url:rootPath+"/wendubaojingshezhi/setMaxTemperature.shtml",
			data:{maxTemp:val},
			type:"post",
			dataType:"json",
			success:function(data){
				if(data == "success"){
					alert("设置成功！");
				}else{
					alert("设置失败！");
				}
			}
		});
	});
});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});


function lookUI(id){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin :true,
		area : [ "1200px", "600px" ],
		offset:"40px",
		content : rootPath + '/wendubaojingshezhi/lookUI.shtml?id='+id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}