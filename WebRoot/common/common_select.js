(function(){
 myselect=function(config,fn1,fn2){
	this.init(config);
	this.toSelect();
	this.boundFun(fn1,fn2);
};
myselect.prototype={
		defalutConfig:{obj_id:"id",no_results_text :"未找到选项！",width:"100%",data:{},dataType:"json",option_val:["id"],option_val_prefix:",",option_html:["name"],option_html_prefix:",",selected_val:""},
		init:function(config){
			for(_name in this.defalutConfig){
				this.changeProp(this.defalutConfig,_name);
			}
			for(_name in config){
			this.changeProp(config,_name);
			}
		},changeProp:function(c,n){
			this[n]=c[n];
		}
		,toSelect:function(){
			var $sel=$("#"+this['obj_id']);
			var datas= CommnUtil.ajax(this.url, this.data,this.dataType);
			if(datas!=null){
				$sel.empty();
				$("<option>").val("")
				.html("")
				.appendTo($("#"+this['obj_id']));
				for(index in datas){
					this.createOption(datas[index],"");
					this.validateChild(datas[index],"");
				}
			}
		},chosen:function(){
			$("#"+this['obj_id']).chosen({
				no_results_text : this.no_results_text,
					width:this.width
					});
		},validateChild:function(data,pre){
			pre+="=";
			var child=data.children||[];
			for(var i=0;i<child.length;i++){
				this.createOption(child[i],pre);
				this.validateChild(child[i],pre);
			}
			return ;
		},
		createOption:function(data,pre){
			var vals=[];
			for(var i=0;i<this.option_val.length;i++){
				vals.push(data[this.option_val[i]]);
			}
			var htmls=[];
			for(var i=0;i<this.option_html.length;i++){
				htmls.push(data[this.option_html[i]]);
			}	
			var op=$("<option>");
			if(!this.selected_val==""){  //赋予选择值
				if(vals.join(this['option_val_prefix'])==this.selected_val){
					op.attr("selected","true");
				};
			}
			if(!this.selected_vals==""){ //多选值
				var values = this.selected_vals.split(",");
				if($.inArray(vals.join(this['option_val_prefix']), values)>-1){
					op.attr("selected","true");										
				}
			}
			op.val(vals.join(this['option_val_prefix']))
			.html(pre+htmls.join(this['option_html_prefix']))
			.appendTo($("#"+this['obj_id']));
		},
		boundFun:function(fn,fn2){
		if( typeof fn== 'function'){
			$("#"+this['obj_id']).change(function(){
				fn();
			});
		}
		if(typeof fn2=='function'){
			fn2();
		}
		}
};
})();