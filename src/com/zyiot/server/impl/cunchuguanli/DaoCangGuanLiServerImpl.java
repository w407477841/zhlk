package com.zyiot.server.impl.cunchuguanli;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.cunchuguanli.DaoCangGuanLiFormMap;
import com.zyiot.mapper.StoreInfoMapper;
import com.zyiot.mapper.cunchuguanli.DaoCangGuanLiMapper;
import com.zyiot.server.cunchuguanli.DaoCangGuanLiServerI;
import com.zyiot.util.CalculateUtils;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.StorageChangeUtil;
@Service("daoCangGuanLiServer")
public class DaoCangGuanLiServerImpl implements DaoCangGuanLiServerI {
	@Autowired
	private DaoCangGuanLiMapper daoCangGuanLiMapper;
	
	@Autowired
	StoreInfoMapper storeInfoMapper;
	@Override
	@SystemLog(module="倒仓管理",methods="添加",description="添加成功")
	@Transactional(readOnly=false)
	public void addDaoCangGuanLi(DaoCangGuanLiFormMap daoCangGuanLiFormMap)
			throws Exception {
		/**
		 * 进行仓库库存量修改
		 */
		int oId = Integer.parseInt(daoCangGuanLiFormMap.getStr("wgtOriginalId"));
		int tId = Integer.parseInt(daoCangGuanLiFormMap.getStr("wgtTargetId"));
		//倒仓数量
		String wgtNumber = daoCangGuanLiFormMap.getStr("wgtNumber");
		
		StorageInfoFormMap storageInfoFormMapo = storeInfoMapper.findByWarehouseId(oId);
		StorageInfoFormMap storageInfoFormMapt = storeInfoMapper.findByWarehouseId(tId);
		//原始仓库库存量减少
		//目标仓库库存量增加
		String oWeight = Common.numberConvertString(CalculateUtils.sub(storageInfoFormMapo.getStr("cangKu"), wgtNumber),0);
		String tWeight = Common.numberConvertString(CalculateUtils.add(storageInfoFormMapt.getStr("cangKu"), wgtNumber),0);
		
		//添加库存变化数据记录
		StorageChangeUtil.addChangeLog(storageInfoFormMapo.getInt("id"), storageInfoFormMapo.getStr("cangKu"), wgtNumber, oWeight, "倒仓", daoCangGuanLiFormMap.getStr(Constant.ENTITY_TABLE), oId+"", daoCangGuanLiMapper);
		StorageChangeUtil.addChangeLog(storageInfoFormMapt.getInt("id"), storageInfoFormMapt.getStr("cangKu"), wgtNumber, tWeight, "倒仓", daoCangGuanLiFormMap.getStr(Constant.ENTITY_TABLE), tId+"", daoCangGuanLiMapper);
		
		storageInfoFormMapo.set("cangKu",oWeight);
		storageInfoFormMapt.set("cangKu",tWeight);
		
		daoCangGuanLiFormMap.set("wgtNumber", wgtNumber);
		daoCangGuanLiMapper.addEntity(daoCangGuanLiFormMap);
		
		FormMapUtil.toUPDATEFormMap(storageInfoFormMapo);
		FormMapUtil.toUPDATEFormMap(storageInfoFormMapt);
		storeInfoMapper.updateEntity(storageInfoFormMapo);
		storeInfoMapper.updateEntity(storageInfoFormMapt);
	}

	@Override
	public List<DaoCangGuanLiFormMap> findByPage(
			DaoCangGuanLiFormMap daoCangGuanLiFormMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return daoCangGuanLiMapper.findByPage(daoCangGuanLiFormMap);
	}

	@Override
	public DaoCangGuanLiFormMap findDaoCangGuanLiById(int id) throws Exception {
		return daoCangGuanLiMapper.findDaoCangGuanLiById(id);
	}

	@Override
	public DaoCangGuanLiFormMap findDaoCangGuanLiByWarehouseId(int warehouseId)
			throws Exception {
		return daoCangGuanLiMapper.findDaoCangGuanLiByWarehouseId(warehouseId);
	}

}
