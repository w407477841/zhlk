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
	<div id="errorDiv" class="col-md-12"></div>
	<div class=" col-md-8">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">粮食轮换出库保管耗</h3>
		</div>
	</div>
	<div class=" col-md-4"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/liangshilunhuanchukubaoguanhao/edit.shtml">
			<input type="hidden" name="lunHuanChuKuBaoGuanHaoFormMap.id"
				value="${lunHuanChuKuBaoGuanHaoFormMap.id }"> <input
				type="hidden" name="lunHuanChuKuBaoGuanHaoFormMap.version"
				value="${lunHuanChuKuBaoGuanHaoFormMap.version }"> <input
				type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">粮库地点<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" readonly="readonly" value="${lunHuanChuKuBaoGuanHaoFormMap.wlName }" class="form-control" >
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">仓号<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" readonly="readonly" value="${lunHuanChuKuBaoGuanHaoFormMap.wName }" class="form-control">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">粮食品种<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" id="grainVariety" readonly="readonly" class="form-control easyui-validatebox" missingMessage="请输入粮食品种"
								data-options="required:true" value="${lunHuanChuKuBaoGuanHaoFormMap.text }">
						<input type="hidden" id="gslCategory" name="lunHuanChuKuBaoGuanHaoFormMap.gslCategory" value="${lunHuanChuKuBaoGuanHaoFormMap.gslCategory }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">粮食性质<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" id="grainProperty" readonly="readonly" class="form-control easyui-validatebox" missingMessage="请输入粮食品种"
								data-options="required:true" placeholder="请输入 ：粮食性质"  value="${lunHuanChuKuBaoGuanHaoFormMap.property }">
						<input type="hidden" id="gslProperty" name="lunHuanChuKuBaoGuanHaoFormMap.gslProperty" value="${lunHuanChuKuBaoGuanHaoFormMap.gslProperty }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">包装方式<span>*</span></div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" id="packageWay" readonly="readonly" class="form-control easyui-validatebox" missingMessage="请输入粮食品种"
								data-options="required:true" placeholder="请输入 ：包装方式"  value="${lunHuanChuKuBaoGuanHaoFormMap.packageText }">
						<input type="hidden" id="gslPackageWay" name="lunHuanChuKuBaoGuanHaoFormMap.gslPackageWay" value="${lunHuanChuKuBaoGuanHaoFormMap.gslPackageWay }">
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
						    id="baoguantianshu" onfocus="getDays()" value="${lunHuanChuKuBaoGuanHaoFormMap.gslSaveDays }"
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
							placeholder="请输入 ：进仓日期" onblur="getDays()" value="${lunHuanChuKuBaoGuanHaoFormMap.gslPutInDate }"
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
							placeholder="请输入 ：出库日期" onblur="getDays()" value="${lunHuanChuKuBaoGuanHaoFormMap.gslGetOutDate }"
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
							 id="wsf" onchange="shuize()" value="${lunHuanChuKuBaoGuanHaoFormMap.gslPutInFluid }"
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
							 id="osf" onchange="shuize()" value="${lunHuanChuKuBaoGuanHaoFormMap.gslGetOutFluid }"
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
							 id="wzz" onchange="shuize()" value="${lunHuanChuKuBaoGuanHaoFormMap.gslPutInImpurity }"
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
							 id="ozz" onchange="shuize()" value="${lunHuanChuKuBaoGuanHaoFormMap.gslGetOutImpurity }"
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
							 id="inWeight" value="${lunHuanChuKuBaoGuanHaoFormMap.gslPutInWeight }"
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
							id="outWeight" value="${lunHuanChuKuBaoGuanHaoFormMap.gslGetOutWeight }"
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
							 id="sunhaozongzhong" value="${lunHuanChuKuBaoGuanHaoFormMap.gslTotalReduce }"
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
							 id="shuizahaoshuliang" value="${lunHuanChuKuBaoGuanHaoFormMap.gslCleanUpWeight }"
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
							 id="ziranhaobili" value="${lunHuanChuKuBaoGuanHaoFormMap.gslLossRate }"
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
							 id="ziranhaoshuliang" value="${lunHuanChuKuBaoGuanHaoFormMap.gslLossWeight }"
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
							 id="chadingersunhao" value="${lunHuanChuKuBaoGuanHaoFormMap.gslOverrateWeight }"
							name="lunHuanChuKuBaoGuanHaoFormMap.gslOverrateWeight"
							placeholder="请输入 ：超定额损耗(kg)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">溢余(kg)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"  value="${lunHuanChuKuBaoGuanHaoFormMap.gslOverflowWeight }" id="yiyu" readonly="readonly"
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
							placeholder="损耗单价(元/公斤)" maxlength="5" value="${lunHuanChuKuBaoGuanHaoFormMap.lossPrice }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">报损金额(元)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="lossMoney" onfocus="complateLossMoney()"
							name="lunHuanChuKuBaoGuanHaoFormMap.lossMoney" maxlength="12" value="${lunHuanChuKuBaoGuanHaoFormMap.lossMoney }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-2 div_label">备注</div>
				<div class="col-md-10">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control" name="lunHuanChuKuBaoGuanHaoFormMap.remark">${lunHuanChuKuBaoGuanHaoFormMap.remark }</textarea>
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
							layer.confirm('修改成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('修改失败！', {icon:5});
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
