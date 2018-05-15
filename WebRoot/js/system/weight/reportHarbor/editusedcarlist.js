var grid;
var pageii;
var bId;
function search_info(){
	bId = $("#bId").val();
	if(bId == null || bId == ''){
		clear_datagrid();
		layer.alert("单据号为空！", {icon:7});
	}else{
		if(bId.length !=12){
			clear_datagrid();
			layer.alert("单据号输入有误！", {icon:7});
		}else{
			//根据单据号获取报港数据
			$.ajax({
				type:'post',
				dataType:'json',
				url:rootPath+'/reportHarbor/findByBId.shtml',
				data:{bId:bId},
				success:function(data){
					if(data == null){
						clear_datagrid();
						layer.alert("暂无查找数据！", {icon:7});
					}else{
						if(data.usedCar == '1'){
							datagridBind();
						}else{
							clear_datagrid();
							layer.alert("此单据号未启动驳车！", {icon:7});
						}
					}
				},
				error:function(data){
					clear_datagrid();
					layer.alert("查询失败！", {icon:5});
				}
			});
		}
	}
}

function clear_datagrid(){
	if(grid != null){
		$('#magazineGrid').datagrid('loadData', { total: 0, rows: [] });
	}
}

function datagridBind(){
	grid = $('#magazineGrid').datagrid({
		url : rootPath+'/car/findNotUsedByPage.shtml',
		method : 'POST',
		queryParams : {bId:bId},
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		checkOnSelect:false,
		sortName : 'id',
		sortOrder : 'desc',
		multiSort : true,
		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'cId',
			title : '车牌号',
			sortable : true,
			width: 80
		}, {
			field : 'carType',
			title : '车型',
			sortable : true,
			width: 60
		}, {
			field : 'driver',
			title : '驾驶员',
			sortable : true,
			width: 30
		}, {
			field : 'driveLicense',
			title : '驾驶证',
			sortable : true,
			width: 60
		}, {
			field : 'phoneNumber',
			title : '联系方式',
			sortable : true,
			width: 60
		}, {
			field : 'RFIDName',
			title : 'RFID名称',
			sortable : true,
			width: 60
		}, {
			field : 'bId',
			title : '状态',
			sortable : true,
			width: 60,
			formatter:function formatprice(val,row){ 
				if (val == ''){  
					return '<span style="color:green;">未分配</span>';  
				}else{
					return '<span style="color:red;">分配使用中</span>'; 
				}
			}
		}, {
			field : '_operate',
			title : '数据操作',
			sortable : true,
			width: 160,
			formatter:function formatprice(val,row){  
				if(row.bId == ''){
					return '<button type="button" class="btn btn-info" onclick="usedFun('+row.id+')">绑定</button> <button type="button" class="btn btn-info" onclick="create_qc('+row.id+')">绑定二维码</button>';
				}else{
					if(row.RFIDName == '二维码'){
						return '<button type="button" class="btn btn-danger" onclick="clear_bId('+row.id+')">解绑</button> <button type="button" class="btn btn-info" onclick="print_qc('+row.id+')">打印二维码</button>';
					}else{
						return '<button type="button" class="btn btn-danger" onclick="clear_bId('+row.id+')">解绑</button>';
					}
					
				}
				  
			}
		}
		] ]
	});
	
	
	grid.datagrid('getPager').pagination({
		displayMsg : '当前显示从{from}到{to},共{total}记录',
		onBeforeRefresh : function(pageNumber, pageSize) {
			$(this).pagination('loading');
			$(this).pagination('loaded');
		},
	});
}

/**
 * 打开分配页面
 */
function usedFun(id){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>分配<h5>",
		type : 2,
		maxmin :true,
		area : [ "1000px", "500px" ],
		offset:"40px",
		content : rootPath + '/car/usedUI.shtml?id='+id+'&bId='+bId,
		end :function(){
			grid.datagrid("reload");
		}
	});
}
/**
 * 解绑卡
 * @param id
 */
function clear_bId(id){
	//layer.msg(id);
	layer.confirm('确认解绑？', function(index) {
		var url = rootPath + '/car/clearUsedById.shtml';
		var s = CommnUtil.ajax(url, {id:id
		}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('解绑成功');
			grid.datagrid("reload");
		}else if(s == "used"){
			grid.datagrid('rejectChanges');
			layer.msg('已进行称重');
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('解绑失败');
		}
	});
}
/**
 * 生成二维码并打印
 * @param id
 */
function create_qc(id){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>二维码<h5>",
		type : 2,
		maxmin :true,
		area : [ "400px", "530px" ],
		offset:"40px",
		content : rootPath + '/car/crateQC.shtml?id='+id+'&bId='+bId,
		end :function(){
			grid.datagrid("reload");
		}
	});
}
/**
 * 打印二维码
 * @param id
 */
function print_qc(id){
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>二维码<h5>",
		type : 2,
		maxmin :true,
		area : [ "400px", "530px" ],
		offset:"40px",
		content : rootPath + '/car/printQC.shtml?id='+id,
		end :function(){
			grid.datagrid("reload");
		}
	});
}
