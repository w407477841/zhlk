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
import com.zyiot.entity.cunchuguanli.LunHuanChuKuBaoGuanHaoFormMap;
import com.zyiot.mapper.StoreInfoMapper;
import com.zyiot.mapper.cunchuguanli.LunHuanChuKuBaoGuanHaoMapper;
import com.zyiot.server.cunchuguanli.LunHuanChuKuBaoGuanHaoServerI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
import com.zyiot.util.StorageChangeUtil;
@Service("lunHuanChuKuBaoGuanHaoServer")
public class LunHuanChuKuBaoGuanHaoServerImpl implements
		LunHuanChuKuBaoGuanHaoServerI {

	@Autowired
	private LunHuanChuKuBaoGuanHaoMapper lunHuanChuKuBaoGuanHaoMapper;
	@Autowired
	private StoreInfoMapper storeInfoMapper;
	
	@Override
	@SystemLog(module="粮食轮换出库保管耗",methods="添加",description="添加成功")
	@Transactional(readOnly = false)
	public void addLunHuanChuKuBaoGuanHao(
			LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap)
			throws Exception {
		
		
		//清空库存
		String wId = lunHuanChuKuBaoGuanHaoFormMap.getStr("gslWId");
		// 根据仓号信息获取实时库存
		StorageInfoFormMap storageInfoFormMap = storeInfoMapper.findByWarehouseId(Integer.parseInt(wId));
		
		StorageChangeUtil.addChangeLog(storageInfoFormMap.getInt("id"), storageInfoFormMap.getStr("cangKu"), lunHuanChuKuBaoGuanHaoFormMap.getStr("gslOverflowWeight"), "0", "保管损耗添加", lunHuanChuKuBaoGuanHaoFormMap.getStr(Constant.ENTITY_TABLE), "-1", lunHuanChuKuBaoGuanHaoMapper);
		
		// 更新实时库存
		storageInfoFormMap.set("cangKu", "0");
		FormMapUtil.toUPDATEFormMap(storageInfoFormMap);
		storeInfoMapper.updateEntity(storageInfoFormMap);
				
		//添加数据
		lunHuanChuKuBaoGuanHaoMapper.addEntity(lunHuanChuKuBaoGuanHaoFormMap);
		//添加清空记录
		StorageChangeUtil.addEmptyData(wId+"", storeInfoMapper,lunHuanChuKuBaoGuanHaoFormMap.getStr("gslGetOutDate")+" 00:00:00");
	}

	@Override
	@SystemLog(module="粮食轮换出库保管耗",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editLunHuanChuKuBaoGuanHao(
			LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap)
			throws Exception {
		LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap2 = lunHuanChuKuBaoGuanHaoMapper.findLunHuanChuKuBaoGuanHaoById(Integer.parseInt(lunHuanChuKuBaoGuanHaoFormMap.getStr("id")));
		
		if(lunHuanChuKuBaoGuanHaoFormMap2.getInt(Constant.VERSION) == Integer.parseInt(lunHuanChuKuBaoGuanHaoFormMap.getStr(Constant.VERSION))){
			lunHuanChuKuBaoGuanHaoFormMap.set(Constant.VERSION, lunHuanChuKuBaoGuanHaoFormMap2.getInt(Constant.VERSION)+1);
			
			lunHuanChuKuBaoGuanHaoMapper.updateEntity(lunHuanChuKuBaoGuanHaoFormMap);
			
			addOperatorLog(lunHuanChuKuBaoGuanHaoFormMap2, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	@SystemLog(module="粮食轮换出库保管耗",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropLunHuanChuKuBaoGuanHao(String id) throws Exception {
		LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap = lunHuanChuKuBaoGuanHaoMapper.findLunHuanChuKuBaoGuanHaoById(Integer.parseInt(id));
		
		lunHuanChuKuBaoGuanHaoMapper.deleteEntityByKey("id", id, LunHuanChuKuBaoGuanHaoFormMap.class);
		
		addOperatorLog(lunHuanChuKuBaoGuanHaoFormMap, "delete");
	}

	@Override
	public List<LunHuanChuKuBaoGuanHaoFormMap> findByPage(
			LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap,
			int pageNumber, int pageSize) {
		PageHelper.startPage(pageNumber, pageSize);
		return lunHuanChuKuBaoGuanHaoMapper.findByPage(lunHuanChuKuBaoGuanHaoFormMap);
	}

	@Override
	public LunHuanChuKuBaoGuanHaoFormMap findLunHuanChuKuBaoGuanHaoById(int id)
			throws Exception {
		return lunHuanChuKuBaoGuanHaoMapper.findLunHuanChuKuBaoGuanHaoById(id);
	}
	private void addOperatorLog(LunHuanChuKuBaoGuanHaoFormMap lunHuanChuKuBaoGuanHaoFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		lunHuanChuKuBaoGuanHaoFormMap.remove("wLocation");
		lunHuanChuKuBaoGuanHaoFormMap.remove("wName");
		lunHuanChuKuBaoGuanHaoFormMap.remove("wlName");
		lunHuanChuKuBaoGuanHaoFormMap.remove("text");
		lunHuanChuKuBaoGuanHaoFormMap.remove("property");
		lunHuanChuKuBaoGuanHaoFormMap.remove("packageText");
		lunHuanChuKuBaoGuanHaoFormMap.set(Constant.ENTITY_TABLE, "t_getout_storage_loss_his");
		lunHuanChuKuBaoGuanHaoFormMap.set("gslhSQL", sql);
		lunHuanChuKuBaoGuanHaoFormMap.set("gslhUser", session.getAttribute("userSessionId"));
		lunHuanChuKuBaoGuanHaoFormMap.set("gslhType", type);
		lunHuanChuKuBaoGuanHaoFormMap.set("gslhOpDate", new Timestamp(System.currentTimeMillis()));
		lunHuanChuKuBaoGuanHaoMapper.addEntity(lunHuanChuKuBaoGuanHaoFormMap);
	}

	@Override
	public LunHuanChuKuBaoGuanHaoFormMap findCheckDetailById(int id) {
		return lunHuanChuKuBaoGuanHaoMapper.findCheckDetailById(id);
	}
}
