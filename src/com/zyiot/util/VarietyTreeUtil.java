package com.zyiot.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
/**
 * 品种菜单树
 * @author Admin
 * @date 2017年4月26日 上午9:54:16
 */
public class VarietyTreeUtil {
	/**
	 * 根据父节点的ID获取所有子节点
	 * 
	 * @param list
	 *            分类表
	 * @param typeId
	 *            传入的父节点ID
	 * @return String
	 */
	public List<VarietyTreeObject> getChildVarietyTreeObjects(List<VarietyTreeObject> list,
			int praentId) {
		List<VarietyTreeObject> returnList = new ArrayList<VarietyTreeObject>();
		for (Iterator<VarietyTreeObject> iterator = list.iterator(); iterator
				.hasNext();) {
			VarietyTreeObject t = (VarietyTreeObject) iterator.next();
			// 一、根据传入的某个父节点ID,遍历该父节点的所有子节点
			if (t.getParentId().equals(praentId)) {
				recursionFn(list, t);
				returnList.add(t);
			}
		}
		return returnList;
	}

	/**
	 * 递归列表 parent1 { child1 ,child2 { child_child1} } parent2 { child1 ,child2
	 * { child_child1} }
	 */
	private void recursionFn(List<VarietyTreeObject> list, VarietyTreeObject t) {
		List<VarietyTreeObject> childList = getChildList(list, t);// 得到子节点列表
		t.setChildren(childList);
		for (VarietyTreeObject tChild : childList) {
			if (hasChild(list, tChild)) {// 判断是否有子节点
				// returnList.add(VarietyTreeObject);
				Iterator<VarietyTreeObject> it = childList.iterator();
				while (it.hasNext()) {
					VarietyTreeObject n = (VarietyTreeObject) it.next();

					recursionFn(list, n);

				}
			}
		}
	}

	// 得到子节点列表
	private List<VarietyTreeObject> getChildList(List<VarietyTreeObject> list, VarietyTreeObject t) {

		List<VarietyTreeObject> tlist = new ArrayList<VarietyTreeObject>();

		if (t.getId() != null && t.getId() == 0)
			return tlist;
		Iterator<VarietyTreeObject> it = list.iterator();
		while (it.hasNext()) {
			VarietyTreeObject n = (VarietyTreeObject) it.next();
			if (n.getParentId().equals(t.getId())) {
				tlist.add(n);
			}
		}
		return tlist;
	}

	List<VarietyTreeObject> returnList = new ArrayList<VarietyTreeObject>();

	/**
	 * 根据父节点的ID获取所有子节点 parent1 child1 child2 child2_child1 parent2 child2
	 */
	public List<VarietyTreeObject> getChildVarietyTreeObjects(List<VarietyTreeObject> list,
			int typeId, String prefix) {
		if (list == null)
			return null;
		for (Iterator<VarietyTreeObject> iterator = list.iterator(); iterator
				.hasNext();) {
			VarietyTreeObject node = (VarietyTreeObject) iterator.next();
			// 一、根据传入的某个父节点ID,遍历该父节点的所有子节点

			if (node.getParentId().equals(typeId)) {

				if (node.getId() != 0) {
					recursionFn(list, node, prefix);
				}
			}
			// 二、遍历所有的父节点下的所有子节点
			/*
			 * if (node.getParentId()==0) { recursionFn(list, node); }
			 */
		}
		return returnList;
	}

	private void recursionFn(List<VarietyTreeObject> list, VarietyTreeObject node, String p) {
		List<VarietyTreeObject> childList = getChildList(list, node);// 得到子节点列表
		if (hasChild(list, node)) {// 判断是否有子节点
			returnList.add(node);
			Iterator<VarietyTreeObject> it = childList.iterator();
			while (it.hasNext()) {
				VarietyTreeObject n = (VarietyTreeObject) it.next();
				//n.setName(p + n.getName());
				recursionFn(list, n, p + p);
			}
		} else {
			returnList.add(node);
		}
	}

	// 判断是否有子节点
	private boolean hasChild(List<VarietyTreeObject> list, VarietyTreeObject t) {
		return getChildList(list, t).size() > 0 ? true : false;
	}
}
