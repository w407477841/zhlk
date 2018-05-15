package com.zyiot.controller.shebeiguanli;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiFormMap;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiFuJianFormMap;
import com.zyiot.entity.shebeiguanli.DaXingSheBeiWeiXiuFormMap;
import com.zyiot.server.shebeiguanli.DaXingSheBeiFuJianServiceI;
import com.zyiot.server.shebeiguanli.DaXingSheBeiServiceI;
import com.zyiot.server.shebeiguanli.DaXingSheBeiWeiXiuServiceI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("daxingshebeikucun")
public class DaXingSheBeiKuCunController extends BaseController {
	Logger log = Logger.getLogger(DaXingSheBeiKuCunController.class);
	@Autowired
	private DaXingSheBeiServiceI daXingSheBeiService;
	@Autowired
	private DaXingSheBeiFuJianServiceI daXingSheBeiFuJianService;
	@Autowired
	private DaXingSheBeiWeiXiuServiceI daXingSheBeiWeiXiuService;
	@Autowired
	private DataSource dataSource;
	
	@RequestMapping("listUI")
	public String listUI(){
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/kucunguanlilist";
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<DaXingSheBeiFormMap> findByPage(int page, int rows){
		DaXingSheBeiFormMap daXingSheBeiFormMap =getFormMap(DaXingSheBeiFormMap.class);
		List<DaXingSheBeiFormMap> list = daXingSheBeiService.findByPage(daXingSheBeiFormMap, rows, page);
		if(list!=null && list.size()>0){
			for(DaXingSheBeiFormMap yj:list){
				Date date = yj.getDate("leUsedDate");
				yj.set("leUsedDate", DateUtils.dateFormatToShort(date));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		clearFuJian();
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/kucunguanliadd";
	}
	
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		DaXingSheBeiFormMap daXingSheBeiFormMap = getFormMap(DaXingSheBeiFormMap.class);
		if(!validData(daXingSheBeiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(daXingSheBeiFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiKuCunController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			String dateStr = daXingSheBeiFormMap.getStr("leUsedDate")+" 00:00:00";
			Timestamp ts = Timestamp.valueOf(dateStr);
			daXingSheBeiFormMap.set("leUsedDate",ts);
			
			Session session = SecurityUtils.getSubject().getSession();
			daXingSheBeiFormMap.put("leDataOperator", session.getAttribute("userSessionId"));
			
			daXingSheBeiService.addDaXingSheBei(daXingSheBeiFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiKuCunController==Method:addDaXingSheBei=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		
		clearFuJian();
		
		String id = getPara("id");
		DaXingSheBeiFormMap daXingSheBeiFormMap = daXingSheBeiService.findDaXingSheBeiById(Integer.parseInt(id));
		daXingSheBeiFormMap.set("leUsedDate", DateUtils.dateFormatToShort(daXingSheBeiFormMap.getDate("leUsedDate")));
		model.addAttribute("daXingSheBeiFormMap", daXingSheBeiFormMap);
		return  Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/kucunguanliedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		DaXingSheBeiFormMap daXingSheBeiFormMap = getFormMap(DaXingSheBeiFormMap.class);
		if(!validData(daXingSheBeiFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(daXingSheBeiFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			daXingSheBeiService.editDaXingSheBei(daXingSheBeiFormMap);
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:editDaXingSheBei=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(Model model) {
		String id = getPara("id");
		try {
			daXingSheBeiService.dropDaXingSheBei(id);
				
		} catch (Exception e) {
			log.error("===Class:YaoJiKuCunGuanLiController==Method:deleteYaoJiKuCunById=="+e);
			return ERROR;
		}

		return SUCCESS;
	}
	@RequestMapping("lookUI")
	public String lookUI(Model model){
		String id = getPara("id");
		//获取设备基本信息
		DaXingSheBeiFormMap daXingSheBeiFormMap = daXingSheBeiService.findDaXingSheBeiById(Integer.parseInt(id));
		daXingSheBeiFormMap.set("leUsedDate", DateUtils.dateFormatToShort(daXingSheBeiFormMap.getDate("leUsedDate")));
		model.addAttribute("daXingSheBeiFormMap", daXingSheBeiFormMap);
		//获取设备附件信息
		String leSon = daXingSheBeiFormMap.getStr("leSon");
		if(leSon!=null && leSon.length()>0){
			String[] idsStr = leSon.split(",");
			List<Integer> ids = new ArrayList<Integer>();
			for(String idStr:idsStr){
				ids.add(Integer.parseInt(idStr));
			}
			List<DaXingSheBeiFuJianFormMap> daXingSheBeiFuJianList =daXingSheBeiFuJianService.findByleId(ids);
			model.addAttribute("daXingSheBeiFuJianList",daXingSheBeiFuJianList );
		}
		//获取设备维修信息
		
		DaXingSheBeiWeiXiuFormMap daXingSheBeiWeiXiuFormMap = new DaXingSheBeiWeiXiuFormMap();
		daXingSheBeiWeiXiuFormMap.set("leId", id);
		try {
			FormMapUtil.toADDFormMap(daXingSheBeiWeiXiuFormMap);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiKuCunController===Method:toADDFormMap==="+e);
		}
		
		model.addAttribute("daXingSheBeiWeiXiuList", daXingSheBeiWeiXiuService.findByAttr(daXingSheBeiWeiXiuFormMap));
		return Common.BACKGROUND_PATH+"/yewuguanlixitong/shebeiguanli/daxingshebei/kucunguanlilook";
	}
	
	@RequestMapping("createPDFReport")
	public void createPDFReport(HttpServletRequest request,HttpServletResponse response){
		DaXingSheBeiFormMap daXingSheBeiFormMap = getFormMap(DaXingSheBeiFormMap.class);
		daXingSheBeiFormMap.set("id", Integer.parseInt(daXingSheBeiFormMap.getStr("id")));
		JasperHelper.export("pdf", "设备信息", "equimentdetail.jasper", daXingSheBeiFormMap, dataSource, request, response);
	}
	@RequestMapping("createExcelReport")
	public void createExcelReport(HttpServletRequest request,HttpServletResponse response){
		DaXingSheBeiFormMap daXingSheBeiFormMap = getFormMap(DaXingSheBeiFormMap.class);
		daXingSheBeiFormMap.set("id", Integer.parseInt(daXingSheBeiFormMap.getStr("id")));
		JasperHelper.export("excel", "设备信息", "equimentdetail.jasper",daXingSheBeiFormMap,dataSource, request, response);
	}
	@RequestMapping("createWordReport")
	public void createWordReport(HttpServletRequest request,HttpServletResponse response){
		DaXingSheBeiFormMap daXingSheBeiFormMap = getFormMap(DaXingSheBeiFormMap.class);
		daXingSheBeiFormMap.set("id", Integer.parseInt(daXingSheBeiFormMap.getStr("id")));
		JasperHelper.export("word", "设备信息", "equimentdetail.jasper", daXingSheBeiFormMap,dataSource, request, response);
	}
	
	
	
	/**
	 * 查找设备名--去除重复
	 * @return
	 */
	@RequestMapping("findAllName")
	@ResponseBody
	public List<DaXingSheBeiFormMap> getAllSheBeiName(){	
		return daXingSheBeiService.findAllName();
	}
	/**
	 * 根据设备名查找编号
	 * @return
	 */
	@RequestMapping("findIdByName")
	@ResponseBody
	public List<DaXingSheBeiFormMap> getIdByName(){	
		DaXingSheBeiFormMap daXingSheBeiFormMap = new DaXingSheBeiFormMap();
		daXingSheBeiFormMap.set("leName", getPara("leName"));
		return daXingSheBeiService.findByAttr(daXingSheBeiFormMap);
	}
	
	
	/**
	 * 清除未处理的附件
	 */
	private void clearFuJian(){
		Session session = SecurityUtils.getSubject().getSession();
		try {
			daXingSheBeiFuJianService.clearNotUsedData((Integer)session.getAttribute("userSessionId"));
		} catch (InvalidSessionException e) {
			log.error("===Class:DaXingSheBeiKuCunController==Method:(Integer)session.getAttribute=="+e);
		} catch (Exception e) {
			log.error("===Class:DaXingSheBeiKuCunController==Method:clearNotUsedData=="+e);
		}
	}
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String leNo = formMap.getStr("leNo");
		String leName = formMap.getStr("leName");
		String leStandard = formMap.getStr("leStandard");
		String leWorth = formMap.getStr("leWorth");
		String leMotorsNumber = formMap.getStr("leMotorsNumber");
		String lePower = formMap.getStr("lePower");
		String leTelephone = formMap.getStr("leTelephone");
		String leZipCode = formMap.getStr("leZipCode");
		String leLocation = formMap.getStr("leLocation");
		String leManufacturingUnit = formMap.getStr("leManufacturingUnit");
		String leManufacturingAddress = formMap.getStr("leManufacturingAddress");
		String leWLNo = formMap.getStr("leWLNo");
		String leType = formMap.getStr("leType");
		String leUnit = formMap.getStr("leUnit");
		
		if(ValidateUtil.isEmpty(leNo) || !ValidateUtil.isLength(leNo,Constant.INT_32)){
			return false;
		}
		if(ValidateUtil.isEmpty(leName) || !ValidateUtil.isLength(leName,Constant.INT_64)){
			return false;
		}
		if(!ValidateUtil.isLength(leStandard,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isFloat(leWorth)){
			return false;
		}
		if(!ValidateUtil.isInt(leMotorsNumber)){
			return false;
		}
		if(!ValidateUtil.isFloat(lePower)){
			return false;
		}
		if(!ValidateUtil.isLength(leTelephone,Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(leZipCode,Constant.INT_6)){
			return false;
		}
		if(!ValidateUtil.isLength(leLocation,Constant.INT_32)){
			return false;
		}
		if(!ValidateUtil.isLength(leManufacturingUnit,Constant.INT_128)){
			return false;
		}
		if(!ValidateUtil.isLength(leManufacturingAddress,Constant.INT_128)){
			return false;
		}
		if(ValidateUtil.isEmpty(leWLNo) || !ValidateUtil.isInt(leWLNo)){
			return false;
		}
		if(ValidateUtil.isEmpty(leType) || !ValidateUtil.isInt(leType)){
			return false;
		}
		if(ValidateUtil.isEmpty(leUnit) || !ValidateUtil.isInt(leUnit)){
			return false;
		}
		return true;
	}
	
}
