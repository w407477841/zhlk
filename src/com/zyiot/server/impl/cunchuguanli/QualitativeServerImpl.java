package com.zyiot.server.impl.cunchuguanli;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.cunchuguanli.QualitativeFormMap;
import com.zyiot.mapper.StorageInfoMapper;
import com.zyiot.mapper.cunchuguanli.QualitativeMapper;
import com.zyiot.server.cunchuguanli.QualitativeServerI;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.TimeGenerate;

@Service("qualitativeServer")
public class QualitativeServerImpl implements QualitativeServerI {
	@Autowired
	QualitativeMapper qualitativeMapper;
	@Autowired
	StorageInfoMapper storageInfoMapper;

	public List<QualitativeFormMap> findByPage(QualitativeFormMap q,
			int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return qualitativeMapper.findByPage(q);
	}

	@Transactional(readOnly = false)
	@SystemLog(module = "定性管理", methods = "定性", description = "成功")
	public void addQualitative(QualitativeFormMap q) throws Exception {
		q.put("qChangeTime", TimeGenerate.generator2());
		qualitativeMapper.addEntity(q);

		StorageInfoFormMap storage = new StorageInfoFormMap();
		storage.put("storageID", q.get("warehouse_id"));
		List<StorageInfoFormMap> l = storageInfoMapper.findByAttr(storage);
		if (l != null) {
			storage = l.get(0);
			storage.put("quanZhong", q.get("qNewQualitative"));

			FormMapUtil.toUPDATEFormMap(storage);
			storageInfoMapper.updateEntity(storage);

		} else {
			throw new Exception("不存在该仓库");
		}
	}

	public List<QualitativeFormMap> findCk() {
		return qualitativeMapper.findCk();
	}

}
