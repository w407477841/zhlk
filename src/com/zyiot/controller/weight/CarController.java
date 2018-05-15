package com.zyiot.controller.weight;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.CarFormMap;
import com.zyiot.entity.weight.HardwareConfigFormMap;
import com.zyiot.entity.weight.WeighingFormMap;
import com.zyiot.server.weight.CarServerI;
import com.zyiot.server.weight.HardwareConfigServerI;
import com.zyiot.server.weight.WeighingServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.TwoDimensionCodeUtil;
import com.zyiot.util.ValidateUtil;
/**
 * 车辆档案信息
 * @author Lip
 * @date 2017年4月24日 上午9:13:48
 */
@Controller
@RequestMapping("car")
public class CarController extends BaseController {
	Logger log = Logger.getLogger(CarController.class);
	@Autowired
	private CarServerI carServer;
	@Autowired
	private WeighingServerI weighingServer;
	
	@Autowired
	private HardwareConfigServerI hardwareConfigServer;
	
	@RequestMapping("list")
	public String listUI(){
		return Constant.BACKGROUND_PATH+"/weight/car/carlist";
	}
	/**
	 * 分页查询所有车辆信息
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<CarFormMap> findByPage(int rows,int page){
		CarFormMap carFormMap = getFormMap(CarFormMap.class);
		List<CarFormMap> list = carServer.findByPage(carFormMap, rows, page);
		return toMyPage(list);
	}
	/**
	 * 查找未分配的车，或者此单据号分配的车
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findNotUsedByPage")
	@ResponseBody
	public MyPage<CarFormMap> findNotUsedByPage(int rows,int page){
		String bId = getPara("bId");
		List<CarFormMap> list = carServer.findNotUsedByPage(bId, rows, page);
		return toMyPage(list);
	}
	
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Constant.BACKGROUND_PATH+"/weight/car/caradd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		CarFormMap carFormMap = getFormMap(CarFormMap.class);
		if(!validData(carFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(carFormMap);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			carServer.addCar(carFormMap);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:add==Exception:addCar=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		String id = getPara("id");
		CarFormMap carFormMap = carServer.findCarById(Integer.parseInt(id));
		model.addAttribute("carFormMap", carFormMap);
		return Constant.BACKGROUND_PATH+"/weight/car/caredit"; 
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		CarFormMap carFormMap = getFormMap(CarFormMap.class);
		if(!validData(carFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(carFormMap);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:edit==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			carServer.editCar(carFormMap);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:edit==Exception:editCar=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		
		try {
			carServer.dropCar(id);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:delete==Exception:dropCar=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("usedUI")
	@Token(save=true)
	public String usedUI(Model model){
		Session session = SecurityUtils.getSubject().getSession();
		String mac = (String) session.getAttribute(Constant.MAC_ADDr);
		HardwareConfigFormMap hardwareConfig = hardwareConfigServer.findByMacAndType(mac, Constant.RFID_CAR);
		
		String id = getPara("id");
		String bId = getPara("bId");
		CarFormMap carFormMap = carServer.findCarById(Integer.parseInt(id));
		model.addAttribute("carFormMap", carFormMap);
		model.addAttribute("bId", bId);
		model.addAttribute("hardwareConfig", hardwareConfig);
		return Constant.BACKGROUND_PATH+"/weight/car/carused"; 
	}
	/**
	 * 车辆分配
	 * @return
	 */
	@RequestMapping("used")
	@ResponseBody
	@Token(remove=true)
	public String used(){
		CarFormMap carFormMap = getFormMap(CarFormMap.class);
		if(!validData1(carFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(carFormMap);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:used==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			carServer.editCar(carFormMap);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:used==Exception:editCar=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("look")
	public String look(Model model){
		String id = getPara("id");
		CarFormMap carFormMap = carServer.findCarById(Integer.parseInt(id));
		model.addAttribute("carFormMap", carFormMap);
		return Constant.BACKGROUND_PATH+"/weight/car/carlook";
	}
	/**
	 * 判断RFID卡是否已绑定
	 * @return
	 */
	@RequestMapping("isUsed")
	@ResponseBody
	public String isUsed(){
		String id = getPara("rfid");
		CarFormMap carFormMap = carServer.isUsed(id);
		if(carFormMap != null){
			return SUCCESS;
		}else{
			return ERROR;
		}
	}
	/**
	 * 根据id清除车辆绑定
	 * @return
	 */
	@RequestMapping("clearUsedById")
	@ResponseBody
	public String clearUsedById(){
		String Id = getPara("id");
		//根据id获取车辆信息
		CarFormMap carFormMap = carServer.findCarById(Integer.parseInt(Id));
		if(carFormMap != null){
			//根据车辆信息获取单据号
			String bId = carFormMap.getStr("bId");
			//根据单据号获取称重信息
			List<WeighingFormMap> weighingList = weighingServer.findWeighingByBId(bId);
			//若有称重信息，则不可进行解绑操作
			if(weighingList != null && weighingList.size()>0){
				return "used";
			}
		}
		try {
			carServer.ClearUsedCarById(Integer.parseInt(Id));
		} catch (NumberFormatException e) {
			log.error("===Class:CarController==Method:clearUsedById==Exception:Integer.parseInt=="+e);
			return ERROR;
		} catch (Exception e) {
			log.error("===Class:CarController==Method:clearUsedById==Exception:ClearUsedCarById=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 没有RFID卡，生成二维码
	 * @param model
	 * @return
	 */
	@RequestMapping("crateQC")
	public String createQC(Model model){
		String id = getPara("id");
		String bId = getPara("bId");
		String rfid=Common.getRandomString(16);
		CarFormMap carFormMap = carServer.findCarById(Integer.parseInt(id));
		carFormMap.set("id", id);
		carFormMap.set("bId", bId);
		carFormMap.set("RFID", rfid);
		carFormMap.set("RFIDName", "二维码");
		carFormMap.set(Constant.VERSION, carFormMap.getInt(Constant.VERSION)+"");
		try {
			FormMapUtil.toUPDATEFormMap(carFormMap);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:createQC==Exception:toUPDATEFormMap=="+e);
		}
		
		try {
			carServer.editCar(carFormMap);
		} catch (Exception e) {
			log.error("===Class:CarController==Method:createQC==Exception:editCar=="+e);
		}
		//model.addAttribute("qcId", rfid);
		model.addAttribute("carFormMap", carFormMap);
		return Constant.BACKGROUND_PATH+"/weight/car/carqc";
	}
	
	/**
	 * 打印二维码
	 * @param model
	 * @return
	 */
	@RequestMapping("printQC")
	public String printQC(Model model){
		String id = getPara("id");
		CarFormMap carFormMap = carServer.findCarById(Integer.parseInt(id));
		model.addAttribute("carFormMap", carFormMap);
		return Constant.BACKGROUND_PATH+"/weight/car/carqc";
	}
	/**
	 * 生成二维码图片显示在页面
	 * @param response
	 */
	@RequestMapping("createqrc")
	public void createQC(HttpServletResponse response){
		String qc = getPara("qc");
		TwoDimensionCodeUtil.encoderQRCode(qc, response);
	}
	/**
	 * 根据单据号查找所使用的车辆信息
	 * @return
	 */
	@RequestMapping("findUsedCarByBId")
	@ResponseBody
	public List<CarFormMap> findUsedCarByBId(){
		String bId = getPara("bId");
		if(!Common.isEmpty(bId)){
			return carServer.findCarByBId(bId);
		}
		return null;
	}
	
	@RequestMapping("findById")
	@ResponseBody
	public CarFormMap findById(){
		String id = getPara("id");
		CarFormMap carFormMap = carServer.findCarById(Integer.parseInt(id));
		return carFormMap;
	}
	/**
	 * 根据rfid卡查找车辆信息
	 * @return
	 */
	@RequestMapping("findByRFID")
	@ResponseBody
	public CarFormMap findByRFID(){
		String rfid = getPara("rfid");
		CarFormMap carFormMap = carServer.isUsed(rfid);
		return carFormMap;
	}
	
	private boolean validData(CarFormMap carFormMap){
		String cId = carFormMap.getStr("cId");
		String driver = carFormMap.getStr("driver");
		String carType = carFormMap.getStr("carType");
		String driveLicense = carFormMap.getStr("driveLicense");
		String phoneNumber = carFormMap.getStr("phoneNumber");
		
		if(ValidateUtil.isEmpty(cId) || !ValidateUtil.isLength(cId, Constant.INT_16)){
			return false;
		}
		if(ValidateUtil.isEmpty(carType) || !ValidateUtil.isLength(carType, Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(driver, Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(driveLicense, Constant.INT_32)){
			return false;
		}

		if(!ValidateUtil.isLength(phoneNumber, Constant.INT_16)){
			return false;
		}

		return true;
	}
	private boolean validData1(CarFormMap carFormMap){
		String bId = carFormMap.getStr("bId");
		String RFID = carFormMap.getStr("RFID");
		String RFIDName = carFormMap.getStr("RFIDName");
		
		if(ValidateUtil.isEmpty(bId) || !ValidateUtil.isLength(bId, Constant.INT_16)){
			return false;
		}
		if(ValidateUtil.isEmpty(RFID) || !ValidateUtil.isLength(RFID, Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(RFIDName) || !ValidateUtil.isLength(RFIDName, Constant.INT_32)){
			return false;
		}
		
		return true;
	}
}
