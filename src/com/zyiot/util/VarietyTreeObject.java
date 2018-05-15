package com.zyiot.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 品种信息
 * @author Lip
 * @date 2017年4月26日 上午9:44:48
 */
public class VarietyTreeObject{
	private Integer id;
	private Integer parentId;
	private String text;
	private String definedText;
	private Float salePrice;
	private Float buyPrice;
	private Float rankPrice;
	private String isEnable;
	private List<VarietyTreeObject> children = new ArrayList<VarietyTreeObject>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getDefinedText() {
		return definedText;
	}
	public void setDefinedText(String definedText) {
		this.definedText = definedText;
	}
	public Float getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(Float salePrice) {
		this.salePrice = salePrice;
	}
	public Float getBuyPrice() {
		return buyPrice;
	}
	public void setBuyPrice(Float buyPrice) {
		this.buyPrice = buyPrice;
	}
	public Float getRankPrice() {
		return rankPrice;
	}
	public void setRankPrice(Float rankPrice) {
		this.rankPrice = rankPrice;
	}
	public String getIsEnable() {
		return isEnable;
	}
	public void setIsEnable(String isEnable) {
		this.isEnable = isEnable;
	}
	public List<VarietyTreeObject> getChildren() {
		return children;
	}
	public void setChildren(List<VarietyTreeObject> children) {
		this.children = children;
	}
	
}
