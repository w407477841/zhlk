package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.CangKuDianWeiFormMap;
import com.zyiot.entity.ChuanGanQiFormMap;
import com.zyiot.mapper.CangKuDianWeiMapper;
import com.zyiot.mapper.ChuanGanQiMapper;
import com.zyiot.server.CangKuDianWeiServerI;
import com.zyiot.util.Constant;

@Service("cangKuDianWeiServer")
public class CangKuDianWeiServerImpl implements CangKuDianWeiServerI {
	@Autowired
	CangKuDianWeiMapper cangKuDianWeiMapper;
	@Autowired
	ChuanGanQiMapper chuanGanQiMapper;

	public List<CangKuDianWeiFormMap> findDianWeiByPage(
			CangKuDianWeiFormMap cangKuDianWeiFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return cangKuDianWeiMapper.findDianWeiByPage(cangKuDianWeiFormMap);
	}

	@SystemLog(module = "系统管理/仓库点位管理", methods = "新增", description = "成功")
	public void addCangKuDianWei(CangKuDianWeiFormMap cangKuDianWeiFormMap)
			throws Exception {
		cangKuDianWeiMapper.addEntity(cangKuDianWeiFormMap);
	}

	@SystemLog(module = "系统管理/仓库点位管理", methods = "修改", description = "成功")
	public void editCangKuDianWei(CangKuDianWeiFormMap cangKuDianWeiFormMap)
			throws Exception {
		cangKuDianWeiMapper.updateEntity(cangKuDianWeiFormMap);
	}

	@Override
	public CangKuDianWeiFormMap findById(String id) {
		return cangKuDianWeiMapper.findById(id, CangKuDianWeiFormMap.class);
	}

	@SystemLog(module = "系统管理/仓库点位管理", methods = "删除", description = "成功")
	public void deleteOne(String id) throws Exception {
		cangKuDianWeiMapper.deleteEntityByKey("id", id,
				CangKuDianWeiFormMap.class);
	}

	@Override
	public List<CangKuDianWeiFormMap> findDianWeiByAttr(
			CangKuDianWeiFormMap cangKuDianWeiFormMap) {
		List<CangKuDianWeiFormMap> cangkus = cangKuDianWeiMapper
				.findByAttr(cangKuDianWeiFormMap);
		for (CangKuDianWeiFormMap cangku : cangkus) {
			ChuanGanQiFormMap map = new ChuanGanQiFormMap();
			map.put("cangkudianwei_id", cangku.get("id") + "");
			map.put(Constant.ORDER_BY, "id asc");
			List<ChuanGanQiFormMap> sensorList = chuanGanQiMapper
					.findByAttr(map);
			cangku.put("sensorList", sensorList);
		}
		return cangkus;
	}

	@Override
	public List<CangKuDianWeiFormMap> findDataById(String id) {
		return cangKuDianWeiMapper.findDataById(id);
	}
	
	
}
