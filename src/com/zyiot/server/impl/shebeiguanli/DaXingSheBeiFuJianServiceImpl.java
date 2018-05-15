package com.zyiot.server.impl.shebeiguanli;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyiot.entity.shebeiguanli.DaXingSheBeiFuJianFormMap;
import com.zyiot.mapper.shebeiguanli.DaXingSheBeiFuJianMapper;
import com.zyiot.server.shebeiguanli.DaXingSheBeiFuJianServiceI;
@Service("daXingSheBeiFuJianService")
public class DaXingSheBeiFuJianServiceImpl implements
		DaXingSheBeiFuJianServiceI {
	@Autowired
	private DaXingSheBeiFuJianMapper daXingSheBeiFuJianMapper;
	@Override
	public void addDaXingSheBeiFuJian(
			DaXingSheBeiFuJianFormMap daXingSheBeiFuJianFormMap)
			throws Exception {
		daXingSheBeiFuJianMapper.addEntity(daXingSheBeiFuJianFormMap);
	}

	@Override
	public void dropDaXingSheBeiFuJian(String id) throws Exception {
		daXingSheBeiFuJianMapper.deleteEntityByKey("id", id, DaXingSheBeiFuJianFormMap.class);
	}

	@Override
	public List<DaXingSheBeiFuJianFormMap> findByPage(
			DaXingSheBeiFuJianFormMap daXingSheBeiFuJianFormMap) {
		return daXingSheBeiFuJianMapper.findByPage(daXingSheBeiFuJianFormMap);
	}

	@Override
	public void clearNotUsedData(int dataOperator) throws Exception {
		daXingSheBeiFuJianMapper.clearNotUsedData(dataOperator);
	}

	@Override
	public List<DaXingSheBeiFuJianFormMap> findByleId(List<Integer> ids) {
		return daXingSheBeiFuJianMapper.findByleId(ids);
	}

}
