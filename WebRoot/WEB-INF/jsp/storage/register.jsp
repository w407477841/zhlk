<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
    <div id="content" class="col-lg-12 col-sm-12">
            <!-- content starts -->
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-list"></i> 报港</h2>

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content" id="page">
    <div class="alert alert-info"> 
     <form class="form-inline" role="form" id="searchForm"name="searchForm">
			<input type="text" name="id"  placeholder="流水单号">
			<input type="text" id="start" name="createTime"  class="inline laydate-icon  form-control" placeholder="时间">
			<select id="inorout" data-rel="chosen" name="inorout" data-placeholder="出入库" >
					<option value="99"></option>
					<option value="1">入库</option>
					<option value="0">出库</option>
			</select>
			
    </form>
  <a class="btn btn-primary add" href="javascript:void(0)" data-inorout="1" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-plus icon-white" ></i>
               		新增入库
            	</a>
   <a class="btn btn-primary add" href="javascript:void(0)" data-inorout="0" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-plus icon-white" ></i>
               		新增出库
            	</a>
            	<a class="btn btn-primary" href="javascript:void(0)" id="remove" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-remove icon-white" ></i>
               		删除
            	</a>
            		<a class="btn btn-primary" href="javascript:void(0)" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		查询
            	</a>
            	<a class="btn btn-primary" href="javascript:void(0)" id="export" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-export icon-white" ></i>
               		导出
            	</a>
            	</div>
            <table id="magazineGrid"  style="width:99%;height:600px">
			</table>
			

    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->
	</div>

  
<script type="text/javascript" src="js/storage/register.js"></script>
<script type="text/javascript">
	laydate({elem : '#start',event : 'focus'});
	$("#inorout").chosen({no_results_text : "未找到此选项!"});
$(".chosen-container").css("verticalAlign","top")
$(".chosen-single").css("height","30px").css("width","100px").css("borderRadius","4px")
$(".chosen-drop").css("width","100px");

	
	
</script>
