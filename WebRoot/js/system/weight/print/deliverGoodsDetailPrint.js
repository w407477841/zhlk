var LODOP; //声明为全局变量
	function deliverGoodsDetailPrint(data) {		
		LODOP=getLodop(); 
		
		//第一个参数：1：纵向，2：横向
		//第二个参数：纸张宽，单位0.1mm
		//第三个参数：纸张高，单位0.1mm
		//第四个参数：纸张类型名，当第三个参数为0时，此参数才有效
		LODOP.SET_PRINT_PAGESIZE(0,2970,2110,'A4');
		
		LODOP.ADD_PRINT_TEXT('47mm','52mm','50mm','5mm',data.agreementBill);
		LODOP.ADD_PRINT_TEXT('47mm','140mm','50mm','5mm',data.getoutBill);
		LODOP.ADD_PRINT_TEXT('47mm','230mm','50mm','5mm',data.agreementName);
		
		LODOP.ADD_PRINT_TEXT('62mm','52mm','50mm','5mm',data.deliverGoodsName);
		LODOP.ADD_PRINT_TEXT('62mm','140mm','50mm','5mm',data.takeDeliveryName);
		LODOP.ADD_PRINT_TEXT('62mm','230mm','50mm','5mm',data.transportName);
		
		LODOP.ADD_PRINT_TEXT('77mm','52mm','50mm','5mm',data.deliverGoodsStation);
		LODOP.ADD_PRINT_TEXT('77mm','140mm','50mm','5mm',data.takeDeliveryStation);
		LODOP.ADD_PRINT_TEXT('77mm','230mm','50mm','5mm',data.transportTool);
		
		LODOP.ADD_PRINT_TEXT('92mm','52mm','50mm','5mm',data.deliverGoodsDate);
		LODOP.ADD_PRINT_TEXT('92mm','140mm','50mm','5mm',data.takeDeliveryDate);
		LODOP.ADD_PRINT_TEXT('92mm','230mm','50mm','5mm',data.carOrShipNo);
		
		LODOP.ADD_PRINT_TEXT('107mm','52mm','50mm','5mm',data.grainVariety);
		LODOP.ADD_PRINT_TEXT('107mm','150mm','50mm','5mm',data.takeDeliveryNumberLower);
		LODOP.ADD_PRINT_TEXT('107mm','230mm','50mm','5mm',data.transportBill);
		
		LODOP.ADD_PRINT_TEXT('122mm','52mm','50mm','5mm',data.warehouseName);
		LODOP.ADD_PRINT_TEXT('122mm','150mm','50mm','5mm',data.takeDeliveryNumberUpper);
		LODOP.ADD_PRINT_TEXT('122mm','230mm','50mm','5mm',data.transportLossRate);
		
		LODOP.ADD_PRINT_TEXT('137mm','62mm','50mm','5mm',data.deliverGoodsNumberLower);
		LODOP.ADD_PRINT_TEXT('137mm','140mm','50mm','5mm',data.tureLossNumber);
		LODOP.ADD_PRINT_TEXT('137mm','230mm','50mm','5mm',data.transportLossNumber);
		
		LODOP.ADD_PRINT_TEXT('152mm','62mm','50mm','5mm',data.deliverGoodsNumberUpper);
		LODOP.ADD_PRINT_TEXT('152mm','140mm','50mm','5mm',data.overstepNumber);
		
		LODOP.ADD_PRINT_TEXT('167mm','32mm','250mm','5mm',data.remark);
        LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='"+rootPath+"/img/deliverGoodsDetail.jpg'>");
		LODOP.SET_SHOW_MODE("BKIMG_PRINT",1);	//预览打印包含背景图(默认没图)		
		LODOP.PREVIEW(); //打印预览
		//LODOP.PRINT_DESIGN();  //打印设计
	};	