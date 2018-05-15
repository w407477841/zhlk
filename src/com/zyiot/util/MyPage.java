package com.zyiot.util;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class MyPage<T> implements Serializable{
	private static final long serialVersionUID = 1L;
	List<T> rows=new ArrayList<T>();
	private  int pageSize=10;
	private int pageNum=1;
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
	private long total;

	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}

	
}
