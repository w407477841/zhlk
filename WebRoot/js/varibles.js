		/**
 * 全局属性
 */
var CONFIGURE = {
	BREED : {
		"1114" : "混合小麦",
		"1132002" : "晚粳稻谷"
	},
	PROPERTY : {
		"31" : "最低收购价粮",
		"11" : "国家储备粮",
		"121" : "省级储备粮",
		"122" : "地市级储备粮",
		"123" : "县级储备粮",
		"2" : "商品粮",
		"34" : "地方临时存储粮"
	},
	TYPE : {
		"0" : "通风",
		"1" : "熏蒸",
		"2" : "冷却",
	},
	STATUS : {
		"0" : "审批中",
		"1" : "通过",
		"2" : "退回",
		"3":"未提交"
	},
	USECAR:{
		"0":"不使用",
		"1":"使用"
		
	},
	ISTATUS:{
		"1":"待称重",
		"2":"待结算",
		"3":"已完成"
	},
	PAYWAY:{
		"1":"现金",
		"2":"转账"
	},
	list : function(type, index) {

	}

}

Array.prototype.seriArrs=function(){
	
	var _thisArr=this;
	return _thisArr.map(function(item){
		return JSON.stringify(item);
	}).join("||");
	
}
	String.prototype.parseToArr=function(){
	
	var _str=this;
	if(_str==""){
		return [];
	} 
	return _str.split("||").map(function(item){
		return JSON.parse(item);
	})
	
}

Date.prototype.format = function(format){ 
	var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
	} 

	if(/(y+)/.test(format)) { 
	format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 

	for(var k in o) { 
	if(new RegExp("("+ k +")").test(format)) { 
	format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
	} 
	} 
	return format; 
	} 

