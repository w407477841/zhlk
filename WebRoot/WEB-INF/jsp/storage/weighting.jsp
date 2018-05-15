<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>

<style>
.box-content{
min-height: 400px;
}
*{
box-sizing:border-box;
}
.flex{
display:flex;
flex-flow:row wrap;
justify-content:flex-start;
align-items:flex-start;
align-content:flex-start;
overflow: auto;
}
.item{
width:260px;
height: 100px;
background: #0a3f44;
display:flex;
align-items:center;
justify-content:center;
flex-flow:column wrap;
font-size: 24px;
border-radius:5px;
transition:all 1s;
margin: 10px;
padding:0 10px;
position: relative;
box-shadow:4px 1px 3px 0px #03273c;
overflow: hidden;
}
.item:BEFORE{
content:'';
position: absolute;
background: -webkit-linear-gradient(120deg,#f5efef 0,#5a8079 50%,#000000 100%);
background: -moz-linear-gradient(120deg,#f5efef 0,#5a8079 50%,#000000 100%);
background: -ms-linear-gradient(120deg,#f5efef 0,#5a8079 50%,#000000 100%);
background: linear-gradient(120deg,#f5efef 0,#5a8079 50%,#000000 100%);
width: 100%;
height:100%;
left:0;
top:0;
opacity:.4;
}
.item:after{
			position: absolute;
			left: -100%;                   
			top: 0;
			width: 30%;
			height: 100%;
			content: "";
			transform: skewX(-45deg);
			background: linear-gradient(to right,rgba(255,255,255,0) 0,rgba(255,255,255,.3) 50%,rgba(255,255,255,0) 100%);
}
.item>a{
text-decoration: none;
color:#fff;
}
.item>a:last-child{
position:absolute;
right:10px;
bottom: 10px;
font-size: 16px;

}
.item>a:hover{
color:#fff;
}
.item:HOVER {
cursor: pointer;
}
.item:HOVER:after{
left: 150%;
 transition: 1s ease;
}

</style>

<div id="content" class="col-lg-12 col-sm-12">
	<!-- content starts -->
	<div class="row">
		<div class="box col-md-12">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-list"></i> 地磅选择
					</h2>

					<div class="box-icon">
						<a href="javascript:void(0)"class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i>
						</a> <a href="javascript:void(0)"class="btn btn-minimize btn-round btn-default"><i class="glyphicon glyphicon-chevron-up"></i>
						</a> <a href="javascript:void(0)"class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i>
						</a>
					</div>
				</div>
				<div class="box-content flex">
				
				</div>
			</div>
		</div>

	</div>
</div>


<script type="text/javascript">

$(document).ready(function(){
var url = rootPath + '/storage/allSettings.shtml';
		var s = CommnUtil.ajax(url, {}, "json");
		if (s.success) {
			for(var i=0;i<s.rs.length;i++){
			$(".flex").append("<div class='item' data-key='"+s.rs[i].parameterKey+"'><a>"+s.rs[i].wName+"</a><a>"+s.rs[i].number+"</a></div>");
			}
		}
	$(".item").on("click",function(){
		var code=$(this).data("key");
		window.open(rootPath+"/storage/weight/listUI.shtml?code="+code+"");
	
	});
});



$('.btn-close').click(function (e) {
    e.preventDefault();
    $(this).parent().parent().parent().fadeOut();
});
$('.btn-minimize').click(function (e) {
    e.preventDefault();
    var $target = $(this).parent().parent().next('.box-content');
    if ($target.is(':visible')) $('i', $(this)).removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
    else                       $('i', $(this)).removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
    $target.slideToggle();
});
</script>
