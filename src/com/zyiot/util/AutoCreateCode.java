package com.zyiot.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class AutoCreateCode {
	// private String name;
	private String formMapFileName;
	private String formMapFileDir;
	private String formMapPackage;
	private String mapperFileName;
	private String mapperFileDir;
	private String mapperPackage;
	private String xmlFileName;
	private String xmlFileDir;
	private String serverIFileName;
	private String serverIFileDir;
	private String serverIPackage;
	private String serverFileName;
	private String serverFileDir;
	private String serverPackage;
	private String controllerFileName;
	private String controllerFileDir;
	private String tableName;
	private String id;
	private String namePre;
	private String lownamePre;
	private String m;
	private String murl;
	private String rootUrl;
	private String columns;

	/**
	 * 
	 * @param tableName
	 *            表名
	 * @param id
	 *            主键名
	 * @param namePre
	 *            名称前缀
	 * @param m
	 *            模块 aa/bb/cc
	 * @param columns
	 *            表字段 a,b,c
	 * 
	 */
	public AutoCreateCode(String tableName, String id, String namePre,
			String m, String columns) {
		super();
		// this.name = name;
		this.tableName = tableName;
		this.id = id;
		this.namePre = namePre;
		this.columns = columns;

		File directory = new File("D://autocreate");// 设定为当前文件夹
		try {
			// System.out.println(directory.getCanonicalPath());// 获取标准的路径
			rootUrl = directory.getAbsolutePath();// 获取绝对路径
		} catch (Exception e) {
		}
		lownamePre = namePre.substring(0, 1).toLowerCase()
				+ namePre.substring(1);
		if (m == null)
			m = "";
		// m 为 aa/bb/cc
		murl = m;
		m = m + (m.equals("") ? "" : ".");
		formMapFileName = (namePre + "FormMap.java");
		formMapFileDir = (rootUrl + "\\src\\com\\zyiot\\entity\\"
				+ murl.replace("/", "\\") + "\\");
		formMapPackage = ("com.zyiot.entity." + m.replace("/", ".") + namePre + "FormMap");
		mapperFileName = (namePre + "Mapper.java");
		mapperFileDir = (rootUrl + "\\src\\com\\zyiot\\mapper\\"
				+ murl.replace("/", "\\") + "\\");
		mapperPackage = ("com.zyiot.mapper." + m.replace("/", ".") + namePre + "Mapper");

		xmlFileName = (lownamePre + "-mapper.xml");
		xmlFileDir = (rootUrl + "\\src\\mappings\\" + murl.replace("/", "\\") + "\\");
		serverIFileName = (namePre + "ServerI.java");
		serverIFileDir = (rootUrl + "\\src\\com\\zyiot\\server\\"
				+ murl.replace("/", "\\") + "\\");
		serverIPackage = ("com.zyiot.server." + m.replace("/", ".") + namePre + "ServerI");
		serverFileName = (namePre + "ServerImpl.java");
		serverFileDir = (rootUrl + "\\src\\com\\zyiot\\server\\impl\\"
				+ murl.replace("/", "\\") + "\\");
		serverPackage = ("com.zyiot.server.impl" + m.replace("/", ".")
				+ namePre + "ServerImpl");
		controllerFileName = (namePre + "Controller.java");
		controllerFileDir = (rootUrl + "\\src\\com\\zyiot\\controller\\"
				+ murl.replace("/", "\\") + "\\");
	}

	private void createJavaFormMap() throws IOException {
		File dir = new File(formMapFileDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(formMapFileDir + formMapFileName);
		if (!file.exists()) {
			file.createNewFile();
		}
		FileOutputStream os = new FileOutputStream(file);
		os.write(("package com.zyiot.entity"
				+ (murl.equals("") ? "" : ("." + murl.replace("/", "."))) + ";\n")
				.getBytes("UTF-8"));
		os.write("import com.zyiot.annotation.TableSeg;\n".getBytes("UTF-8"));
		os.write("import com.zyiot.util.FormMap;\n".getBytes("UTF-8"));
		os.write(("@TableSeg(id = \"" + id + "\", tableName = \"" + tableName + "\")\n")
				.getBytes("UTF-8"));
		os.write(("public class " + namePre + "FormMap extends FormMap<String, Object> {\n")
				.getBytes("UTF-8"));
		os.write("private static final long serialVersionUID = 1L;\n"
				.getBytes("UTF-8"));
		os.write("}".getBytes("UTF-8"));
		os.flush();
		os.close();
	}

	private void createJavaMapper() throws IOException {
		File dir = new File(mapperFileDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(mapperFileDir + mapperFileName);
		if (!file.exists()) {
			file.createNewFile();
		}
		FileOutputStream os = new FileOutputStream(file);

		os.write(("package com.zyiot.mapper"
				+ (murl.equals("") ? "" : ("." + murl.replace("/", "."))) + ";\n")
				.getBytes("UTF-8"));
		os.write("import java.util.List;\n".getBytes("UTF-8"));
		os.write("import com.zyiot.mapper.BaseMapper;\n".getBytes("UTF-8"));
		os.write(("import " + formMapPackage + ";\n").getBytes("UTF-8"));
		os.write(("public interface " + namePre + "Mapper extends BaseMapper {\n")
				.getBytes("UTF-8"));
		os.write(("List<" + namePre + "FormMap> find" + namePre + "ByPage("
				+ namePre + "FormMap FormMap);\n").getBytes("UTF-8"));
		os.write("}".getBytes("UTF-8"));
		os.flush();
		os.close();
	}

	private void createXMLMapper() throws IOException {

		File dir = new File(xmlFileDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(xmlFileDir + xmlFileName);
		if (!file.exists()) {
			file.createNewFile();
		}
		FileOutputStream os = new FileOutputStream(file);

		os.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
				.getBytes("UTF-8"));
		os.write("<!DOCTYPE mapper PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\"\n"
				.getBytes("UTF-8"));
		os.write("\"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">\n"
				.getBytes("UTF-8"));
		os.write(("<mapper namespace=\"" + mapperPackage + "\">\n")
				.getBytes("UTF-8"));
		os.write("<sql id=\"selectId\">\n".getBytes("UTF-8"));
		os.write((columns + "\n").getBytes("UTF-8"));
		os.write("</sql>\n".getBytes("UTF-8"));
		os.write(("<select id=\"find" + namePre + "ByPage\" resultType=\""
				+ formMapPackage + "\">\n").getBytes("UTF-8"));
		os.write(("select <include refid=\"selectId\"></include> from "
				+ tableName + " where 1=1 \n").getBytes("UTF-8"));
		os.write(("<if test=\"" + id + "!=null and " + id + "!=''\"> and " + id
				+ "='${" + id + "}'</if> \n").getBytes("UTF-8"));
		os.write("</select>\n".getBytes("UTF-8"));
		os.write("</mapper>\n".getBytes("UTF-8"));
		os.flush();
		os.close();
	}

	private void createJavaServerI() throws IOException {

		File dir = new File(serverIFileDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(serverIFileDir + serverIFileName);
		if (!file.exists()) {
			file.createNewFile();
		}
		FileOutputStream os = new FileOutputStream(file);
		os.write(("package com.zyiot.server"
				+ (murl.equals("") ? "" : ("." + murl.replace("/", "."))) + ";\n")
				.getBytes("UTF-8"));
		os.write("import java.util.List;\n".getBytes("UTF-8"));
		os.write(("import " + formMapPackage + ";\n").getBytes("UTF-8"));
		os.write(("public interface " + namePre + "ServerI {\n")
				.getBytes("UTF-8"));
		os.write(("public List<" + namePre + "FormMap> find" + namePre
				+ "ByPage(" + namePre + "FormMap u,int pageSize, int pageNum);\n")
				.getBytes("UTF-8"));
		os.write(("public void add(" + namePre + "FormMap u) throws Exception;\n")
				.getBytes("UTF-8"));
		os.write(("public void edit(" + namePre + "FormMap u) throws Exception;\n")
				.getBytes("UTF-8"));
		os.write("public void delete(String id) throws Exception;\n"
				.getBytes("UTF-8"));
		os.write("}\n".getBytes("UTF-8"));
		os.flush();
		os.close();
	}

	private void delete() throws IOException {
		detete(formMapFileDir, formMapFileName);
		detete(mapperFileDir, mapperFileName);
		detete(xmlFileDir, xmlFileName);
		detete(serverIFileDir, serverIFileName);
		detete(serverFileDir, serverFileName);
		detete(controllerFileDir, controllerFileName);
	}

	private void detete(String serverFileDir, String serverFileName)
			throws IOException {
		File file = new File(serverFileDir + serverFileName);
		if (file.exists()) {
			file.delete();
		}
		/*
		 * 最好不好删目录 防止误删 File Dir = new File(serverFileDir); if (Dir.exists()) {
		 * Dir.delete(); }
		 */

	}

	private void createJavaServer() throws IOException {
		File dir = new File(serverFileDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(serverFileDir + serverFileName);
		if (!file.exists()) {
			file.createNewFile();
		}
		FileOutputStream os = new FileOutputStream(file);
		os.write(("package com.zyiot.server.impl"
				+ (murl.equals("") ? "" : ("." + murl.replace("/", "."))) + ";\n")
				.getBytes("UTF-8"));
		os.write(("import java.util.List;\n").getBytes("UTF-8"));
		os.write(("import org.springframework.beans.factory.annotation.Autowired;\n")
				.getBytes("UTF-8"));
		os.write(("import org.springframework.transaction.annotation.Transactional;\n")
				.getBytes("UTF-8"));

		os.write(("import org.springframework.stereotype.Service;\n")
				.getBytes("UTF-8"));
		os.write(("import com.github.pagehelper.PageHelper;\n")
				.getBytes("UTF-8"));

		os.write(("import com.zyiot.annotation.SystemLog;\n").getBytes("UTF-8"));
		os.write(("import " + formMapPackage + ";\n").getBytes("UTF-8"));
		os.write(("import " + mapperPackage + ";\n").getBytes("UTF-8"));
		os.write(("import " + serverIPackage + ";\n").getBytes("UTF-8"));
		os.write(("@Service(\"" + lownamePre + "Server\")\n").getBytes("UTF-8"));
		os.write(("public class " + namePre + "ServerImpl implements "
				+ namePre + "ServerI {\n").getBytes("UTF-8"));
		os.write(("@Autowired\n").getBytes("UTF-8"));
		os.write((namePre + "Mapper " + lownamePre + "Mapper;\n")
				.getBytes("UTF-8"));
		os.write(("public List<" + namePre + "FormMap> find" + namePre
				+ "ByPage(" + namePre + "FormMap u,int pageSize, int pageNum) {\n")
				.getBytes("UTF-8"));
		os.write(("PageHelper.startPage(pageNum, pageSize);\n")
				.getBytes("UTF-8"));
		os.write(("return " + lownamePre + "Mapper.find" + namePre + "ByPage(u);\n")
				.getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));
		os.write(("@SystemLog(module = \"" + murl + "\", methods = \"新增\", description = \"成功\")\n")
				.getBytes("UTF-8"));
		os.write(("@Transactional(readOnly = false)\n").getBytes("UTF-8"));
		os.write(("public void add(" + namePre + "FormMap u) throws Exception {")
				.getBytes("UTF-8"));
		os.write((lownamePre + "Mapper.addEntity(u);\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));

		os.write(("@SystemLog(module = \"" + murl + "\", methods = \"修改\", description = \"成功\")\n")
				.getBytes("UTF-8"));
		os.write(("@Transactional(readOnly = false)\n").getBytes("UTF-8"));
		os.write(("public void edit(" + namePre + "FormMap u) throws Exception {\n")
				.getBytes("UTF-8"));
		os.write((lownamePre + "Mapper.updateEntity(u);\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));

		os.write(("@SystemLog(module = \"" + murl + "\", methods = \"删除\", description = \"成功\")\n")
				.getBytes("UTF-8"));
		os.write(("@Transactional(readOnly = false)\n").getBytes("UTF-8"));
		os.write(("public void delete(String id) throws Exception {\n")
				.getBytes("UTF-8"));
		os.write((lownamePre + "Mapper.deleteEntityByKey(" + id + ", id,"
				+ namePre + "FormMap.class);\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));

		os.write(("}\n").getBytes("UTF-8"));
		os.flush();
		os.close();
	}

	public void createController() throws IOException {
		File dir = new File(controllerFileDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(controllerFileDir + controllerFileName);
		if (!file.exists()) {
			file.createNewFile();
		}
		FileOutputStream os = new FileOutputStream(file);
		os.write(("package com.zyiot.controller"
				+ (murl.equals("") ? "" : ("." + murl.replace("/", "."))) + ";\n")
				.getBytes("UTF-8"));
		os.write("import org.springframework.beans.factory.annotation.Autowired;\n"
				.getBytes("UTF-8"));
		os.write("import org.springframework.stereotype.Controller;\n"
				.getBytes("UTF-8"));
		os.write("import org.apache.log4j.Logger;\n".getBytes("UTF-8"));
		os.write("import java.util.List;\n".getBytes("UTF-8"));
		os.write("import org.springframework.ui.Model;\n".getBytes("UTF-8"));

		os.write("import org.springframework.web.bind.annotation.RequestMapping;\n"
				.getBytes("UTF-8"));
		os.write("import org.springframework.web.bind.annotation.RequestMethod;\n"
				.getBytes("UTF-8"));
		os.write("import org.springframework.web.bind.annotation.ResponseBody;\n"
				.getBytes("UTF-8"));
		os.write(("import " + formMapPackage + ";\n").getBytes("UTF-8"));
		os.write("import com.zyiot.controller.BaseController;\n"
				.getBytes("UTF-8"));
		os.write(("import " + serverIPackage + ";\n").getBytes("UTF-8"));
		os.write("import com.zyiot.util.Common;\n".getBytes("UTF-8"));
		os.write("import com.zyiot.util.MyPage;\n".getBytes("UTF-8"));
		os.write("import com.zyiot.util.FormMapUtil;\n".getBytes("UTF-8"));
		os.write(("@Controller\n").getBytes("UTF-8"));
		os.write(("@RequestMapping(\"" + murl + (murl.equals("") ? "" : "/")
				+ lownamePre + "\")\n").getBytes("UTF-8"));
		os.write(("public class " + namePre + "Controller extends BaseController {\n")
				.getBytes("UTF-8"));
		os.write(("@Autowired\n").getBytes("UTF-8"));
		os.write((namePre + "ServerI " + lownamePre + "Server;\n")
				.getBytes("UTF-8"));
		os.write(("Logger logger = Logger.getLogger(" + namePre + "Controller.class);\n")
				.getBytes("UTF-8"));

		os.write(("@RequestMapping(value = \"listUI\", method = RequestMethod.POST)\n")
				.getBytes("UTF-8"));
		os.write(("public String " + lownamePre + "ListUI() {\n")
				.getBytes("UTF-8"));
		os.write(("return Common.BACKGROUND_PATH + \"/" + murl + "/"
				+ namePre.toLowerCase() + "/list\";\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));
		os.write(("@RequestMapping(value = \"findByPage\")\n")
				.getBytes("UTF-8"));
		os.write(("@ResponseBody\n").getBytes("UTF-8"));
		os.write(("public MyPage findByPage(int page, int rows) {\n")
				.getBytes("UTF-8"));
		os.write((namePre + "FormMap " + lownamePre + "FormMap = getFormMap("
				+ namePre + "FormMap.class);\n").getBytes("UTF-8"));
		os.write(("return toMyPage(" + lownamePre + "Server.find" + namePre
				+ "ByPage(" + lownamePre + "FormMap, rows, page));\n")
				.getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));
		os.write(("@RequestMapping(value = \"addUI\")\n").getBytes("UTF-8"));
		os.write(("public String addUI() {\n").getBytes("UTF-8"));
		os.write(("return Common.BACKGROUND_PATH + \"/" + murl + "/"
				+ namePre.toLowerCase() + "/add\";\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));

		os.write(("@RequestMapping(value = \"editUI\")\n").getBytes("UTF-8"));
		os.write(("public String editUI(Model model) {\n").getBytes("UTF-8"));
		os.write((namePre + "FormMap u = new " + namePre + "FormMap();\n")
				.getBytes("UTF-8"));
		os.write(("u.put(\"" + id + "\", getPara(\"id\"));\n")
				.getBytes("UTF-8"));
		os.write(("List<" + namePre + "FormMap> list = " + lownamePre
				+ "Server.find" + namePre + "ByPage(u, 1, 1);\n")
				.getBytes("UTF-8"));
		os.write(("if (list != null && list.size() > 0) {\n").getBytes("UTF-8"));
		os.write(("model.addAttribute(\"" + lownamePre + "FormMap\", list.get(0));\n")
				.getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));
		os.write(("return Common.BACKGROUND_PATH + \"/" + murl + "/"
				+ namePre.toLowerCase() + "/edit\";\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));

		os.write(("@RequestMapping(value = \"add\")\n").getBytes("UTF-8"));
		os.write(("@ResponseBody\n").getBytes("UTF-8"));
		os.write(("public String add() {\n").getBytes("UTF-8"));
		os.write((namePre + "FormMap " + lownamePre + "FormMap = getFormMap("
				+ namePre + "FormMap.class);\n").getBytes("UTF-8"));
		os.write(("try {\n").getBytes("UTF-8"));
		os.write(("FormMapUtil.toADDFormMap(" + lownamePre + "FormMap);\n")
				.getBytes("UTF-8"));
		os.write((lownamePre + "Server.add(" + lownamePre + "FormMap);\n")
				.getBytes("UTF-8"));
		os.write(("} catch (Exception e) {\n").getBytes("UTF-8"));
		os.write(("logger.error(e.getMessage());\n").getBytes("UTF-8"));
		os.write(("return ERROR;\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));
		os.write(("return SUCCESS;\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));

		os.write(("@RequestMapping(value = \"edit\")\n").getBytes("UTF-8"));
		os.write(("@ResponseBody\n").getBytes("UTF-8"));
		os.write(("public String edit() {\n").getBytes("UTF-8"));
		os.write((namePre + "FormMap " + lownamePre + "FormMap = getFormMap("
				+ namePre + "FormMap.class);\n").getBytes("UTF-8"));
		os.write(("try {\n").getBytes("UTF-8"));
		os.write(("FormMapUtil.toUPDATEFormMap(" + lownamePre + "FormMap);\n")
				.getBytes("UTF-8"));
		os.write((lownamePre + "Server.edit(" + lownamePre + "FormMap);\n")
				.getBytes("UTF-8"));
		os.write(("} catch (Exception e) {\n").getBytes("UTF-8"));
		os.write(("logger.error(e.getMessage());\n").getBytes("UTF-8"));
		os.write(("return ERROR;\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));
		os.write(("return SUCCESS;\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));

		os.write(("@RequestMapping(value = \"deleteOne\")\n").getBytes("UTF-8"));
		os.write(("@ResponseBody\n").getBytes("UTF-8"));
		os.write(("public String deleteOne() {\n").getBytes("UTF-8"));
		os.write(("try {\n").getBytes("UTF-8"));
		os.write((lownamePre + "Server.delete(getPara(\"id\"));\n")
				.getBytes("UTF-8"));
		os.write(("} catch (Exception e) {\n").getBytes("UTF-8"));
		os.write(("logger.error(e.getMessage());\n").getBytes("UTF-8"));
		os.write(("return ERROR;\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));
		os.write(("return SUCCESS;\n").getBytes("UTF-8"));
		os.write(("}\n").getBytes("UTF-8"));

		os.write(("}\n").getBytes("UTF-8"));
		os.flush();
		os.close();
	}

	public static void main(String[] args) {

		AutoCreateCode autoCreateCode = new AutoCreateCode("t_ammeter_data",
				"id", "AmmeterData", "cangkuzhinenghuaxitong",
				"id,reading,isError,type,acquisitionTime,energy,warehouse");
		try {

			autoCreateCode.createJavaFormMap();
			autoCreateCode.createJavaMapper();
			autoCreateCode.createXMLMapper();
			autoCreateCode.createJavaServerI();
			autoCreateCode.createJavaServer();
			autoCreateCode.createController();
			System.out.println("FormMap生成完毕");

			// autoCreateCode.delete();
		} catch (IOException e) {
			System.out.println("FormMap生成失败");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
