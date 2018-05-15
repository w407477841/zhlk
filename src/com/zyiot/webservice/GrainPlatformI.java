package com.zyiot.webservice;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public interface GrainPlatformI {
	/**
	 * 
	 * @param jsonData
	 *            上传数据
	 * @param checkData
	 *            byte[]长度
	 * @param dataType
	 *            类型
	 * @param orgCode
	 *            库点编码
	 * 
	 * @return
	 */
	@WebMethod
	public int saveOrUpdateDate(byte[] jsonData, String checkData,
			int dataType, String orgCode);

}
