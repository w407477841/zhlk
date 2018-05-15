package com.zyiot.interceptor;

import java.lang.reflect.Method;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.zyiot.annotation.Token;
/**
 * 
 * @author Administrator
 *避免重复提交拦截器
 *在提交一个页面跳转的action时，服务器端会生成一个token存在session中并在跳转后的页面上也带上这个token
 *在提交form时，会判断token值，然后更新token
 *
 */

public class TokenInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		 
		  if (handler instanceof HandlerMethod) {
	            HandlerMethod handlerMethod = (HandlerMethod) handler;
	            Method method = handlerMethod.getMethod();
	            Token annotation = method.getAnnotation(Token.class);
	            if (annotation != null) {
	                boolean needSaveSession = annotation.save();
	                if (needSaveSession) {
	                    request.getSession(false).setAttribute("token", UUID.randomUUID().toString());
	                }
	                boolean needRemoveSession = annotation.remove();
	                if (needRemoveSession) {
	                    if (isRepeatSubmit(request)) {
	                        return false;
	                    }
	                    request.getSession(false).removeAttribute("token");
	                }
	            }
	            return true;
	        } else {
	            return super.preHandle(request, response, handler);
	        }
	}
	
	
	 private boolean isRepeatSubmit(HttpServletRequest request) {
	        String serverToken = (String) request.getSession(false).getAttribute("token");
	        if (serverToken == null) {
	            return true;
	        }
	        String clinetToken = request.getParameter("token");
	        if (clinetToken == null) {
	            return true;
	        }
	        if (!serverToken.equals(clinetToken)) {
	            return true;
	        }
	        return false;
	    }
}
