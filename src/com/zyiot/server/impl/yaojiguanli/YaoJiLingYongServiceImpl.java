package com.zyiot.server.impl.yaojiguanli;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.yaojiguanli.YaoJiKuCunFormMap;
import com.zyiot.entity.yaojiguanli.YaoJiLingYongFormMap;
import com.zyiot.mapper.yaojiguanli.YaoJiKuCunMapper;
import com.zyiot.mapper.yaojiguanli.YaoJiLingYongMapper;
import com.zyiot.server.yaojiguanli.YaoJiLingYongServiceI;
import com.zyiot.util.Constant;
import com.zyiot.util.FormMapUtil;
@Service("yaoJiLingYongService")
public class YaoJiLingYongServiceImpl implements YaoJiLingYongServiceI {

	@Autowired
	private YaoJiLingYongMapper yaoJiLingYongMapper;
	@Autowired
	private YaoJiKuCunMapper yaoJiKuCunMapper;
	
	
	@Override
	@SystemLog(module="药剂领用",methods="添加",description="领用成功")
	@Transactional(readOnly=false)
	public void addYaoJiLingYong(YaoJiLingYongFormMap yaoJiLingYongFormMap,YaoJiKuCunFormMap yaoJiKuCunFormMap)
			throws Exception {
		
          yaoJiKuCunFormMap.set("mrNumber", Integer.parseInt(yaoJiKuCunFormMap.getStr("mrNumber")) - Integer.parseInt(yaoJiLingYongFormMap.getStr("muQuantity")));
		

			YaoJiKuCunFormMap yaoJiKuCunFormMap2 =yaoJiKuCunMapper.findYaoJiKuCunById(Integer.parseInt(yaoJiKuCunFormMap.getStr("id")));
			if(Integer.parseInt(yaoJiKuCunFormMap.getStr(Constant.VERSION)) == yaoJiKuCunFormMap2.getInt(Constant.VERSION)){
				yaoJiKuCunFormMap.set(Constant.VERSION, yaoJiKuCunFormMap2.getInt(Constant.VERSION)+1);
				
				yaoJiKuCunMapper.updateEntity(yaoJiKuCunFormMap);
			
			addOperatorLog(yaoJiKuCunFormMap2,"used");
			}else{
				throw new Exception("[已被修改]");
			}
		
			String dateStr = yaoJiLingYongFormMap.getStr("muUsedDate")+" 12:00:00";
			Timestamp ts = Timestamp.valueOf(dateStr);
			yaoJiLingYongFormMap.set("muUsedDate",ts);
			Session session = SecurityUtils.getSubject().getSession();
			yaoJiLingYongFormMap.set("muDataOperator",session.getAttribute("userSessionId"));
			yaoJiLingYongMapper.addEntity(yaoJiLingYongFormMap);
	}

	@Override
	public void editYaoJiLingYong(YaoJiLingYongFormMap yaoJiLingYongFormMap)
			throws Exception {
		yaoJiLingYongMapper.updateEntity(yaoJiLingYongFormMap);
	}

	@Override
	@SystemLog(module="药剂领用",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void deleteYaoJiLingYongById(String id) throws Exception {
		
		YaoJiLingYongFormMap yaoJiLingYongFormMap = yaoJiLingYongMapper.findYaoJiLingYongById(Integer.parseInt(id));
		YaoJiKuCunFormMap yaoJiKuCunFormMap = yaoJiKuCunMapper.findYaoJiKuCunById(yaoJiLingYongFormMap.getInt("mrId"));
		YaoJiKuCunFormMap yaoJiKuCunFormMap2 = new YaoJiKuCunFormMap();
		if(yaoJiLingYongFormMap!=null){
			if(yaoJiKuCunFormMap !=null){//药剂库存有数据
				
				yaoJiKuCunFormMap2.set("mrNumber", yaoJiKuCunFormMap.getInt("mrNumber")+yaoJiLingYongFormMap.getInt("muQuantity"));
				yaoJiKuCunFormMap2.set(Constant.VERSION, yaoJiKuCunFormMap.getInt(Constant.VERSION)+1);
				yaoJiKuCunFormMap2.set("id", yaoJiKuCunFormMap.getInt("id")+"");
				
				FormMapUtil.toUPDATEFormMap(yaoJiKuCunFormMap2);
				
				yaoJiKuCunMapper.updateEntity(yaoJiKuCunFormMap2);
				addOperatorLog(yaoJiKuCunFormMap,"backup");
				
				
			}else{ //药剂库存无数据
				YaoJiLingYongToYaoJiKuCun(yaoJiLingYongFormMap,yaoJiKuCunFormMap2);
			    FormMapUtil.toADDFormMap(yaoJiKuCunFormMap2);
			    yaoJiKuCunMapper.addEntity(yaoJiKuCunFormMap2);
			
			    addOperatorLog(yaoJiKuCunFormMap2,"backup and add");
				
			}
			yaoJiLingYongMapper.deleteEntityByKey("id", id, YaoJiLingYongFormMap.class);
			addOperatorLog(yaoJiLingYongFormMap, "delete");
		}
	}

	@Override
	public List<YaoJiLingYongFormMap> findByPage(
			YaoJiLingYongFormMap yaoJiLingYongFormMap, int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return yaoJiLingYongMapper.findByPage(yaoJiLingYongFormMap);
	}

	@Override
	public List<YaoJiLingYongFormMap> findByAttr(
			YaoJiLingYongFormMap yaoJiLingYongFormMap) {
		return yaoJiLingYongMapper.findByAttr(yaoJiLingYongFormMap);
	}

	@Override
	public YaoJiLingYongFormMap findById(int id) throws Exception {
		return yaoJiLingYongMapper.findYaoJiLingYongById(id);
	}
	public void addOperatorLog(YaoJiKuCunFormMap yaoJiKuCunFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		yaoJiKuCunFormMap.set(Constant.ENTITY_TABLE, "t_medicament_repository_his");
		yaoJiKuCunFormMap.set("mrhSQL", sql);
		yaoJiKuCunFormMap.set("mrhUser", session.getAttribute("userSessionId"));
		yaoJiKuCunFormMap.set("mrhType", type);
		yaoJiKuCunFormMap.set("mrhOpDate", new Timestamp(System.currentTimeMillis()));
	    yaoJiKuCunMapper.addEntity(yaoJiKuCunFormMap);
	}
	
	public void addOperatorLog(YaoJiLingYongFormMap yaoJiLingYongFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		yaoJiLingYongFormMap.remove("page");
		yaoJiLingYongFormMap.remove("drug");
		yaoJiLingYongFormMap.remove("wName");
		yaoJiLingYongFormMap.set(Constant.ENTITY_TABLE, "t_medicament_used_his");
		yaoJiLingYongFormMap.set("muhSQL", sql);
		yaoJiLingYongFormMap.set("muhUser", session.getAttribute("userSessionId"));
		yaoJiLingYongFormMap.set("muhType", type);
		yaoJiLingYongFormMap.set("muhOpDate", new Timestamp(System.currentTimeMillis()));
	    yaoJiLingYongMapper.addEntity(yaoJiLingYongFormMap);
	}
	
	public void YaoJiLingYongToYaoJiKuCun(YaoJiLingYongFormMap yaoJiLingYongFormMap,YaoJiKuCunFormMap yaoJiKuCunFormMap){
		Session session = SecurityUtils.getSubject().getSession();
		yaoJiKuCunFormMap.put("id", yaoJiLingYongFormMap.getInt("mrId"));
		yaoJiKuCunFormMap.put("mrName", yaoJiLingYongFormMap.getStr("muName"));
		yaoJiKuCunFormMap.put("mrBrand", yaoJiLingYongFormMap.getStr("muBrand"));
		yaoJiKuCunFormMap.put("mrPage", yaoJiLingYongFormMap.getInt("muPage"));
		yaoJiKuCunFormMap.put("mrStandard", yaoJiLingYongFormMap.getStr("muStandard"));
		yaoJiKuCunFormMap.put("mrPrice", yaoJiLingYongFormMap.getFloat("muPrice"));
		yaoJiKuCunFormMap.put("mrNumber", yaoJiLingYongFormMap.getInt("muQuantity"));
		yaoJiKuCunFormMap.put("mrUnit", yaoJiLingYongFormMap.getStr("muUnit"));
		yaoJiKuCunFormMap.put("mrManufactureDate", yaoJiLingYongFormMap.getTimestamp("muManufactureDate"));
		yaoJiKuCunFormMap.put("mrProductCompany", yaoJiLingYongFormMap.getStr("muProductCompany"));
		yaoJiKuCunFormMap.put("mrDrug", yaoJiLingYongFormMap.getInt("muDrug"));
		yaoJiKuCunFormMap.put("mrWLNo", yaoJiLingYongFormMap.getInt("muWLNo"));
		yaoJiKuCunFormMap.put("mrDataOperator", session.getAttribute("userSessionId"));
	}
}
