package com.zyiot.controller.weight;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.DeliverGoodsDetailFormMap;
import com.zyiot.server.weight.DeliverGoodsDetailServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FileManager;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
@Controller
@RequestMapping("deliverGoodsDetail")
public class DeliverGoodsDetailController extends BaseController {
	Logger logger = Logger.getLogger(DeliverGoodsDetailController.class);
	@Autowired
	private DeliverGoodsDetailServerI deliverGoodsDetailServer;
	
	@RequestMapping("list")
	public String listUI(){
		return Constant.BACKGROUND_PATH+"/weight/delivergoodsdetail/list";
	}
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<DeliverGoodsDetailFormMap> findByPage(int rows,int page){
		DeliverGoodsDetailFormMap deliverGoodsDetailFormMap = getFormMap(DeliverGoodsDetailFormMap.class);
		
		List<DeliverGoodsDetailFormMap> list = deliverGoodsDetailServer.findByPage(deliverGoodsDetailFormMap, page, rows);
		
		return toMyPage(list);
	}
	@RequestMapping("addUI")
	@Token(save = true)
	public String addUI(){
		return Constant.BACKGROUND_PATH+"/weight/delivergoodsdetail/add";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove = true)
	public String add(){
		DeliverGoodsDetailFormMap deliverGoodsDetailFormMap = getFormMap(DeliverGoodsDetailFormMap.class);
		Session session = SecurityUtils.getSubject().getSession();
		deliverGoodsDetailFormMap.set("addUser", session.getAttribute("userSessionId"));
		try {
			FormMapUtil.toADDFormMap(deliverGoodsDetailFormMap);
			deliverGoodsDetailServer.addDeliverGoodsDetail(deliverGoodsDetailFormMap);
			return SUCCESS;
		} catch (Exception e) {
			logger.error("===Class:DeliverGoodsDetailController===Method:add===Exception:addDeliverGoodsDetail=="+e);
			return ERROR;
		}
	}
	@RequestMapping("editUI")
	@Token(save = true)
	public String editUI(Model model){
		String id = getPara("id");
		DeliverGoodsDetailFormMap deliverGoodsDetailFormMap = deliverGoodsDetailServer.findById(Integer.parseInt(id));
		model.addAttribute("deliverGoodsDetailFormMap", deliverGoodsDetailFormMap);
		return Constant.BACKGROUND_PATH+"/weight/delivergoodsdetail/edit";
	}
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove = true)
	public String edit(){
		DeliverGoodsDetailFormMap deliverGoodsDetailFormMap = getFormMap(DeliverGoodsDetailFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(deliverGoodsDetailFormMap);
			deliverGoodsDetailServer.editDeliverGoodsDetail(deliverGoodsDetailFormMap);
			return SUCCESS;
		} catch (Exception e) {
			logger.error("===Class:DeliverGoodsDetailController===Method:edit===Exception:editDeliverGoodsDetail=="+e);
			return ERROR;
		}
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		try {
			deliverGoodsDetailServer.dropDeliverGoodsDetail(id);
			return SUCCESS;
		} catch (Exception e) {
			logger.error("===Class:DeliverGoodsDetailController===Method:delete===Exception:dropDeliverGoodsDetail=="+e);
			return ERROR;
		}
	}
	@RequestMapping("findById")
	@ResponseBody
	public DeliverGoodsDetailFormMap findById(){
		String id = getPara("id");
		DeliverGoodsDetailFormMap deliverGoodsDetailFormMap = deliverGoodsDetailServer.findById(Integer.parseInt(id));
		return deliverGoodsDetailFormMap;
	}
	//文件上传页面
	@RequestMapping("uploadFilesUI")
	public String uploadFilesUI(){
		return Constant.BACKGROUND_PATH+"/weight/delivergoodsdetail/upload";
	}
	@RequestMapping("uploadFile")
	@ResponseBody
	public String uploadCodeItem(
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, String dataid) {
		try {
			
			String savePath = request.getServletContext().getRealPath("/upload/files/deliverGoodsDetail");
			
			//获取扩展名
			String oFileName = file.getOriginalFilename();
			String ext = oFileName.substring(oFileName.lastIndexOf("."));
			String fileName = UUID.randomUUID().toString().replace("-", "");
			fileName+=ext;
			// 上传文件
			FileManager.upFile(file, savePath,fileName);
			// 更新表数据
			DeliverGoodsDetailFormMap deliverGoodsDetailFormMap = getFormMap(DeliverGoodsDetailFormMap.class);
			deliverGoodsDetailFormMap.put("id", dataid);
			deliverGoodsDetailFormMap.put("imagePath", fileName);
			FormMapUtil.toUPDATEFormMap(deliverGoodsDetailFormMap);
			deliverGoodsDetailServer.uploadFile(deliverGoodsDetailFormMap);
		} catch (Exception e) {
			logger.error("===Class:DeliverGoodsDetailController===Method:uploadCodeItem===Exception:uploadFile=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("download")
	@ResponseBody
	public void download(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String fileName = getPara("id");
			String path = request.getServletContext().getRealPath("/upload/files/deliverGoodsDetail");
			
			File file = new File(path + "\\" + fileName);

			String lastName = new String(fileName.getBytes("utf-8"),
					"ISO-8859-1");
			// IE
			if (request.getHeader("User-Agent").toUpperCase()
					.indexOf("TRIDENT") > 0) {
				lastName = URLEncoder.encode(fileName, "UTF-8");
			}
			OutputStream os = response.getOutputStream();
			response.reset();
			response.setHeader("Content-Disposition", "attachment; filename="
					+ lastName);
			response.setContentType("application/octet-stream; charset=utf-8");
			os.write(FileUtils.readFileToByteArray(file));
			os.flush();

		} catch (Exception e) {
			logger.error("===Class:DeliverGoodsDetailController===Method:download===Exception:download=="+e);
		}

	}
}
