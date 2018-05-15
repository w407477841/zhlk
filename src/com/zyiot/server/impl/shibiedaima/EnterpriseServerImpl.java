package com.zyiot.server.impl.shibiedaima;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.shibiedaima.EnterpriseFormMap;
import com.zyiot.entity.shibiedaima.InRegisterFormMap;
import com.zyiot.entity.shibiedaima.OutRegisterFormMap;
import com.zyiot.mapper.shibiedaima.EnterpriseMapper;
import com.zyiot.server.shibiedaima.EnterpriseServerI;

@Service("enterpriseServer")
public class EnterpriseServerImpl implements EnterpriseServerI {
	@Autowired
	EnterpriseMapper enterpriseMapper;

	public List<EnterpriseFormMap> findByPage(EnterpriseFormMap m,
			int paseSize, int pageNum) {
		PageHelper.startPage(pageNum, paseSize);
		return enterpriseMapper.findByPage(m);
	}

	public EnterpriseFormMap findById(String id) {
		return enterpriseMapper.findById(id, EnterpriseFormMap.class);
	}

	@SystemLog(module = "识别代码", methods = "企业管理/新增", description = "成功")
	public void add(EnterpriseFormMap m) throws Exception {
		enterpriseMapper.addEntity(m);
	}

	@SystemLog(module = "识别代码", methods = "企业管理/修改", description = "成功")
	public void edit(EnterpriseFormMap m) throws Exception {
		enterpriseMapper.updateEntity(m);
	}

	@SystemLog(module = "识别代码", methods = "企业管理/删除", description = "成功")
	public void delete(String id) throws Exception {
		enterpriseMapper.deleteEntityByKey("id", id, EnterpriseFormMap.class);
	}

	@Override
	public List<InRegisterFormMap> findInFormByPage(InRegisterFormMap m,
			int paseSize, int pageNum) {
		PageHelper.startPage(pageNum, paseSize);
		return enterpriseMapper.findInFormByPage(m);
	}

	@Override
	public InRegisterFormMap findInFormById(String id) {
		return enterpriseMapper.findById(id, InRegisterFormMap.class);
		}
	@Override
	public InRegisterFormMap findOneInForm(String id) {
		return enterpriseMapper.findOneInForm(id) ;
		}

	@Override
	public void addInForm(InRegisterFormMap m) throws Exception {
		enterpriseMapper.addEntity(m);
		}

	@Override
	public void editInForm(InRegisterFormMap m) throws Exception {
		enterpriseMapper.updateEntity(m);
		}

	@Override
	public void deleteInForm(InRegisterFormMap m) throws Exception {
		enterpriseMapper.deleteEntityByNames(m);
		}

	@Override
	public List<OutRegisterFormMap> findOutFormByPage(OutRegisterFormMap m,
			int paseSize, int pageNum) {
		PageHelper.startPage(pageNum, paseSize);
		return enterpriseMapper.findOutFormByPage(m);
	}

	@Override
	public OutRegisterFormMap findOutFormById(String id) {
		return enterpriseMapper.findById(id, OutRegisterFormMap.class);
		}

	@Override
	public void addOutForm(OutRegisterFormMap m) throws Exception {
		enterpriseMapper.addEntity(m);
		}

	@Override
	public void editOutForm(OutRegisterFormMap m) throws Exception {
		enterpriseMapper.updateEntity(m);
		}

	@Override
	public void deleteOutForm(OutRegisterFormMap m) throws Exception {
		enterpriseMapper.deleteEntityByNames(m);
		}

}
