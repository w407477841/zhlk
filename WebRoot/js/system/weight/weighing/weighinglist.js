var grid1;
var grid2;
var pageii;
usedCar_Weight();
retail_Weight();
function retail_Weight(){
	grid1 = $('#retailGrid').datagrid({
		url : rootPath+'/weighing/findRetailWeightByPage.shtml?time_d='+new Date(),
		method : 'POST',
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
		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'bId',
			title : '单据号',
			sortable : true,
			width: 60
		}, {
			field : 'userName',
			title : '单位',
			sortable : true,
			width: 90
		}, {
			field : 'grainVariety',
			title : '粮食品种',
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
			field : 'trueWeight',
			title : '净重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'buyPrice',
			title : '单价(元/kg)',
			sortable : true,
			width: 60
		}
		]],
		onLoadSuccess:function(data){
			div_show();
		}
	});
}

function usedCar_Weight() {
	grid2 = $('#usedCarGrid').datagrid({
		url : rootPath+'/weighing/findUsedCarWeightByPage.shtml?time_d='+new Date(),
		method : 'POST',
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
		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'bId',
			title : '单据号',
			sortable : true,
			width: 60
		}, {
			field : 'userName',
			title : '单位',
			sortable : true,
			width: 90
		}, {
			field : 'carId',
			title : '车船号',
			sortable : true,
			width: 60
		}, {
			field : 'grainVariety',
			title : '粮食品种',
			sortable : true,
			width: 60
		}, {
			field : 'grossWeight',
			title : '总毛重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'grossWeightCount',
			title : '称毛次数',
			sortable : true,
			width: 60
		}, {
			field : 'tare',
			title : '总皮重(kg)',
			sortable : true,
			width: 60
		}, {
			field : 'tareCount',
			title : '称皮次数',
			sortable : true,
			width: 60,
			formatter:function(val,row){ 
				if (val == 0 || row.grossWeightCount != val){  
					return '<span style="color:red;">'+val+'</span>';  
				}else{
					return '<span style="color:blue;">'+val+'</span>'; 
				}
			}
		}, {
			field : '_totalWeight',
			title : '净重(kg)',
			sortable : true,
			width: 60,
			formatter:function (val,row){
				return row.grossWeight == undefined?0:row.grossWeight - row.tare== undefined?0:row.tare;
			}
		}, {
			field : 'buyPrice',
			title : '单价(元/kg)',
			sortable : true,
			width: 60
		}
		]],
		onDblClickRow:function(index,row){
			var carId = row.carId==undefined?null:row.carId;
			showDetailWeighing(row.bId,carId);
		}
	});
}
var abId='',acarId='';
function showDetailWeighing(bId,carId){
	abId = bId;
	acarId = carId;
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin :true,
		area : [ "630px", "450px" ],
		offset :"40px",
		content : rootPath + '/weighing/weighingDetailUI.shtml',
		end :function(){
			//grid.datagrid("reload");
		}
	});
}