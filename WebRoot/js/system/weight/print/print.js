var LODOP; //声明为全局变量
	function myPrint(data) {		
		LODOP=getLodop(); 
		
		//第一个参数：1：纵向，2：横向
		//第二个参数：纸张宽，单位0.1mm
		//第三个参数：纸张高，单位0.1mm
		//第四个参数：纸张类型名，当第三个参数为0时，此参数才有效
		LODOP.SET_PRINT_PAGESIZE(1,2110,1400,'A4');
		
		LODOP.ADD_PRINT_TEXT('31mm','38mm','50mm','5mm',data.companyName);
		LODOP.ADD_PRINT_TEXT('31mm','100mm','30mm','5mm',data.nowDate);
		
		LODOP.ADD_PRINT_TEXT('41mm','35mm','23mm','5mm',data.userName);
		LODOP.ADD_PRINT_TEXT('41mm','74mm','45mm','5mm',data.address);
		LODOP.ADD_PRINT_TEXT('41mm','140mm','40mm','5mm',data.IDCard);

        LODOP.ADD_PRINT_TEXT('52mm','42mm','18mm','5mm',data.shipId);
		LODOP.ADD_PRINT_TEXT('52mm','74mm','25mm','5mm',data.grainVariety);
		LODOP.ADD_PRINT_TEXT('52mm','120mm','20mm','5mm',data.level);
		LODOP.ADD_PRINT_TEXT('52mm','156mm','20mm','5mm',data.wName);
		
		LODOP.ADD_PRINT_TEXT('64mm','51mm','10mm','5mm',data.sf);
		LODOP.ADD_PRINT_TEXT('64mm','86mm','10mm','5mm',data.rz);
		LODOP.ADD_PRINT_TEXT('64mm','115mm','10mm','5mm',data.zjml);
		LODOP.ADD_PRINT_TEXT('64mm','143mm','10mm','5mm',data.gwcm);
		LODOP.ADD_PRINT_TEXT('64mm','168mm','10mm','5mm',data.hlm);
		
		LODOP.ADD_PRINT_TEXT('70mm','51mm','10mm','5mm',data.zz);
		LODOP.ADD_PRINT_TEXT('70mm','86mm','10mm','5mm',data.rz);
		LODOP.ADD_PRINT_TEXT('70mm','115mm','10mm','5mm',data.bwsld);
		LODOP.ADD_PRINT_TEXT('70mm','143mm','10mm','5mm',data.cmbl);
		LODOP.ADD_PRINT_TEXT('70mm','173mm','10mm','5mm',data.szqw);
		
		LODOP.ADD_PRINT_TEXT('81mm','50mm','15mm','5mm',data.grossWeight);
		LODOP.ADD_PRINT_TEXT('81mm','74mm','15mm','5mm',data.tare);
		LODOP.ADD_PRINT_TEXT('81mm','97mm','15mm','5mm',(data.totalWeight - data.trueWeight));
		LODOP.ADD_PRINT_TEXT('81mm','120mm','15mm','5mm',data.trueWeight);
		LODOP.ADD_PRINT_TEXT('81mm','167mm','15mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('100mm','48mm','15mm','5mm',data.sfkl);
		LODOP.ADD_PRINT_TEXT('100mm','73mm','15mm','5mm',data.zzkl);
		LODOP.ADD_PRINT_TEXT('100mm','104mm','15mm','5mm',data.otherReduce);
		LODOP.ADD_PRINT_TEXT('100mm','130mm','15mm','5mm',data.totalReduce);
		LODOP.ADD_PRINT_TEXT('100mm','169mm','15mm','5mm',"");
		
		LODOP.ADD_PRINT_TEXT('107mm','48mm','15mm','5mm',data.buyPrice);
		LODOP.ADD_PRINT_TEXT('107mm','140mm','30mm','5mm',data.sumMoney);
		
		LODOP.ADD_PRINT_TEXT('116mm','65mm','70mm','5mm',data.sumMoneyUp);
		
		//LODOP.ADD_PRINT_TEXT('124mm','40mm','20mm','5mm',data.checker);
		//LODOP.ADD_PRINT_TEXT('124mm','77mm','20mm','5mm',data.weightAuthor);
		//LODOP.ADD_PRINT_TEXT('124mm','116mm','20mm','5mm',data.payAuthor);
		//LODOP.ADD_PRINT_TEXT('124mm','155mm','20mm','5mm',data.payAuthor);
		
        LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='"+rootPath+"/img/putinBill.jpg'>");
		LODOP.SET_SHOW_MODE("BKIMG_PRINT",1);	//预览打印包含背景图(默认没图)		
		LODOP.PREVIEW(); //打印预览	
	};	