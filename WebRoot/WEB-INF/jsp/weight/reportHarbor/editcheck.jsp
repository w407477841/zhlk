<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/common/common.jspf"%>
	 <style type="text/css">
	 .chosen-container-single .chosen-single{
	 height:37px;
	 }
	 .title_header_label{
	  padding: 0 0 0 0;
	  border-left:1px #ffffff solid;
	  border-right:1px #ffffff solid;
	  text-align:center;
	  height:35px;
	  line-height:35px;
	  background-color: #D1D1D1;
	 }
	 </style>
</head>
<body style="background-color:#d9edf7">
<div class=" col-md-12"><div class=" col-md-6">  <h3 class="animated rubberBand">报港信息</h3> </div>   </div> 
<form id="form" name="form" method="post" action="${ctx}/reportHarbor/editcheck.shtml">
<input type="hidden" name="token" value="${token }">
<input type="hidden" name="qualityCheckFormMap.id" value="${reportHarborFormMap.id }">
<input type="hidden" name="qualityCheckFormMap.version" value="${reportHarborFormMap.version }">
<input type="hidden" name="reportHarborFormMap.bId" value="${reportHarborFormMap.bId }">
<div class=" col-md-12"> 
  <div class="form-group col-md-6">
      <div class="col-md-2 div_label">粮食品种</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="variety" name="reportHarborFormMap.grainVariety" value="${reportHarborFormMap.grainVariety }" readonly="readonly">
   </div> 
   </div>
   </div> 
  <div class="form-group col-md-6">
      <div class="col-md-2 div_label">粮食性质</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="property" name="reportHarborFormMap.grainProperty" value="${reportHarborFormMap.grainProperty }" readonly="readonly">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">收购价(50kg)</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" id="byPrice" name="reportHarborFormMap.buyPrice" maxlength="6">
    </div> 
   </div>
   </div> 
  <div class="form-group col-md-6">
      <div class="col-md-2 div_label">总扣量</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="totalReduce" name="reportHarborFormMap.totalReduce" value="0.0" readonly="readonly">
   </div> 
   </div>
   </div>
  	</div>
   <div class="form-group col-md-12">
    <div class="col-md-12">
    <div class="col-md-1 title_header_label">容重|出糙</div>
    <div class="col-md-1 title_header_label">水分</div>
    <div class="col-md-1 title_header_label">杂质</div>
    <div class="col-md-1 title_header_label">其中矿物质 </div>
    <div class="col-md-1 title_header_label">不完善粒度</div>
    <div class="col-md-1 title_header_label">整精米粒</div>
    <div class="col-md-1 title_header_label">谷外糙米</div>
    <div class="col-md-1 title_header_label">黄粒米</div>
    <div class="col-md-1 title_header_label">互混</div>
    <div class="col-md-1 title_header_label">赤霉病粒</div>
    <div class="col-md-1 title_header_label">硬度指数</div>
    <div class="col-md-1 title_header_label">色泽气味</div>
    </div>
    <div class="form-group col-md-12">
    <div class="col-md-1 title_header_label">
     <input type="text" id="01or02" class="form-control" name="qualityCheckFormMap.rz" value="0.0" readonly="readonly" onblur="onChange_price(this)" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="03" class="form-control" name="qualityCheckFormMap.sf" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('03')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="04" class="form-control" name="qualityCheckFormMap.zz" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('04')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="05" class="form-control" name="qualityCheckFormMap.kwz" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('05')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="06" class="form-control" name="qualityCheckFormMap.bwsld" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('06')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="07" class="form-control" name="qualityCheckFormMap.zjml" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('07')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="08" class="form-control" name="qualityCheckFormMap.gwcm" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('08')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="09" class="form-control" name="qualityCheckFormMap.hlm" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('09')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="10" class="form-control" name="qualityCheckFormMap.hh" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('10')" maxlength="6">
    </div>
    
    <div class="col-md-1 title_header_label">
      <input type="text" id="14" class="form-control" name="qualityCheckFormMap.cmbl" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="change_cmbl('14')" maxlength="5">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="12" class="form-control" name="qualityCheckFormMap.ydzs" value="48" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" maxlength="5">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="13" class="form-control" name="qualityCheckFormMap.szqw" value="正常" maxlength="12">
    </div>
    </div>
    <div class="col-md-12">
    <div class="col-md-1 title_header_label">等级</div>
    <div class="col-md-8 title_header_label">分项扣量(%)</div>
    <div class="col-md-1 title_header_label">其他扣量</div>
    </div>
    <div class="form-group col-md-12">
    <div class="col-md-1 title_header_label">
     <input type="text" id="01or02_val" class="form-control" name="qualityCheckFormMap.level" value="3" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="03_val" class="form-control" name="qualityCheckFormMap.sfkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="04_val" class="form-control" name="qualityCheckFormMap.zzkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="05_val" class="form-control" name="qualityCheckFormMap.kwzkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="06_val" class="form-control" name="qualityCheckFormMap.bwsldkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="07_val" class="form-control" name="qualityCheckFormMap.zjmlkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="08_val" class="form-control" name="qualityCheckFormMap.gwcmkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="09_val" class="form-control" name="qualityCheckFormMap.hlmkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="10_val" class="form-control" name="qualityCheckFormMap.hhkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="11" class="form-control" name="reportHarborFormMap.otherReduce" value="0.0" onkeyup="validFloat(this)" onblur="get_total_reduce()" maxlength="6">
    </div>
    </div>
    </div>
    
    <div class="form-group col-md-12">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
      </div> 
   </form> 	
<script type="text/javascript">
$("#form").validate({
		submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
			ly.ajaxSubmit(form, {//验证新增是否成功
				type : "post",
				dataType : "json",
				success : function(data) {
					if (data == "success") {
						layer.confirm('修改成功，是否关闭?', function(index) {
						layer.close(index);
						parent.layer.close(parent.pageii);
					});
					} else {
						layer.alert('修改失败！', 3);
					}
				}
			});
		},
		rules : {
			
		},
		messages : {
			
		},
		errorPlacement : function(error, element) {// 自定义提示错误位置
		},
		success : function(label) {// 验证通过后
		}
	});
	
	
   find_variety_property('${reportHarborFormMap.wId}');
	
  //根据仓号获取粮食品种和粮食属性
  function find_variety_property(warehouse_id){
	  $.ajax({
			dataType:'json',
			type:'post',
			url:'${ctx}/kcxx/findVAndPByWId.shtml',
			data:{id:warehouse_id},
			async:false,
			success:function(data){
				if(data != null){
					$("#variety").val(data.variety);
					$("#property").val(data.property);
					find_quality(data.name);
					find_variety(data.name);
				}else{
					$("#variety").val('');
					$("#property").val('');
				}
			}
	  });
	  
	  init();
  }
  //根据粮食品种获取国标质检信息
  function find_quality(grainId){
	  $.ajax({
			dataType:'json',
			type:'post',
			async:false,
			url:'${ctx}/quality/findQualityByVarietyId.shtml',
			data:{id:grainId},
			success:function(data){
				if(data != null){
					//console.log(data);
					qualityArr = data;
					for(var i=0;i<data.length;i++){
						var id = data[i].id;
						var vId = data[i].aId;
						if(vId != undefined){
							if(id == '01' || id=='02'){
								$("#01or02").val(data[i].standard);
								$("#01or02").removeAttr("readonly");
							}else{
								$("#"+id).val(data[i].standard);
								$("#"+id).removeAttr("readonly");
							}
						}else{
							if(id == '01' || id=='02'){
								//$("#01|02").val(data[i].standard);
							}else{
								$("#"+id).val("0.0");
								$("#"+id).attr("readonly","readonly");
							}
						}
					}
					
				}else{
					layer.alert('国标质检信息获取失败！', {icon:7});
				}
			}
	  });
  }
  //根据品种获取采购价等级差价
  function find_variety(grainId){
	  $.ajax({
			dataType:'json',
			type:'post',
			async:false,
			url:'${ctx}/variety/findByVarietyId.shtml',
			data:{id:grainId},
			success:function(data){
				if(data != null){
					//console.log(data);
					variety = data;
					$("#byPrice").val(data.buyPrice);
				}else{
					layer.alert('粮食品种信息获取失败！', {icon:7});
				}
			}
	  });
  }
  var qualityArr;
  var variety;
  //改变容重或出糙，进行等级计算和价格计算
   function onChange_price(obj){
	   var temp = null;
	   for(var i=0;i<qualityArr.length;i++){
		   if(qualityArr[i].id == '01' || qualityArr[i].id == '02'){
			   if(qualityArr[i].vId != undefined){
				   temp = qualityArr[i];
				   break;
			   }
		   }
	   }
	   if(temp != null){
		   var maxVal = temp.maxiValue; //最大区间
		   var minVal = temp.miniValue; //最小区间
		   var standard = temp.standard; //标准值
		   var rank = temp.rank; //等级差
		   
		   var byPrice = variety.buyPrice;
		   var rankPrice = variety.rankPrice;
		   var valu = $(obj).val();
		   if(!isNumber(valu)){
				  $(obj).val(standard);
				  $("#01or02_val").val("0.0");
				  layer.alert("【数据输入有误！】",{icon:7});
				  return ;
		    }
		   if(valu>maxVal || valu<minVal){
			   $(obj).val(standard);
			   $("#01or02_val").val("3");
			   layer.alert("超出范围【"+minVal+"-"+maxVal+"】",{icon:7});
		   }else{
			   var diff = Math.floor((valu - standard)/rank);
			   if(3-diff<1){
				   $("#01or02_val").val("1");
				   console.log(byPrice+(3-1)*rankPrice);
				   $("#byPrice").val(byPrice+(3-1)*rankPrice);
			   }else if(3-diff>5){
				   $("#01or02_val").val("等外");
				   $("#byPrice").val(byPrice-(5-3)*rankPrice);
			   }else{
				   $("#01or02_val").val(3-diff);
				   $("#byPrice").val(byPrice+(diff)*rankPrice);
			   }
		   }
	   }
   }
  
  //根据质检信息进行扣量计算
  function change_reduce_rate(obj){
	  var temp = null;
	  for(var i=0;i<qualityArr.length;i++){
		   if(qualityArr[i].id == obj){
			 temp = qualityArr[i];
		   }
	   }
	  if(temp !=null){
		  var maxVal = temp.maxiValue; //最大区间
		  var minVal = temp.miniValue; //最小区间
		  var standard = temp.standard; //标准值
		  var reduceRate = temp.reduceStandard;
		  var reduceValue = temp.reduceValue;
		  var increaseRate = temp.increaseRange;
		  var increaseValue = temp.increaseValue;
		  
		  var valu = $("#"+obj).val();
		  if(!isNumber(valu)){
			  $("#"+obj).val(standard);
			  $("#"+obj+"_val").val("0.0");
			  layer.alert("【数据输入有误！】",{icon:7});
			  return ;
		  }
		  if($("#"+obj).attr("readonly") != 'readonly'){
			  if(valu>maxVal || valu<minVal){
				   $("#"+obj).val(standard);
				   $("#"+obj+"_val").val("0.0");
				   layer.alert("超出范围【"+minVal+"-"+maxVal+"】",{icon:7});
			   }else{
				   if(valu>=standard){
					   if(reduceRate != 0){
						   var diff = Math.floor((valu - standard)/reduceRate);
						   $("#"+obj+"_val").val(diff*reduceValue);
					   }else{
						   $("#"+obj+"_val").val("0.0");
					   }
				   }else{
					   if(increaseRate!=0){
						   var diff = Math.floor((standard - valu)/increaseRate);
						   $("#"+obj+"_val").val(-(diff*increaseValue));
					   }else{
						   $("#"+obj+"_val").val("0.0");
					   }
				   }
				   get_total_reduce();
			   }
		  }
	  }
  }
  //获取总的扣量
  function get_total_reduce(){
	  var total = 0.0;
	  for(var i=3;i<10;i++){
		  total +=parseFloat( $("#0"+i+"_val").val());
	  }
	  total +=parseFloat($("#10_val").val());
	  total +=parseFloat($("#11").val());
	  $("#totalReduce").val(total);
  }
  //赤霉病粒
  function change_cmbl(obj){
	  var txt = $("#"+obj).val();
	  if(!isNumber(txt)){
		  $("#"+obj).val("0.0");
		  layer.alert("【数据输入有误！】",{icon:7});
		  return ;
	  }
	  if(txt<0 || txt >4){
		  $("#"+obj).val("0.0");
		  layer.alert("超出范围【0-4】",{icon:7});
	  }
  }
  
  function init(){
	  $("#byPrice").val('${reportHarborFormMap.buyPrice}');
	  $("#totalReduce").val('${reportHarborFormMap.totalReduce}');
	  $("#01or02").val('${reportHarborFormMap.rz}');
	  $("#03").val('${reportHarborFormMap.sf}');
	  $("#04").val('${reportHarborFormMap.zz}');
	  $("#05").val('${reportHarborFormMap.kwz}');
	  $("#06").val('${reportHarborFormMap.bwsld}');
	  $("#07").val('${reportHarborFormMap.zjml}');
	  $("#08").val('${reportHarborFormMap.gwcm}');
	  $("#09").val('${reportHarborFormMap.hlm}');
	  $("#10").val('${reportHarborFormMap.hh}');
	  $("#14").val('${reportHarborFormMap.cmbl}');
	  $("#12").val('${reportHarborFormMap.ydzs}');
	  $("#13").val('${reportHarborFormMap.szqw}');
	  
	  $("#01or02_val").val('${reportHarborFormMap.level}');
	  $("#03_val").val('${reportHarborFormMap.sfkl}');
	  $("#04_val").val('${reportHarborFormMap.zzkl}');
	  $("#05_val").val('${reportHarborFormMap.kwzkl}');
	  $("#06_val").val('${reportHarborFormMap.bwsldkl}');
	  $("#07_val").val('${reportHarborFormMap.zjmlkl}');
	  $("#08_val").val('${reportHarborFormMap.gwcmkl}');
	  $("#09_val").val('${reportHarborFormMap.hlmkl}');
	  $("#10_val").val('${reportHarborFormMap.hhkl}');
	  $("#11").val('${reportHarborFormMap.otherReduce}');
  }
  
  
	function _submit() {
	if($("#form").form("validate")){
		$("#form").submit();     
     }
	}
</script>

</body>
</html>
