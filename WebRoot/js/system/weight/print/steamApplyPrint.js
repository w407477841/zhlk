var LODOP; //声明为全局变量
	function steamApplyPrint(data) {		
		LODOP=getLodop(); 
		
		//第一个参数：1：纵向，2：横向
		//第二个参数：纸张宽，单位0.1mm
		//第三个参数：纸张高，单位0.1mm
		//第四个参数：纸张类型名，当第三个参数为0时，此参数才有效
		LODOP.SET_PRINT_PAGESIZE(1,2910,2110,'');
		LODOP.ADD_PRINT_TEXT('25mm','38mm','10mm','5mm',data.applyDate[0]);
		LODOP.ADD_PRINT_TEXT('25mm','53mm','10mm','5mm',data.applyDate[1]);
		LODOP.ADD_PRINT_TEXT('25mm','63mm','10mm','5mm',data.applyDate[2]);
		
		LODOP.ADD_PRINT_TEXT('25mm','135mm','10mm','5mm',data.steamDate[0]);
		LODOP.ADD_PRINT_TEXT('25mm','150mm','10mm','5mm',data.steamDate[1]);
		LODOP.ADD_PRINT_TEXT('25mm','160mm','10mm','5mm',data.steamDate[2]);
		
		LODOP.ADD_PRINT_TEXT('25mm','265mm','10mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('48mm','33mm','20mm','5mm',data.wName);
		LODOP.ADD_PRINT_TEXT('48mm','60mm','20mm','5mm',data.waWarehouseType);
		LODOP.ADD_PRINT_TEXT('48mm','85mm','20mm','5mm',data.length);
		LODOP.ADD_PRINT_TEXT('48mm','110mm','20mm','5mm',data.width);
		LODOP.ADD_PRINT_TEXT('48mm','140mm','20mm','5mm',data.acturalHeight);
		LODOP.ADD_PRINT_TEXT('48mm','165mm','20mm','5mm',data.length*data.width*data.acturalHeight);
		LODOP.ADD_PRINT_TEXT('48mm','190mm','20mm','5mm',data.waInnerLong);
		LODOP.ADD_PRINT_TEXT('48mm','210mm','20mm','5mm',data.waInnerWidth);
		LODOP.ADD_PRINT_TEXT('48mm','235mm','20mm','5mm',data.waDesignHeight);
		LODOP.ADD_PRINT_TEXT('48mm','260mm','20mm','5mm',data.waInnerLong*data.waInnerWidth*data.waDesignHeight);
		
		LODOP.ADD_PRINT_TEXT('70mm','33mm','20mm','5mm',data.grainVariety);
		LODOP.ADD_PRINT_TEXT('70mm','60mm','20mm','5mm',data.amount);
		LODOP.ADD_PRINT_TEXT('70mm','85mm','20mm','5mm',data.waterPer);
		LODOP.ADD_PRINT_TEXT('70mm','110mm','20mm','5mm',data.upperTemperature);
		LODOP.ADD_PRINT_TEXT('70mm','140mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('70mm','165mm','20mm','5mm',data.footTemperature);
		LODOP.ADD_PRINT_TEXT('70mm','190mm','20mm','5mm',data.houseTemperature);
		LODOP.ADD_PRINT_TEXT('70mm','210mm','20mm','5mm',data.innerWet);
		LODOP.ADD_PRINT_TEXT('70mm','235mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('70mm','260mm','20mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('93mm','33mm','20mm','5mm',data.chonghai);
		LODOP.ADD_PRINT_TEXT('93mm','85mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('93mm','110mm','20mm','5mm',data.perWeight);
		LODOP.ADD_PRINT_TEXT('93mm','140mm','40mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('93mm','190mm','40mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('100mm','33mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('100mm','85mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('100mm','110mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('100mm','140mm','40mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('100mm','190mm','40mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('130mm','33mm','40mm','5mm',data.steamForm);
		LODOP.ADD_PRINT_TEXT('130mm','85mm','20mm','5mm',"");
		//药
		LODOP.ADD_PRINT_TEXT('130mm','165mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('130mm','190mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('130mm','210mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('130mm','235mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('130mm','260mm','20mm','5mm',data.mAmount);
		LODOP.ADD_PRINT_TEXT('140mm','165mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('140mm','190mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('140mm','210mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('140mm','235mm','20mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('140mm','260mm','20mm','5mm',"");
		//选框
		LODOP.ADD_PRINT_TEXT('135mm','124mm','5mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('135mm','138mm','5mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('145mm','124mm','5mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('145mm','138mm','5mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('155mm','170mm','20mm','5mm',data.personNumber);
		LODOP.ADD_PRINT_TEXT('155mm','260mm','20mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('163mm','60mm','100mm','5mm',data.persons);
		LODOP.ADD_PRINT_TEXT('163mm','260mm','20mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('173mm','60mm','100mm','5mm',data.remark);
		
		LODOP.ADD_PRINT_TEXT('180mm','60mm','50mm','5mm',"");
		LODOP.ADD_PRINT_TEXT('180mm','210mm','50mm','5mm',"");
		
		
        LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='"+rootPath+"/img/steamApply.jpg'>");
		LODOP.SET_SHOW_MODE("BKIMG_PRINT",1);	//预览打印包含背景图(默认没图)		
		//LODOP.PREVIEW(); //打印预览
		LODOP.PRINT_DESIGN();  //打印设计
		//LODOP.PRINT_INIT("");  //打印设计
		//LODOP.PRINT_SETUP();  //打印维护
	};	