package com.zyiot.controller.liangqingjiankong;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.controller.BaseController;
import com.zyiot.entity.TemperatureAlarmFormMap;
import com.zyiot.server.TemperatureAlarmServerI;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.MyPage;
import com.zyiot.util.PropertiesUtils;

@Controller
@RequestMapping("wendubaojingshezhi")
public class WenDuBaoJingSheZhiController extends BaseController {
	@Autowired
	private TemperatureAlarmServerI temperatureAlarmServer;
	
	@RequestMapping("listUI")
	public String listUI(Model model) {
		String alarm = PropertiesUtils.getPropertyByName("qitibaojing.properties").getProperty("t_alarm");
		model.addAttribute("alarm", alarm);
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/liangqingjiankong/wendubaojingshezhilist";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<TemperatureAlarmFormMap> findByPage(int page, int rows) {
		TemperatureAlarmFormMap temperatureAlarm = getFormMap(TemperatureAlarmFormMap.class);
		
		List<TemperatureAlarmFormMap> lists = temperatureAlarmServer.findByPage(temperatureAlarm, rows, page);
		for(TemperatureAlarmFormMap temp:lists){
			temp.set("cjsj", DateUtils.dateFormatToLong(temp.getDate("cjsj")));
			temp.set("alarmDate", DateUtils.dateFormatToLong(temp.getDate("alarmDate")));
		}
		return toMyPage(lists);
	}

	@RequestMapping("setMaxTemperature")
	@ResponseBody
	public String setMaxTemperature(){
		String maxTem = getPara("maxTemp");
		if(!Common.isEmpty(maxTem)){
			PropertiesUtils.modifyByName("qitibaojing", "t_alarm", maxTem);
		}
		return SUCCESS;
	}
	@RequestMapping("lookUI")
	public String lookUI(Model model){
		String id = getPara("id");
		TemperatureAlarmFormMap temperatureAlarmFormMap = temperatureAlarmServer.findTemperatureAlarmById(id);
		
		temperatureAlarmFormMap.set("cjsj", DateUtils.dateFormatToLong(temperatureAlarmFormMap.getDate("cjsj")));
		temperatureAlarmFormMap.set("alarmDate", DateUtils.dateFormatToLong(temperatureAlarmFormMap.getDate("alarmDate")));
		
		String position = temperatureAlarmFormMap.getStr("position").trim();
		String[] arr = position.split(";");
		StringBuffer result = new StringBuffer();
		for(int i = 0;i<arr.length;i++){
			String str = arr[i];
			result.append(str);
			result.append("\t\t");
			if(i%3 == 2){
				result.append("\r\n");				
			}
		}
		temperatureAlarmFormMap.set("alarmNum", arr.length);
		temperatureAlarmFormMap.set("position", result.toString());
		
		model.addAttribute("temperatureAlarmFormMap", temperatureAlarmFormMap);
		return Common.BACKGROUND_PATH
				+ "/cangkuzhinenghuaxitong/liangqingjiankong/wendubaojingshezhilook";
	}
}
