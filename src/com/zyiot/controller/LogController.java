package com.zyiot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.entity.LogFormMap;
import com.zyiot.server.LogServerI;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.MyPage;

@Controller
@RequestMapping("log")
public class LogController extends BaseController {
	@Autowired
	LogServerI logServer;

	@RequestMapping("listUI")
	public String listUI() {
		return Common.BACKGROUND_PATH + "/log/list";
	}

	@RequestMapping("findByPage")
	@ResponseBody
	public MyPage<LogFormMap> findByPage(int page, int rows) {
		LogFormMap logFormMap = getFormMap(LogFormMap.class);
		List<LogFormMap> log = logServer.findByPage(logFormMap, rows, page);
		for(LogFormMap l:log){
			l.put("operTime", DateUtils.dateFormatToLong(l.getTimestamp("operTime")));
		}
		return toMyPage(log);
	}
}
