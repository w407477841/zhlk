package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.ResFormMap;
import com.zyiot.entity.RoleResFormMap;
import com.zyiot.entity.UserResFormMap;

public interface ResourcesServerI {

	List<ResFormMap> findResByPage(ResFormMap resFormMap, int PageNum,
			int PageSize);

	List<ResFormMap> findAllRes();

	List<ResFormMap> findRes(ResFormMap resFormMap);

	List<ResFormMap> findFirstRes(ResFormMap resFormMap);

	List<ResFormMap> findAllParent();

	ResFormMap findResById(String id);

	int edit(ResFormMap resFormMap) throws Exception;

	int deleteByKey(String key, String val) throws Exception;

	int deleteAll(ResFormMap resFormMap, UserResFormMap userResFormMap,
			RoleResFormMap roleResFormMap) throws Exception;

	int add(ResFormMap resFormMap) throws Exception;

	int editRoleRes(ResFormMap resFormMap) throws Exception;
}
