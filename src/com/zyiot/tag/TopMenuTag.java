package com.zyiot.tag;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.zyiot.util.TreeObject;

/**
 * 
 * 生成顶部导航 <mt:showTopMenu ctx="${pageContext.servletContext.contextPath}"
 * menuList="${list}"/>
 */
public class TopMenuTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private List<TreeObject> menuList = new ArrayList<TreeObject>();
	private String ctx = new String();
	private int count = 0;

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
			for (TreeObject t1 : menuList) {
				int temp = count;
				out.println("<div class=\"btn-group pull-letf\">");
				out.println("<button class=\"btn btn-default dropdown-toggle\" data-toggle=\"dropdown\">");
				count = count + 1;
				out.println("<i class=\""
						+ ((t1.getIcon() != null && !t1.getIcon().equals("")) ? t1
								.getIcon() : "glyphicon glyphicon-list")
						+ "\"	></i><span class=\"hidden-sm hidden-xs\">"
						+ t1.getName() + "</span><span class=\"caret\"></span>");
				out.println("  </button>");
				if (hasChild(t1)) {
					recursiveObj(t1.getChildren(), out, "");

				} else {
					out.println("<li><a href=\"javascript:void(0)\" onclick=\"onloadUrl(this,'"
							+ getCtx()
							+ "/"
							+ t1.getResUrl()
							+ "')\" >"
							+ t1.getName() + "</a>");
				}
				out.println("</div>");
			}

			// recursiveObj(menuList, out);
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
		this.count = 0;
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
	private void recursiveObj(List<TreeObject> list, JspWriter out,
			String reskey) throws Exception {
		int temp = count;
		out.println("<ul class=\"dropdown-menu" + reskey + "\">");
		for (TreeObject t1 : list) {
			if (hasChild(t1)) {
				out.println("<li><a href=\"javascript:void(0)\" data-toggle=\"dropdown"
						+ temp + "\">" + t1.getName() + "</a>");
				count = count + 1;
				recursiveObj(t1.getChildren(), out, temp + "");

			} else {
				out.println("<li><a href=\"javascript:void(0)\" onclick=\"onloadUrl(this,'"
						+ getCtx()
						+ "/"
						+ t1.getResUrl()
						+ "')\" >"
						+ t1.getName() + "</a>");

			}
		}
		out.print("</ul>");
	}
}
