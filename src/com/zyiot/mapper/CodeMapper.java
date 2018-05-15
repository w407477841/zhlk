package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.CodeFormMap;

public interface CodeMapper extends BaseMapper {

	List<CodeFormMap> findCodeByPage(CodeFormMap codeFormMap);
	
}
