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
			<h3 class="animated rubberBand">添加智能窗户</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12 ">
		<form id="form" class="form-horizontal" name="form" method="post"
			action="${ctx}/windowConfig/add.shtml">
			<input type="hidden" name="token" value="${token}" />

			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">
					窗户名称<span>*</span>
				</div>
				<div class="col-sm-6">
					<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入窗户名称" data-options="required:true" id="name"
						name="windowConfigFormMap.name" maxlength="50" placeholder="请输入 ：窗户名称">
				</div>
				<div class="help-block col-sm-4">给该窗户起个响亮的名字</div>
			</div>

			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">
					所属粮库<span>*</span>
				</div>
				<div class="col-sm-6">
					<select id="selectLocation" data-rel="chosen"
						data-placeholder="所属粮库">
						<option value=""></option>
					</select>
				</div>
				<div class="help-block col-sm-4">选择粮站</div>
			</div>

			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">
					点位<span>*</span>
				</div>
				<div class="col-sm-6">
					<select id="selectHouse" data-rel="chosen" data-placeholder="点位"
						name="windowConfigFormMap.cangkudianwei">
						<option value=""></option>
					</select>
				</div>
				<div class="help-block col-sm-4">选择仓库点位，用于定位</div>
			</div>

			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">
					IP地址<span>*</span>
				</div>
				<div class="col-sm-6">
					<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入IP地址" data-options="required:true" id="ipNum"
						name="windowConfigFormMap.ip" value="" placeholder="请输入 ：ip" maxlength="15">
				</div>
				<div class="help-block col-sm-4">该处输入窗户控制元件IP</div>
			</div>
			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">
					端口号<span>*</span>
				</div>
				<div class="col-sm-6">
					<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入端口号" data-options="required:true" id="sLeft"
						name="windowConfigFormMap.port" value="" placeholder="请输入 ：端口号" maxlength="10">
				</div>
				<div class="help-block col-sm-4">该处输入控制元件端口号</div>
			</div>
			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">方向</div>
				<div class="col-sm-6">
					<select id="selectLX" data-rel="chosen" data-placeholder="方向"
						name="windowConfigFormMap.direction">
						<option value=""></option>
						<option value="E">东</option>
						<option value="W">西</option>
						<option value="S">南</option>
						<option value="N">北</option>
						<option value="ES">东南</option>
						<option value="WS">西南</option>
						<option value="EN">东北</option>
						<option value="WN">西北</option>
					</select>

				</div>
				<div class="help-block col-sm-4">选择窗户朝向方向</div>
			</div>


			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">开启(闭合)</div>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="open1" maxlength="40"
						name="windowConfigFormMap.open1" value="" placeholder="开启(闭合)">
				</div>
				<div class="help-block col-sm-4">
					窗户开启(控制元件为闭合状态),<font class="text-danger"><strong>空格去除</strong></font>
				</div>
			</div>
			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">开启(断开)</div>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="open2" maxlength="40"
						name="windowConfigFormMap.open2" value="" placeholder="开启(断开)">
				</div>
				<div class="help-block col-sm-4">
					窗户开启停止(控制元件为断开状态),<font class="text-danger"><strong>空格去除</strong></font>
				</div>
			</div>
			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">开启附带选项</div>
				<div class="col-sm-6">
					<select id="selectneedClosedBeforeOpen" data-rel="chosen"
						data-placeholder="开启前执行"
						name="windowConfigFormMap.needClosedBeforeOpen">
						<option value="1">执行</option>
						<option value="0" selected="selected">不执行</option>
					</select>
				</div>
				<div class="help-block col-sm-4">
					开启前是否需要执行<font class="text-danger"><strong>关闭(断开)</strong></font>指令
				</div>
			</div>

			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">关闭(闭合)</div>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="close1" maxlength="40"
						name="windowConfigFormMap.close1" value="" placeholder="关闭(闭合)">
				</div>
				<div class="help-block col-sm-4">
					窗户关闭(控制元件为闭合状态),<font class="text-danger"><strong>空格去除</strong></font>
				</div>
			</div>


			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">关闭(断开)</div>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="close2" maxlength="40"
						name="windowConfigFormMap.close2" value="" placeholder="关闭(断开)">
				</div>
				<div class="help-block col-sm-4">
					窗户关闭停止(控制元件为断开状态),<font class="text-danger"><strong>空格去除</strong></font>
				</div>
			</div>

			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">关闭附带选项</div>
				<div class="col-sm-6">
					<select id="selectneedOpenBeforeClose" data-rel="chosen"
						data-placeholder="关闭前执行"
						name="windowConfigFormMap.needOpenBeforeClose">
						<option value="1">执行</option>
						<option value="0" selected="selected">不执行</option>
					</select>
				</div>
				<div class="help-block col-sm-4">
					关闭前是否需要执行<font class="text-danger"><strong>开启(断开)</strong></font>指令
				</div>
			</div>

			<div class="form-group col-sm-12">
				<div class="col-sm-2 div_label">总时长</div>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="duration" maxlength="8"
						name="windowConfigFormMap.duration" value="" placeholder="总耗时（毫秒）">
				</div>
				<div class="help-block col-sm-4">开启/关闭的总时长,用于部分开启/关闭</div>
			</div>
			<div class="form-group col-sm-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		new myselect({
			obj_id : "selectLocation",
			url : rootPath + "/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
			$("#selectHouse").html("");
			$("#selectHouse").chosen("destroy");
			findSel($("#selectLocation").val());
			$("#selectHouse").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法
		});

		function findSel(wId) {
			new myselect({
				obj_id : "selectHouse",
				url : rootPath + "/sensorManager/findByHouseSelect.shtml",
				data : {
					"location" : wId
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "name" ],
				option_html_prefix : ","
			}, function() {
				//给change事件添加方法
			}, function() {
				//初始化执行方法
			});
		}

		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data) {
							layer.confirm('添加成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('添加失败！', 3);
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

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
