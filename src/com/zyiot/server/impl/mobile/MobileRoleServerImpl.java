package com.zyiot.server.impl.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.mobile.MobileRoleFormMap;
import com.zyiot.mapper.mobile.MobileRoleMapper;
import com.zyiot.server.mobile.MobileRoleServerI;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;

@Service
public class MobileRoleServerImpl implements MobileRoleServerI {
	@Autowired
	private MobileRoleMapper mobileRoleMapper;
	
	@Override
	@SystemLog(module="移动端角色",methods="添加",description="成功")
	public void addMobileRole(MobileRoleFormMap mobileRoleFormMap)
			throws Exception {
		mobileRoleMapper.addEntity(mobileRoleFormMap);
	}

	@Override
	@SystemLog(module="移动端角色",methods="修改",description="成功")
	public void editMobileRole(MobileRoleFormMap mobileRoleFormMap)
			throws Exception {
		mobileRoleMapper.updateEntity(mobileRoleFormMap);
	}

	@Override
	@Transactional(readOnly = false)
	@SystemLog(module="移动端角色",methods="删除",description="成功")
	public void dropMobileRole(String id) throws Exception {
		mobileRoleMapper.deleteRolePermission(id);
		mobileRoleMapper.deleteEntityByKey("id", id, MobileRoleFormMap.class);
	}

	@Override
	public List<MobileRoleFormMap> findByPage(
			MobileRoleFormMap mobileRoleFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return mobileRoleMapper.findByPage(mobileRoleFormMap);
	}

	@Override
	public List<MobileRoleFormMap> findBySelected(
			MobileRoleFormMap mobileRoleFormMap) {
		return mobileRoleMapper.findByAttr(mobileRoleFormMap);
	}

	@Override
	public MobileRoleFormMap findByRoleId(int id) {
		return mobileRoleMapper.findMobileRoleById(id);
	}

	@Override
	@Transactional(readOnly = false)
	public void editPermission(MobileRoleFormMap mobileRoleFormMap)
			throws Exception {
		String resIds[] = (String[]) mobileRoleFormMap.get("resId");
		String roleId = mobileRoleFormMap.getStr("roleId");
		
		if(!Common.isEmpty(roleId) && resIds != null){
			mobileRoleMapper.deleteRolePermission(roleId);
			MobileRoleFormMap mr ;
			for(String resId:resIds){
				mr = new MobileRoleFormMap();
				mr.set("resId", resId);
				mr.set("roleId", roleId);
				mr.set(Constant.ENTITY_TABLE,"app_role_permission");
				mobileRoleMapper.addRolePermission(mr);
			}
		}
	}

}
