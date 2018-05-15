package com.zyiot.controller.chuliangguanli;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.controller.BaseController;
import com.zyiot.entity.cunchuguanli.QualitativeFormMap;
import com.zyiot.server.cunchuguanli.QualitativeServerI;
import com.zyiot.util.Common;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("dingxingguanli")
public class DingXingGuanLiController extends BaseController {

	@Autowired
	QualitativeServerI qualitativeServer;

	/**
	 * 定性列表页面跳转
	 * 
	 */
	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/dingxingguanli";
	}

	/**
	 * 
	 * 定性查询分页
	 */
	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<QualitativeFormMap> findByPage(int page, int rows) {
		QualitativeFormMap map = getFormMap(QualitativeFormMap.class);
		List<QualitativeFormMap> list = qualitativeServer.findByPage(map, rows, page);
		return toMyPage(list);
	}

	/**
	 * 定性添加 页面跳转
	 */
	@Token(save = true)
	@RequestMapping("addUI")
	public String addUI() {
		return Common.BACKGROUND_PATH
				+ "/yewuguanlixitong/cunchuguanli/dingxingguanliadd";
	}

	/**
	 * 
	 * 定性添加
	 */
	@RequestMapping("add")
	@ResponseBody
	@Token(remove = true)
	public String add() {

		QualitativeFormMap q = getFormMap(QualitativeFormMap.class);
		try {
			FormMapUtil.toADDFormMap(q);
		} catch (Exception e) {
			return ERROR;
		}
		try {
			qualitativeServer.addQualitative(q);
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("findCk")
	@ResponseBody
	public List<QualitativeFormMap> findCk() {

		return qualitativeServer.findCk();
	}

}
