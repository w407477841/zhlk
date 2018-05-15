package com.zyiot.server.impl.weight;

import java.sql.Timestamp;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyiot.entity.weight.PropertyFormMap;
import com.zyiot.mapper.weight.PropertyMapper;
import com.zyiot.server.weight.PropertyServerI;
import com.zyiot.util.Constant;
@Service("propertyServer")
public class PropertyServerImpl implements PropertyServerI {
	@Autowired
	private PropertyMapper propertyMapper;
	@Override
	@Transactional(readOnly=false)
	public void editPropertyFormMap(PropertyFormMap propertyFormMap)
			throws Exception {
		PropertyFormMap base = propertyMapper.findById(propertyFormMap.getStr("id"), PropertyFormMap.class);
		
		propertyFormMap.set(Constant.VERSION, base.getInt(Constant.VERSION)+1);
		propertyMapper.updateEntity(propertyFormMap);
		
		addOperatorLog(base, "update");
	}

	@Override
	public List<PropertyFormMap> findAllProperty() {
		return propertyMapper.findAllProperty();
	}

	@Override
	public List<PropertyFormMap> findEnableProperty() {
		return propertyMapper.findEnableProperty();
	}
	
	private void addOperatorLog(PropertyFormMap propertyFormMap,String type) throws Exception{
		Session session = SecurityUtils.getSubject().getSession();
		String sql = (String) session.getAttribute("sql_str");
		sql = sql.replace("'", "\"");
		propertyFormMap.set(Constant.ENTITY_TABLE, "t_weight_grain_property_his");
		propertyFormMap.set("execSQL", sql);
		propertyFormMap.set("execUser", session.getAttribute("userSessionId"));
		propertyFormMap.set("execType", type);
		propertyFormMap.set("execDate", new Timestamp(System.currentTimeMillis()));
		propertyMapper.addEntity(propertyFormMap);
	}
}
