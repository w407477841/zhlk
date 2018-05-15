var EventUtil = {
	//添加事件
    addHandler: function(element, type, handler){
			//stopPropagation(e);
        if (element.addEventListener){
            element.addEventListener(type, handler, false);
        } else if (element.attachEvent){
            element.attachEvent("on" + type, handler);
        } else {
            element["on" + type] = handler;
        }
    },
    addParamHandler: function(element, type, handler,id){
       	var binder=	function(){
        				handler.apply(element,[id]);
        	}
            if (element.addEventListener){
                element.addEventListener(type, binder, false);
            } else if (element.attachEvent){
                element.attachEvent("on" + type, binder);
            } else {
                element["on" + type] = binder;
            }
            return function(){
                if (element.removeEventListener){
                    element.removeEventListener(type, binder, false);
                } else if (element.detachEvent){
                    element.detachEvent("on" + type, binder);
                } else {
                    element["on" + type] = null;
                }
            
            }
        },
    
    getButton: function(event){
        if (document.implementation.hasFeature("MouseEvents", "2.0")){
            return event.button;
        } else {
            switch(event.button){
                case 0:
                case 1:
                case 3:
                case 5:
                case 7:
                    return 0;
                case 2:
                case 6:
                    return 2;
                case 4: return 1;
            }
        }
    },
    
    getCharCode: function(event){
        if (typeof event.charCode == "number"){
            return event.charCode;
        } else {
            return event.keyCode;
        }
    },
    
    getClipboardText: function(event){
        var clipboardData =  (event.clipboardData || window.clipboardData);
        return clipboardData.getData("text");
    },
   //获取事件 
    getEvent: function(event){
        return event ? event : window.event;
    },
    
    getRelatedTarget: function(event){
        if (event.relatedTarget){
            return event.relatedTarget;
        } else if (event.toElement){
            return event.toElement;
        } else if (event.fromElement){
            return event.fromElement;
        } else {
            return null;
        }
    
    },
   //	捕获当前事件作用的对象 
    getTarget: function(event){
        return event.target || event.srcElement;
    },
    
    getWheelDelta: function(event){
        if (event.wheelDelta){
            return (client.engine.opera && client.engine.opera < 9.5 ? -event.wheelDelta : event.wheelDelta);
        } else {
            return -event.detail * 40;
        }
    },
  //取消事件默认行为  
    preventDefault: function(event){
        if (event.preventDefault){
            event.preventDefault();
        } else {
            event.returnValue = false;
        }
    },

    removeHandler: function(element, type, handler){
        if (element.removeEventListener){
            element.removeEventListener(type, handler, false);
        } else if (element.detachEvent){
            element.detachEvent("on" + type, handler);
        } else {
            element["on" + type] = null;
        }
    },
    
    setClipboardText: function(event, value){
        if (event.clipboardData){
            event.clipboardData.setData("text/plain", value);
        } else if (window.clipboardData){
            window.clipboardData.setData("text", value);
        }
    },
    //取消事件冒泡
    stopPropagation: function(event){
        if (event.stopPropagation){
            event.stopPropagation();
        } else {
            event.cancelBubble = true; //ie
        }
    }

};