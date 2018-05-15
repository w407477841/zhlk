package com.zyiot.controller.weight;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.HardwareConfigFormMap;
import com.zyiot.entity.weight.WeighingSpeckConfigFormMap;
import com.zyiot.entity.weight.WeighingVideoConfigFormMap;
import com.zyiot.server.weight.HardwareConfigServerI;
import com.zyiot.server.weight.WeighingSpeckConfigServerI;
import com.zyiot.server.weight.WeighingVideoConfigServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FileManager;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.PropertiesUtils;
/**
 * 设备参数配置
 * @author Lip
 * @date 2017年4月24日 上午11:14:31
 */

@Controller
@RequestMapping("config")
public class ConfigController extends BaseController {
	Logger log = Logger.getLogger(ConfigController.class);
	
	@Autowired
	private HardwareConfigServerI hardwareConfigServer;
	@Autowired
	private WeighingVideoConfigServerI weighingVideoConfigServer;
	@Autowired
	private WeighingSpeckConfigServerI weighingSpeckConfigServer;
	
	@RequestMapping("list")
	public String list(Model model){
		Properties properties = PropertiesUtils.getPropertyByName("weightConfig.properties");
		String usedOrNot = properties.getProperty("usedOrNot");
		model.addAttribute("usedOrNot",usedOrNot);
		String companyName = properties.getProperty("companyName");
		model.addAttribute("companyName",companyName);
		
		
		return Constant.BACKGROUND_PATH+"/weight/config/config";
	}
	/**
	 * RFID卡设置
	 * @param request
	 * @return
	 */
	@RequestMapping("carConfig")
	@ResponseBody
	public String carConfig(HttpServletRequest request){
		Session session = SecurityUtils.getSubject().getSession();
		String mac = (String) session.getAttribute(Constant.MAC_ADDr);

		HardwareConfigFormMap hardwareConfig = hardwareConfigServer.findByMacAndType(mac, Constant.RFID_CAR);
		
		String port = getPara("port");
		String rate = getPara("rate");
		String start = getPara("start");
		String num = getPara("num");
		String remark = getPara("remark");
		
		if(hardwareConfig == null){//添加
			hardwareConfig = new HardwareConfigFormMap();
			hardwareConfig.set("mac", mac);
			hardwareConfig.set("carType", Constant.RFID_CAR);
			hardwareConfig.set("COMNum",port);
			hardwareConfig.set("baudRate",rate);
			hardwareConfig.set("startAddress",start);
			hardwareConfig.set("wordNum",num);
			hardwareConfig.set("remark",remark);
			
			try {
				FormMapUtil.toADDFormMap(hardwareConfig);
				hardwareConfigServer.addHardwareConfig(hardwareConfig);
			} catch (Exception e) {
				log.error("===Class:ConfigController==Method:carConfig==Exception:addHardwareConfig=="+e);
				return ERROR;
			}
		}else{//修改
			hardwareConfig.set("COMNum",port);
			hardwareConfig.set("baudRate",rate);
			hardwareConfig.set("startAddress",start);
			hardwareConfig.set("wordNum",num);
			hardwareConfig.set("remark",remark);
			try {
				FormMapUtil.toUPDATEFormMap(hardwareConfig);
				hardwareConfigServer.editHardwareConfig(hardwareConfig);
			} catch (Exception e) {
				log.error("===Class:ConfigController==Method:carConfig==Exception:editHardwareConfig=="+e);
				return ERROR;
			}
		}
		
		return SUCCESS;
	}
	@RequestMapping("findRFIDByPage")
	@ResponseBody
	public MyPage<HardwareConfigFormMap> findRFIDByPage(int rows,int page){
		
		List<HardwareConfigFormMap> list = hardwareConfigServer.findByCarType(Constant.RFID_CAR,page,rows);
		
		return toMyPage(list);
	}
	
	
	/**
	 * 删除RFID配置
	 * @return
	 */
	@RequestMapping("deleteRFIDConfig")
	@ResponseBody
	public String deleteRFIDConfig(){
		String id = getPara("id");
		try {
			hardwareConfigServer.dropHardwareConfig(id);
		} catch (Exception e) {
			log.error("===Class:ConfigController==Method:deleteRFIDConfig==Exception:dropHardwareConfig=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 设置一卡通是否启用
	 * @return
	 */
	@RequestMapping("oneCardSetting")
	@ResponseBody
	public String oneCardSetting(){
		String usedOrNot = getPara("usedOrNot");
		
		PropertiesUtils.modifyByName("weightConfig", "usedOrNot", usedOrNot);
		
		return SUCCESS;
	}
	/**
	 * 修改或添加称重视频配置
	 * @return
	 */
	@RequestMapping("shipinSetting")
	@ResponseBody
	public String shiPinSetting(){
		String ip = getPara("ip");
		String mac = getPara("mac");
		String port = getPara("port");
		String remark = getPara("remark");
		String userName = getPara("userName");
		String password = getPara("password");
		String through = getPara("through");
		String turnweighing = getPara("turnweighing");
		String screenshotPath = getPara("screenshotPath");
		String printType = getPara("printType");
		String id = getPara("id");
		List<WeighingVideoConfigFormMap> weighingVideoConfigList = weighingVideoConfigServer.findWeighingVideoConfigByMAC(mac);
		if(Common.isEmpty(id)){ //新增
			WeighingVideoConfigFormMap weighingVideoConfig =  new WeighingVideoConfigFormMap();
			
			weighingVideoConfig.set("ipAddr", ip);
			weighingVideoConfig.set("mac", mac);
			weighingVideoConfig.set("ipPort", port);
			weighingVideoConfig.set("remark", remark);
			weighingVideoConfig.set("userName", userName);
			weighingVideoConfig.set("password", password);
			weighingVideoConfig.set("throughPort", through);
			weighingVideoConfig.set("turnWeighing", turnweighing);
			weighingVideoConfig.set("screenshotPath", screenshotPath);
			weighingVideoConfig.set("printType", printType);
			
			try {
				FormMapUtil.toADDFormMap(weighingVideoConfig);
				weighingVideoConfigServer.addWeighingVideoConfig(weighingVideoConfig);
			} catch (Exception e) {
				log.error("===Class:ConfigController==Method:shiPinSetting==Exception:addWeighingVideoConfig=="+e);
				return ERROR;
			}
		}else{ //修改
			WeighingVideoConfigFormMap weighingVideoConfig = weighingVideoConfigServer.findWeighingVideoConfigById(Integer.parseInt(id));
			
			weighingVideoConfig.set("ipAddr", ip);
			weighingVideoConfig.set("mac", mac);
			weighingVideoConfig.set("ipPort", port);
			weighingVideoConfig.set("remark", remark);
			weighingVideoConfig.set("userName", userName);
			weighingVideoConfig.set("password", password);
			weighingVideoConfig.set("throughPort", through);
			weighingVideoConfig.set("turnWeighing", turnweighing);
			weighingVideoConfig.set("screenshotPath", screenshotPath);
			weighingVideoConfig.set("printType", printType);
			
			try {
				FormMapUtil.toUPDATEFormMap(weighingVideoConfig);
				weighingVideoConfigServer.editWeighingVideoConfig(weighingVideoConfig);
			} catch (Exception e) {
				log.error("===Class:ConfigController==Method:shiPinSetting==Exception:editWeighingVideoConfig=="+e);
				return ERROR;
			}
		}
		//把所有的轮询设置改成一样
		//把所以的截图地址改成一样
		//把所有的打印方式改成一样
		if(weighingVideoConfigList != null && weighingVideoConfigList.size()>0){
			for(WeighingVideoConfigFormMap weighingVideoConfig:weighingVideoConfigList){
				if(!Common.isEmpty(id)){ //如果id存在，则不需要在此修改
					if(weighingVideoConfig.getInt("id")==Integer.parseInt(id)){
						continue;
					}
				}
				weighingVideoConfig.set("turnWeighing", turnweighing);
				weighingVideoConfig.set("screenshotPath", screenshotPath);
				weighingVideoConfig.set("printType", printType);
				try {
					FormMapUtil.toUPDATEFormMap(weighingVideoConfig);
					weighingVideoConfigServer.editWeighingVideoConfig(weighingVideoConfig);
				} catch (Exception e) {
					log.error("===Class:ConfigController==Method:shiPinSetting==Exception:editWeighingVideoConfig=="+e);
					return ERROR;
				}
			}
		}
		
		return SUCCESS;
	}
	
	/**
	 * 分页查询称重视频配置
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findWeighingVideoByPage")
	@ResponseBody
	public MyPage<WeighingVideoConfigFormMap> findWeighingVideoByPage(int rows,int page){
		WeighingVideoConfigFormMap weighingVideoConfigFormMap = getFormMap(WeighingVideoConfigFormMap.class);
		List<WeighingVideoConfigFormMap> list = weighingVideoConfigServer.findByPage(weighingVideoConfigFormMap, page, rows);
		
		return toMyPage(list);
	}
	/**
	 * 删除称重视频配置
	 * @return
	 */
	@RequestMapping("deleteWeighingVideoConfig")
	@ResponseBody
	public String deleteWeighingVideoConfig(){
		String id = getPara("id");
		try {
			weighingVideoConfigServer.dropWeighingVideoConfig(id);
		} catch (Exception e) {
			log.error("===Class:ConfigController==Method:deleteWeighingVideoConfig==Exception:dropWeighingVideoConfig=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 添加或修改称重语音播报
	 * @return
	 */
	@RequestMapping("addOrUpdateSpeck")
	@ResponseBody
	public String addOrUpdateSpeck(){
		String mac = getPara("mac");
		String isOpen = getPara("isOpen");
		String speechRate = getPara("speechRate");
		String speechContent = getPara("speechContent");
		String speechRemark = getPara("speechRemark");
		
		WeighingSpeckConfigFormMap weighingSpeckConfig = weighingSpeckConfigServer.findWeighingSpeckConfigByMac(mac);
		if(weighingSpeckConfig == null){
			weighingSpeckConfig =  new WeighingSpeckConfigFormMap();
			weighingSpeckConfig.set("mac", mac);
			weighingSpeckConfig.set("isOpen",isOpen);
			weighingSpeckConfig.set("speechRate", speechRate);
			weighingSpeckConfig.set("content", speechContent);
			weighingSpeckConfig.set("remark", speechRemark);
			
			try {
				FormMapUtil.toADDFormMap(weighingSpeckConfig);
				weighingSpeckConfigServer.addWeighingSpeckConfig(weighingSpeckConfig);
			} catch (Exception e) {
				log.error("===Class:ConfigController==Method:addOrUpdateSpeck==Exception:addWeighingSpeckConfig=="+e);
				return ERROR;
			}
		}else{
			weighingSpeckConfig.set("mac", mac);
			weighingSpeckConfig.set("isOpen",isOpen);
			weighingSpeckConfig.set("speechRate", speechRate);
			weighingSpeckConfig.set("content", speechContent);
			weighingSpeckConfig.set(Constant.VERSION, weighingSpeckConfig.getInt(Constant.VERSION)+1);
			weighingSpeckConfig.set("remark", speechRemark);
			try {
				FormMapUtil.toUPDATEFormMap(weighingSpeckConfig);
				weighingSpeckConfigServer.editWeighingSpeckConfig(weighingSpeckConfig);
			} catch (Exception e) {
				log.error("===Class:ConfigController==Method:addOrUpdateSpeck==Exception:editWeighingSpeckConfig=="+e);
				return ERROR;
			}
		}
		return SUCCESS;
	}
	/**
	 * 分页显示语音播报
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findWeighingSpeckByPage")
	@ResponseBody
	public MyPage<WeighingSpeckConfigFormMap> findWeighingSpeckByPage(int rows,int page){
		List<WeighingSpeckConfigFormMap> list = weighingSpeckConfigServer.findByPage(page, rows);
		return toMyPage(list);
	}
	/**
	 * 删除语音播报
	 * @return
	 */
	@RequestMapping("deleteWeighingSpeckConfig")
	@ResponseBody
	public String deleteWeighingSpeckConfig(){
		String id = getPara("id");
		try {
			weighingSpeckConfigServer.dropWeighingSpeckConfig(id);
		} catch (Exception e) {
			log.error("===Class:ConfigController==Method:deleteWeighingSpeckConfig==Exception:dropWeighingSpeckConfig=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 收购凭证--收购单位
	 * @return
	 */
	@RequestMapping("companySetting")
	@ResponseBody
	public String companySetting(){
		String companyName = getPara("companyName");
		
		PropertiesUtils.modifyByName("weightConfig", "companyName", companyName);
		
		return SUCCESS;
	}
	/**
	 * 插件下载 -- Active 支持OCX
	 * @param request
	 * @param response
	 */
	@RequestMapping("fileDownload")
	public void fileDownload(HttpServletRequest request,HttpServletResponse response){
		String path = request.getServletContext().getRealPath("/codebase");
		try {
			FileManager.download(path, "FFOCX.rar", response);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
}
