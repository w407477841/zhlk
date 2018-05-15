function validInt(obj) {
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
		obj.value = val;
	} else {
		obj.value = 0;
	}
}

function validFloat(obj) {
	var val = obj.value;
	while (val.length > 0) {
		var ind = val.indexOf(".");
		if (ind >= 0) { // 判断是否有小数点
			var temp = val.substring(ind + 1);
			var tind = temp.indexOf(".");
			if (tind >= 0) { // 判断是否有两个小数点
				val = '0.0';
				break;
			} else {
				var integer = val.substring(0, ind);
				var decimal = val.substring(ind + 1);
				if (integer == null || integer == '') {
					integer = 0;

				} else {
					while (integer.indexOf("-") > 1) {
						integer = integer.replace("-", "");
					}

					while (integer.length > 0) { // 去除整数前的0
						var first = integer.substring(0, 1);
						if (first != '0') {
							break;
						} else {
							integer = integer.substring(1);
						}
					}
					if (integer == null || integer == '') {
						integer = 0;
					}
				}
				if (decimal.length != null && decimal.length != "") {
					while (decimal.indexOf("-") >= 0) {
						decimal = decimal.replace("-", "");
					}
				}
				if (decimal.length > 2) {
					decimal = decimal.substring(0, 2);
				}
				val = integer + "." + decimal;
				break;
			}
		} else { // 去除整数前的0
			var first = val.substring(0, 1);
			if (first != '0') {
				break;
			} else {
				val = val.substring(1);
			}
		}
	}
	if (val.length > 0) {
		obj.value = val;
	}
}
/**
 * 判断是否是数字
 * @param val
 * @returns {Boolean}
 */
function isNumber(val) {
	 //var reg1 = /^[0-9]+.?[0-9]*$/;
	 var reg = /^(\+|-)?\d+($|\.\d+$)/;
	if (reg.test(val)) {
		return true;
	}else{
		return false;
	}
}


function shotDateStr(date) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	var str = y + '-' + (m < 10 ? ('0' + m) : m) + '-'
			+ (d < 10 ? ('0' + d) : d);
	return str;
}
function shotDate(s) {
	if (!s)
		return new Date();
	var y = s.substring(0, 4);
	var m = s.substring(5, 7);
	var d = s.substring(8, 10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
		return new Date(y, m - 1, d);
	} else {
		return new Date();
	}
}

function chengeToUpper(obj) {
	var number = [ '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' ];
	var bit = [ '拾', '佰', '仟', '万', '亿' ];
	var val = obj.value.replace(/\D/g, '');
	obj.value = val;
	var result = '';
	var flag = false;
	var nvm = 0;
	if (val.length == 1) {
		if (val == '0') {
			result = number[0];
		} else {
			nvm = parseInt(val);
			result = number[nvm];
		}
	} else {
		var leng = val.length;
		for (var i = 0; i < leng; i++) {
			// 从尾部开始截取，个、十、百、千......
			var temp = val.substring(leng - i - 1, leng - i);
			nvm = parseInt(temp);
			if (nvm == 0 && i == 0) { // 第一位为0，不做处理

			} else if (nvm == 0 && !flag) {// 遇见第一个0，将标记设成true
				flag = true;
			} else if (nvm == 0 && flag) {// 遇见连续的非第一个0，不做任何处理

			} else if (nvm != 0 && flag) {// 当0结束时
				flag = false;
				var c = parseInt(i / 4); // 计算万、亿
				if (c == 0) {
					result = number[0] + result; // 拼接零
					result = bit[i - 1] + result; // 拼接位
					result = number[nvm] + result; // 拼接数字
				} else {
					var t = i - (c * 4); // 计算是十、百、千、十万、百万、千万
					if (t == 0) {
						result = number[0] + result; // 拼接零
						result = bit[c + 2] + result; // 拼接位
						result = number[nvm] + result; // 拼接数字
					} else {
						result = number[0] + result; // 拼接零
						if (result.indexOf(bit[c + 2]) > 0) { // 判断是否已经拼接位

						} else {
							result = bit[c + 2] + result; // 拼接位，万亿
						}
						result = bit[t - 1] + result; // 拼接位，十百千
						result = number[nvm] + result; // 拼接数字
					}
				}

			} else if (nvm != 0 && !flag) {
				var c = parseInt(i / 4); // 计算万、亿
				if (c == 0) {
					if (i > 0) {
						result = bit[i - 1] + result; // 拼接位
					}
					result = number[nvm] + result; // 拼接数字
				} else {
					var t = i - (c * 4); // 计算是十、百、千、十万、百万、千万
					if (t == 0) {
						result = bit[c + 2] + result; // 拼接位
						result = number[nvm] + result; // 拼接数字
					} else {
						result = bit[t - 1] + result; // 拼接位，十百千
						result = number[nvm] + result; // 拼接数字
					}
				}

			}
		}
	}
	// 获取最后一位
	var lastNumber = result.substring(result.length - 1, result.length);
	// 如果最后一位是零，则去掉
	if (lastNumber == number[0]) {
		result = result.substring(0, result.length - 1);
	}
	// 获取前两位
	var firstNumber = result.substring(0, 2);
	// 将首个壹拾转换成拾，方便人的阅读
	if (firstNumber == '壹拾') {
		result = result.substring(1, result.length);
	}
	return result;
}
function chengeFloatToUpper(obj) {
	var number = [ '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' ];
	var bit = [ '拾', '佰', '仟', '万', '亿' ];
	var val = obj.value.replace(/[^\-?\d.]/g, '');
	obj.value = val;
	var result = '';
	var flag = false;
	var nvm = 0;
	var indx = val.indexOf('.');
	var dec = 0;
	var flgdec = false;
	if(indx>0){ //含有小数点
		dec = val.substring(indx+1,val.length);
		val = val.substring(0,indx);
		flgdec = true;
	}
	
	
	if (val.length == 1) {
		if (val == '0') {
			result = number[0];
		} else {
			nvm = parseInt(val);
			result = number[nvm];
		}
	} else {
		var leng = val.length;
		for (var i = 0; i < leng; i++) {
			// 从尾部开始截取，个、十、百、千......
			var temp = val.substring(leng - i - 1, leng - i);
			nvm = parseInt(temp);
			if (nvm == 0 && i == 0) { // 第一位为0，不做处理

			} else if (nvm == 0 && !flag) {// 遇见第一个0，将标记设成true
				flag = true;
			} else if (nvm == 0 && flag) {// 遇见连续的非第一个0，不做任何处理

			} else if (nvm != 0 && flag) {// 当0结束时
				flag = false;
				var c = parseInt(i / 4); // 计算万、亿
				if (c == 0) {
					result = number[0] + result; // 拼接零
					result = bit[i - 1] + result; // 拼接位
					result = number[nvm] + result; // 拼接数字
				} else {
					var t = i - (c * 4); // 计算是十、百、千、十万、百万、千万
					if (t == 0) {
						result = number[0] + result; // 拼接零
						result = bit[c + 2] + result; // 拼接位
						result = number[nvm] + result; // 拼接数字
					} else {
						result = number[0] + result; // 拼接零
						if (result.indexOf(bit[c + 2]) > 0) { // 判断是否已经拼接位

						} else {
							result = bit[c + 2] + result; // 拼接位，万亿
						}
						result = bit[t - 1] + result; // 拼接位，十百千
						result = number[nvm] + result; // 拼接数字
					}
				}

			} else if (nvm != 0 && !flag) {
				var c = parseInt(i / 4); // 计算万、亿
				if (c == 0) {
					if (i > 0) {
						result = bit[i - 1] + result; // 拼接位
					}
					result = number[nvm] + result; // 拼接数字
				} else {
					var t = i - (c * 4); // 计算是十、百、千、十万、百万、千万
					if (t == 0) {
						result = bit[c + 2] + result; // 拼接位
						result = number[nvm] + result; // 拼接数字
					} else {
						result = bit[t - 1] + result; // 拼接位，十百千
						result = number[nvm] + result; // 拼接数字
					}
				}

			}
		}
	}
	// 获取最后一位
	var lastNumber = result.substring(result.length - 1, result.length);
	// 如果最后一位是零，则去掉
	if (lastNumber == number[0]) {
		result = result.substring(0, result.length - 1);
	}
	// 获取前两位
	var firstNumber = result.substring(0, 2);
	// 将首个壹拾转换成拾，方便人的阅读
	if (firstNumber == '壹拾') {
		result = result.substring(1, result.length);
	}
	
	if(flgdec){//包含小数
		result+= '点';
		for(var i=0;i<dec.length;i++){
			result+= number[dec.substring(i,i+1)];
		}
	}
	
	return result;
}