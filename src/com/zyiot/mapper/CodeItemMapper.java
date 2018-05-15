package com.zyiot.mapper;

import java.util.List;

import com.zyiot.entity.CodeItemFormMap;

public interface CodeItemMapper extends BaseMapper {
	List<CodeItemFormMap> findCodeItemByPage(CodeItemFormMap codeItemFormMap);
}
