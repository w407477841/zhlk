package com.zyiot.server.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.ictehi.grainplat.service.GrainplatService;
import com.ictehi.grainplat.service.GrainplatServicePortType;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.ChuanGanQiBaoJingFormMap;
import com.zyiot.entity.ChuanGanQiDataFormMap;
import com.zyiot.entity.ChuanGanQiFormMap;
import com.zyiot.entity.WarehouseLocationFormMap;
import com.zyiot.entity.shouchu.StorageFormMap;
import com.zyiot.mapper.ChuanGanQiBaoJingMapper;
import com.zyiot.mapper.ChuanGanQiDataMapper;
import com.zyiot.mapper.StorageMapper;
import com.zyiot.mapper.WarehouseLocationMapper;
import com.zyiot.server.ChuanGanQiDataServerI;
import com.zyiot.util.BatchInsertParameter;

@Service("chuanGanQiDataServer")
public class ChuanGanQiDataServerImpl implements ChuanGanQiDataServerI {
	@Autowired
	ChuanGanQiDataMapper chuanGanQiDataMapper;
	@Autowired
	ChuanGanQiBaoJingMapper baoJingMapper;
	@Autowired
	private StorageMapper mapper;
	@Autowired
	private WarehouseLocationMapper locationMapper;

	@Transactional(readOnly = false)
	@SystemLog(module = "传感器管理", methods = "传感器数据采集", description = "成功")
	public void batchSave(List<ChuanGanQiFormMap> chuanGanQiFormMaps)
			throws Exception {

		chuanGanQiDataMapper.batchSave(BatchInsertParameter
				.wrap(chuanGanQiFormMaps));

	}

	public List<ChuanGanQiDataFormMap> getDatas(ChuanGanQiFormMap chuanGanQiFormMap,int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return chuanGanQiDataMapper.getDatas(chuanGanQiFormMap);
	}

	@Override
	public List<ChuanGanQiDataFormMap> findByPage(
			ChuanGanQiDataFormMap formMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return chuanGanQiDataMapper.findByPage(formMap);
	}

	@Override
	public List<ChuanGanQiDataFormMap> findCangWaiByPage(
			ChuanGanQiDataFormMap formMap, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return chuanGanQiDataMapper.findCangWaiByPage(formMap);
	}

	@Override
	public List<ChuanGanQiBaoJingFormMap> getBaojing(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		return baoJingMapper.getDatas();
	}

	// 查询上次对接最后时间
	//
	@Transactional(readOnly = false)
	@SystemLog(module = "数据对接", methods = "传感器数据上报", description = "成功")
	public void upDatas() throws Exception {
		List<WarehouseLocationFormMap> locations = locationMapper
				.findByAttr(new WarehouseLocationFormMap());
		int size = 0;
		String tableName = "t_chuanganqi_data";
		if (locations == null || (size = locations.size()) <= 0) {
			throw new Exception("未配置库点");
		}
		com.ictehi.grainplat.service.GrainplatService s = new GrainplatService();
		GrainplatServicePortType ss = s.getGrainplatServiceHttpSoap11Endpoint();
		String shibiema = "";
		String daima = "";
		for (int i = 0; i < size; i++) {
			String location = locations.get(i).get("wNo") + "";
			StorageFormMap query = new StorageFormMap();
			query.put("tableName", tableName);
			query.put("location", location);
			StorageFormMap time = mapper.findMaxBasicidInStorage(query);
			String lasttime = null;
			if (time != null) {
				lasttime = time.get("lasttime") + "";
			}
			boolean needAdd = false;
			if (lasttime == null || lasttime.equals("")) {
				lasttime = "2016-01-01 00:00:00";
				needAdd = true;
			}
			ChuanGanQiDataFormMap queryData = new ChuanGanQiDataFormMap();
			queryData.put("cjsj", lasttime);
			queryData.put("location", location);
			List<ChuanGanQiDataFormMap> datas = chuanGanQiDataMapper
					.find_g_lasttime(queryData);
			int datasSize = datas != null ? datas.size() : 0;
			StringBuffer json = new StringBuffer("[");
			for (int index = 0; index < datasSize; index++) {
				ChuanGanQiDataFormMap map = datas.get(index);
				String lxs[] = map.getStr("lx").split(",");
				String cDatas[] = map.getStr("datas").split(",");
				String point = map.get("point") + "";
				String cjsj = map.getStr("cjsj");

				String tongyixinyongdaima = map.getStr("tongyixinyongdaima");
				String kuqubianma = map.getStr("kuqubianma");
				String cangfangbianhao = map.getStr("cangfangbianhao");
				String huoweibianma = map.getStr("huoweibianhao");
				if (index == 0) {
					daima = kuqubianma;
					shibiema = tongyixinyongdaima;
					lasttime = cjsj;
				}
				if (index != 0) {
					json.append(",");
				}
				json.append("{");
				json.append("storehouse:'");
				json.append(cangfangbianhao);
				json.append("',");
				json.append("house:'");
				json.append(huoweibianma);
				json.append("',");
				json.append("time:'");
				json.append(cjsj.replace("-", "").replace(":", "")
						.replace(" ", ""));
				json.append("',");
				json.append("points:[{");
				json.append("point:'");
				json.append(point);
				json.append("'");
				String sPoint = "";
				for (int x = 0; x < lxs.length; x++) {
					sPoint = sPoint + "," + lxs[x] + ":'" + cDatas[x] + "'";

				}
				if (!sPoint.contains("o2")) {
					sPoint = sPoint + ",o2:''";
				}
				if (!sPoint.contains("co2")) {
					sPoint = sPoint + ",co2:''";
				}
				if (!sPoint.contains("h3p")) {
					sPoint = sPoint + ",h3p:''";
				}
				if (!sPoint.contains("n2")) {
					sPoint = sPoint + ",n2:''";
				}
				json.append(sPoint);
				json.append("}]");
				json.append("}");
			}
			json.append("]");
			if (json.length() > 2) {
				System.out.println(json.toString());
				Integer ret = ss.saveOrUpdateGrainDepotInfo(json.toString(),
						json.length() + "", 6, daima, shibiema);
				System.out.println(ret);
				if (ret.intValue() != 0) {
					throw new Exception("上传失败");
				} else {
					time = new StorageFormMap();
					time.put("location", location);
					time.put("tableName", tableName);
					time.put("lasttime", lasttime);
					if (needAdd) {
						mapper.addTimeStamp(time);
					} else {
						mapper.updateTimeStamp(time);
					}

				}
			}
		}

	}

	@Override
	public String getMaxCjsj() {
		return chuanGanQiDataMapper.getMaxCjsj();
	}
}
