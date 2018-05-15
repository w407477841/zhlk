package com.zyiot.tag;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.zyiot.util.Common;
import com.zyiot.util.TreeObject;

/**
 * 
 * 左侧菜单标签
 * 
 * 用于生成左侧菜单
 * 
 */
public class MenuTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	private List<TreeObject> menuList = new ArrayList<TreeObject>();
	private String ctx = new String();

	public String getCtx() {
		return ctx;
	}

	public void setCtx(String ctx) {
		this.ctx = ctx;
	}

	public List<TreeObject> getMenuList() {
		return menuList;
	}

	public void setMenuList(List<TreeObject> menuList) {
		this.menuList = menuList;
	}

	@Override
	public int doStartTag() throws JspException {
		try {
			JspWriter out = this.pageContext.getOut();
			if (menuList == null) {
				out.println("该用户为分配任何权限");
				return SKIP_BODY;
			}
			out.println("<ul class=\"nav nav-pills nav-stacked main-menu\">");
			out.println(" <li data-name=\"主 页\"><a  id=\"home_a\" href=\"javascript:void(0)\" onclick=\"onloadUrl(this,'"
					+ getCtx()
					+ "/welcome.shtml')\"><i class=\"glyphicon glyphicon-home\"></i><span>主页</span></a> </li>");
			recursiveObj(menuList, out);
		} catch (Exception e) {
			new JspException(e.getMessage());
		}

		return SKIP_BODY;
	}

	@Override
	public int doEndTag() throws JspException {
		return EVAL_PAGE;
	}

	@Override
	public void release() {
		super.release();
		this.menuList = null;
		this.ctx = null;
	}

	private boolean hasChild(TreeObject to) {
		if (to != null && to.getChildren().size() > 0)
			return true;
		return false;
	}

	/**
	 * 递归tree对象
	 * 
	 * @param to
	 * @throws Exception
	 */
	private void recursiveObj(List<TreeObject> list, JspWriter out)
			throws Exception {

		for (TreeObject t1 : list) {
			if (hasChild(t1)) {
				out.println("<li class=\"accordion\" data-name=\""
						+ t1.getName() + "\">");
				out.println("<a href=\"javascript:void(0)\"  onclick=\"changeClass(this)\"><i class=\"glyphicon glyphicon-plus\"></i><span>&nbsp;"
						+ t1.getName() + "</span></a>");
				out.println("<ul class=\"nav nav-pills nav-stacked\">");
				recursiveObj(t1.getChildren(), out);
				out.print("</ul>");
				out.print("</li>");

			} else {
				String icon = t1.getIcon();
				if(Common.isEmpty(icon)){
					icon = "fa fa-tasks";
				}
				out.println("<li data-name=\""
						+ t1.getName()
						+ "\"><a href=\"javascript:void(0)\" onclick=\"onloadUrl(this,'"
						+ getCtx() + "/" + t1.getResUrl() + "')\"><i class=\""
						+ icon + "\"></i><span>&nbsp;" + t1.getName()
						+ "</span></a></li>");
			}

		}

	}

}
