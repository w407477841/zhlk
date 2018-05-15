package com.zyiot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zyiot.server.CommonsFileServerI;

@Controller
@RequestMapping("/commonsFileManager")
public class CommonsFileController extends BaseController{
	@Autowired
	private CommonsFileServerI fileManager;
}
