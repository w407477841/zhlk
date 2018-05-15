package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.ShiPinDianWeiFormMap;
import com.zyiot.mapper.ShiPinDianWeiMapper;
import com.zyiot.server.ShiPinDianWeiServerI;

@Service("shiPinDianWeiServer")
public class ShiPinDianWeiServerImpl implements ShiPinDianWeiServerI {

	@Autowired
	ShiPinDianWeiMapper shiPinDianWeiMapper;

	public List<ShiPinDianWeiFormMap> findShiPinDianWeiByPage(
			ShiPinDianWeiFormMap shiPinDianWeiFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return shiPinDianWeiMapper
				.findShiPinDianWeiByPage(shiPinDianWeiFormMap);
	}

	@SystemLog(description = "成功", methods = "添加点位", module = "系统管理/视频点位管理")
	public int addShiPinDianWei(ShiPinDianWeiFormMap shiPinDianWeiFormMap)
			throws Exception {

		return shiPinDianWeiMapper.addEntity(shiPinDianWeiFormMap);
	}

	@Override
	public List<ShiPinDianWeiFormMap> findShiPinDianWeiByAttr(
			ShiPinDianWeiFormMap shiPinDianWeiFormMap) {
		return shiPinDianWeiMapper.findByAttr(shiPinDianWeiFormMap);
	}

	@SystemLog(description = "成功", methods = "修改点位", module = "系统管理/视频点位管理")
	public void editShiPinDianWei(ShiPinDianWeiFormMap formMap)
			throws Exception {
		shiPinDianWeiMapper.updateEntity(formMap);
	}

	@Override
	public ShiPinDianWeiFormMap findShiPinDianWeiById(String id) {
		return shiPinDianWeiMapper.findById(id, ShiPinDianWeiFormMap.class);
	}

	@SystemLog(description = "成功", methods = "删除点位", module = "系统管理/视频点位管理")
	public void deleteShiPinDianWei(String id) throws Exception {
		shiPinDianWeiMapper.deleteEntityByKey("id", id,
				ShiPinDianWeiFormMap.class);

	}

}
