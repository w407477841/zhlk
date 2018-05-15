var treeTable;
$(function() {
	treeTable = $('#treeTable').treegrid({
		url : rootPath +'/variety/findTreeGrid.shtml',
		idField : 'id',
		treeField : 'text',
		fitColumns : true,
		striped : true,
		nowrap : false,
		columns : [ [ {
			title : '品种名称',
			field : 'text',
			width : 180
		}, {
			title : '自定义名称',
			field : 'definedText',
			width : 150
		}, {
			title : '销售价格',
			field : 'salePrice',
			width : 100
		} , {
			title : '购买价格',
			field : 'buyPrice',
			width : 100
		} , {
			title : '等级差价',
			field : 'rankPrice',
			width : 100
		} , {
			title : '是否启用',
			field : 'isEnable',
			width : 100,
			formatter: function (value, row, index) {
				if(value == '2'){
					return "<span style='color:green;'>启用</span>";
				} else {
					return "<span style='color:red;'>禁止</span>";
				}
			}
		} 
		] ],
		onLoadSuccess : function(row, data) {
			treeTable.treegrid('collapseAll');
		},
		onDblClickRow : function(row) {
			lookUI(row);
		}
	});

	$("#editFun").click("click", function() {
		editUI();
	});
});


/**
 * 打开修改页面
 */
function editUI() {
	var selectRow = treeTable.treegrid('getSelected');
	if (selectRow) {
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>修改<h5>",
			type : 2,
			maxmin : true,
			area : [ "1200px", "600px" ],
			content : rootPath + '/variety/editUI.shtml?id=' + selectRow.id,
			end : function() {// 关闭时执行
				treeTable.treegrid("reload");
			}
		});
	} else {
		layer.msg('请选择一行');

	}
}
/**
 * 打开查看页面
 */
function lookUI(row) {
	pageii = layer.open({
		title : "<h5><i class='glyphicon glyphicon-link'></i>查看<h5>",
		type : 2,
		maxmin : true,
		area : [ "1200px", "600px" ],
		content : rootPath + '/variety/lookUI.shtml?id=' + row.id,
		end : function() {// 关闭时执行
			treeTable.treegrid("reload");
		}
	});
}
