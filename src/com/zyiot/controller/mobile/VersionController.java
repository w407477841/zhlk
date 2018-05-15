package com.zyiot.controller.mobile;

import java.io.File;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.mobile.VersionFormMap;
import com.zyiot.server.mobile.VersionServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FileManager;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.PropertiesUtils;
/**
 * 移动端--版本控制
 * @author Admin
 * @date 2017年11月7日 下午1:49:12
 */
@Controller
@RequestMapping("version")
public class VersionController extends BaseController {
	Logger log = Logger.getLogger(VersionController.class);
	@Autowired
	private VersionServerI versionServer;
	
	@RequestMapping("list")
	public String listUI(){
		return Constant.BACKGROUND_PATH+"/mobile/version/list";
	}
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<VersionFormMap> findByPage(int page, int rows) {
		VersionFormMap versionFormMap =getFormMap(VersionFormMap.class);
		List<VersionFormMap> list = versionServer.findByPage(versionFormMap, page, rows);
		return toMyPage(list);
	}
	
	@RequestMapping("addUI")
	@Token(save = true)
	public String addUI(){
		return Constant.BACKGROUND_PATH+"/mobile/version/add";
	}
	@RequestMapping("editUI")
	@Token(save = true)
	public String editUI(Model model){
		String id = getPara("id");
		VersionFormMap versionMap = versionServer.findById(Integer.parseInt(id));
		model.addAttribute("versionFormMap", versionMap);
		return Constant.BACKGROUND_PATH+"/mobile/version/edit";
	}
	
	@RequestMapping("uploadFormFiles")
	@Token(save = true)
	public String uploadFormFiles(){
		return Constant.BACKGROUND_PATH+"/mobile/version/upload";
	}
	@RequestMapping("code")
	public String code(Model model){
		HttpServletRequest request = getHttpServletRequest();
		Properties properties = PropertiesUtils.getPropertyByName("webservice.properties");
		String ip = properties.getProperty("code_ip");
		String port = properties.getProperty("code_port");
		String scheme = request.getScheme();
		String path = scheme+"://"+ip+":"+port;
		model.addAttribute("url", path);
		return Constant.BACKGROUND_PATH+"/mobile/version/code";
	}
	@RequestMapping("download")
	public String download(Model model){
		VersionFormMap versionMap = versionServer.findLast("Android");
		model.addAttribute("versionFormMap", versionMap);
		return Constant.BACKGROUND_PATH+"/mobile/version/download";
	}
	@RequestMapping("add")
	@ResponseBody
	@Token(remove=true)
	public String add(){
		VersionFormMap versionFormMap =getFormMap(VersionFormMap.class);
		
		try {
			FormMapUtil.toADDFormMap(versionFormMap);
		} catch (Exception e) {
			log.error("===Class:VersionController===Method:add===Exception:toADDFormMap===");
			return ERROR;
		}
		
		try {
			versionFormMap.set("cre_time", DateUtils.dateFormatToLong(new Date()));
			versionFormMap.set("file_name", null);
			versionFormMap.set("download_num", 0);
			versionServer.addVersionMap(versionFormMap);
		} catch (Exception e) {
			log.error("===Class:VersionController===Method:add===Exception:addVersionMap===");
			return ERROR;
		}
		return SUCCESS;
	}
	
	@RequestMapping("edit")
	@ResponseBody
	@Token(remove=true)
	public String edit(){
		VersionFormMap versionFormMap =getFormMap(VersionFormMap.class);
		
		try {
			FormMapUtil.toUPDATEFormMap(versionFormMap);
		} catch (Exception e) {
			log.error("===Class:VersionController===Method:edit===Exception:toUPDATEFormMap===");
			return ERROR;
		}
		
		try {
			versionServer.editVersionMap(versionFormMap);
		} catch (Exception e) {
			log.error("===Class:VersionController===Method:edit===Exception:editVersionMap===");
			return ERROR;
		}
		return SUCCESS;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(){
		String id = getPara("id");
		try {
			versionServer.dropVersionMap(id);
		} catch (Exception e) {
			log.error("===Class:VersionController===Method:delete===Exception:dropVersionMap===");
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	@RequestMapping("android")
	@ResponseBody
	public void download(HttpServletRequest request,HttpServletResponse response) {
		try {
			VersionFormMap versionMap = versionServer.findLast("Android");
			String fileName = versionMap.getStr("file_name");
			String savePath = request.getServletContext().getRealPath("/upload/android");
			
			File file = new File(savePath + "\\" + fileName);
				
			String lastName;
			String ext = fileName.substring(fileName.lastIndexOf("."));
			lastName = "zhlk"+versionMap.getStr("version")+ext;
			
			 OutputStream os = response.getOutputStream();  
			 response.reset();  
			 response.setHeader("Content-Disposition", "attachment; filename="+lastName);  
			 response.setContentType("application/octet-stream; charset=utf-8");  
		     os.write(FileUtils.readFileToByteArray(file));  
		     os.flush();
			
		     versionMap.set("download_num", versionMap.getInt("download_num")+1);
		     FormMapUtil.toUPDATEFormMap(versionMap);
		     versionServer.editVersionMap(versionMap);
		     
		} catch (Exception e) {
			log.error("==Class:VersionController==Method:download==Exception:下载文件=="+e);
		}

	}

	@RequestMapping("uploadFile")
	@ResponseBody
	public String uploadApp(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, String dataid) {
		try {
			
			//获取扩展名
			String oFileName = file.getOriginalFilename();
			String ext = oFileName.substring(oFileName.lastIndexOf("."));
			String fileName = UUID.randomUUID().toString().replace("-", "");
			fileName+=ext;
			String savePath = request.getServletContext().getRealPath("/upload/android");
			if(!ext.equalsIgnoreCase(".apk")){
				savePath = request.getServletContext().getRealPath("/upload/ios");
			}
			// 上传文件
			FileManager.upFile(file, savePath,fileName);
			
			// 更新表数据
			VersionFormMap versionFormMap = new VersionFormMap();
			versionFormMap.set("id", dataid);
			versionFormMap.set("file_name", fileName);
			FormMapUtil.toUPDATEFormMap(versionFormMap);
			versionServer.editVersionMap(versionFormMap);

		} catch (Exception e) {
			log.error("==Class:VersionController==Method:uploadApp==Exception:上传文件=="+e);
			return ERROR;
		}
		return SUCCESS;
	}
}
