package com.zyiot.server.impl.weight;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.weight.SupplierFormMap;
import com.zyiot.mapper.weight.SupplierMapper;
import com.zyiot.server.weight.SupplierServerI;
import com.zyiot.util.Constant;
@Service("supplierServer")
public class SupplierServerImpl implements SupplierServerI {
	@Autowired
	private SupplierMapper supplierMapper;
	@Override
	@SystemLog(module="供应商管理",methods="添加",description="添加成功")
	public void addSupplier(SupplierFormMap supplierFormMap) throws Exception {
		supplierMapper.addEntity(supplierFormMap);
	}

	@Override
	@SystemLog(module="供应商管理",methods="修改",description="修改成功")
	@Transactional(readOnly=false)
	public void editSupplier(SupplierFormMap supplierFormMap) throws Exception {
		SupplierFormMap supplier = supplierMapper.findSupplierById(Integer.parseInt(supplierFormMap.getStr("id")));
		
		if(supplier.getInt(Constant.VERSION) == Integer.parseInt(supplierFormMap.getStr(Constant.VERSION))){
			supplierFormMap.set(Constant.VERSION, supplier.getInt(Constant.VERSION)+1);
			
			supplierMapper.updateEntity(supplierFormMap);
			addOperatorLog(supplier, "update");
		}else{
			throw new Exception("[数据已被修改]");
		}
	}

	@Override
	@SystemLog(module="供应商管理",methods="删除",description="删除成功")
	@Transactional(readOnly=false)
	public void dropSupplier(String id) throws Exception {
		SupplierFormMap supplier = supplierMapper.findSupplierById(Integer.parseInt(id));
		
		supplierMapper.deleteEntityByKey("id", id, SupplierFormMap.class);
		addOperatorLog(supplier, "delete");
	}

	@Override
	public SupplierFormMap findSupplierById(int id) {
		return supplierMapper.findSupplierById(id);
	}

	@Override
	public List<SupplierFormMap> findByPage(SupplierFormMap supplierFormMap,
			int pageSize, int pageNum) {
		PageHelper.startPage(pageNum, pageSize);
		return supplierMapper.findByPage(supplierFormMap);
	}
	
	private void addOperatorLog(SupplierFormMap supplierFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		supplierFormMap.set(Constant.ENTITY_TABLE, "t_weight_supplier_his");
		supplierFormMap.set("execSQL", sql);
		supplierFormMap.set("execUser", session.getAttribute("userSessionId"));
		supplierFormMap.set("execType", type);
		supplierFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		supplierMapper.addEntity(supplierFormMap);
	}

	@Override
	public List<SupplierFormMap> findSupplierByIDCardOrPhone(String param) {
		return supplierMapper.findSupplierByIDCardOrPhone(param);
	}
}
