var grid="";
//驳车设置
function bulidCarChart(gridData, gridFormatArr, f) {
	// 查询表格数据
	$.ajax({
		url : rootPath + "/storage/queryCars.shtml",
		type : "post",
		data:{"all":1},
		success : function(rs) {
			if (!rs.success)
				console.error("....");
			// 生成表格
			grid=	$('#grid').datagrid({
				rownumbers : false,
				pagination : true,
				fitColumns:true,
				data : rs.cars,
				columns : [ [ {field : 'CaNum',title : '车牌号',width : 150}, 
				              {field : 'Model',title : '车型',width : 150}, 
				              {field : 'Driver',title : '司机',width : 150},
				              {field : 'DrivingLcence',title : '驾驶证',width : 150},
				              {field : 'Phone',title : '电话',width : 150},
				              {field : 'Inuse',title : '状态',width : 150,formatter :function (value){
				            	  return  value=="0"?"空闲":"使用中";
				              }},
				              {field:'del',title:"操作",width:150,formatter:function(value,row,index){
				            	   return 	"<button class='btn btn-warning' onclick=removeCar('"+row.CaNum+"','"+row.Inuse+"','"+index+"') ><i class='glyphicon glyphicon-remove glyphicon-white'></i>删除</button> " 
				              }}
				          ] ]
			});
		}
	})

}
//数据补录


//测试地磅
EventUtil.addHandler(document.getElementById("testCOM"),"click",function(){
    if(MSComm1.PortOpen==true)  MSComm1.PortOpen=false;
    try{ 
      MSComm1.CommPort=document.getElementById("ComName").value; 
      MSComm1.Settings=document.getElementById("BaudRate").value.toString()+ 
                       ","+document.getElementById("CheckBit").value.toString()+
                        ","+document.getElementById("DataBits").value.toString()+
                        ","+document.getElementById("StopBits").value.toString();  
       MSComm1.OutBufferCount =0;           //清空发送缓冲区 
      MSComm1.InBufferCount = 0;           //滑空接收缓冲区                         
      alert("已配置串口COM"+MSComm1.CommPort+"\n 参数:"+MSComm1.Settings);       
      MSComm1.PortOpen=true; 
      }catch(ex){alert(ex.message);} 
});


// 保存地磅设置
EventUtil.addHandler(document.getElementById("saveSetting"), "click",function() {
			try {
				var obj = new Object;
				obj.CommPort = document.getElementById("ComName").value;
				obj.Settings = document.getElementById("BaudRate").value
						.toString()
						+ ","
						+ document.getElementById("CheckBit").value.toString()
						+ ","
						+ document.getElementById("DataBits").value.toString()
						+ ","
						+ document.getElementById("StopBits").value.toString();

				var location = document.getElementById("selectLocation1").value;
				var num = document.getElementById("number").value;
				if (!!!location  || !!!num) {
					layer.alert("信息不完整!");
					return false;
				}
				layer.confirm('是否确认保存?', function(index) {
					$.ajax({
						url : "storage/saveDiBangData.shtml",
						data : {
							"para" : JSON.stringify(obj),
							"location" : location,
							"num" : num
						},
						success : function() {
							layer.msg("保存成功");
							layer.close(index)
							document.getElementById("number").value="";
						}
					})
				});

			} catch (ex) {
				throw new Error(ex)
			}
		});
//车辆类
function AvailableCarsFormMap(CaNum, Model, Driver, DrivingLcence, Phone,
		Inuse, id) {
	this["AvailableCarsFormMap.CaNum"] = CaNum;
	this["AvailableCarsFormMap.Model"] = Model;
	this["AvailableCarsFormMap.Driver"] = Driver;
	this["AvailableCarsFormMap.DrivingLcence"] = DrivingLcence;
	this["AvailableCarsFormMap.Phone"] = Phone;
	this["AvailableCarsFormMap.Inuse"] = Inuse || 0;
	this["AvailableCarsFormMap.ID"] = id;

}

// 车辆新增
EventUtil.addHandler(document.getElementById("insertCar"), "click", function() {
	try {
		
		var CaNum = document.getElementById("CaNum").value;
		var Model = document.getElementById("Model").value;
		var Driver = document.getElementById("Driver").value;
		var DrivingLcence = document.getElementById("DrivingLcence").value;
		var Phone = document.getElementById("Phone").value;

		var availableCarsFormMap = new AvailableCarsFormMap(CaNum, Model,Driver, DrivingLcence, Phone);
		
		var rows=$('#grid').datagrid("getRows");
		
		if(CaNum==''){
			layer.alert("信息填写不完整!");
			return false;
		}
		for(var i=0;i<rows.length;i++){
			if(CaNum==rows[i].CaNum){
				layer.alert("车牌号重复!");
				throw new Error("duplicate CaNum field! you should specific a different one~");
			}
		}
		
		
		layer.confirm('是否确认保存?', function(index) {
			$.ajax({
				url : "storage/insertCars.shtml",
				data : availableCarsFormMap,
				success : function() {
				$('#grid').datagrid("appendRow",{CaNum:CaNum,Model:Model,Driver:Driver,DrivingLcence:DrivingLcence,Phone:Phone,Inuse:0});
					layer.close(index)
				}
			})
		});

	} catch (ex) {
		console.error(ex)
	}
});
//车辆删除
function removeCar(id,use,rowIndex){
	if(use!="0"){
		layer.alert("不能删除该辆车!");
		return false;
	}
	
	layer.confirm('确认删除？', function(index) {
		grid.datagrid('deleteRow', rowIndex);
		var url = rootPath + '/storage/deleteCars.shtml';
		var s = CommnUtil.ajax(url, {id : id}, "json");
		if (s == "success") {
			grid.datagrid('acceptChanges');
			layer.msg('删除成功');
			
		} else {
			grid.datagrid('rejectChanges');
			layer.msg('删除失败');
		}
	});
	

	
	
}

function initLocation1() {
	$.ajax({
		url : rootPath + "/kcxx/locations.shtml",
		type : "post",
		async : false,
		data : {
			"source" : 1
		},
		success : function(rs) {
			var sel = document.getElementById("selectLocation1");
			var sel2=document.getElementById("selectLocation2");
			if (rs.success) {
				for ( var i = 0; i < rs.list.length; i++) {
					sel.add(new Option(rs.list[i].wName, rs.list[i].wNo))
					sel2.add(new Option(rs.list[i].wName, rs.list[i].wNo))
				}
			}

		}
	})
}

$("#selectLocation2").on("change",function(event) {
	var value = this.value;
	$.ajax({
		url : rootPath + "/businessManager/findHouses.shtml",
		type : "post",
		async : false,
		data : {
			"wno" : value
		},
		success : function(rs) {
			var sel = document.getElementById("selectHouseid");
			sel.innerHTML = "<option value=''></option>"
			$("#selectHouseid").chosen("destroy");
			rs = JSON.parse(rs);
			if (rs.success) {
				for ( var i = 0; i < rs.result.length; i++) {
					sel.add(new Option(rs.result[i].wName,
									rs.result[i].id + ","
											+ rs.result[i].wName))
				}
				$("#selectHouseid").chosen({
					no_results_text : "未找到此选项!",
					width : "100%"
				});
				
				$(".chosen-single").css("height", "37px").css("borderRadius", "4px");
			}
		}
	})
});

var searchBtn=document.getElementById("search");
EventUtil.addHandler(searchBtn, "click", function(event){
	var input=document.getElementById("billID").value;
	var output=document.querySelectorAll(".output")[0];
	var container=document.querySelectorAll(".s-detil-inst")[0];
	var reg=/^[0-9]{14,18}$/;
	if(!reg.test(input)){
		output.innerHTML="输入有误"
	 return false;
	}
	output.innerHTML="查询中..."
	//validating passed
		$.ajax({	
			url:rootPath+"/storage/totalDetail.shtml",
			async:true,
			data:{"id":input},
			type:"post",
			success:function(rs){
			if(rs.success==true){
				var spans=document.querySelectorAll(".desc-span");
				var msg=rs.msg[0];
				for(var i=0;i<spans.length;i++){
					var tag=spans[i].dataset["tag"];
					if(msg.hasOwnProperty(tag)){
						spans[i].innerHTML=msg[tag];
						delete msg[tag];
					}
				
				}
				$('#magazine').datagrid({
				rownumbers : false,
				pagination : true,
				fitColumns:true,
				singleSelect:true,
				data : rs.msg1,
				columns : [ [ {field : 'id',title : '流水单号',width : 150}, 
							  {field : 'vid',title : '车牌号',width : 150}, 
				              {field : 'TotalWeight',title : '总毛重',width : 150,formatter:function(value){return value}}, 
				              {field : 'CarWeight',title : '总皮重',width : 150,formatter:function(value){return value}}, 
				              {field : 'TotalWeightingTime',title:'毛重时间',width : 150},
				              {field : 'CarWeightingTime',title : '皮重时间',width : 150}
				          ] ]
			});
				
				output.innerHTML=""
				container.style.height='300px'
				container.style.border='1px dashed'
			}
		}
	}); 	
})

EventUtil.addHandler(document.getElementById("add"), "click", function(event){
var input=document.getElementById("billID").value;
var output=document.querySelectorAll(".output")[0];
	var reg=/^[0-9]{14,18}$/;
	if(!reg.test(input)){
		output.innerHTML="流水单号有误"
	 return false;
	}
	 layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>补录<h5>",
			type : 2,
			maxmin : true,
			area : [ "600px", "300px" ],
			content : rootPath + "/storage/paramConfig/addPage.shtml?id="+input,
			end : function() {
				grid.datagrid("reload");
			}
		});
})
EventUtil.addHandler(document.getElementById("edit"), "click", function(event){
var input=document.getElementById("billID").value;
var output=document.querySelectorAll(".output")[0];
	var reg=/^[0-9]{14,18}$/;
	if(!reg.test(input)){
		output.innerHTML="流水单号有误"
	 return false;
	}
	
	var selectRow = $("#magazine").datagrid('getSelected');
	if(!selectRow) {
		layer.alert("未选中一行!");
		return false;
	}
		 layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>修正<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "400px" ],
			content : rootPath + "/storage/paramConfig/editPage.shtml?sid="+selectRow.sid,
			end : function() {
				grid.datagrid("reload");
			}
		});
	
})
