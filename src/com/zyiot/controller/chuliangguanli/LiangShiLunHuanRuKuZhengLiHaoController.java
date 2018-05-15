package com.zyiot.controller.chuliangguanli;

import java.sql.Timestamp;
import java.util.List;

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
import com.zyiot.entity.cunchuguanli.LunHuanRuKuZhengLiHaoFormMap;
import com.zyiot.server.cunchuguanli.LunHuanRuKuZhengLiHaoServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;

@Controller
@RequestMapping("liangshilunhuanrukuzhenglihao")
public class LiangShiLunHuanRuKuZhengLiHaoController extends BaseController {
	
	Logger log = Logger.getLogger(LiangShiLunHuanRuKuZhengLiHaoController.class);
	
	@Autowired
	private LunHuanRuKuZhengLiHaoServerI lunHuanRuKuZhengLiHaoServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/sunyiguanli/liangshilunhuanrukuzhenglihao";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<LunHuanRuKuZhengLiHaoFormMap> findByPage(int page, int rows) {
		LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap = getFormMap(LunHuanRuKuZhengLiHaoFormMap.class);
		
		List<LunHuanRuKuZhengLiHaoFormMap> list = lunHuanRuKuZhengLiHaoServer.findByPage(lunHuanRuKuZhengLiHaoFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(LunHuanRuKuZhengLiHaoFormMap cf:list){
				if(cf.getDate("pslPutInDate") != null){
					cf.set("pslPutInDate", DateUtils.dateFormatToShort(cf.getDate("pslPutInDate")));
				}
				if(cf.getDate("pslAddDate") != null){
					cf.set("pslAddDate", DateUtils.dateFormatToLong(cf.getDate("pslAddDate")));
				}
			}
		}
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/sunyiguanli/liangshilunhuanrukuzhenglihaoadd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap = getFormMap(LunHuanRuKuZhengLiHaoFormMap.class);
		if(!validData(lunHuanRuKuZhengLiHaoFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toADDFormMap(lunHuanRuKuZhengLiHaoFormMap);
		} catch (Exception e) {
			log.error("===Class:LiangShiLunHuanRuKuZhengLiHaoController==Method:toADDFormMap=="+e);
			return ERROR;
		}

		try {
			Session session = SecurityUtils.getSubject().getSession();
			lunHuanRuKuZhengLiHaoFormMap.set("pslDataOperator", session.getAttribute("userSessionId"));
			lunHuanRuKuZhengLiHaoFormMap.set("pslAddDate", new Timestamp(System.currentTimeMillis()));
			
			lunHuanRuKuZhengLiHaoServer.addLunHuanRuKuZhengLiHao(lunHuanRuKuZhengLiHaoFormMap);
		} catch (Exception e) {
			log.error("===Class:LiangShiLunHuanRuKuZhengLiHaoController==Method:addLunHuanRuKuZhengLiHao=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		try {
			LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap = lunHuanRuKuZhengLiHaoServer.findLunHuanRuKuZhengLiHaoById(Integer.parseInt(getPara("id")));
			if(lunHuanRuKuZhengLiHaoFormMap.getDate("pslPutInDate") != null){
				lunHuanRuKuZhengLiHaoFormMap.set("pslPutInDate", DateUtils.dateFormatToShort(lunHuanRuKuZhengLiHaoFormMap.getDate("pslPutInDate")));				
			}
			model.addAttribute("lunHuanRuKuZhengLiHaoFormMap", lunHuanRuKuZhengLiHaoFormMap);
		} catch (NumberFormatException e) {
			log.error("===Class:LiangShiLunHuanRuKuZhengLiHaoController==Method:Integer.parseInt=="+e);
		} catch (Exception e) {
			log.error("===Class:LiangShiLunHuanRuKuZhengLiHaoController==Method:findLunHuanRuKuZhengLiHaoById=="+e);
		}
		
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/sunyiguanli/liangshilunhuanrukuzhenglihaoedit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap = getFormMap(LunHuanRuKuZhengLiHaoFormMap.class);
		if(!validData(lunHuanRuKuZhengLiHaoFormMap)){
			return ERROR;
		}
		try {
			FormMapUtil.toUPDATEFormMap(lunHuanRuKuZhengLiHaoFormMap);
		} catch (Exception e) {
			log.error("===Class:LiangShiLunHuanRuKuZhengLiHaoController==Method:toUPDATEFormMap=="+e);
			return ERROR;
		}

		try {
			lunHuanRuKuZhengLiHaoServer.editLunHuanRuKuZhengLiHao(lunHuanRuKuZhengLiHaoFormMap);
		} catch (Exception e) {
			log.error("===Class:LiangShiLunHuanRuKuZhengLiHaoController==Method:editLunHuanRuKuZhengLiHao=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		try {
			lunHuanRuKuZhengLiHaoServer.dropLunHuanRuKuZhengLiHao(getPara("id"));
		} catch (Exception e) {
			log.error("===Class:LiangShiLunHuanRuKuZhengLiHaoController==Method:dropLunHuanRuKuZhengLiHao=="+e);
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
	public LunHuanRuKuZhengLiHaoFormMap findDetail(){
		String wId = getPara("id");
		LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap = lunHuanRuKuZhengLiHaoServer.findCheckDetailById(Integer.parseInt(wId));
		return lunHuanRuKuZhengLiHaoFormMap;
	}
	
	/**
	 * 数据验证，确保数据符合要求
	 * @param formMap  要验证的数据
	 * @return true:通过，false:不通过
	 */
	private Boolean validData(FormMap<String, Object> formMap){
		String pslWId = formMap.getStr("pslWId");
		String pslCategory = formMap.getStr("pslCategory");
		
		if(ValidateUtil.isEmpty(pslWId) || !ValidateUtil.isInt(pslWId)){
			return false;
		}
		if(ValidateUtil.isEmpty(pslCategory) || !ValidateUtil.isLength(pslCategory,Constant.INT_32)){
			return false;
		}
		
		return true;
	}
}
