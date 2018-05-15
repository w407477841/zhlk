var grid;
var pageii;
var searchParams;
$(function() {
	searchParams = $("#searchForm").serializeJson();
	grid = $('#magazineGrid').datagrid({
		url : 'shipindianwei/findShiPinByPage.shtml',
		method : 'POST',
		queryParams : searchParams,
		idField : 'id',
		striped : true,
		fitColumns : true,
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		nowrap : false,
		sortName : 'storageID',
		sortOrder : 'asc',
		multiSort : true,
		pageSize : 20,
		pageList : [ 10, 20, 50, 100, 150, 200 ],
		showFooter : true,
		columns : [ [ {
			field : 'location_id',
			title : '粮库地点',
			width : 150,
			align : 'left',
			editor : 'text'
		}, {
			field : 'name',
			title : '视频点位',
			width : 180,
			align : 'left'
		}
		] ],
		onDblClickRow: function(index,row){
			lookUI(row);
		},
		onLoadSuccess : function(data) {
			grid.datagrid('getPager').pagination({
				displayMsg : '当前显示从{from}到{to},共{total}记录',
				onBeforeRefresh : function(pageNumber, pageSize) {
					$(this).pagination('loading');
					$(this).pagination('loaded');
				},
			});
		},
		onLoadError : function() {
		}
	});
	
});

function lookUI(row){
	var name =  $("#location_id").val();
	openPostWindow(rootPath + '/liangku/viewjiankong.shtml',name,row.ipNum,row.ip,row.port,row.userName,row.password);
	//window.open(rootPath + '/liangku/viewjiankong.shtml?name='+name+'&ipNum='+row.ipNum+'&ip='+row.ip+'&port='+row.port+'&userName='+row.userName+'&password='+row.password,'','height=600,width=1000,resizable=no,scrollbars=yes,status=yes,toolbar=no,menubar=yes,location=no')
}
function openPostWindow(url,name,ipNum,ip,port,userName,password)      

{      
  
   var tempForm = document.createElement("form");      
   tempForm.id="tempForm1";      
   tempForm.method="post";      
   tempForm.action=url;      
   tempForm.target="viewjiank";
   
   var hideInput = document.createElement("input");      
   hideInput.type="hidden";      
   hideInput.name= "name";  
   hideInput.value= name;    
   tempForm.appendChild(hideInput);
   
   var hideInput1 = document.createElement("input");      
   hideInput1.type="hidden";      
   hideInput1.name= "ipNum";  
   hideInput1.value= ipNum;    
   tempForm.appendChild(hideInput1);
   
   var hideInput2 = document.createElement("input");      
   hideInput2.type="hidden";      
   hideInput2.name= "ip";  
   hideInput2.value= ip;    
   tempForm.appendChild(hideInput2);
   
   var hideInput3 = document.createElement("input");      
   hideInput3.type="hidden";      
   hideInput3.name= "port";  
   hideInput3.value= port;    
   tempForm.appendChild(hideInput3);
   
   var hideInput4 = document.createElement("input");      
   hideInput4.type="hidden";      
   hideInput4.name= "userName";  
   hideInput4.value= userName;    
   tempForm.appendChild(hideInput4);
   
   var hideInput5 = document.createElement("input");      
   hideInput5.type="hidden";      
   hideInput5.name= "password";  
   hideInput5.value= password;    
   tempForm.appendChild(hideInput5);
   
   tempForm.onsubmit = openWindow("viewjiank");    
   document.body.appendChild(tempForm);      
   //tempForm.fireEvent("onsubmit");    
   tempForm.submit();    
   document.body.removeChild(tempForm);    
} 
function openWindow(name)      
{      
   window.open('about:blank',name,'height=600,width=1000,resizable=no,scrollbars=yes,status=yes,toolbar=no,menubar=yes,location=no');       
}      