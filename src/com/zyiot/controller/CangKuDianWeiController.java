package com.zyiot.controller;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.annotation.Token;
import com.zyiot.entity.CangKuDianWeiFormMap;
import com.zyiot.server.CangKuDianWeiServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.MyPage;
import com.zyiot.util.SensorUtil;

@Controller
@RequestMapping("cangkudianwei")
public class CangKuDianWeiController extends BaseController {
	@Autowired
	CangKuDianWeiServerI cangKuDianWeiServer;

	@RequestMapping("listUI")
	public String listUI() {

		return Common.BACKGROUND_PATH + "/system/cangkudianwei/list";
	}

	@RequestMapping("addUI")
	@Token(save = true)
	public String addUI() {

		return Common.BACKGROUND_PATH + "/system/cangkudianwei/add";
	}

	@RequestMapping("editUI")
	@Token(save = true)
	public String editUI(Model model) {

		model.addAttribute("cangKuDianWeiFormMap",
				cangKuDianWeiServer.findById(getPara("id")));

		return Common.BACKGROUND_PATH + "/system/cangkudianwei/edit";
	}

	@RequestMapping("edit")
	@Token(remove = true)
	@ResponseBody
	public String edit() {
		CangKuDianWeiFormMap cangKuDianWeiFormMap = getFormMap2Edit(CangKuDianWeiFormMap.class);
		try {
			FormMapUtil.toUPDATEFormMap(cangKuDianWeiFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		try {
			cangKuDianWeiServer.editCangKuDianWei(cangKuDianWeiFormMap);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("deleteOne")
	@ResponseBody
	public String deleteOne() {

		try {
			cangKuDianWeiServer.deleteOne(getPara("id"));
		} catch (Exception e) {
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("add")
	@Token(remove = true)
	@ResponseBody
	public String add() {
		CangKuDianWeiFormMap cangKuDianWeiFormMap = getFormMap(CangKuDianWeiFormMap.class);
		try {
			FormMapUtil.toADDFormMap(cangKuDianWeiFormMap);
		} catch (Exception e) {
			return ERROR;
		}
		try {
			cangKuDianWeiServer.addCangKuDianWei(cangKuDianWeiFormMap);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

		return SUCCESS;
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<CangKuDianWeiFormMap> findByPage(int page, int rows) {
		CangKuDianWeiFormMap cangKuDianWeiFormMap = getFormMap(CangKuDianWeiFormMap.class);
		List<CangKuDianWeiFormMap> cs = cangKuDianWeiServer.findDianWeiByPage(
				cangKuDianWeiFormMap, rows, page);
		return toMyPage(cs);
	}

	@RequestMapping("findByLocation")
	@ResponseBody
	public List<CangKuDianWeiFormMap> findByLocation() {
		CangKuDianWeiFormMap cangKuDianWeiFormMap = getFormMap(CangKuDianWeiFormMap.class);
		cangKuDianWeiFormMap.put("location_id", getPara("location_id"));
		cangKuDianWeiFormMap.put("lx", getPara("lx"));
		List<CangKuDianWeiFormMap> cs = cangKuDianWeiServer
				.findDianWeiByAttr(cangKuDianWeiFormMap);
		return cs;
	}

	@RequestMapping("getSensorData")
	@ResponseBody
	public List<CangKuDianWeiFormMap> getSensorData() {
		//String[] ips = getPara("ips").split(",");
		//String[] ports = getPara("ports").split(",");
		//String[] zls = getPara("zls").split(",");
		String dwId = getPara("dwId");
		List<CangKuDianWeiFormMap> l = new ArrayList<CangKuDianWeiFormMap>();
		l = cangKuDianWeiServer.findDataById(dwId);
//		for (int i = 0; i < ips.length; i++) {
//			CangKuDianWeiFormMap ck = new CangKuDianWeiFormMap();
//			try {
//				ck.put("data", SensorUtil.getData(ips[i], ports[i], zls[i]));
//				Thread.sleep(500);
//				l.add(ck);
//			} catch (UnknownHostException e) {
//				ck.put("data", "主机不明");
//				l.add(ck);
//			} catch (IOException e) {
//				ck.put("data", "请检查传感器网络环境");
//				l.add(ck);
//			} catch (Exception e) {
//				ck.put("data", "数据异常");
//				l.add(ck);
//			}
//
//		}
		return l;
	}

	private void toGet(List<CangKuDianWeiFormMap> l, String[] ips,
			String ports[], String zls[], int index) {
		CangKuDianWeiFormMap ck = new CangKuDianWeiFormMap();
		try {
			ck.put("data",
					SensorUtil.getData(ips[index], ports[index], zls[index]));
			l.add(ck);
		} catch (UnknownHostException e) {
			ck.put("data", "主机不明");
			l.add(ck);
		} catch (IOException e) {
			ck.put("data", "请检查传感器网络环境");
			l.add(ck);
		} catch (Exception e) {
			ck.put("data", "数据异常");
			l.add(ck);
		}

	}

}
