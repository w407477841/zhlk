package com.zyiot.aop;

import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.zyiot.annotation.Module;
import com.zyiot.annotation.SystemLog;
import com.zyiot.entity.LogFormMap;
import com.zyiot.server.LogServerI;
import com.zyiot.util.Common;
import com.zyiot.util.DateUtils;
import com.zyiot.util.FormMapUtil;

/**
 * 
 * @author wyf Component Aspect
 */
@Component
@Aspect
public class LogAOP {

	private static final Logger logger = LoggerFactory.getLogger(LogAOP.class);
	@Autowired
	private LogServerI logServer;

	@AfterReturning(value = "execution(* com.zyiot.server..*.*(..)) && @annotation(ta)")
	public void doController(JoinPoint point, SystemLog ta) {
		// System.out.println("进入logAOP");
		String methodName = point.getSignature().getName();
		String className = point.getTarget().getClass().getSimpleName();
		LogFormMap logForm = new LogFormMap();
		String user = null;
		Long start = 0L;
		Long end = 0L;
		Long time = 0L;
		String ip = null;
		try {
			ip = SecurityUtils.getSubject().getSession().getHost();
		} catch (Exception e) {
			ip = "无法获取登录用户Ip";
		}
		try {
			// 登录名
			user = SecurityUtils.getSubject().getPrincipal().toString();
			if (Common.isEmpty(user)) {
				user = "无法获取登录用户信息！";
			}
		} catch (Exception e) {
			user = "无法获取登录用户信息！";
		}
		// 当前用户
		try {
			// map=getControllerMethodDescription(point);
			// 执行方法所消耗的时间
			start = System.currentTimeMillis();
			// result = point.proceed();
			end = System.currentTimeMillis();
			time = end - start;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		}
		try {

			if (ta.module().equals("") && ta.methods().equals("")
					&& ta.description().equals("")) {
				Module t = point.getTarget().getClass()
						.getAnnotation(Module.class);
				if (t == null)
					throw new Exception("请为该server设置 module注解");
				logForm.put("accountName", user);
				logForm.put("module", t.module());
				if (methodName.equals("add"))
					logForm.put("methods", "添加");
				else if (methodName.equals("edit"))
					logForm.put("methods", "修改");
				else if (methodName.equals("deleteByAttr"))
					logForm.put("methods", "删除");
				logForm.put("description", "成功");
				logForm.put("actionTime", time.toString());
				logForm.put("operTime", DateUtils.format());
				logForm.put("userIP", ip);
			} else {
				logForm.put("accountName", user);
				logForm.put("module", ta.module());
				logForm.put("methods", ta.methods());
				logForm.put("description", ta.description());
				logForm.put("actionTime", time.toString());
				logForm.put("operTime", DateUtils.format());
				logForm.put("userIP", ip);
			}
			FormMapUtil.toADDFormMap(logForm);
			logServer.addLog(logForm);
			// *========控制台输出=========*//
			System.out.println("=====通知开始=====");
			System.out.println("请求方法:" + className + "." + methodName + "()");
			System.out.println("方法描述:" + ta.description());
			System.out.println("请求IP:" + ip);
			System.out.println("=====通知结束=====");
		} catch (Exception e) {
			// 记录本地异常日志
			logger.error("====通知异常====");
			logger.error("异常信息:{}", e.getMessage());
			e.printStackTrace();
		}
		return;
	}

	@AfterThrowing(pointcut = "execution(* com.zyiot.server..*.*(..)) && @annotation(ta)", throwing = "e")
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public void doAfterThrowing(JoinPoint point, SystemLog ta, Throwable e) {
		System.out.println("有异常");
		String methodName = point.getSignature().getName();
		LogFormMap logForm = new LogFormMap();
		String user = null;
		String ip = null;
		try {
			ip = SecurityUtils.getSubject().getSession().getHost();
		} catch (Exception ee) {
			ip = "无";
		}
		try {
			// map=getControllerMethodDescription(point);
			// 登录名
			user = SecurityUtils.getSubject().getPrincipal().toString();
			if (Common.isEmpty(user)) {
				user = "无";
			}
		} catch (Exception ee) {
			user = "无！";
		}
		try {
			if (ta.module().equals("") && ta.methods().equals("")
					&& ta.description().equals("")) {
				Module t = point.getTarget().getClass()
						.getAnnotation(Module.class);
				if (t == null)
					throw new Exception("请为该server设置 module注解");

				logForm.put("accountName", user);
				logForm.put("module", t.module());
				if (methodName.equals("add"))
					logForm.put("methods", "<font color=\"red\">异常:>添加</font>");
				else if (methodName.equals("edit"))
					logForm.put("methods", "<font color=\"red\">异常:>修改</font>");
				else if (methodName.equals("deleteById"))
					logForm.put("methods", "<font color=\"red\">异常:>删除</font>");
				logForm.put("description",
						"<font color=\"red\">异常:>数据库异常</font>");
				logForm.put("actionTime", 0);
				logForm.put("operTime", DateUtils.format());
				logForm.put("userIP", ip);
			} else {
				logForm.put("accountName", user);
				logForm.put("module", ta.module());
				logForm.put("methods", ta.methods());
				logForm.put("description", ta.description());
				logForm.put("actionTime", 0);
				logForm.put("operTime", DateUtils.format());
				logForm.put("userIP", ip);
			}
			/*
			 * logForm.put("accountName", user); logForm.put("module",
			 * ta.module()); logForm.put("methods", "<font color=\"red\">异常:>" +
			 * ta.methods() + "</font>"); logForm.put("description",
			 * "<font color=\"red\">异常:>数据库异常</font>");
			 * logForm.put("actionTime", "0"); logForm.put("operTime",
			 * DateUtils.format()); logForm.put("userIP", ip);
			 */

			FormMapUtil.toADDFormMap(logForm);
			logServer.addLog(logForm);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}

	/**
	 * 拦截所有controller
	 * 
	 * @param point
	 * @param ta
	 */
	@AfterReturning(value = "execution(* com.zyiot.controller..*.*(..)) && @annotation(ta)")
	public void doController1(JoinPoint point, SystemLog ta) {
		String methodName = point.getSignature().getName();
		String className = point.getTarget().getClass().getSimpleName();
		LogFormMap logForm = new LogFormMap();
		String user = null;
		Long start = 0L;
		Long end = 0L;
		Long time = 0L;
		String ip = null;
		try {
			ip = SecurityUtils.getSubject().getSession().getHost();
		} catch (Exception e) {
			ip = "无法获取登录用户Ip";
		}
		try {
			// 登录名
			user = SecurityUtils.getSubject().getPrincipal().toString();
			if (Common.isEmpty(user)) {
				user = "无法获取登录用户信息！";
			}
		} catch (Exception e) {
			user = "无法获取登录用户信息！";
		}
		// 当前用户
		try {
			// map=getControllerMethodDescription(point);
			// 执行方法所消耗的时间
			start = System.currentTimeMillis();
			// result = point.proceed();
			end = System.currentTimeMillis();
			time = end - start;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		}
		try {
			logForm.put("accountName", user);
			logForm.put("module", ta.module());
			logForm.put("methods", ta.methods());
			logForm.put("description", ta.description());
			logForm.put("actionTime", time.toString());
			logForm.put("operTime", DateUtils.format());
			logForm.put("userIP", ip);
			FormMapUtil.toADDFormMap(logForm);
			logServer.addLog(logForm);
			// *========控制台输出=========*//
			System.out.println("=====通知开始=====");
			System.out.println("请求方法:" + className + "." + methodName + "()");
			System.out.println("方法描述:" + ta.description());
			System.out.println("请求IP:" + ip);
			System.out.println("=====通知结束=====");
		} catch (Exception e) {
			// 记录本地异常日志
			logger.error("====通知异常====");
			logger.error("异常信息:{}", e.getMessage());
		}
		return;
	}

	@AfterThrowing(pointcut = "execution(* com.zyiot.controller..*.*(..)) && @annotation(ta)", throwing = "e")
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public void doAfterThrowing1(JoinPoint point, SystemLog ta, Throwable e) {
		LogFormMap logForm = new LogFormMap();
		String user = null;
		String ip = null;
		try {
			ip = SecurityUtils.getSubject().getSession().getHost();
		} catch (Exception ee) {
			ip = "无";
		}
		try {
			// map=getControllerMethodDescription(point);
			// 登录名
			user = SecurityUtils.getSubject().getPrincipal().toString();
			if (Common.isEmpty(user)) {
				user = "无";
			}
		} catch (Exception ee) {
			user = "无！";
		}

		logForm.put("accountName", user);
		logForm.put("module", ta.module());
		logForm.put("methods", "<font color=\"red\">异常:>" + ta.methods()
				+ "</font>");
		logForm.put("description", "<font color=\"red\">异常:>数据库异常</font>");
		logForm.put("actionTime", "0");
		logForm.put("operTime", DateUtils.format());
		logForm.put("userIP", ip);
		try {
			FormMapUtil.toADDFormMap(logForm);
			logServer.addLog(logForm);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}

}
