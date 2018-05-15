var LODOP; //声明为全局变量
	function medicamentApplyPrint(data) {		
		LODOP=getLodop(); 
		
		//第一个参数：1：纵向，2：横向
		//第二个参数：纸张宽，单位0.1mm
		//第三个参数：纸张高，单位0.1mm
		//第四个参数：纸张类型名，当第三个参数为0时，此参数才有效
		LODOP.SET_PRINT_PAGESIZE(1,2110,1400,'A4');
		
		LODOP.ADD_PRINT_TEXT('43mm','38mm','50mm','5mm',data.departmentName);
		LODOP.ADD_PRINT_TEXT('43mm','95mm','30mm','5mm',data.year);
		LODOP.ADD_PRINT_TEXT('43mm','110mm','30mm','5mm',data.month);
		LODOP.ADD_PRINT_TEXT('43mm','120mm','30mm','5mm',data.day);
		
		LODOP.ADD_PRINT_TEXT('64mm','26mm','23mm','5mm',data.maName);
		LODOP.ADD_PRINT_TEXT('64mm','74mm','45mm','5mm',data.maStandard);
		LODOP.ADD_PRINT_TEXT('64mm','120mm','40mm','5mm',data.maQuantity);
		LODOP.ADD_PRINT_TEXT('64mm','144mm','40mm','5mm',data.maUsed);

		LODOP.ADD_PRINT_TEXT('100mm','26mm','140mm','5mm',data.remark);
		
        LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='"+rootPath+"/img/medicamentApply.jpg'>");
		LODOP.SET_SHOW_MODE("BKIMG_PRINT",1);	//预览打印包含背景图(默认没图)		
		LODOP.PREVIEW(); //打印预览	
		//LODOP.PRINT_DESIGN();  //打印设计
	};	