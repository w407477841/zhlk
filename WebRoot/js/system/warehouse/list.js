var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/warehouse/findWarehouseInfoByPage.shtml',
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
			title : '粮库地点',
			sortable : true,
			width: 60
		}, {
			field : 'wName',
			title : '仓库名称',
			sortable : true,
			width: 60
		}, {
			field : 'wTemperature',
			title : '仓内温度',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == null){  
					return '';  
				} else if(val >= 300 || val < -100){
					return "<font color='red'>D-E</font>";
				}
				else{
					return val.toFixed(2); 
				}
			}
		}, {
			field : 'gTemperature',
			title : '仓外温度',
			sortable : true,
			width: 80,
			formatter:function formatprice(val,row){ 
				if (val == null){  
					return '';  
				} else if(val >= 300 || val < -100){
					return "<font color='red'>D-E</font>";
				}
				else{
					return val.toFixed(2); 
				}
			}
		}, {
			field : 'wHumidity',
			title : '仓内湿度',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == null){  
					return '';  
				} else if(val >= 300 || val < -100){
					return "<font color='red'>D-E</font>";
				}
				else{
					return val.toFixed(2); 
				}
			}
		}, {
			field : 'gHumidity',
			title : '仓外湿度',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == null){  
					return '';  
				} else if(val >= 300 || val < -100){
					return "<font color='red'>D-E</font>";
				}
				else{
					return val.toFixed(2); 
				}
			}
		}, {
			field : 'maxTemperature',
			title : '最高温度',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == null){  
					return '';  
				} else if(val >= 300 || val < -100){
					return "<font color='red'>D-E</font>";
				}
				else{
					return val.toFixed(2); 
				}
			}
		}, {
			field : 'minTemperature',
			title : '最低温度',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == null){  
					return '';  
				} else if(val >= 300 || val < -100){
					return "<font color='red'>D-E</font>";
				}
				else{
					return val.toFixed(2); 
				}
			}
		}, {
			field : 'cjsj',
			title : '采集时间',
			sortable : true,
			width: 100
		}
		] ],
		onDblClickRow: function(index,row){
			lookUI(row);
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
	$("#look").click("click",function(){
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
 * 查看
 * @param id
 */
function look(){
	var selectRow =grid.datagrid('getSelected');
	if(selectRow){
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
			type : 2,
			maxmin :true,
			area : [ "90%", "90%" ],
			offset:"40px",
			content : rootPath + '/warehouse/look.shtml?id='+selectRow.id,
			end :function(){
				grid.datagrid("reload");
			}
		});
	}else{
		layer.msg("请选择一行");
	}
}
function lookUI(row){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin :true,
		area : [ "90%", "90%" ],
		offset:"40px",
		content : rootPath + '/warehouse/look.shtml?id='+row.id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}
