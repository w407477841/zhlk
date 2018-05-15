package com.zyiot.test;

import org.junit.Test;

import com.aisino.grain.webservice.impl.GrainService;
import com.aisino.grain.webservice.impl.GrainServiceImplService;
import com.ictehi.grainplat.service.GrainplatService;
import com.ictehi.grainplat.service.GrainplatServicePortType;

public class DuiJieTest {
	
	/**
	 * 省级
	 */
	public void shihsikucun() {

		GrainServiceImplService gis = new GrainServiceImplService();

		GrainService gs = gis.getGrainServiceImplPort();
		StringBuffer sb = new StringBuffer();
		sb.append("{storehouse:'008',house:'004',allocation:'',status:'2',houseStoreID:'002',grainKind:'111',quantity:'1298233',grainAttribute:'121',grade:'',owner:'',year:'2014',DBarCode:'',houseCode:'',inBeginTime:'20140601000000',storeBeginTime:'20140801000000'}");
		
		byte[] bs = sb.toString().getBytes();
		System.out.println(gs.saveOrUpdateGrainDepotInfo(bs, bs.length + "", 2,
				"001", "729013324"));
	}

	/**
	 * 市级
	 */
	@Test
	public void shiji_shishikucun() {
		com.ictehi.grainplat.service.GrainplatService s = new GrainplatService();
		GrainplatServicePortType ss = s.getGrainplatServiceHttpSoap11Endpoint();
		StringBuffer sb = new StringBuffer();
		//sb.append("{storehouse:'008',house:'004',allocation:'',status:'2',houseStoreID:'002',grainKind:'111',quantity:'1298233',grainAttribute:'121',grade:'',owner:'',year:'2014',DBarCode:'',houseCode:'',inBeginTime:'20140601000000',storeBeginTime:'20140801000000'}");
		//sb.append("{storehouse:'007',house:'001',allocation:'',houseStoreID:'',inTemp:'',inH:'',outTemp:'',outH:'',maxTemp:'',minTemp:'',averageTemp:'',time:'20170106100816',points:[{temp:'9.5',X:'0',Y:'0',Z:'0',rod:'1',point:'1'}]}");
		sb.append("{equipment_group_id:'1',type_name:'仓储设备',type_des:'',measuring_unit_code:'5',original_id:'2',");
		sb.append("equipment:[{equipment_name:'熏蒸机械',measuring_unit_code:'5',equipment_group_id:'1',equipment_model:'DS1001',equipment_spec:'sc001',equipment_state:'1',manufacturer:'江苏南通',procurement_price:'5693',original_id:'2'}]}");
		System.out.println(ss.saveOrUpdateGrainDepotInfo(sb.toString(),sb.length() + "", 12, "001", "690266497"));
	}
	public static void main(String[] args) {
		DuiJieTest a=new DuiJieTest();
		
		a.shiji_shishikucun();
	}
}
