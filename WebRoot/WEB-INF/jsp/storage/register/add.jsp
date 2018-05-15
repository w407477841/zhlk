<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}
.laydate-icon{
height: 38px;
line-height: 38px
}
.div_lable1{
text-align: center; height: 56px;line-height: 56px
}
.form-control{
padding: 0px 12px
}
.form-control{
padding: 0px 12px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12">
		<form id="form" name="form" method="post" action="${ctx}/storage/addInstorage.shtml">
			<br><input type="hidden" name="token" value="${token}">
			<input type="hidden" name="StorageFormMap.state" value="1">
			<input type="hidden" name="StorageFormMap.inorout" value="${inorout}">
			<div class="form-group col-md-12" style="border: 1px dashed; padding: 10px;margin: 10px 0">
			
				<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">必填信息</h3>
		</div>
	</div>
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮户姓名:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.Owner" value="" placeholder="粮户姓名">
						</div>
					</div>
			</div>
			
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">身份证号:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.Identity" value="" placeholder="身份证号">
						</div>
					</div>
			</div>
			
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">手机号码:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.Phone" value="" placeholder="手机号码">
						</div>
					</div>
			</div>	
			
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">地址:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.Address" value="" placeholder="地址">
						</div>
					</div>
			</div>
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">车船号:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.CarID" value="" placeholder="地址">
						</div>
					</div>
			</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">启用驳车:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectCar" data-rel="chosen" data-placeholder="是否启用" name="StorageFormMap.useCar">
								<option value=""></option>
								<option value="0" selected="selected">否</option>
								<option value="1">是</option>
							</select>
						</div>
					</div>
				</div>		
				
								<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属粮库:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"  name="StorageFormMap.location" data-placeholder="所属粮库">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属仓号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectHouseid" data-rel="chosen" name="StorageFormMap.StorageID" data-placeholder="所属仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				
				
			
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食品种:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectBreed" data-rel="chosen" data-placeholder="粮食品种" name="StorageFormMap.Breed">
								<option value=""></option>
								<option value="1114" selected="selected">混合小麦</option>
								<option value="1132002">晚粳稻谷</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食性质:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="" data-rel="chosen" data-placeholder="粮食性质" name="StorageFormMap.Property">
								<option value=""></option>
								<option  value="31">最低收购价粮</option>
								<option value="11">国家储备粮</option>
								<option value="121">省级储备粮</option>
								<option value="122">地市级储备粮</option>
								<option value="123">县级储备粮</option>
								<option value="2">商品粮</option>
								<option value="34">地方临时存储粮 </option>
							</select>
						</div>
					</div>
				</div>
				


				</div>	
	<div class="form-group col-md-12" style="border: 1px dashed; padding: 10px;margin: 10px 0">
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">质检信息录入</h3>
		</div>
	</div>
	<div class=" col-md-12" style="margin-bottom: 15px">
	 <table id="magazineGrid"  style="width:99%;height:70px"></table>
	</div>
	
			<div class="form-group col-md-4">
					<div class="col-md-3 div_label">收购价格(元):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="price" class="form-control"name="" disabled="disabled" value="" placeholder="收购价格">
						</div>
					</div>
				</div>
			<div class="form-group col-md-4">
					<div class="col-md-3 div_label">等级:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="level" class="form-control"name="" disabled="disabled" value="3" placeholder="等级">
						</div>
					</div>
				</div>
				
			<div class="form-group col-md-4">
					<div class="col-md-3 div_label">扣量百分比:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="percentage" class="form-control"name="" disabled="disabled" value="0.00" placeholder="总扣量">
						</div>
					</div>
				</div>
	</div>			
				
								

			<div class="form-group col-md-12" style="text-align: center;">
				<button type="button" class="btn btn-info bt-submit"onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="${ctx}/js/storage/register_add.js"></script>
</body>
<script type="text/javascript">
	$("#selectHouseid").on("change",function(e){
	var houseid=this.value;
	var location=$("#selectLocation").val();
		$.ajax({
			url : rootPath + "/kcxx/weights.shtml",
			type : "post",
			async:false,
			data : {
				"houseid" : houseid,
				"location" : location
			},
			success : function(rs) {
 			 var sel=document.getElementById("selectBreed");
			 for(var i=0;i<sel.options.length;i++){
			 	if(sel.options[i].text==rs.reslut.breed){
			 		sel.options[i].selected=true;
			 	}
			 }
			 	$("#selectBreed").chosen("destroy").chosen({width : "100%"}).trigger("change");
			}
		})
		
	})


</script>
</html>
