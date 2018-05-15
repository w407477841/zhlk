package com.zyiot.server;

import com.zyiot.entity.CommonsFileFormMap;

public interface CommonsFileServerI {
	public int saveFileMsg(CommonsFileFormMap m);
	public CommonsFileFormMap queryFile(String id);
}
