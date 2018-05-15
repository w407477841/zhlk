package com.zyiot.controller.weight;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.weight.QualityFormMap;
import com.zyiot.server.weight.QualityServerI;
import com.zyiot.util.MyPage;
/**
 * 质量国标档案
 * @author Lip
 * @date 2017年4月26日 上午11:01:24
 */
@Controller
@RequestMapping("quality")
public class QualityController extends BaseController {
	@Autowired
	private QualityServerI qualityServer;
	
	@RequestMapping("findByVarietyId")
	@ResponseBody
	public MyPage<QualityFormMap> findByVarietyId(){
		String id = getPara("id");
		List<QualityFormMap> list = qualityServer.findByVarietyId(Integer.parseInt(id));
		return toMyPage(list);
	}
	/**
	 * 根据品种获取国标质检信息
	 * @return
	 */
	@RequestMapping("findQualityByVarietyId")
	@ResponseBody
	public List<QualityFormMap> findQualityByVarietyId(){
		String id = getPara("id");
		List<QualityFormMap> list = qualityServer.findQualityByVarietyId(Integer.parseInt(id));
		return list;
	}
	
}
