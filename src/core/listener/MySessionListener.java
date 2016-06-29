/**
 * 源文件名：MySessionListener.java
 * 文件版本：1.0.0
 * 创建作者：黄为
 * 创建日期：2013-12-13
 * 修改作者：黄为
 * 修改日期：
 * 文件描述：session值监听类，对用户session值创建、销毁侦听并修改用户登录状态
 * 版权所有：Copyright 2013 湖北网格, Inc. All Rights Reserved.
 */
package core.listener;

import java.util.HashMap;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import core.entity.system.SysUser;

public class MySessionListener implements HttpSessionListener {

	private static int onlinePeoples = 0;
	
	private static HashMap<String,String> userMap = new HashMap<String, String>();
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
	}

	/**
	 * 浏览器关闭移除session
	 */
	public void sessionDestroyed(HttpSessionEvent se){
		SysUser user = (SysUser) se.getSession().getAttribute("user");
		if(user != null){
			userMap.remove(user);
			onlinePeoples--;
			se.getSession().removeAttribute("user");
		}
		
	}

	public static int getOnlinePeoples() { 
	     return onlinePeoples; 
	}
	
	public static void addOnlinePeoples(String userId, String sessionId){
		final String uId = userId;
		final String sId = sessionId;
		onlinePeoples++;
		userMap.put(uId, sId);
	}
	
	public static String getUserSession(String userId){
		final String uId = userId;
		return userMap.get(uId);
	}
}
