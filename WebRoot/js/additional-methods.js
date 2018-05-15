//验证通过　整数　或者小数
jQuery.validator.addMethod("decimal", function(value, element, param) {
    var decimal=value;
   var reg=/^(\d|[1-9]\d*)(.\d*[1-9])?$/;
  return reg.exec(decimal);   
}, "请输入正确的小数");