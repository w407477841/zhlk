var LODOP; //声明为全局变量
	function qualityCheckPrint(data) {		
		LODOP=getLodop(); 
		
		//第一个参数：1：纵向，2：横向
		//第二个参数：纸张宽，单位0.1mm
		//第三个参数：纸张高，单位0.1mm
		//第四个参数：纸张类型名，当第三个参数为0时，此参数才有效
		LODOP.SET_PRINT_PAGESIZE(1,2110,1400,'A4');
		//第一个参数：距顶部距离
		//第二个参数：距左侧距离
		//第三个参数：内容所占长度
		//第四个参数：内容所占高度
		//第五个参数：所填充内容
		LODOP.ADD_PRINT_TEXT('30mm','38mm','50mm','5mm',data.companyName);
		LODOP.ADD_PRINT_TEXT('30mm','130mm','30mm','5mm',data.year);
		LODOP.ADD_PRINT_TEXT('30mm','150mm','30mm','5mm',data.month);
		LODOP.ADD_PRINT_TEXT('30mm','160mm','30mm','5mm',data.day);
		
		LODOP.ADD_PRINT_TEXT('39mm','38mm','50mm','5mm',data.userName);
		LODOP.ADD_PRINT_TEXT('39mm','130mm','45mm','5mm',data.checkAim);

		LODOP.ADD_PRINT_TEXT('48mm','38mm','50mm','5mm',data.grainVariety);
		LODOP.ADD_PRINT_TEXT('48mm','130mm','20mm','5mm',data.checkWeight);
		
		LODOP.ADD_PRINT_TEXT('80mm','40mm','10mm','5mm',data.sf);
		LODOP.ADD_PRINT_TEXT('80mm','60mm','10mm','5mm',data.zz);
		LODOP.ADD_PRINT_TEXT('80mm','80mm','10mm','5mm',data.cc);
		LODOP.ADD_PRINT_TEXT('80mm','100mm','10mm','5mm',data.zjml);
		LODOP.ADD_PRINT_TEXT('80mm','120mm','10mm','5mm',data.rz);
		LODOP.ADD_PRINT_TEXT('80mm','140mm','10mm','5mm',data.bwsld);
		LODOP.ADD_PRINT_TEXT('80mm','170mm','10mm','5mm',data.cmbl);
		
		LODOP.ADD_PRINT_TEXT('100mm','40mm','10mm','5mm',data.szqw);
		LODOP.ADD_PRINT_TEXT('100mm','60mm','10mm','5mm',data.level);
		
		LODOP.ADD_PRINT_TEXT('110mm','40mm','150mm','5mm',data.remark);
		
        LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='"+rootPath+"/img/qualityCheck.jpg'>");
		LODOP.SET_SHOW_MODE("BKIMG_PRINT",1);	//预览打印包含背景图(默认没图)		
		LODOP.PREVIEW(); //打印预览	
	};	