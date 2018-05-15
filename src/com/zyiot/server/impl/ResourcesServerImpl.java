package com.zyiot.server.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.ResFormMap;
import com.zyiot.entity.RoleResFormMap;
import com.zyiot.entity.UserResFormMap;
import com.zyiot.entity.UserRoleFormMap;
import com.zyiot.mapper.ResourcesMapper;
import com.zyiot.mapper.UserMapper;
import com.zyiot.server.ResourcesServerI;
import com.zyiot.util.BatchInsertParameter;

/**
 * 
 * 一人最多一个权限
 * 
 */
@Service("ressourcesServer")
public class ResourcesServerImpl implements ResourcesServerI {
	@Autowired
	ResourcesMapper resourcesMapper;
	@Autowired
	UserMapper userMapper;

	public List<ResFormMap> findResByPage(ResFormMap resFormMap, int PageNum,
			int PageSize) {
		PageHelper.startPage(PageNum, PageSize);
		return resourcesMapper.findResByPage(resFormMap);
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "菜单管理", methods = "修改菜单", description = "成功")
	public int edit(ResFormMap resFormMap) throws Exception {
		return resourcesMapper.updateEntity(resFormMap);
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "菜单管理", methods = "删除菜单", description = "成功")
	public int deleteByKey(String key, String val) throws Exception {
		return resourcesMapper.deleteEntityByKey(key, val, ResFormMap.class);
	}

	@Override
	public List<ResFormMap> findAllRes() {
		return resourcesMapper.findByAttr(new ResFormMap());
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "菜单管理", methods = "添加", description = "成功")
	public int add(ResFormMap resFormMap) throws Exception {

		return resourcesMapper.addEntity(resFormMap);
	}

	@Override
	public ResFormMap findResById(String id) {

		return resourcesMapper.findById(id, ResFormMap.class);
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "菜单管理", methods = "删除含子菜单", description = "成功")
	public int deleteAll(ResFormMap resFormMap, UserResFormMap userResFormMap,
			RoleResFormMap roleResFormMap) throws Exception {
		// 删除菜单
		// 删除用户下的菜单
		// 删除角色下的菜单
		resourcesMapper.deleteEntityByNames(userResFormMap);
		resourcesMapper.deleteEntityByNames(roleResFormMap);
		return resourcesMapper.deleteEntityByNames(resFormMap);
	}

	@Override
	public List<ResFormMap> findRes(ResFormMap resFormMap) {
		return resourcesMapper.findRes_RoleIdORUserId(resFormMap);
	}

	@SystemLog(module = "菜单管理", methods = "修改权限", description = "成功")
	@Transactional(readOnly = false)
	public int editRoleRes(ResFormMap resFormMap) throws Exception {
		String resIds[] = (String[]) resFormMap.get("resId");
		String roleId = resFormMap.getStr("roleId");
		String userId = resFormMap.getStr("userId");
		if (roleId != null && !roleId.equals("")) {

			// 删除所有拥有该role的用户的权限
			// 如 admin用户有 role和role1 , 只删除 role下的权限
			resourcesMapper.deleteResByRoleId(roleId);

			// 先删除该role下的所有权限。
			resourcesMapper.deleteEntityByKey("roleId", roleId,
					RoleResFormMap.class);
			// 添加修改后的权限
			List<RoleResFormMap> roleResList = new ArrayList<RoleResFormMap>();
			if (resIds != null && resIds.length > 0) {
				for (String resId : resIds) {
					RoleResFormMap roleRes = new RoleResFormMap();
					roleRes.put("roleId", roleId);
					roleRes.put("resId", resId);
					roleResList.add(roleRes);
				}
			}
			BatchInsertParameter<RoleResFormMap> bip = BatchInsertParameter
					.wrap(roleResList, 100);
			resourcesMapper.batchSave(bip);

			// 重新分配所有拥有该role的用户的权限
			UserRoleFormMap urole = new UserRoleFormMap();
			urole.put("roleId", roleId);
			List<UserRoleFormMap> uroles = userMapper.findByAttr(urole);
			List<UserResFormMap> rresList = null;
			for (int i = 0; uroles != null && i < uroles.size(); i++) {
				Object userId1 = uroles.get(i).get("userId");
				rresList = new ArrayList<UserResFormMap>();
				for (String resId : resIds) {
					UserResFormMap userRes = new UserResFormMap();
					userRes.put("userId", userId1);
					userRes.put("resId", resId);
					rresList.add(userRes);
				}
				BatchInsertParameter<UserResFormMap> bipUr = BatchInsertParameter
						.wrap(rresList, 100);
				resourcesMapper.batchSave(bipUr);
			}
		}

		else if (userId != null && !userId.equals("")) {
			// 删除 该用户下所有权限
			resourcesMapper.deleteEntityByKey("userId", userId,
					UserResFormMap.class);
			// 添加前台传来的所有权限
			List<UserResFormMap> rresList = new ArrayList<UserResFormMap>();
			for (String resId : resIds) {
				UserResFormMap ures = new UserResFormMap();
				ures.put("userId", userId);
				ures.put("resId", resId);
				rresList.add(ures);
			}
			BatchInsertParameter<UserResFormMap> bipUr = BatchInsertParameter
					.wrap(rresList, 100);
			resourcesMapper.batchSave(bipUr);
		}
		return 0;
	}

	public List<ResFormMap> findAllParent() {
		return resourcesMapper.findAllParent();
	}

	@Override
	public List<ResFormMap> findFirstRes(ResFormMap resFormMap) {
		return resourcesMapper.findFirstRes(resFormMap);
	}

}
