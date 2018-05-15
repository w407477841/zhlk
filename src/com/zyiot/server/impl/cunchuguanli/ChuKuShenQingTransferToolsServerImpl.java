package com.zyiot.server.impl.cunchuguanli;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.cunchuguanli.ChuKuShenQingTransferToolsFormMap;
import com.zyiot.mapper.cunchuguanli.ChuKuShenQingTransferToolsMapper;
import com.zyiot.server.cunchuguanli.ChuKuShenQingTransferToolsServerI;
@Service("chuKuShenQingTransferToolsServer")
public class ChuKuShenQingTransferToolsServerImpl implements
		ChuKuShenQingTransferToolsServerI {
	@Autowired
	private ChuKuShenQingTransferToolsMapper chuKuShenQingTransferToolsMapper;
	@Override
	public List<ChuKuShenQingTransferToolsFormMap> findByPage(
			ChuKuShenQingTransferToolsFormMap c) {
		return chuKuShenQingTransferToolsMapper.findByPage(c);
	}

	@Override
	@SystemLog(module="出库传输工具",methods="添加",description="添加成功")
	public void addChuKuShenQingTransferTools(
			ChuKuShenQingTransferToolsFormMap c) throws Exception {
		chuKuShenQingTransferToolsMapper.addEntity(c);
	}

	@Override
	@SystemLog(module="出库传输工具",methods="删除",description="删除成功")
	public void dropChuKuShenQingTransferTools(String id) throws Exception {
		chuKuShenQingTransferToolsMapper.deleteEntityByKey("id", id, ChuKuShenQingTransferToolsFormMap.class);
	}

	@Override
	public void clearNoUsedData(int dataOperator)throws Exception {
		chuKuShenQingTransferToolsMapper.clearNoUsed(dataOperator);
	}

	@Override
	public List<ChuKuShenQingTransferToolsFormMap> findByIds(List<Integer> ids)
			throws Exception {
		return chuKuShenQingTransferToolsMapper.findByIds(ids);
	}

}
