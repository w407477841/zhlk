package com.zyiot.server.impl.cunchuguanli;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.cunchuguanli.LunHuanRuKuZhengLiHaoFormMap;
import com.zyiot.mapper.StoreInfoMapper;
import com.zyiot.mapper.cunchuguanli.LunHuanRuKuZhengLiHaoMapper;
import com.zyiot.server.cunchuguanli.LunHuanRuKuZhengLiHaoServerI;
import com.zyiot.util.CalculateUtils;
import com.zyiot.util.Common;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.StorageChangeUtil;
@Service("lunHuanRuKuZhengLiHaoServer")
public class LunHuanRuKuZhengLiHaoServerImpl implements
		LunHuanRuKuZhengLiHaoServerI {
	
	@Autowired
	private LunHuanRuKuZhengLiHaoMapper lunHuanRuKuZhengLiHaoMapper;
	@Autowired
	private StoreInfoMapper storeInfoMapper;
	@Override
	@SystemLog(module="轮换入库整理耗",methods="添加",description="添加成功")
	@Transactional(readOnly = false)
	public void addLunHuanRuKuZhengLiHao(
			LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap)
			throws Exception {
		String reduce = lunHuanRuKuZhengLiHaoFormMap.getStr("pslTotalReduce");
		//清空库存
		String wId = lunHuanRuKuZhengLiHaoFormMap.getStr("pslWId");
		// 根据仓号信息获取实时库存
		StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(Integer.parseInt(wId));
		//库存
		String kc = storageInfoFormMap.getStr("cangKu");
		//损耗
		double currentWeight = CalculateUtils.add(kc, reduce);
		// 更新实时库存
		String weight = Common.numberConvertString(currentWeight, 0);
		StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), kc, reduce, weight, "轮换入库增加", lunHuanRuKuZhengLiHaoFormMap.getStr(Constant.ENTITY_TABLE), "-1", lunHuanRuKuZhengLiHaoMapper);
		
		storageInfoFormMap.set("cangKu", weight);
		FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
		storeInfoMapper.updateEntity(storageInfoFormMap);
		
		lunHuanRuKuZhengLiHaoMapper.addEntity(lunHuanRuKuZhengLiHaoFormMap);
	}

	@Override
	@SystemLog(module="轮换入库整理耗",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editLunHuanRuKuZhengLiHao(
			LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap)
			throws Exception {
		String wId = lunHuanRuKuZhengLiHaoFormMap.getStr("pslWId");
		LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap2 = lunHuanRuKuZhengLiHaoMapper.findLunHuanRuKuZhengLiHaoById(Integer.parseInt(lunHuanRuKuZhengLiHaoFormMap.getStr("id")));
		
		if(lunHuanRuKuZhengLiHaoFormMap2.getInt(Constant.VERSION) == Integer.parseInt(lunHuanRuKuZhengLiHaoFormMap.getStr(Constant.VERSION))){
			lunHuanRuKuZhengLiHaoFormMap.set(Constant.VERSION, lunHuanRuKuZhengLiHaoFormMap2.getInt(Constant.VERSION)+1);
			
			//修改后减量
			String reduce = lunHuanRuKuZhengLiHaoFormMap.getStr("pslTotalReduce");
			//原减量
			String oReducr = lunHuanRuKuZhengLiHaoFormMap2.getBigDecimal("pslTotalReduce").toString();
			//损耗修改
			if(!reduce.equals(oReducr)){
				StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(Integer.parseInt(wId));
				
				String kc = storageInfoFormMap.getStr("cangKu");
				//加上原本的，减去现有的
				double orl = CalculateUtils.sub(kc, oReducr);
				double currentWeight= CalculateUtils.add(String.valueOf(orl), reduce);
				
				String changeWeight = Common.numberConvertString(CalculateUtils.sub(reduce, oReducr), 0);
				 // 更新实时库存
				String weight =  Common.numberConvertString(currentWeight, 0);
				StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), kc, changeWeight, weight, "轮换入库修改", lunHuanRuKuZhengLiHaoFormMap.getStr(Constant.ENTITY_TABLE), lunHuanRuKuZhengLiHaoFormMap.getStr("id"), lunHuanRuKuZhengLiHaoMapper);
				
				storageInfoFormMap.set("cangKu",weight);
				FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
				storeInfoMapper.updateEntity(storageInfoFormMap);
				
				lunHuanRuKuZhengLiHaoMapper.updateEntity(lunHuanRuKuZhengLiHaoFormMap);
				addOperatorLog(lunHuanRuKuZhengLiHaoFormMap2, "update");
			}
		}else{
			throw new Exception("[数据已更改]");
		}
	}

	@Override
	@SystemLog(module="轮换入库整理耗",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropLunHuanRuKuZhengLiHao(String id) throws Exception {
		LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap = lunHuanRuKuZhengLiHaoMapper.findLunHuanRuKuZhengLiHaoById(Integer.parseInt(id));
		
		lunHuanRuKuZhengLiHaoMapper.deleteEntityByKey("id", id, LunHuanRuKuZhengLiHaoFormMap.class);
		
		addOperatorLog(lunHuanRuKuZhengLiHaoFormMap, "delete");
		
		int wId = lunHuanRuKuZhengLiHaoFormMap.getInt("pslWId");
		String reduce = lunHuanRuKuZhengLiHaoFormMap.getBigDecimal("pslTotalReduce").toString();
		StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(wId);
		
		String kc = storageInfoFormMap.getStr("cangKu");
		//加上原本的，减去现有的
		double currentWeight = CalculateUtils.sub(kc, reduce);
		
		String weight = Common.numberConvertString(currentWeight, 0);
		StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), kc, reduce, weight, "入库轮换删除", "t_putin_storage_loss", id, lunHuanRuKuZhengLiHaoMapper);
		
		// 更新实时库存
		storageInfoFormMap.set("cangKu", weight);
		FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
		storeInfoMapper.updateEntity(storageInfoFormMap);
	}

	@Override
	public List<LunHuanRuKuZhengLiHaoFormMap> findByPage(
			LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap,
			int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return lunHuanRuKuZhengLiHaoMapper.findByPage(lunHuanRuKuZhengLiHaoFormMap);
	}

	@Override
	public LunHuanRuKuZhengLiHaoFormMap findLunHuanRuKuZhengLiHaoById(int id)
			throws Exception {
		return lunHuanRuKuZhengLiHaoMapper.findLunHuanRuKuZhengLiHaoById(id);
	}
	private void addOperatorLog(LunHuanRuKuZhengLiHaoFormMap lunHuanRuKuZhengLiHaoFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		lunHuanRuKuZhengLiHaoFormMap.remove("wLocation");
		lunHuanRuKuZhengLiHaoFormMap.remove("wName");
		lunHuanRuKuZhengLiHaoFormMap.remove("wlName");
		lunHuanRuKuZhengLiHaoFormMap.remove("text");
		lunHuanRuKuZhengLiHaoFormMap.set(Constant.ENTITY_TABLE, "t_putin_storage_loss_his");
		lunHuanRuKuZhengLiHaoFormMap.set("pslhSQL", sql);
		lunHuanRuKuZhengLiHaoFormMap.set("pslhUser", session.getAttribute("userSessionId"));
		lunHuanRuKuZhengLiHaoFormMap.set("pslhType", type);
		lunHuanRuKuZhengLiHaoFormMap.set("pslhOpDate", new Timestamp(System.currentTimeMillis()));
		lunHuanRuKuZhengLiHaoMapper.addEntity(lunHuanRuKuZhengLiHaoFormMap);
	}

	@Override
	public LunHuanRuKuZhengLiHaoFormMap findCheckDetailById(int id) {
		return lunHuanRuKuZhengLiHaoMapper.findCheckDetailById(id);
	}
}
