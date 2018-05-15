package com.zyiot.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zyiot.server.StorageServerI;

@Controller
@RequestMapping("transfer")
public class DataTransferController extends BaseController {
	@Autowired
	StorageServerI server;

	/**
	 * 初始化存粮
	 */

	@RequestMapping("test")
	@ResponseBody
	public String initStore() {
		
		try {
			server.dataTransfer();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}


}
