package com.zyiot.mapper.shibiedaima;

import java.util.List;

import com.zyiot.entity.shibiedaima.EnterpriseFormMap;
import com.zyiot.entity.shibiedaima.InRegisterFormMap;
import com.zyiot.entity.shibiedaima.OutRegisterFormMap;
import com.zyiot.mapper.BaseMapper;

public interface EnterpriseMapper extends BaseMapper {

	List<EnterpriseFormMap> findByPage(EnterpriseFormMap m);
	
	List<OutRegisterFormMap> findOutFormByPage(OutRegisterFormMap m);
	
	List<InRegisterFormMap> findInFormByPage(InRegisterFormMap m);
	
	InRegisterFormMap findOneInForm(String id);

}
