package com.zyiot.controller.zhiliangguanli;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

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
import com.zyiot.entity.weight.QualityCheckFormMap;
import com.zyiot.entity.zhiliangguanli.QualityManagerFormMap;
import com.zyiot.server.zhiliangguanli.QualityManagerServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
/**
 * 质量管理
 * @author Admin
 * @date 2017年7月5日 上午9:58:38
 */
@Controller
@RequestMapping("qualityManager")
public class QualityManagerController extends BaseController {
	Logger log = Logger.getLogger(QualityManagerController.class);
	
	@Autowired
	private QualityManagerServerI qualityManagerServer;
	@Autowired
	private DataSource dataSource;
	/**
	 * 入库统仓质检列表
	 * @return
	 */
	@RequestMapping("inputList")
	public String inputListUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/inputcheck/list";
	}
	/**
	 * 出库统仓质检列表
	 * @return
	 */
	@RequestMapping("outputList")
	public String outputListUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/outputcheck/list";
	}
	/**
	 * 库存统仓质检列表
	 * @return
	 */
	@RequestMapping("storeList")
	public String storeListUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/storecheck/list";
	}
	/**
	 * 库存统仓质检报表
	 * @return
	 */
	@RequestMapping("show")
	public String show(Model model){
		model.addAttribute("pId", getPara("pId"));
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/storecheck/show";
	}
	/**
	 * 入库统仓质检分页查询
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findInputByPage")
	@ResponseBody
	public MyPage<QualityCheckFormMap> findInputCheckByPage(int page, int rows){
		QualityCheckFormMap qualityCheckFormMap = getFormMap(QualityCheckFormMap.class);
		String beginDate = qualityCheckFormMap.getStr("checkBeginDate");
		String endDate = qualityCheckFormMap.getStr("checkEndDate");
		if( !Common.isEmpty(beginDate) && !Common.isEmpty(endDate)){
			qualityCheckFormMap.set("checkBeginDate", beginDate+" 00:00:00");
			qualityCheckFormMap.set("checkEndDate", endDate+" 23:59:59");
		}
		qualityCheckFormMap.set("inOrOut", "2");
		List<QualityCheckFormMap> list = qualityManagerServer.findByPage(qualityCheckFormMap, rows, page);
		return toMyPage(list);
	}
	/**
	 * 出库统仓质检分页查询
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findOutputByPage")
	@ResponseBody
	public MyPage<QualityCheckFormMap> findOutputCheckByPage(int page, int rows){
		QualityCheckFormMap qualityCheckFormMap = getFormMap(QualityCheckFormMap.class);
		String beginDate = qualityCheckFormMap.getStr("checkBeginDate");
		String endDate = qualityCheckFormMap.getStr("checkEndDate");
		if( !Common.isEmpty(beginDate) && !Common.isEmpty(endDate)){
			qualityCheckFormMap.set("checkBeginDate", beginDate+" 00:00:00");
			qualityCheckFormMap.set("checkEndDate", endDate+" 23:59:59");
		}
		qualityCheckFormMap.set("inOrOut", "1");
		List<QualityCheckFormMap> list = qualityManagerServer.findByPage(qualityCheckFormMap, rows, page);
		return toMyPage(list);
	}
	/**
	 * 库存统仓质检分页查询
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping("findStoreByPage")
	@ResponseBody
	public MyPage<QualityManagerFormMap> findStoreCheckByPage(int page, int rows){
		QualityManagerFormMap qualityManagerFormMap = getFormMap(QualityManagerFormMap.class);
		String beginDate = qualityManagerFormMap.getStr("checkBeginDate");
		String endDate = qualityManagerFormMap.getStr("checkEndDate");
		if( !Common.isEmpty(beginDate) && !Common.isEmpty(endDate)){
			qualityManagerFormMap.set("checkBeginDate", beginDate+" 00:00:00");
			qualityManagerFormMap.set("checkEndDate", endDate+" 23:59:59");
		}
		qualityManagerFormMap.set("qualityType", "3");
		List<QualityManagerFormMap> list = qualityManagerServer.findByPage(qualityManagerFormMap, rows, page);
		for(QualityManagerFormMap qmf:list){
			Date date = qmf.getDate("checkDate");
			if(date!=null){
				qmf.set("checkDate", DateUtils.dateFormatToLong(date));
			}
		}
		return toMyPage(list);
	}
	/**
	 * 入库统仓质检添加页面
	 * @return
	 */
	@RequestMapping("addInputCheckUI")
	@Token(save=true)
	public String addInputCheckUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/inputcheck/add";
	}
	
	/**
	 * 统仓质检添加数据
	 * @return
	 */
	@RequestMapping("addQualityCheck")
	@ResponseBody
	@Token(remove=true)
	public String addQualityCheck(){
		QualityManagerFormMap qualityManagerFormMap = getFormMap(QualityManagerFormMap.class);
		if(!validData(qualityManagerFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(qualityManagerFormMap);
		} catch (Exception e) {
			log.error("===Class:QualityManagerController===Method:addInputCheck==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		Session session = SecurityUtils.getSubject().getSession();
		qualityManagerFormMap.set("dataOperator", session.getAttribute("userSessionId"));
		
		try {
			qualityManagerServer.addQualityManagerFormMap(qualityManagerFormMap);
		} catch (Exception e) {
			log.error("===Class:QualityManagerController===Method:addInputCheck==Exception:addQualityManagerFormMap=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 入库统仓质检修改页面
	 * @param model
	 * @return
	 */
	@RequestMapping("editInputCheckUI")
	@Token(save=true)
	public String editInputCheckUI(Model model){
		String id = getPara("id");
		QualityManagerFormMap qualityManagerFormMap = qualityManagerServer.findQualityManagerById(Integer.parseInt(id));
		model.addAttribute("qualityManagerFormMap", qualityManagerFormMap);
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/inputcheck/edit";
	}
	/**
	 * 统仓质检修改添加
	 * @return
	 */
	@RequestMapping("editQualityCheck")
	@ResponseBody
	@Token(remove=true)
	public String editQualityCheck(){
		QualityManagerFormMap qualityManagerFormMap = getFormMap(QualityManagerFormMap.class);
		if(!validData(qualityManagerFormMap)){
			return ERROR;
		}
		
		try {
			FormMapUtil.toUPDATEFormMap(qualityManagerFormMap);
		} catch (Exception e) {
			log.error("===Class:QualityManagerController===Method:editInputCheck==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		Session session = SecurityUtils.getSubject().getSession();
		qualityManagerFormMap.set("dataOperator", session.getAttribute("userSessionId"));
		
		try {
			qualityManagerServer.editQualityManagerFormMap(qualityManagerFormMap);
		} catch (Exception e) {
			log.error("===Class:QualityManagerController===Method:editInputCheck==Exception:editQualityManagerFormMap=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	/**
	 * 统仓质检删除
	 * @return
	 */
	@RequestMapping("deleteQualityCheck")
	@ResponseBody
	public String deleteQualityCheck(){
		String id = getPara("id");
		try {
			qualityManagerServer.dropQualityManagerFormMap(id);
		} catch (Exception e) {
			log.error("===Class:QualityManagerController===Method:deleteInputCheck==Exception:dropQualityManagerFormMap=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 出库统仓质检添加页面
	 * @return
	 */
	@RequestMapping("addOutputCheckUI")
	@Token(save=true)
	public String addOutputCheckUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/outputcheck/add";
	}
	
	/**
	 * 出库统仓质检修改页面
	 * @param model
	 * @return
	 */
	@RequestMapping("editOutputCheckUI")
	@Token(save=true)
	public String editOutputCheckUI(Model model){
		String id = getPara("id");
		QualityManagerFormMap qualityManagerFormMap = qualityManagerServer.findQualityManagerById(Integer.parseInt(id));
		model.addAttribute("qualityManagerFormMap", qualityManagerFormMap);
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/outputcheck/edit";
	}
	
	/**
	 * 库存统仓质检添加页面
	 * @return
	 */
	@RequestMapping("addStoreCheckUI")
	@Token(save=true)
	public String addStoreCheckUI(){
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/storecheck/add";
	}
	
	/**
	 * 库存统仓质检修改页面
	 * @param model
	 * @return
	 */
	@RequestMapping("editStoreCheckUI")
	@Token(save=true)
	public String editStoreCheckUI(Model model){
		String id = getPara("id");
		QualityManagerFormMap qualityManagerFormMap = qualityManagerServer.findQualityManagerById(Integer.parseInt(id));
		model.addAttribute("qualityManagerFormMap", qualityManagerFormMap);
		return Constant.BACKGROUND_PATH+"/yewuguanlixitong/zhiliangguanli/qualitycheck/storecheck/edit";
	}
	/**
	 * 产生报表
	 * @param request
	 * @param response
	 */
	@RequestMapping("export")
	public void report(HttpServletRequest request,HttpServletResponse response) {
		//参数
		FormMap<String,Object> param = new FormMap<String,Object>();
		//方式
		String pId = request.getParameter("pId");
		param.set("dataId", pId);
		param.set("dateString", DateUtils.dateFormatToShortChinese(new Date()));
		String showType = request.getParameter("showType");
		if(showType.equalsIgnoreCase("html")){
			JasperHelper.export(showType, "粮油保管账", "saveRecordHtml.jasper", param, dataSource, request, response);
		}else{
			JasperHelper.export(showType, "粮油保管账", "saveRecord.jasper", param, dataSource, request, response);
		}
	}
	
	/**
	 * 输入数据校验
	 * @param qualityManagerFormMap
	 * @return
	 */
	public boolean validData(QualityManagerFormMap qualityManagerFormMap){
		String wId = qualityManagerFormMap.getStr("wId");
		String grainVariety = qualityManagerFormMap.getStr("grainVariety");
		String grainProperty = qualityManagerFormMap.getStr("grainProperty");
		
		if(ValidateUtil.isEmpty(wId) || !ValidateUtil.isInt(wId)){
			return false;
		}
		if(ValidateUtil.isEmpty(grainVariety)){
			return false;
		}
		if(ValidateUtil.isEmpty(grainProperty)){
			return false;
		}
		return true;
	}
}
