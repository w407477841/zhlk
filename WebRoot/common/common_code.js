var Util=(function(util){
	var code=function(initV){
		new myselect({
			obj_id:initV.obj_id||"",
			url:rootPath+"/code/findCodeItemTreeGrid.shtml",
			data:{"codeItemFormMap.codeid":initV.codeid||"-1"},
			option_val:["id"],
			option_val_prefix:",",
			option_html:["text"],
			option_html_prefix:",",
			selected_val:initV.selected_val||''
		},function(){
		},function(){
		});
	};
	util.code=code;
	return util;
})(Util||{});