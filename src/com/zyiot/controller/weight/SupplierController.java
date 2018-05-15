package com.zyiot.controller.weight;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.SupplierFormMap;
import com.zyiot.server.weight.SupplierServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.ValidateUtil;
/**
 * 供应商
 * @author Lip
 * @date 2017年4月20日 下午3:28:40
 */
@Controller
@RequestMapping("supplier")
public class SupplierController extends BaseController {
	Logger log = Logger.getLogger(SupplierController.class);
	@Autowired
	private SupplierServerI supplierServer;
	@RequestMapping("list")
	public String listUI(){
		return Common.BACKGROUND_PATH +"/weight/supplier/supplierlist";
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<SupplierFormMap> findByPage(int rows,int page){
		SupplierFormMap supplierFormMap = getFormMap(SupplierFormMap.class);
		
		List<SupplierFormMap> list = supplierServer.findByPage(supplierFormMap,rows,page);
		
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save=true)
	public String addUI(){
		return Common.BACKGROUND_PATH +"/weight/supplier/supplieradd";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove = true)
	public String add(){
		SupplierFormMap supplierFormMap = getFormMap(SupplierFormMap.class);
		if(!validData(supplierFormMap)){
			return ERROR;
		}
		
		try {
			FormMapUtil.toADDFormMap(supplierFormMap);
		} catch (Exception e) {
			log.error("===Class:SupplierController==Method:add==Exception:toADDFormMap=="+e);
			return ERROR;
		}
		
		try {
			supplierServer.addSupplier(supplierFormMap);
		} catch (Exception e) {
			log.error("===Class:SupplierController==Method:add==Exception:addSupplier=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("editUI")
	@Token(save=true)
	public String editUI(Model model){
		String id = getPara("id");
		SupplierFormMap supplierFormMap = supplierServer.findSupplierById(Integer.parseInt(id));
		model.addAttribute("supplierFormMap", supplierFormMap);
		return Common.BACKGROUND_PATH +"/weight/supplier/supplieredit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		SupplierFormMap supplierFormMap = getFormMap(SupplierFormMap.class);
		
		if(!validData(supplierFormMap)){
			return ERROR;
		}
		
		try {
			FormMapUtil.toUPDATEFormMap(supplierFormMap);
		} catch (Exception e) {
			log.error("===Class:SupplierController==Method:edit==Exception:toUPDATEFormMap=="+e);
			return ERROR;
		}
		
		try {
			supplierServer.editSupplier(supplierFormMap);
		} catch (Exception e) {
			log.error("===Class:SupplierController==Method:edit==Exception:editSupplier=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		try {
			supplierServer.dropSupplier(id);
		} catch (Exception e) {
			log.error("===Class:SupplierController==Method:delete==Exception:dropSupplier=="+e);
			return ERROR;
		}
		
		return SUCCESS;
	}
	/**
	 * 根据身份证或者电话号码查找供应商
	 * @return
	 */
	@RequestMapping("findSupplierByIDCardOrPhone")
	@ResponseBody
	public List<SupplierFormMap> findSupplierByIDCardOrPhone(){
		String id = getPara("id");
		List<SupplierFormMap> list = supplierServer.findSupplierByIDCardOrPhone(id);
		return list;
	}
	
	private boolean validData(SupplierFormMap supplierFormMap){
		String userName = supplierFormMap.getStr("userName");
		String phoneNumber = supplierFormMap.getStr("phoneNumber");
		
		if(ValidateUtil.isEmpty(userName) || !ValidateUtil.isLength(userName, Constant.INT_16)){
			return false;
		}
		if(!ValidateUtil.isLength(phoneNumber, Constant.INT_16)){
			return false;
		}
		
		return true;
	}
	
}
