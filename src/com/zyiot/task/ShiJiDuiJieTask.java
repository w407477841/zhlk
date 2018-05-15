package com.zyiot.task;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.zyiot.server.ChuanGanQiDataServerI;
import com.zyiot.server.StorageServerI;
import com.zyiot.server.dataDocking.DataDockingServerI;
import com.zyiot.server.weight.ReportHarborServerI;
import com.zyiot.util.PropertiesUtils;

@Component
@Lazy(false)
public class ShiJiDuiJieTask {
	Logger log = Logger.getLogger(ShiJiDuiJieTask.class);
	@Autowired
	ChuanGanQiDataServerI chuanGanQiDataServer;
	@Autowired
	DataDockingServerI dataDockingServer;
	@Autowired
	StorageServerI storageServer;

	@Autowired
	ReportHarborServerI reportHarborServer;

	public void upload() throws Exception {
		String qiti_open = PropertiesUtils.getPropertyByName(
				"shijiduijie.properties").getProperty("qiti_open");
		String yaoji_open = PropertiesUtils.getPropertyByName(
				"shijiduijie.properties").getProperty("yaoji_open");
		String churuku_open = PropertiesUtils.getPropertyByName(
				"shijiduijie.properties").getProperty("churuku_open");
		String churuku__new_open = PropertiesUtils.getPropertyByName(
				"shijiduijie.properties").getProperty("churuku__new_open");
		String kucun_open = PropertiesUtils.getPropertyByName(
				"shijiduijie.properties").getProperty("kucun_open");
		String liangqing_open = PropertiesUtils.getPropertyByName(
				"shijiduijie.properties").getProperty("liangqing_open");
		String shebei_open = PropertiesUtils.getPropertyByName(
				"shijiduijie.properties").getProperty("shebei_open");
		if (qiti_open != null && !qiti_open.equals("") && qiti_open.equals("1")) {
			try {
				chuanGanQiDataServer.upDatas();
			} catch (Exception e) {
				log.error("传感器上传失败" + e.getMessage());
			}
		}
		if (yaoji_open != null && !yaoji_open.equals("")
				&& yaoji_open.equals("1")) {
			try {
				dataDockingServer.DrugDataDocking();
			} catch (Exception e) {
				log.error("药剂上传失败" + e.getMessage());
			}
		}
		if (churuku_open != null && !churuku_open.equals("")// 老版
				&& churuku_open.equals("1")) {
			try {
				storageServer.dataTransfer();
			} catch (Exception e) {
				log.error("出入库上传失败" + e.getMessage());
			}
		}

		if (churuku__new_open != null && !churuku__new_open.equals("")// 新版
				&& churuku__new_open.equals("1")) {
			try {
				reportHarborServer.shijiduijie();
			} catch (Exception e) {
				log.error("出入库上传失败" + e.getMessage());
			}
		}

		if (kucun_open != null && !kucun_open.equals("")
				&& kucun_open.equals("1")) {
			try {
				storageServer.dataInstanceTransfer();
			} catch (Exception e) {
				log.error("库存上传失败" + e.getMessage());
			}
		}
		if (liangqing_open != null && !liangqing_open.equals("")
				&& liangqing_open.equals("1")) {
			log.error("粮情上传开始");
			try {
				int count = dataDockingServer.WarehouseInfoDataDocking();
				log.error("粮情上传:"+count);
			} catch (Exception e) {
				log.error("粮情上传失败" + e.getMessage());
			}
			log.error("粮情上传结束");
		}
		if (shebei_open != null && !shebei_open.equals("")
				&& shebei_open.equals("1")) {
			try {
				dataDockingServer.equipmentDataDocking();
			} catch (Exception e) {
				log.error("设备上传失败" + e.getMessage());
			}
		}
	}

}
