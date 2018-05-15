var grid;
var pageii;

$(function(){
	var bId = parent.abId;
	var carId =  parent.acarId;
	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/weighing/findAllWeighingByBIdAndCarId.shtml',
		method : 'POST',
		idField : 'id',
		queryParams :{bId:bId,carId:carId},
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [{
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
			width: 60
		}, {
			field : 'tarDate',
			title : '称皮时间',
			sortable : true,
			width: 60
		}
		]]
	});
});
