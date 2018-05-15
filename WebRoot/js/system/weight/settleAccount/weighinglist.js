var grid;
var pageii;
$(function() {
	var bId=$("#bill").val();
	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/weighing/findAllWeighingByBId.shtml',
		method : 'POST',
		queryParams : {bId:bId},
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : true,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'bId',
			title : '单据号',
			sortable : true,
			width: 80
		}, {
			field : 'carId',
			title : '车牌号',
			sortable : true,
			width: 60
		}, {
			field : 'grossWeight',
			title : '毛重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'tare',
			title : '皮重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'grossWeightDate',
			title : '称毛时间',
			sortable : true,
			width: 80
		}, {
			field : 'tarDate',
			title : '称皮时间',
			sortable : true,
			width: 80
		}, {
			field : 'grossWeightPhoto',
			title : '称毛截图',
			width: 80,
			formatter:function formatprice(val,row){ 
				return createImg(val);
			}
		}, {
			field : 'tarPhoto',
			title : '称皮截图',
			width: 80,
			formatter:function formatprice(val,row){ 
				return createImg(val);
			}
		}
		]]
	});
	
});

grid.datagrid('getPager').pagination({
	displayMsg : '当前显示从{from}到{to},共{total}记录',
	onBeforeRefresh : function(pageNumber, pageSize) {
		$(this).pagination('loading');
		$(this).pagination('loaded');
	},
});

function createImg(path){
	var result = '';
	if(path !=null && path !=''){
		var paths = path.split(";");
		for(var i=0;i<paths.length;i++){
			var pt = paths[i];
			if(pt != ''){
				result+="<img src='"+rootPath+"/screenshot/"+pt+"' weight='30px' height='30px' onclick='layerImg(this)'>&nbsp;&nbsp;";
			}
		}
	}
	return result;
}


function layerImg(obj){
	var path = $(obj).attr("src");
	$("#showImg").show();
	$("#showImg").attr("src",path);
	layer.open({
		  type: 1,
		  title: false,
		  area : [ "600px", "400px" ],
		  skin: 'layui-layer-nobg', //没有背景色
		  shadeClose: true,
		  content: $('#showImg')
	});
}