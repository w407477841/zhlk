<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
    <div id="content" class="col-lg-12 col-sm-12">
            <!-- content starts -->

   <div class="row">
    <div class="box col-md-12">
    <div class="box-inner" style="height: 100%">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i>出入库明细表</h2>

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    
    <div class="box-content" id="page">
         <div class="alert alert-info"> 
     <form class="form-inline" role="form" id="searchForm" name="searchForm">
			 <input id="start" class=" laydate-icon " name="timestart" placeholder="开始日期" style="" >
			<input id="start1" class=" laydate-icon " name="timeend" placeholder="结束日期" style="">
			库点名称:	
			<!-- <select class=" laydate-icon " name="library_sel" style="background-image: none;width: 187px"></<select>  -->
			<select name="library_sel" style="background-image: none;width: 187px" class=" laydate-icon " ></select>
    </form> 
    		<a class="btn btn-primary" href="javascript:void(0)" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		查询
            	</a>  
            	</div> 
            <table id="magazineGrid"  style="width:99%;height:400px">
			</table> 

    </div>
    </div>
    </div>
    </div>
    </div>

<script type="text/javascript">
	laydate({
    elem: '#start',
    event: 'focus' 
	});
	laydate({
    elem: '#start1',
    event: 'focus' 
	});
 	$(function() {
		$.ajax({
			url : rootPath + "/kcxx/locations.shtml",
			type : "post",
			ansyc:true,
			data : {
				"source" : 1
			},
			success : function(rs) {
				var sel = document.forms[0]["library_sel"];
				if (rs.success) {
					for ( var i = 0; i < rs.list.length; i++) {
						sel.add(new Option(rs.list[i].wName, rs.list[i].wNo))
					}
				}

			}
		})

	}) 
</script>
<script type="text/javascript" src="js/liangku/libraryDetail.js"> </script>