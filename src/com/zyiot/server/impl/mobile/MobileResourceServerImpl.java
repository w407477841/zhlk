package com.zyiot.server.impl.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.mobile.MobileResourceFormMap;
import com.zyiot.mapper.mobile.MobileResourceMapper;
import com.zyiot.server.mobile.MobileResourceServerI;

@Service
public class MobileResourceServerImpl implements MobileResourceServerI {
	@Autowired
	private MobileResourceMapper mobileResourceMapper;
	@Override
	@SystemLog(module="移动端菜单",methods="添加",description="成功")
	public void addMobileResource(MobileResourceFormMap mobileResourceFormMap)
			throws Exception {
		mobileResourceMapper.addEntity(mobileResourceFormMap);
	}

	@Override
	@SystemLog(module="移动端菜单",methods="修改",description="成功")
	public void editMobileResource(MobileResourceFormMap mobileResourceFormMap)
			throws Exception {
		mobileResourceMapper.updateEntity(mobileResourceFormMap);
	}

	@Override
	@SystemLog(module="移动端菜单",methods="删除",description="成功")
	@Transactional(readOnly = false)
	public void dropMobileResource(List<String> ids)throws Exception {
		mobileResourceMapper.dropResource(ids);
		mobileResourceMapper.dropResourceAndPrmession(ids);
	}

	@Override
	public List<MobileResourceFormMap> findByAttr(
			MobileResourceFormMap mobileResourceFormMap) {
		return mobileResourceMapper.findAllResource(mobileResourceFormMap);
	}

	@Override
	public MobileResourceFormMap findById(int id) {
		return mobileResourceMapper.findResourceById(id);
	}

	@Override
	public List<MobileResourceFormMap> findByPermission(
			MobileResourceFormMap mobileResourceFormMap) {
		return mobileResourceMapper.findByPermission(mobileResourceFormMap);
	}

}
