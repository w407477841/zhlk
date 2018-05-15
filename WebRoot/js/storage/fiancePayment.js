var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();

	grid = $('#magazineGrid').datagrid({
		url : 'storage/queryPayInstorages.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'basicid',   
		striped : true,
		singleSelect : true,
		fitColumns : true,
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
			field : 'id',
			title : '流水单号',
			width: 120
		},{
			field : 'CarID',
			title : '车船号',
			width: 100
		},{
			field : 'NAME',
			title : '粮食品种',
			width: 100
		},{
			field : 'LEVEL',
			title : '等级',
			width: 60
		},{
			field : 'Price',
			title : '粮食单价（元）',
			width: 100
		},{
			field : 'CarWeight',
			title : '净重(KG)',
			width: 110,
			formatter:function(value,row){
				return Math.abs(row.TotalWeight-row.CarWeight);
			}
		},{
			field : 'Slef',
			title : '结算金额',
			width: 110,
			formatter:function(value,row){
				return Math.abs((row.TotalWeight-row.CarWeight)*row.Price/100);
			}
		},{
			field : 'State',
			title : '流水单状态',
			width: 80,
			formatter:function(value){
				var returnVal=""
					if(value=="1"){
						returnVal="<font color='#ff00'>"+CONFIGURE.ISTATUS[value]+"";
					}else if(value=="2"){
					returnVal="<font color='#0000ff'>"+CONFIGURE.ISTATUS[value]+"";
				}else if(value=="3"){
					returnVal="<font color='#00ff'>"+CONFIGURE.ISTATUS[value]+"";
				}
				return returnVal;
			}
		},{
			field : 'Payway',
			title : '结算类型',
			width: 80,
			formatter:function(value){
				return value==1&&"现金"||value==2&&"转账"||"--";
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
	$("#add").click("click", function() {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>报港<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : rootPath + "/storage/register/add.shtml",
			end : function() {
				grid.datagrid("reload");
			}
		});
	});
	
	/**
	 * 打开edit页面
	 */
	$("#edit").click("click", function() {
	 window.selectRow = grid.datagrid('getSelected');
		if(!selectRow){
				layer.alert("未选择一行") ;return false
			} else if(selectRow.State!=2){
				layer.alert("请选择待结算的数据") ;return false
			}
		pageii = layer.open({											
			title : "<h5><i class='glyphicon glyphicon-link'></i><h5>",
			type : 1,
			maxmin : true,
			offset : '40px',
			area : [ "600px", "300px" ],
			content : $("#paywayConfirm"),
			btn : [ '确认', '取消' ],
			yes : function(index,elem) {
				var params=new Object;
				params.id=selectRow.basicid;
				params.wayid=$("#settleType").val();
				params.bankName=$(elem).find("input")[1].value||"";
				params.bankid=$(elem).find("input")[2].value||"";
				params.order=selectRow.id;
				$.ajax({
							url:rootPath + "/storage/setPayWay.shtml",
							data:params,
							type:"post",
							success:function(){
										//	window.location.reload();
											layer.close(index);
											grid.datagrid("reload");
										}
									})
				
			}
		});
	});
	//导出
	$("#export").click("click", function() {
		 window.selectRow = grid.datagrid('getSelected');
		if(!selectRow){
			layer.alert("未选择一行") ;return false
		} else if(selectRow.State!=3){
			layer.alert("流程未结束,无法导出") ;return false
		}
		window.open("/zhlk/gridReport/shouchuxitong/w.jsp?id="+selectRow.id)
	});
});

/**
 * 删除行，失败后还原。 ps如果 有修改但未提交的数据，也会还原。
 * 
 * @param rowindex
 * @param id
 */
function deleteCold(rowindex, id) {
	
}

$("#settleType").on("change",function(){
	if($(this).val()=="1"){	
		$(this).parent().nextAll().remove();
	}else{
		$("#settleWay").append("<li><label >开户银行:</label><input name='bank' type='text'  class='text_add'/></li>"+
       "<li><label>银行卡号:</label><input name='cardname' type='text'  class='text_add'/></li>")
	}
})

