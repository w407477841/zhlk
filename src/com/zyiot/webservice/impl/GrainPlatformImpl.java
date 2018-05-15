package com.zyiot.webservice.impl;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.jws.WebService;
import javax.servlet.ServletContext;

import net.sf.json.JSONArray;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zyiot.entity.StorageInfoFormMap;
import com.zyiot.entity.WarehouseInfoFormMap;
import com.zyiot.server.StoreInfoServerI;
import com.zyiot.server.WarehouseInfoServerI;
import com.zyiot.util.MapUtil;
import com.zyiot.webservice.GrainPlatformI;

@WebService
public class GrainPlatformImpl implements GrainPlatformI {
	StoreInfoServerI storeInfoServer;
	WarehouseInfoServerI warehouseInfoServer;

	public GrainPlatformImpl(ServletContext sc) {
		WebApplicationContext wc = WebApplicationContextUtils
				.getWebApplicationContext(sc);
		wc.getBean("storeInfoServer");

		this.storeInfoServer = (StoreInfoServerI) wc.getBean("storeInfoServer");
		this.warehouseInfoServer = (WarehouseInfoServerI) wc
				.getBean("warehouseInfoServer");
	}

	/**
	 * 0 成功
	 */
	public int saveOrUpdateDate(byte[] jsonData, String checkData,
			int dataType, String orgCode) {

		String dataStr = null;
		try {
			dataStr = new String(jsonData, "UTF-8");

			if (!checkDate(dataStr, checkData)) {
				return 30;
			}

		} catch (UnsupportedEncodingException e1) {
			return 99;
		}
		JSONArray json = JSONArray.fromObject(dataStr);
		// 粮情
		if (dataType == 4) {
			try {
				List<WarehouseInfoFormMap> wiList = (List<WarehouseInfoFormMap>) JSONArray
						.toCollection(json, WarehouseInfoFormMap.class);

				for (WarehouseInfoFormMap m : wiList) {
					MapUtil.sysoMapKeyAndVal(m);
				}

				saveOrUpdateLiangQing(wiList);
			} catch (Exception e) {
				return 99;
			}
		}
		// 实时库存
		if (dataType == 2) {

			List<StorageInfoFormMap> wiList = (List<StorageInfoFormMap>) JSONArray
					.toCollection(json, StorageInfoFormMap.class);

			for (StorageInfoFormMap m : wiList) {
				MapUtil.sysoMapKeyAndVal(m);
			}

			try {
				saveOrUpdateShiShiKuCun(wiList);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				return 99;
			}

		}
		return 0;
	}

	private boolean checkDate(String d, String l) {
		if (l.equals(d.getBytes().length + ""))
			return true;

		return false;
	}

	/**
	 * 数据格式 ：wDate 日期; wTime 时间 ;wTemperature 仓内温度;gTemperature 仓外温度;wHumidity
	 * 仓内湿度;gHumidity 仓外湿度 ;wCoordinate 温度数据;wWarehouse 仓库编号; cjsj 采集时间 例子
	 * "[{wDate:'20161214',wTime:'095726',wTemperature:'11.2',gTemperature:'10.6',wHumidity:'72',gHumidity:'62',wCoordinate:'8.1 8.1 8.5 7.9 8.2 8.2 8.5 8.7 11.2 411.2 8.5 9.3 8.3 10.2 8.2 8.8 8.4 9.6 11.3 8.1 8.8 8.8 8.7 8.8 8.1 8.2 411.2 411.2 411.2 9.3 8.8 8.3 8.7 8.2 8.2 8.9 9.5 8.4 9.3 411.2 9.3 8.0 10.1 9.2 9.2 8.9 8.8 8.3 11.5 8.3 8.3 8.2 8.3 11.2 8.3 8.2 411.2 411.2 411.2 8.2 9.0 9.5 8.4 8.3 9.5 8.7 9.2 8.4 8.3 411.2 8.5 8.4 8.3 8.5 10.2 8.5 9.1 8.3 11.5 10.9 8.4 9.3 8.6 11.5 10.0 8.0 411.2 411.2 411.2 8.2 8.1 9.4 8.5 10.0 8.3 8.2 8.4 11.4 8.5 411.2 8.1 9.3 8.2 8.3 10.3 8.3 8.8 8.4 11.2 11.0 8.2 8.2 8.4 11.3 9.8 8.1 411.2 411.2 411.2 10.9',wDisable:'1',wWarehouse:'33',cjsj:'2016-12-14 09:57:26'}]"
	 * 
	 * @param l
	 * @throws Exception
	 */
	private void saveOrUpdateLiangQing(List<WarehouseInfoFormMap> l)
			throws Exception {
		warehouseInfoServer.batchSave(l);
	}

	/**
	 * 数据格式 name 粮食品种; code 货位号;quanZhong 粮食性质;cangKu 库存数量;storageID 仓库编码;source
	 * 库点编码
	 * 
	 * @param l
	 * @throws Exception
	 */
	private void saveOrUpdateShiShiKuCun(List<StorageInfoFormMap> l)
			throws Exception {
		storeInfoServer.batchSaveStorageInfo(l);
	}

}
