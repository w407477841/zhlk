package com.zyiot.server;

import java.util.List;

import com.zyiot.entity.CodeFormMap;
import com.zyiot.entity.CodeItemFormMap;

public interface CodeServerI {

	List<CodeFormMap> findCodeByPage(CodeFormMap codeFormMap,int pageSize,int pageNum);
	List<CodeItemFormMap> findCodeItemByAttr(CodeItemFormMap codeItemFormMap);
	int editCode(CodeFormMap codeFormMap)throws Exception;
	int editCodeItem(CodeItemFormMap codeItemFormMap)throws Exception;
	int deleteCode(int id)throws Exception;
	int deleteCodeItem(CodeItemFormMap codeItemFormMap) throws Exception;
	int addCode(CodeFormMap codeFormMap)throws Exception;
	int addCodeItem(CodeItemFormMap codeItemFormMap)throws Exception;
	int batchSaveCodeItem(List<CodeItemFormMap> l)throws Exception;
}
