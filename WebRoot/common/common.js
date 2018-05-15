/**
 * 工具组件 对原有的工具进行封装，自定义某方法统一处理
*/
;
(function() {
	ly = {};
	ly.ajax = (function(params) {
		var pp = {
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				layer.open({
					type : 1,
					title : "出错啦！",
					area : [ '95%', '95%' ],
					content : "<div id='layerError' style='color:red'>"
							+ XMLHttpRequest.responseText + "</div>"
				});
			}
		};
		$.extend(pp, params);
		$.ajax(pp);
	});
	ly.ajaxSubmit = (function(form, params) {// form 表单ID. params ajax参数
		var pp = {
			error : function(XMLHttpRequest, textStatus, errorThrown) {
			if(XMLHttpRequest.status==200){
				layer.alert("请勿重复提交",{icon:7});
			}
			else{
				layer.open({
					type : 1,
					title : "出错啦！",
					area : [ '95%', '95%' ],
					content : "<div id='layerError' style='color:red'>"
							+ XMLHttpRequest.responseText + "</div>"
				});
			}
			}
		};
		$.extend(pp, params);
		$(form).ajaxSubmit(pp);
	});
	CommnUtil = {
			disableButton :function(className,isDisabled){
				$("."+className).each(function(){
					$(this).attr('disabled',isDisabled);
				});
				
			},
		/**
		 * ajax同步请求 返回一个html内容 dataType=html. 默认为html格式 如果想返回json.
		 * CommnUtil.ajax(url, data,"json")
		 * 
		 */
		ajax : function(url, data, dataType) {
			if (!CommnUtil.notNull(dataType)) {
				dataType = "html";
			}
			var html = '没有结果!';
			// 所以AJAX都必须使用ly.ajax..这里经过再次封装,统一处理..同时继承ajax所有属性
			if (url.indexOf("?") > -1) {
				url = url + "&_t=" + new Date();
			} else {
				url = url + "?_t=" + new Date();
			}
			ly.ajax({
				type : "post",
				data : data,
				url : url,
				dataType : dataType,// 这里的dataType就是返回回来的数据格式了html,xml,json
				async : false,
				cache : false,// 设置是否缓存，默认设置成为true，当需要每次刷新都需要执行数据库操作的话，需要设置成为false
				success : function(data) {
					html = data;
				}
			});
			return html;
		},
		/**
		 * 判断某对象不为空..返回true 否则 false
		 */
		notNull : function(obj) {
			if (obj === null) {
				return false;
			} else if (obj === undefined) {
				return false;
			} else if (obj === "undefined") {
				return false;
			} else if (obj === "") {
				return false;
			} else if (obj === "[]") {
				return false;
			} else if (obj === "{}") {
				return false;
			} else {
				return true;
			}

		},

		/**
		 * 判断某对象不为空..返回obj 否则 ""
		 */
		notEmpty : function(obj) {
			if (obj === null) {
				return "";
			} else if (obj === undefined) {
				return "";
			} else if (obj === "undefined") {
				return "";
			} else if (obj === "") {
				return "";
			} else if (obj === "[]") {
				return "";
			} else if (obj === "{}") {
				return "";
			} else {
				return obj;
			}

		},
		loadingImg : function() {
			var html = '<div class="alert alert-warning">'
					+ '<button type="button" class="close" data-dismiss="alert">'
					+ '<i class="ace-icon fa fa-times"></i></button><div style="text-align:center">'
					+ '<img src="' + rootPath + '/images/loading.gif"/><div>'
					+ '</div>';
			return html;
		},
		/**
		 * html标签转义
		 */
		htmlspecialchars : function(str) {
			var s = "";
			if (str.length == 0)
				return "";
			for (var i = 0; i < str.length; i++) {
				switch (str.substr(i, 1)) {
				case "<":
					s += "&lt;";
					break;
				case ">":
					s += "&gt;";
					break;
				case "&":
					s += "&amp;";
					break;
				case " ":
					if (str.substr(i + 1, 1) == " ") {
						s += " &nbsp;";
						i++;
					} else
						s += " ";
					break;
				case "\"":
					s += "&quot;";
					break;
				case "\n":
					s += "";
					break;
				default:
					s += str.substr(i, 1);
					break;
				}
			}
		},
		/**
		 * in_array判断一个值是否在数组中
		 */
		in_array : function(array, string) {
			for (var s = 0; s < array.length; s++) {
				thisEntry = array[s].toString();
				if (thisEntry == string) {
					return true;
				}
			}
			return false;
		},
		/**
		 * 加载字典
		 * combotree jquery对象
		 * url 请求地址
		 * codeid 字典id
		 * required 是否必选
		 * missingMessage 为空时显示字段
		 */
		loadcode :function(combotree,url,codeid,required,missingMessage){
			var width=combotree.parent().css("width");
			width=width.substring(0,width.length-2);
			var height=combotree.parent().css("height");
			height=height.substring(0,height.length-2);
			combotree.combotree({
				url:url+"?codeItemFormMap.codeid="+codeid,
						required:required,
						width:width,
						height:height,
						missingMessage:missingMessage,
						onLoadSuccess :function(node, data){
							if(combotree.val()&&combotree.val()!=null&&combotree.val()!=''){
						var node1	=combotree.combotree('tree').tree('find',combotree.val());
						if(node1){
						combotree.combotree('tree').tree('select',node1.target );
						combotree.combotree('tree').tree('expandAll',node1.target );
						}
							}
						}
			});
			
		},
		/**
		 * 导出数据，参数准备，请求表单生成
		 */
		exportgrid :function(gridid,url){
			
			
			var grid=$("#"+gridid);
			
			var options=grid.datagrid("options");
			var columns=options.columns[0];
			var queryParams=options.queryParams;
			var exportData=[];
			if(columns&&columns.length>0){
			for(var i=0;i<columns.length;i++ ){
				exportData[i]={"colkey":columns[i].field,"name":columns[i].title,"hide":false};
			}
		}
			
			
			var form=$("<form>");//定义一个form表单
			form.attr("style","display:none");
			form.attr("target","");
			form.attr("method","post");
			form.attr("action",url);
			$("body").append(form);//将表单放置在web中
			var input1=$("<input>");
			input1.attr("type","hidden");
			input1.attr("name","exportData");
			input1.attr("value",JSON.stringify(exportData));//需要引用额外JS   json.js
			form.append(input1);
			for(var p in queryParams){
				var input1=$("<input>");
				input1.attr("type","hidden");
				input1.attr("value",queryParams[p]);
				if(p.indexOf(".")>0){
					p = p.split(".")[1];
				}
				input1.attr("name",p);
				form.append(input1);
			}
			form.submit();//表单提交 
		},
		/**
		 * 初始化上传控件
		 * inputid   文件控件ID
		 * divid     生成信息的divid
		 */
		initUpload:function(inputid,divid,formid,gridid){
			$("#"+inputid).change(function (){
				var fileName=$(this).val();
				if(fileName.indexOf("xls")!=-1){
				var str=	"<div class='alert alert-danger' id='uploaddiv'>"+
			    "<strong>待导入文件：</strong> "+fileName+"."+
			    "<div id='loadingdiv'>"+
				"</div>"+
				  "<a class='btn btn-primary' href='javascript:void(0)' onclick='CommnUtil.upload(\""+formid+"\",\""+gridid+"\")' style='text-shadow: black 5px 3px 3px;'>"+
			      "<i class='glyphicon glyphicon-upload icon-white'></i>提交 </a></div>";
				$("#"+divid).html(str);
				}
				else{
					layer.msg("只支持xls格式");
				}
			});
			
			
		}, roundFun:	function  (numberRound,roundDigit)   //四舍五入，保留位数为roundDigit    
	    {  
		    if   (numberRound>=0) {  
		  var   tempNumber   =   parseInt((numberRound   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);  
		  return   tempNumber;}  
		  else{ numberRound1=-numberRound ; 
		  var   tempNumber   =   parseInt((numberRound1   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);  
		  return   -tempNumber;  
		  		}  
		      } ,upload :function(formid,gridid){
			$("#loadingdiv").html("正在拼命导入 <img src='img/ajax-loaders/ajax-loader-1.gif'>");
			$("#"+formid).ajaxSubmit(function (responseResult) {
			$("#"+gridid).treegrid("reload");
				$("#filename").html("");
				layer.alert("["+responseResult+"]");
		   	});
		},toUtf8:function (str) {    
		    var out, i, len, c;    
		    out = "";    
		    len = str.length;    
		    for(i = 0; i < len; i++) {    
		        c = str.charCodeAt(i);    
		        if ((c >= 0x0001) && (c <= 0x007F)) {    
		            out += str.charAt(i);    
		        } else if (c > 0x07FF) {    
		            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));    
		            out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));    
		            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));    
		        } else {    
		            out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));    
		            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));    
		        }    
		    }    
		    return out;    
		} 
	};
})();
// 表单json格式化方法……不使用&拼接
(function($) {
	$.fn.serializeJson = function() {
		var serializeObj = {};
		var array = this.serializeArray();
		$(array).each(
				function() {
					if (serializeObj[this.name]) {
						if ($.isArray(serializeObj[this.name])) {
							serializeObj[this.name].push(this.value);
						} else {
							serializeObj[this.name] = [
									serializeObj[this.name], this.value ];
						}
					} else {
						serializeObj[this.name] = this.value;
					}
				});
		return serializeObj;
	};
	Date.prototype.format = function(format) {
		var o = {
			"M+" : this.getMonth() + 1, // month
			"d+" : this.getDate(), // day
			"h+" : this.getHours(), // hour
			"m+" : this.getMinutes(), // minute
			"s+" : this.getSeconds(), // second
			"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
			"S" : this.getMilliseconds()// millisecond
		}
		if (/(y+)/.test(format)) {
			format = format.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		}
		for ( var k in o) {
			if (new RegExp("(" + k + ")").test(format)) {
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
						: ("00" + o[k]).substr(("" + o[k]).length));
			}
		}
		return format;
	}
})(jQuery);
function comptimeTime(time1,time2,mills){
	time1.setMilliseconds(time1.getMilliseconds()+mills);
	return time1>time2;
}
