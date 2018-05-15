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
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">药剂申请</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/yaojilingyongshenqing/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮库地点<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							name="yaoJiShenQingFormMap.maWLNo" data-rel="chosen"
							data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂名称<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select id="selectName" data-rel="chosen"
							data-placeholder="请选择一种药剂" name="yaoJiShenQingFormMap.maMrId"
							style="width:200px">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂品牌</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrBrand"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">单位</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrPage"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂规格</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrStandard"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂单价(元)</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrPrice"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂库存数量</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrNumber"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂包装</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrUnit"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">生产日期</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrManufactureDate"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">生产厂家</div>
				<div class="col-md-11">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrProductCompany"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">申请数量<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入申请数量" data-options="required:true" id="number"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validIOK(this)" name="yaoJiShenQingFormMap.maQuantity"
							placeholder="请输入 ：领用数量" maxlength="9">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">申请人<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入申请人" data-options="required:true"
							name="yaoJiShenQingFormMap.maApplicant" placeholder="请输入 ：申请人" value="${userSession.userName}"
							maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">用途</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							name="yaoJiShenQingFormMap.maUsed" placeholder="请输入 ：用途"
							maxlength="256"></textarea>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">备注</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							name="yaoJiShenQingFormMap.remark" placeholder="请输入 ：备注"
							maxlength="256"></textarea>
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">保存</button>
				<button type="button" class="btn btn-info bt-submit"
					onclick="_approve()">提交审批</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
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
			$("#selectName").html("");
			$("#selectName").chosen("destroy");
			findDrug($("#warehouseLocation").val());
			clear();
			$("#selectName").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法
		});

		function findDrug(location) {
			new myselect({
				obj_id : "selectName",
				url : "${ctx}/yaojikucunguanli/findByLocationId.shtml",
				data : {
					"location_id" : location
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "mrName" ],
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
				findData($("#selectName").val());
			}, function() {
				//初始化执行方法
			});
		}

		function findData(obj) {
			var _url = "${ctx}/yaojikucunguanli/findById.shtml";
			$.ajax({
				type : "POST",
				url : _url,
				async : true,
				data : "id=" + obj,
				success : function(data) {
					$("#mrBrand").val(data.mrBrand);
					$("#mrPage").val(data.page);
					$("#mrStandard").val(data.mrStandard);
					$("#mrPrice").val(data.mrPrice);
					$("#mrNumber").val(data.mrNumber);
					$("#mrUnit").val(data.mrUnit);
					$("#mrManufactureDate").val(data.mrManufactureDate);
					$("#mrProductCompany").val(data.mrProductCompany);
				}
			});
		}

		function clear() {
			$("#mrBrand").val("");
			$("#mrPage").val("");
			$("#mrStandard").val("");
			$("#mrPrice").val("");
			$("#mrNumber").val("");
			$("#mrUnit").val("");
			$("#mrManufactureDate").val("");
			$("#mrProductCompany").val("");
		}

		function validIOK(obj) {
			var val = obj.value;
			while (val.length > 0) {
				var first = val.substring(0, 1);
				if (first != '0') {
					break;
				} else {
					val = val.substring(1);
				}
			}
			if (val.length > 0) {
				var repository = document.getElementById("mrNumber").value;
				if (parseInt(val) > parseInt(repository)) {
					obj.value = repository;
				} else {
					obj.value = val;
				}
			} else {
				obj.value = 1;
			}
		}

		function _submit() {
			if($("#form").form("validate")){
				$("#form").submit();     
		     }
		}
		function _approve() {
			$("#form").attr("action",
					"${ctx}/yaojilingyongshenqing/approve.shtml");
			if($("#form").form("validate")){
				$("#form").submit();     
		     }
		}
	</script>
</body>
</html>
