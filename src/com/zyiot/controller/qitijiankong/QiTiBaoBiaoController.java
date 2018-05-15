package com.zyiot.controller.qitijiankong;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.ChuanGanQiDataFormMap;
import com.zyiot.server.ChuanGanQiDataServerI;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMap;
import com.zyiot.util.JasperHelper;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("qitibaobiao")
public class QiTiBaoBiaoController extends BaseController {
	@Autowired
	private DataSource dataSource;
	@Autowired
	private ChuanGanQiDataServerI chuanGanQiDataServer;
	@RequestMapping("/listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/qitijiankong/qitibaobiaolist";
	}
	
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ChuanGanQiDataFormMap> findByPage(int page, int rows) {
		ChuanGanQiDataFormMap formMap = getFormMap(ChuanGanQiDataFormMap.class);
		String cjsj = formMap.getStr("cjsj");
		if(!Common.isEmpty(cjsj)){
			formMap.put("cjsj", cjsj.subSequence(0, cjsj.indexOf(" ")));
		}
		List<ChuanGanQiDataFormMap> list = chuanGanQiDataServer.findByPage(formMap, page, rows);
		return toMyPage(list);
	}
	
	
	@RequestMapping("search")
	public void search(HttpServletRequest request,HttpServletResponse response){
		FormMap<String, Object> base = new FormMap<String, Object>();
		base.set("location", request.getParameter("location"));
		base.set("ck", request.getParameter("ck"));
		base.set("cjsj", request.getParameter("cjsj"));
		JasperHelper.export("html", "", "cangneichuanganqi.jasper", base, dataSource, request, response);
	}
	@RequestMapping("pdfExport")
	public void pdfExport(HttpServletRequest request,HttpServletResponse response){
		FormMap<String, Object> base = new FormMap<String, Object>();
		base.set("location", request.getParameter("location"));
		base.set("ck", request.getParameter("ck"));
		base.set("cjsj", request.getParameter("cjsj"));
		JasperHelper.export("pdf", DateUtils.dateToString(new Date()), "cangneichuanganqi.jasper", base, dataSource, request, response);
	}
}
