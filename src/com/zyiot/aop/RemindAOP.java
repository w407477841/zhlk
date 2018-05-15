package com.zyiot.aop;

import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zyiot.annotation.Remind;
import com.zyiot.entity.RemindFormMap;
import com.zyiot.entity.UserFormMap;
import com.zyiot.mapper.RemindMapper;
import com.zyiot.mapper.UserMapper;
import com.zyiot.util.BatchInsertParameter;
import com.zyiot.util.Common;

/**
 * @author Administrator #####通知增强###### 情况1：指定通知用户id、通知种类、url、内容
 *         情况2：指定通知角色id、通知种类、url、内容
 */
@Component
@Aspect
public class RemindAOP {
	@Autowired
	RemindMapper remindMapper;

	@Autowired
	UserMapper userMapper;

	private static final Logger logger = LoggerFactory
			.getLogger(RemindAOP.class);

	@AfterReturning(value = "execution(* com.zyiot.server..*.*(..)) && @annotation(ta)")
	public void doController(JoinPoint point, Remind ta) {

		// Object args[] = point.getArgs();
		// for (int i = 0; args != null && i < args.length; i++) {
		//
		// }
		String url = ta.url();
		if (ta.isNeedParam()) {
			url = url + "?id=1";
		}
		List<RemindFormMap> remindList = new ArrayList<RemindFormMap>();
		if (ta.type().equals("1")) {
			for (int i = 0; i < ta.userIds().length; i++) {
				RemindFormMap remind = new RemindFormMap();
				remind.put("objectId", "1");
				remind.put("objectType", ta.remindType());
				remind.put("userId", ta.userIds()[i]);
				remind.put("content", ta.remindContent());
				remind.put("url", url);
				remindList.add(remind);
			}

		} else if (ta.type().equals("2")) {
			String roleids = Common.array2String(ta.roleIds(), ",");
			UserFormMap user = new UserFormMap();
			user.put("roleId", roleids);
			List<UserFormMap> users = userMapper.findUserByRoleId(user);
			for (UserFormMap u : users) {
				RemindFormMap remind = new RemindFormMap();
				remind.put("objectId", "1");
				remind.put("objectType", ta.remindType());
				remind.put("userId", u.get("userId"));
				remind.put("content", ta.remindContent());
				remind.put("url", url);
				remindList.add(remind);
			}

		}
		try {
			remindMapper.batchSave(BatchInsertParameter.wrap(remindList));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// String roleIds = StringUtils.join(ta.roleId(), ",");
		// String userIds = StringUtils.join(ta.userIds(), ",");
		// System.out.println(ta.userIds().length > 0 ? ta.userIds()[0] :
		// "null");

		return;
	}
}
