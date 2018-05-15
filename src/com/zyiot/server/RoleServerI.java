package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.RoleFormMap;

public interface RoleServerI {
List<RoleFormMap> findRoleByPage(RoleFormMap roleFormMap,int pageSize,int pageNum);
List<RoleFormMap> findRoleByAttr(RoleFormMap roleFormMap);
int edit(RoleFormMap roleFormMap)throws Exception;
int delete(String key ,String val)throws Exception;
int add(RoleFormMap roleFormMap)throws Exception;
}
