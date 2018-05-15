package com.zyiot.tag;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.zyiot.util.TreeObject;

public class ResourcesTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	private static final  String[] CNUM ={"一级菜单","二级菜单","三级菜单","五级菜单","六级菜单","七级菜单","八级菜单","九级菜单"};
	private List<TreeObject> menuList=new ArrayList<TreeObject>();
	private int maxDeepNum=0;
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
		    if(menuList==null&&menuList.size()<=0){
				out.println("未查到任何菜单信息！");
				return SKIP_BODY;
		    }
		   doMaxDeepNum(menuList,1);
		 out.println("<table id=\"mytable\" cellspacing=\"0\" summary=\"The technical specifications of the Apple PowerMac G5 series\">");
		 recursiveObj(menuList,out,"0");
		}catch(Exception e){
			new JspException(e.getMessage());
		}
		return SKIP_BODY;
	}
	@Override
	public void release() {
		super.release();
		this.menuList=null;
	}
	/**
	 * 获取TreeObject深度
	 * @param list
	 * @param temp
	 */
	private void doMaxDeepNum(List<TreeObject> list,int temp){
		if(list==null) return ;
		if(maxDeepNum<temp)
				maxDeepNum=temp;
		for(TreeObject to:list){
			if(hasChild(to)){
				doMaxDeepNum(to.getChildren(),temp+1);
			}
		}
		
	}
	
private void recursiveObj(List<TreeObject> list,JspWriter out,String pids) throws Exception{
		
		for(TreeObject t1 :list){
			out.println("<tr>");
			out.println(" <th scope=\"row\" abbr=\"L2 Cache\" class=\"specalt\">");
			out.println("<input type=\"checkbox\" name=\"resId\" id=\"menu_"+t1.getId()+"\" _key=\""+pids+"\"  onclick=\"smenu(this,'"+t1.getId()+"')\" value=\""+t1.getId()+"\">");
			out.println(t1.getName());
			out.println("</th>");
			if(hasChild(t1)){
				out.println("<th scope=\"row\" abbr=\"L2 Cache\" class=\"specalt\">");
				out.println("<table id=\"mytable\" cellspacing=\"0\" summary=\"The technical specifications of the Apple PowerMac G5 series\" style=\"width: 100%;height: 100%;\">");
				recursiveObj(t1.getChildren(),out,pids+","+t1.getId());
				out.println("</table>");
				out.println("</th>");
         		   
			}
			
			
		}
		
	}
	
	
	private boolean hasChild(TreeObject to){
		if(to!=null&&to.getChildren().size()>0) return true;
		return false;
	}

}
