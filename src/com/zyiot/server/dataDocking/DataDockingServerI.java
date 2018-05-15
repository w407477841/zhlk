package com.zyiot.server.dataDocking;

public interface DataDockingServerI {
	/**
	 * 粮情数据对接
	 * @return 返回上传数据条数  。0:无数据需要上传，-1：数据上传异常
	 * @throws Exception 数据上传失败错误代码
	 */
	public int WarehouseInfoDataDocking() throws Exception;
	
	/**
	 * 药剂管理数据对接
	 * @return 返回上传数据条数  。0:无数据需要上传，-1：数据上传异常
	 * @throws Exception 数据上传失败错误代码
	 */
	public int DrugDataDocking() throws Exception;
	
	/**
	 * 设备数据对接
	 * @return 返回上传数据条数  。0:无数据需要上传，-1：数据上传异常
	 * @throws Exception 数据上传失败错误代码
	 */
	public int equipmentDataDocking() throws Exception;
}
