package com.zyiot.controller.chuliangguanli;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.cunchuguanli.ChuKuShenPiFormMap;
import com.zyiot.server.cunchuguanli.ChuKuShenPiServerI;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("shenpijilu")
public class ShenPiJiLuController extends BaseController {
	@Autowired
	private ChuKuShenPiServerI chuKuShenPiServer;
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/churukuguanli/chukushenqingyushenpi/shenpijilu";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<ChuKuShenPiFormMap> findByPage(int page, int rows) {
		ChuKuShenPiFormMap chuKuShenPiFormMap =  getFormMap(ChuKuShenPiFormMap.class);
		List<ChuKuShenPiFormMap> list = chuKuShenPiServer.findByPage(chuKuShenPiFormMap, page, rows);
		if(list!=null && list.size()>0){
			for(ChuKuShenPiFormMap cf:list){
				cf.set("gsaAuditingDate", DateUtils.dateFormatToLong(cf.getDate("gsaAuditingDate")));
			}
		}
		return toMyPage(list);
	}
}
