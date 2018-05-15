package com.zyiot.controller.chuliangguanli;

import java.sql.Timestamp;
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
import com.zyiot.entity.cunchuguanli.LunHuanChuKuBaoGuanHaoFormMap;
import com.zyiot.server.cunchuguanli.LunHuanChuKuBaoGuanHaoServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
/**
 * 出库保管耗
 * @author Admin
 * @date 2018年1月8日 下午4:48:18
 */
@Controller
@RequestMapping("liangshilunhuanchukubaoguanhao")
public class LiangShiLunHuanChuKuBaoGuanHaoController extends BaseController {
	Logger log = Logger.getLogger(LiangShiLunHuanChuKuBaoGuanHaoController.class);
	
	@Autowired
	private LunHuanChuKuBaoGuanHaoServerI lunHuanChuKuBaoGuanHaoServer;
	@Autowired
	private DataSource dataSource;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/sunyiguanli/liangshilunhuanchukubaoguanhao";
	}
	
	@RequestMapping("show")
	public String show(Model model) {
		model.addAttribute("pId", getPara("pId"));
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/sunyiguanli/liangshilunhuanchukubaoguanhaoshow";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<LunHuanChuKuBaoGuanHaoFormMap> findByPage(int page, int rows) {
		LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap = getFormMap(LunHuanChuKuBaoGuanHaoFormMap.class);
		List<LunHuanChuKuBaoGuanHaoFormMap> list = lunHuanChuKuBaoGuanHaoServer.findByPage(lunHuanChuKuBaoGuanHaoFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(LunHuanChuKuBaoGuanHaoFormMap cf:list){
				cf.set("gslPutInDate", DateUtils.dateFormatToShort(cf.getDate("gslPutInDate")));
				cf.set("gslGetOutDate", DateUtils.dateFormatToShort(cf.getDate("gslGetOutDate")));
				cf.set("gslAddDate", DateUtils.dateFormatToLong(cf.getDate("gslAddDate")));
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/sunyiguanli/liangshilunhuanchukubaoguanhaoadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		
		LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap = getFormMap(LunHuanChuKuBaoGuanHaoFormMap.class);
		if(!validData(lunHuanChuKuBaoGuanHaoFormMap)){
			return ERROR;
		}
		String outDate = lunHuanChuKuBaoGuanHaoFormMap.getStr("gslGetOutDate");
		if(Common.isEmpty(outDate)){
			return ERROR;
		}
		
		try {
			FormMapUtil.toADDFormMap(lunHuanChuKuBaoGuanHaoFormMap);
		} catch (Exception e) {
			log.error("==Class:LiangShiLunHuanChuKuBaoGuanHaoController==Method:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			Session session = SecurityUtils.getSubject().getSession();
			lunHuanChuKuBaoGuanHaoFormMap.set("gslDataOperator", session.getAttribute("userSessionId"));
			lunHuanChuKuBaoGuanHaoFormMap.set("gslAddDate", new Timestamp(System.currentTimeMillis()));
			
			lunHuanChuKuBaoGuanHaoServer.addLunHuanChuKuBaoGuanHao(lunHuanChuKuBaoGuanHaoFormMap);
		} catch (Exception e) {
			log.error("==Class:LiangShiLunHuanChuKuBaoGuanHaoController==Method:addLunHuanChuKuBaoGuanHao=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		try {
			LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap = lunHuanChuKuBaoGuanHaoServer.findLunHuanChuKuBaoGuanHaoById(Integer.parseInt(getPara("id")));
			lunHuanChuKuBaoGuanHaoFormMap.set("gslPutInDate", DateUtils.dateFormatToShort(lunHuanChuKuBaoGuanHaoFormMap.getDate("gslPutInDate")));
			lunHuanChuKuBaoGuanHaoFormMap.set("gslGetOutDate", DateUtils.dateFormatToShort(lunHuanChuKuBaoGuanHaoFormMap.getDate("gslGetOutDate")));
			model.addAttribute("lunHuanChuKuBaoGuanHaoFormMap", lunHuanChuKuBaoGuanHaoFormMap);
			
		} catch (NumberFormatException e) {
			log.error("==Class:LiangShiLunHuanChuKuBaoGuanHaoController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("==Class:LiangShiLunHuanChuKuBaoGuanHaoController==Method:findLunHuanChuKuBaoGuanHaoById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/sunyiguanli/liangshilunhuanchukubaoguanhaoedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap = getFormMap(LunHuanChuKuBaoGuanHaoFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(lunHuanChuKuBaoGuanHaoFormMap);
		} catch (Exception e) {
			log.error("==Class:LiangShiLunHuanChuKuBaoGuanHaoController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			lunHuanChuKuBaoGuanHaoServer.editLunHuanChuKuBaoGuanHao(lunHuanChuKuBaoGuanHaoFormMap);
		} catch (Exception e) {
			log.error("==Class:LiangShiLunHuanChuKuBaoGuanHaoController==Method:editLunHuanChuKuBaoGuanHao=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		
		try {
			lunHuanChuKuBaoGuanHaoServer.dropLunHuanChuKuBaoGuanHao(getPara("id"));
		} catch (Exception e) {
			log.error("==Class:LiangShiLunHuanChuKuBaoGuanHaoController==Method:dropLunHuanChuKuBaoGuanHao=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	/**
	 * 查询库存第一次质检信息
	 * @return
	 */
	@RequestMapping("findCheckDetail")
	@ResponseBody
	public LunHuanChuKuBaoGuanHaoFormMap findDetail(){
		String wId = getPara("id");
		LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap = lunHuanChuKuBaoGuanHaoServer.findCheckDetailById(Integer.parseInt(wId));
		return lunHuanChuKuBaoGuanHaoFormMap;
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
			JasperHelper.export(showType, "粮油保管损耗凭证", "getoutStorageLossHtml.jasper", param, dataSource, request, response);
		}else{
			JasperHelper.export(showType, "粮油保管损耗凭证", "getoutStorageLoss.jasper", param, dataSource, request, response);
		}
	}
	
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String gslWId = formMap.getStr("gslWId");
		String gslCategory = formMap.getStr("gslCategory");
		if(ValidateUtil.isEmpty(gslWId) || !ValidateUtil.isInt(gslWId)){
			return false;
		}
		if(ValidateUtil.isEmpty(gslCategory) || !ValidateUtil.isLength(gslCategory,Constant.INT_32)){
			return false;
		}
		return true;
	}
}
