//style对象
var width = document.defaultView.getComputedStyle($("#magazineGrid")[0], null).width;
var params={car:[]};

function Grid_Format(param, width) {
	param = param || {}
	this.field = param.Abbreviation;
	this.title = param.CodeName;
	this.width = width || 180;
	this.formatter = param.formatter || undefined;
	this.editor = 'text';

}

function GridStandard(param) {
	this.standard = param.Standard;
	this.Min = param.Min;
	this.Max = param.Max;
	this.step = param.Step;
	this.reduce = param.Reduce;
	this.reducing = param.Reducing;
	this.promote = param.Promote;
	this.promoting = param.Promoting;
}
function dataColumn() {
}
Grid_Format.prototype = {
	constroctor : Grid_Format,
	data : new dataColumn(),
	addSelfAttr : function(attrName, value) {
		Object.defineProperty(this.data, attrName, {
			value : value * 1,
			writable : true,
			configurable : true,
			enumerable : true
		})
	},
	addExtendAttr : function(attrName, value) {
		// 覆盖
		//this.data.__proto__[attrName] = value;
		dataColumn.prototype[attrName]=value;
		//console.log(this.data.__proto__===dataColumn.prototype);
	}

}
// 初始化
function initStandard(code) {
	$.ajax({
		url : rootPath + "/storage/queryStandards.shtml",
		type : "post",
		data : {
			"code" : code || 1114
		},
		success : function(rs) {

			// 初始化价格
			$("#price").val(rs.price.BuyPrice);
			$("#level").val(rs.price.Level);

			var gridFormatArr = [];
			var gridData = null;
			// 获取长度:
			var computerredWidth = Math.floor(width.replace("px", "")
					/ (rs.list.length + 1));
			for ( var i = 0; i < rs.list.length; i++) {
				// 构造列
				var gridFormat = new Grid_Format(rs.list[i], computerredWidth);
				// 构造数据
				gridFormat.addSelfAttr(rs.list[i].Abbreviation,rs.list[i].Standard.split(",")[0]);
				// 原型属性
				gridFormat.addExtendAttr("_" + rs.list[i].Abbreviation,
						new GridStandard(rs.list[i]));
				gridFormat.addExtendAttr("_price", rs.price.BuyPrice);
				gridFormat.addExtendAttr("_stepPrice", rs.price.StepPrice);
				gridFormat.addExtendAttr("_level", rs.price.Level);

				gridFormatArr.push(gridFormat);
				gridData = gridFormat.data;
			}
			bulidChart(gridData, gridFormatArr, computerPrice)
		}
	})
}

// 生成表格
function bulidChart(gridData, gridFormatArr, f) {
	var grid = $('#magazineGrid').datagrid(
					{
						rownumbers : false,
						data : [ gridData ],
						columns : [ gridFormatArr ],
						onClickCell : function(index, field, value) {
							if (!endEditing(index, field))
								return false;
							$('#magazineGrid').datagrid('selectRow', index)
									.datagrid('editCell', {
										index : index,
										field : field
									});
							var selected = $('#magazineGrid').datagrid(
									'getData').rows[index]
							var stand = $('#magazineGrid').datagrid(
									'getColumnOption', field);
							// 计算价格等级和扣量
							if (Object.prototype.toString.call(f).slice(8, 16) == "Function")
								f.call(undefined, selected);
							bulidChart.editIndex = index;
						}
					});

}

function computerPrice(data) {
	var currentPrice = $("#price").val();
	var currentLevel = $("#level").val();
	var currentPercent = $("#percentage").val();
	// console.log(data)
	var every = {}, sum = 0;
	for (i in data) {
		if (data.hasOwnProperty(i)) {
			switch (i) {
			// 容重
			case "rz":
				if (data[i] > (data["_" + i].Max.split(",")[0])
						|| data[i] < (data["_" + i].Min.split(",")[0])) {
					layer.alert("超出范围标准!");
					data[i] = data["_" + i].standard.split(",")[0];
				} else {
					let
					temp = data[i] * 1 - data["_" + i].standard.split(",")[0]
							* 1;
					let
					symbol = temp > 0 ? 1 : -1;
					let
					step = (Math.floor(Math.abs(temp) / data["_" + i].step))
							* symbol;
					// 等级
					currentLevel = data._level - step < 1 ? 1 : ((data._level
							- step > 5) ? "5" : data._level - step);
					$("#level").val(currentLevel);

					// 价格根据等级
					currentPrice = data._price * 1
							- (currentLevel - data._level * 1)
							* data._stepPrice;
					$("#price").val(currentPrice.toFixed(2))
				}
				break;

			// 水分的总扣量不会超过3%
			case "sf":
				if (data[i] * 1 > (data["_" + i].Max)
						|| data[i] * 1 < data["_" + i].Min) {
					layer.alert("超出范围标准!");
					data[i] = data["_" + i].standard;
				} else {
					let
					temp = data[i] * 1 - data["_" + i].standard * 1;
					let
					symbol = temp > 0 ? 1 : -1;
					let
					step = (Math.floor(Math.abs(temp) / data["_" + i].reduce))
							* symbol;
					currentPercent = step > 0 ? data["_" + i].reducing * step
							: data["_" + i].promoting * step
					currentPercent = currentPercent < -3 ? -3 : currentPercent;
					every[i] = currentPercent;
					sum += currentPercent;
				}
				break;

			// 矿物质含量只占固定0.75%
			case "kwz":
				if (data[i] * 1 > (data["_" + i].Max)
						|| data[i] * 1 < data["_" + i].Min) {
					layer.alert("超出范围标准!");
					data[i] = data["_" + i].standard;
				} else {
					currentPercent = data[i] * 1 - data["_" + i].standard * 1 > 0 ? 0.75
							: 0;
					every[i] = currentPercent;
					sum += currentPercent;
				}
				break;
			// 整精米占比越低,扣量越高
			case "zjml":
				if (data[i] * 1 > (data["_" + i].Max)
						|| data[i] * 1 < data["_" + i].Min) {
					layer.alert("超出范围标准!");
					data[i] = data["_" + i].standard;
				} else {
					let
					temp = data[i] * 1 - data["_" + i].standard * 1;
					let
					symbol = temp > 0 ? -1 : 1;
					let
					step = (Math.floor(Math.abs(temp) / data["_" + i].reduce))
							* symbol;
					currentPercent = step > 0 ? data["_" + i].reducing * step
							: data["_" + i].promoting * step
					every[i] = currentPercent;
					sum += currentPercent;
				}
				break;

			// 其他算法一致
			default:
				if (data[i] * 1 > (data["_" + i].Max)
						|| data[i] * 1 < data["_" + i].Min) {
					layer.alert("超出范围标准!");
					data[i] = data["_" + i].standard;
				} else {
					let
					temp = data[i] * 1 - data["_" + i].standard * 1;
					let
					symbol = temp > 0 ? 1 : -1;
					let
					step = (Math.floor(Math.abs(temp) / data["_" + i].reduce))
							* symbol;
					currentPercent = step > 0 ? data["_" + i].reducing * step
							: data["_" + i].promoting * step
					every[i] = currentPercent;
					sum += currentPercent;
				}
			}

		}
	}
	$("#percentage").val(sum);
	$('#magazineGrid').datagrid('reload')

}

// 结束编辑
function endEditing(index, field) {
	if (bulidChart.editIndex == undefined) {
		return true
	}
	if ($('#magazineGrid').datagrid('validateRow', bulidChart.editIndex)) {
		$('#magazineGrid').datagrid('endEdit', bulidChart.editIndex);
		bulidChart.editIndex = undefined;
		return true;
	} else {
		return false;
	}
}

initLocation();initProperty();
function initLocation() {
	$.ajax({
		url : rootPath + "/kcxx/locations.shtml",
		type : "post",
		async : false,
		data : {
			"source" : 1
		},
		success : function(rs) {
			var sel = document.getElementById("selectLocation");
			if (rs.success) {
				for ( var i = 0; i < rs.list.length; i++) {
					sel.add(new Option(rs.list[i].wName, rs.list[i].wNo))
				}
			}

		}
	})
}

function initProperty() {
	$.ajax({
		url : rootPath + "/kcxx/properties.shtml",
		type : "post",
		async : false,
		data : {
			"source" : 1
		},
		success : function(rs) {
			var sel = document.getElementById("selectProperty");
			if (rs.success) {
				for ( var i = 0; i < rs.list.length; i++) {
					sel.add(new Option(rs.list[i].text, rs.list[i].id))
				}
			}

		}
	})
}

$("#selectLocation").on("change",function(event) {
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

$("#selectBreed").on("change", function() {
	initStandard(this.value);
}).trigger("change")



$("#selectCar").on("change",function(){
	
	if(this.value=="1"){
		 layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>选择车辆<h5>",
			type : 2,
			maxmin : true,
			area : [ "1100px", "500px" ],
			content : rootPath + "/storage/car/listUI.shtml",
			end : function() {
				grid.datagrid("reload");
			}
		});
	}
	
})


$("#form").validate({
	submitHandler : function(form) {

		let
		columnData = $('#magazineGrid').datagrid('getData').rows[0];
		columnData.price = $("#price").val();
		columnData.level = $("#level").val();
		columnData.amountPercent = $("#percentage").val();
		
		var obj = new Object();
		Object.keys(columnData).forEach(function(index) {
			obj["InstorageQualityFormMap." + index] = columnData[index];
		})
		
		obj.cars=params.car.join(",");
		
		ly.ajaxSubmit(form, {
			type : "post",
			dataType : "json",
			data : obj,
			success : function(data) {
				if (data) {
					
					//form.reset();
					$("#form-carid,#form-address,#form-phone,#form-identity,#form-name").val("");
					
					
					alert('添加成功！', 3);
					setTimeout(function() {
						parent.layer.closeAll()
					}, 1000)
				} else {
					alert('添加失败！', 3);
				}
			}
		});
	},
	rules : {
		"StorageFormMap.Owner" : {
			required : true
		},
		"StorageFormMap.Identity" : {
			required : true
		},
		"StorageFormMap.Phone" : {
			required : true
		},
		"StorageFormMap.Address" : {
			required : true
		},
		"StorageFormMap.CarID" : {
			required : true
		}

	},
	messages : {},
	errorPlacement : function(error, element) {
		if (element[0].classList.contains("error")) {
			element[0].style.cssText = "border: 1px solid #ff0000";
		} else if (element[0].classList.contains("valid")) {
			element[0].style.cssText = "";
		}

	},
	success : function(label) {// 验证通过后
		label.parent().attr("class", "has-success");
	}
});

// 验证select
function vaildateSelects() {
	var eles = document.forms[0].elements;
	var ids = [];
	var j = 0
	for ( var i = 0; i < eles.length; i++) {
		if (eles[i].type == "select-one" && eles[i].id) {
			ids.push(eles[i].id + "_chosen");
		}
	}
	ids.forEach(function(str, index) {
				var t = document.getElementById(str).children[0].children[0].textContent;
				var n = document.getElementById(str.replace("_chosen", "")).dataset.placeholder;
				document.getElementById(str).children[0].style
						.removeProperty("border");
				if (t == "" || t == n) {
					j++;
					document.getElementById(str).scrollIntoView();
					document.getElementById(str).children[0].style.setProperty(
							"border", "1px solid #ff0000");
					return false
				}
			})
	return !!!j
}

function _submit() {
	if (typeof vaildateSelects == "function" && vaildateSelects.call(null))
		$("#form").submit();
}

$.extend($.fn.datagrid.methods, {
	editCell : function(jq, param) {
		return jq.each(function() {
			var opts = $(this).datagrid('options');
			var fields = $(this).datagrid('getColumnFields', true).concat(
					$(this).datagrid('getColumnFields'));
			for ( var i = 0; i < fields.length; i++) {
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor1 = col.editor;
				if (fields[i] != param.field) {
					col.editor = null;
				}
			}
			$(this).datagrid('beginEdit', param.index);
			for ( var i = 0; i < fields.length; i++) {
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor = col.editor1;
			}
		});
	}
});