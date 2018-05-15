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
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-8">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">粮食轮换出库保管耗</h3>
		</div>
	</div>
	<div class=" col-md-4"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/liangshilunhuanchukubaoguanhao/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">粮库地点<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							data-rel="chosen" data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">仓号<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<select class="form-control" id="warehouseName"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslWId" data-rel="chosen"
							data-placeholder="请选择仓号">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">粮食品种<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" id="grainVariety" readonly="readonly" class="form-control easyui-validatebox" missingMessage="请输入粮食品种"
								data-options="required:true" placeholder="请输入 ：粮食品种">
						<input type="hidden" id="gslCategory" name="lunHuanChuKuBaoGuanHaoFormMap.gslCategory">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">粮食性质<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" id="grainProperty" readonly="readonly" class="form-control easyui-validatebox" missingMessage="请输入粮食品种"
								data-options="required:true" placeholder="请输入 ：粮食性质">
						<input type="hidden" id="gslProperty" name="lunHuanChuKuBaoGuanHaoFormMap.gslProperty">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">包装方式<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" id="packageWay" readonly="readonly" class="form-control easyui-validatebox" missingMessage="请输入粮食品种"
								data-options="required:true" placeholder="请输入 ：包装方式">
						<input type="hidden" id="gslPackageWay" name="lunHuanChuKuBaoGuanHaoFormMap.gslPackageWay">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">保管天数<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入保管天数"
								data-options="required:true"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
						    id="baoguantianshu" onfocus="getDays()"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslSaveDays"
							placeholder="请输入 ：保管天数" maxlength="8">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">进仓日期<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入进仓日期"
								data-options="required:true" id="dateformat"
							placeholder="请输入 ：进仓日期" onblur="getDays()"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslPutInDate">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">出库日期<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入出库日期"
								data-options="required:true" id="dateformat1"
							placeholder="请输入 ：出库日期" onblur="getDays()"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslGetOutDate">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">进仓水分(%)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="wsf" onchange="shuize()"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslPutInFluid"
							placeholder="请输入 ：进仓水分(%)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">出库水分(%)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="osf" onchange="shuize()"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslGetOutFluid"
							placeholder="请输入 ：出库水分(%)" maxlength="10">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">进仓杂质(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="wzz" onchange="shuize()"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslPutInImpurity"
							placeholder="请输入 ：进仓杂质(kg)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">出库杂质(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="ozz" onchange="shuize()"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslGetOutImpurity"
							placeholder="请输入 ：出库杂质(kg)" maxlength="10">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">进仓数量(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="inWeight"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslPutInWeight"
							placeholder="请输入 ：进仓数量(kg)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">出库数量(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							id="outWeight"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslGetOutWeight"
							placeholder="请输入 ：出库数量(kg)" maxlength="10">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">损耗总量(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="sunhaozongzhong"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslTotalReduce"
							placeholder="请输入 ：损耗总量(kg)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">整理水杂耗数量(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="shuizahaoshuliang"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslCleanUpWeight"
							placeholder="请输入 ：整理水杂耗数量(kg)" maxlength="10">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">保管自然耗比例(%)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="ziranhaobili"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslLossRate"
							placeholder="请输入 ：保管自然耗比例(%)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">保管自然耗数量(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="ziranhaoshuliang"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslLossWeight"
							placeholder="请输入 ：保管自然耗数量(kg)" maxlength="10">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">超定额损耗(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							 id="chadingersunhao"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslOverrateWeight"
							placeholder="请输入 ：超定额损耗(kg)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">溢余(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="yiyu" readonly="readonly"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslOverflowWeight">
					</div>
				</div>
			</div>
			
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">损耗单价(元/公斤)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="validFloat(this)"
							id="lossPrice"
							name="lunHuanChuKuBaoGuanHaoFormMap.lossPrice"
							placeholder="损耗单价(元/公斤)" maxlength="5">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">报损金额(元)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="lossMoney" onfocus="complateLossMoney()"
							name="lunHuanChuKuBaoGuanHaoFormMap.lossMoney" maxlength="12">
					</div>
				</div>
			</div>
			
			<div class="form-group col-md-12">
				<div class="col-md-2 div_label">备注</div>
				<div class="col-md-10">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control" name="lunHuanChuKuBaoGuanHaoFormMap.remark"></textarea>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		laydate({
			elem : '#dateformat',
			event : 'focus'
		});
		laydate({
			elem : '#dateformat1',
			event : 'focus'
		});
		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							layer.confirm('添加成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('添加失败！', {icon:5});
						}
					}
				});
			},
			rules : {},
			messages : {},
			errorPlacement : function(error, element) {// 自定义提示错误位置
			},
			success : function(label) {// 验证通过后
			}
		});
		var sel = new myselect({
			obj_id : "warehouseLocation",
			url : "${ctx}/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
			$("#warehouseName").html("");
			$("#warehouseName").chosen("destroy");
			findWarehouse($("#warehouseLocation").val());
			$("#warehouseName").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法
		});

		function findWarehouse(location) {
			new myselect({
				obj_id : "warehouseName",
				url : "${ctx}/warehouse/findWareHouseByLocation.shtml",
				data : {
					"location_id" : location
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
				findCheckDetail();
			}, function() {
				//初始化执行方法
			});
		}
		
		function findCheckDetail(){
			var wId = $("#warehouseName").val();
			$.ajax({
				type:'post',
				dataType:'json',
				url:'${ctx}/liangshilunhuanchukubaoguanhao/findCheckDetail.shtml',
				data:{id:wId},
				success:function(data){
					if(data != null){
						console.log(data);
						$("#grainVariety").val(data.variety);
						$("#grainProperty").val(data.property);
						$("#packageWay").val(data.package);
						$("#wsf").val(data.sf);
						$("#wzz").val(data.zz);
						$("#wzz").val(data.zz);
						$("#yiyu").val(data.cangKu);
						$("#outWeight").val(data.outTotalWeight);
						$("#inWeight").val(data.inTotalWeight);
						$("#gslCategory").val(data.name);
						$("#gslProperty").val(data.quanZhong);
						$("#gslPackageWay").val(data.packageWay);
					}else{
						$("#grainVariety").val("");
						$("#grainProperty").val("");
						$("#packageWay").val("");
						$("#wsf").val("");
						$("#wzz").val("");
						$("#wzz").val("");
						$("#yiyu").val("");
						$("#outWeight").val("");
						$("#inWeight").val("");
						$("#gslCategory").val("");
						$("#gslProperty").val("");
						$("#gslPackageWay").val("");
					}
					shuize();
					getDays();
					getTotal();
				},
				error:function(){
					
				}
			});
		}
		//计算水杂损耗
		function shuize(){
			//进仓水分
			var wsf = parseFloat(clearEmpty($("#wsf").val())).toFixed(2);
			//出仓水分
			var osf = parseFloat(clearEmpty($("#osf").val())).toFixed(2);
			//进仓杂质
			var wzz = parseFloat(clearEmpty($("#wzz").val())).toFixed(2);
			//出仓杂质
			var ozz = parseFloat(clearEmpty($("#ozz").val())).toFixed(2);
			//库存数量
			var iWeight = parseFloat(clearEmpty($("#inWeight").val())).toFixed(2);
			
			var sf = (wsf-osf)/(100-osf)*iWeight;
			var zz = (wzz-ozz)/(100-ozz)*iWeight;
			$("#shuizahaoshuliang").val(parseFloat(sf+zz).toFixed(2));
			
			getTotal();
		}
		
		function getDays(){
			var startDate=$("#dateformat").val();
			var endDate=$("#dateformat1").val();
			if(startDate != null && startDate != '' && endDate != null && endDate != '' ){
				var days = GetDateDiff(startDate,endDate);
				$("#baoguantianshu").val(days);
				var rate = 0;
				if(days<183){
					rate = 1/1000;
				}else if(days<365){
					rate = 1.5/1000;
				}else{
					rate = 2/1000;
				}
				$("#ziranhaobili").val(rate);
				//库存数量
				var iWeight = parseFloat(clearEmpty($("#inWeight").val())).toFixed(2);
				//自然
				$("#ziranhaoshuliang").val(parseFloat(iWeight*rate).toFixed(2));
				
				getTotal();
			}
		}
		
		function getTotal(){
			//水杂
			var sz = parseFloat(clearEmpty($("#shuizahaoshuliang").val())).toFixed(2);
			//自然
			var bg = parseFloat(clearEmpty($("#ziranhaoshuliang").val())).toFixed(2);
			//溢余
			var yy = parseFloat(clearEmpty($("#yiyu").val())).toFixed(2);
			//总损耗
			var total = parseFloat(sz) + parseFloat(bg);
			$("#sunhaozongzhong").val(parseFloat(total).toFixed(2));
			
			
			$("#chadingersunhao").val(parseFloat(yy-sz-bg).toFixed(2));
			
		}
		
		//使未填数据为0计算
		function clearEmpty(val){
			if(val == null || val == ''){
				return 0;
			}
			return val;
		}
		//计算两个日期相差天数
		function GetDateDiff(startDate,endDate)  
		{  
		    var startTime = new Date(Date.parse(startDate.replace(/-/g,   "/"))).getTime();     
		    var endTime = new Date(Date.parse(endDate.replace(/-/g,   "/"))).getTime();     
		    var dates = Math.abs((startTime - endTime))/(1000*60*60*24);     
		    return  dates;    
		}
		
		function _submit() {
			if($("#form").form("validate")){
				$("#form").submit();     
		     }
		}
		
		function complateLossMoney(){
			var price = $("#lossPrice").val();
			var weight = $("#yiyu").val();
			$("#lossMoney").val(parseFloat(weight*price).toFixed(2));
		}
	</script>
</body>
</html>
