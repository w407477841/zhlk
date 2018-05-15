package com.zyiot.server.shibiedaima;

import java.util.List;

import com.zyiot.entity.shibiedaima.EnterpriseFormMap;
import com.zyiot.entity.shibiedaima.InRegisterFormMap;
import com.zyiot.entity.shibiedaima.OutRegisterFormMap;

public interface EnterpriseServerI {
	List<EnterpriseFormMap> findByPage(EnterpriseFormMap m, int paseSize,
			int pageNum);

	EnterpriseFormMap findById(String id);

	void add(EnterpriseFormMap m) throws Exception;

	void edit(EnterpriseFormMap m) throws Exception;

	void delete(String id) throws Exception;
	
	
	
	
	List<InRegisterFormMap> findInFormByPage(InRegisterFormMap m, int paseSize,
			int pageNum);

	InRegisterFormMap findInFormById(String id);
	
	InRegisterFormMap findOneInForm(String id);

	void addInForm(InRegisterFormMap m) throws Exception;

	void editInForm(InRegisterFormMap m) throws Exception;

	void deleteInForm(InRegisterFormMap m) throws Exception;
	
	List<OutRegisterFormMap> findOutFormByPage(OutRegisterFormMap m, int paseSize,
			int pageNum);

	OutRegisterFormMap findOutFormById(String id);

	void addOutForm(OutRegisterFormMap m) throws Exception;

	void editOutForm(OutRegisterFormMap m) throws Exception;

	void deleteOutForm(OutRegisterFormMap m) throws Exception;
}
