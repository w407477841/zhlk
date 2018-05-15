package com.zyiot.task;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.zyiot.controller.cangkuzhinenghuaxitong.AmmeterConfigController;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterConfigFormMap;
import com.zyiot.entity.cangkuzhinenghuaxitong.AmmeterDataFormMap;
import com.zyiot.server.cangkuzhinenghuaxitong.AmmeterConfigServerI;
import com.zyiot.server.cangkuzhinenghuaxitong.AmmeterDataServerI;
import com.zyiot.util.DateUtils;
import com.zyiot.util.MapUtil;

@Component
@Lazy(false)
public class RemoteReadingAmmeters {

	Logger logger = Logger.getLogger(RemoteReadingAmmeters.class);

	@Autowired
	AmmeterConfigServerI ammeterConfigServer;
	@Autowired
	AmmeterDataServerI ammeterDataServer;

	/**
	 * 
	 * 当天抄表数据异常，读数为昨日数据，能耗为0。 抄表正常，读数=抄表数据，能耗为抄表数据-昨日数据 第一次抄表 能耗为抄表数据。
	 * 
	 */
	//@Scheduled(cron = "0 59 23 * * ?")
	public void todo() {
		logger.info("====电表执行======");
		String time = DateUtils.dateFormatToLong(new Date());
		List<AmmeterConfigFormMap> ammeters = ammeterDataServer.findAmmeters();

		List<AmmeterDataFormMap> datas = new ArrayList<>();
		for (AmmeterConfigFormMap ammeter : ammeters) {
			String reading = new AmmeterConfigController().readAmmeterTcp(ammeter);

			String lastReading = ammeter.getStr("reading");
			AmmeterDataFormMap data = new AmmeterDataFormMap();
			data.put("id", UUID.randomUUID().toString().replace("-", ""));
			data.put("ammeter", ammeter.get("id") + "");
			data.put("isError", reading.equals("error") ? 1 : 0);
			data.put("type", 0);
			data.put("acquisitionTime", time);
			if (lastReading == null || lastReading.equals("")) {// 第一次
				if (reading.equals("error")) {// 上次读取异常，本次读取异常
					data.put("energy", "0");
					data.put("reading", "0");// 当天数据错误显示昨天数据
				} else {
					data.put("energy", reading);
					data.put("reading", reading);
				}
			}

			else { // 非第一次
				if (reading.equals("error")) {// 当天error,能耗为0
					data.put("energy", "0");
					data.put("reading", lastReading);
				} else {
					data.put("reading", reading);
					data.put(
							"energy",
							Double.parseDouble(reading)
									- Double.parseDouble(lastReading));
				}
			}

			datas.add(data);
		}
		for (AmmeterDataFormMap data : datas) {
			MapUtil.sysoMapKeyAndVal(data);
		}

		try {
			ammeterDataServer.batchSave(datas);
		} catch (Exception e) {
			logger.error("批量保存失败");
		}

	}

	public static void main(String[] args) {

		System.out.println(UUID.randomUUID().toString().length());

	}
}
