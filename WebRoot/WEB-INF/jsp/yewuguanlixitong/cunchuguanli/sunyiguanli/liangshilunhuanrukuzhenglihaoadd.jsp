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
			<h3 class="animated rubberBand">粮食轮换入库整理耗</h3>
		</div>
	</div>
	<div class=" col-md-4"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/liangshilunhuanrukuzhenglihao/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">粮库地点<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							data-rel="chosen" data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">仓号<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<select class="form-control" id="warehouseName"
							name="lunHuanRuKuZhengLiHaoFormMap.pslWId" data-rel="chosen"
							data-placeholder="请选择仓号">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">粮食品种<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" id="grainVariety" class="form-control easyui-validatebox" missingMessage="请输入粮食品种"
								data-options="required:true"
							readonly="readonly">
							
							 <input type="hidden"
							id="selectcategory"
							name="lunHuanRuKuZhengLiHaoFormMap.pslCategory"
							class="form-control">

					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">进仓日期</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="dateformat"
							placeholder="请输入 ：进仓日期"
							name="lunHuanRuKuZhengLiHaoFormMap.pslPutInDate">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">进仓水分(%)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="sf"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="shuize()"
							name="lunHuanRuKuZhengLiHaoFormMap.pslPutInFluid"
							placeholder="请输入 ：进仓水分(%)" maxlength="5">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">整理后水分(%)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="zsf"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="shuize()"
							name="lunHuanRuKuZhengLiHaoFormMap.pslCleanUpFluid"
							placeholder="请输入 ：整理后水分(%)" maxlength="5">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">进仓杂质(%)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="zz"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="shuize()"
							name="lunHuanRuKuZhengLiHaoFormMap.pslPutInImpurity"
							placeholder="请输入 ：进仓杂质(%)" maxlength="5">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">整理后杂质(%)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="zzz"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="shuize()"
							name="lunHuanRuKuZhengLiHaoFormMap.pslCleanUpImpurity"
							placeholder="请输入 ：整理后杂质(kg)" maxlength="5">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">进仓数量(kg)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="zl"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)"
							name="lunHuanRuKuZhengLiHaoFormMap.pslPutInWeight"
							placeholder="请输入 ：进仓数量(kg)" maxlength="11">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">整理后数量(kg)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="zzl"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)"
							name="lunHuanRuKuZhengLiHaoFormMap.pslCleanUpWeight"
							placeholder="请输入 ：整理后数量(kg)" maxlength="11">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">水分减量(kg)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="sfjs"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)"
							name="lunHuanRuKuZhengLiHaoFormMap.pslFluidReduce"
							placeholder="请输入 ：水分减量(kg)" maxlength="11">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">整理去杂减量(kg)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="zzjs"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)"
							name="lunHuanRuKuZhengLiHaoFormMap.pslImpurityReduce"
							placeholder="请输入 ：整理去杂减量(kg)" maxlength="11">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">损耗总量(kg)<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入损耗总量"
								data-options="required:true" id="totalr"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)"
							name="lunHuanRuKuZhengLiHaoFormMap.pslTotalReduce"
							placeholder="请输入 ：损耗总量(kg)" maxlength="11">
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
							layer.alert('添加失败！', {
								icon : 5
							});
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

		function findCheckDetail() {
			var wId = $("#warehouseName").val();
			$.ajax({
						type : 'post',
						dataType : 'json',
						url : '${ctx}/liangshilunhuanrukuzhenglihao/findCheckDetail.shtml',
						data : {
							id : wId
						},
						success : function(data) {
							if (data != null) {
								$("#grainVariety").val(data.text);
								$("#selectcategory").val(data.name);
								$("#sf").val(data.sf);
								$("#zz").val(data.zz);
								$("#zl").val(parseFloat(data.cangKu));

							} else {
								$("#grainVariety").val("");
								$("#selectcategory").val("");
								$("#sf").val("");
								$("#zz").val("");
								$("#zl").val("");
							}
						},
						error : function() {

						}
					});
		}
		
		//计算水杂损耗
		function shuize(){
			//进仓水分
			var wsf = parseFloat(clearEmpty($("#sf").val()));
			//整理水分
			var osf = parseFloat(clearEmpty($("#zsf").val()));
			//进仓杂质
			var wzz = parseFloat(clearEmpty($("#zz").val()));
			//整理杂质
			var ozz = parseFloat(clearEmpty($("#zzz").val()));
			//库存数量
			var iWeight = parseFloat(clearEmpty($("#zl").val()));
			
			var sf = parseFloat((osf-wsf)/(100-osf)*iWeight).toFixed(0);
			var zz = parseFloat((ozz-wzz)/(100-ozz)*iWeight).toFixed(0);
			
			var totalr = parseFloat(parseFloat(sf)+parseFloat(zz)).toFixed(0);
			
			var zzl = parseFloat(iWeight+parseFloat(totalr)).toFixed(0);
			
			$("#sfjs").val(sf);
			$("#zzjs").val(zz);
			$("#totalr").val(totalr);
			$("#zzl").val(zzl);
		}
		//使未填数据为0计算
		function clearEmpty(val){
			if(val == null || val == ''){
				return 0;
			}
			return val;
		}
		function _submit() {
			if($("#form").form("validate")){
				$("#form").submit();     
		     }
		}
	</script>
</body>
</html>
