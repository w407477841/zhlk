package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.CodeFormMap;
import com.zyiot.entity.CodeItemFormMap;
import com.zyiot.mapper.CodeItemMapper;
import com.zyiot.mapper.CodeMapper;
import com.zyiot.server.CodeServerI;
import com.zyiot.util.BatchInsertParameter;

@Service("codeServer")
public class CodeServerImpl implements CodeServerI {
	@Autowired
	CodeMapper codeMapper;
	@Autowired
	CodeItemMapper codeItemMapper;

	public List<CodeFormMap> findCodeByPage(CodeFormMap codeFormMap,
			int pageSize, int pageNum) {

		return codeMapper.findCodeByPage(codeFormMap);
	}

	@Override
	public List<CodeItemFormMap> findCodeItemByAttr(
			CodeItemFormMap codeItemFormMap) {
		return codeItemMapper.findByAttr(codeItemFormMap);
	}

	@SystemLog(module = "字典管理", methods = "修改字典", description = "成功")
	@Transactional(readOnly = false)
	public int editCode(CodeFormMap codeFormMap) throws Exception {
		return codeMapper.updateEntity(codeFormMap);
	}

	@SystemLog(module = "字典管理", methods = "删除字典", description = "成功")
	@Transactional(readOnly = false)
	public int deleteCode(int id) throws Exception {
		codeItemMapper.deleteEntityByKey("codeid", id + "",
				CodeItemFormMap.class);
		return codeMapper.deleteEntityByKey("id", id + "", CodeFormMap.class);
	}

	@SystemLog(module = "字典管理", methods = "添加字典", description = "成功")
	@Transactional(readOnly = false)
	public int addCode(CodeFormMap codeFormMap) throws Exception {
		return codeMapper.addEntity(codeFormMap);
	}

	@SystemLog(module = "字典管理", methods = "添加字典项", description = "成功")
	@Transactional(readOnly = false)
	public int addCodeItem(CodeItemFormMap codeItemFormMap) throws Exception {
		return codeItemMapper.addEntity(codeItemFormMap);
	}

	@SystemLog(module = "字典管理", methods = "修改字典项", description = "成功")
	@Transactional(readOnly = false)
	public int editCodeItem(CodeItemFormMap codeItemFormMap) throws Exception {
		return codeItemMapper.updateEntity(codeItemFormMap);
	}

	@SystemLog(module = "字典管理", methods = "删除字典项", description = "成功")
	@Transactional(readOnly = false)
	public int deleteCodeItem(CodeItemFormMap codeItemFormMap) throws Exception {
		return codeItemMapper.deleteEntityByNames(codeItemFormMap);
	}

	@SystemLog(module = "字典管理", methods = "导入字典项", description = "成功")
	@Transactional(readOnly = false)
	public int batchSaveCodeItem(List<CodeItemFormMap> l) throws Exception {
		return codeItemMapper.batchSave(BatchInsertParameter.wrap(l, 100));
	}

}
