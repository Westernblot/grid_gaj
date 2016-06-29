package core.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GridHttp {

	/**
	 * 设置cookie
	 * @param response
	 * @param name cookie名字
	 * @param value cookie值
	 * @param maxAge cookie生命周期 以小时为单位
	 * @throws UnsupportedEncodingException 
	 */
	public void addCookie(HttpServletResponse response, String name, String value, int maxAge) throws UnsupportedEncodingException {
		value = java.net.URLEncoder.encode(value,"utf-8");
		Cookie cookie = new Cookie(name, value);
		cookie.setPath("/");
		if (maxAge > 0)
			cookie.setMaxAge(maxAge * 3600);
		response.addCookie(cookie);
	}

	/**
	 * 根据名字获取cookie
	 * @param request
	 * @param name cookie名字
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String getCookieByName(HttpServletRequest request, String name) throws UnsupportedEncodingException {
		Map<String, Cookie> cookieMap = ReadCookieMap(request);
		if (cookieMap.containsKey(name)) {
			Cookie cookie = (Cookie) cookieMap.get(name);
			return java.net.URLDecoder.decode(cookie.getValue(),"utf-8");
		} else {
			return null;
		}
	}

	/**
	 * 将cookie封装到Map里面
	 * @param request
	 * @return
	 */
	private static Map<String, Cookie> ReadCookieMap(HttpServletRequest request) {
		Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
		Cookie[] cookies = request.getCookies();
		if (null != cookies) {
			for (Cookie cookie : cookies) {
				cookieMap.put(cookie.getName(), cookie);
			}
		}
		return cookieMap;
	}
	
	/**
	 * 删除cookie
	 * @param response
	 * @param name cookie名字
	 * @return
	 */
	public void deleteCookie(HttpServletResponse response, String name) {
		Cookie deleteNewCookie = new Cookie(name,null); 
		deleteNewCookie.setMaxAge(0); //删除该Cookie 
		deleteNewCookie.setPath("/"); 
		response.addCookie(deleteNewCookie);
	}
	
	
	
	/**
	 * 获取用户真实IP
	 * @param request
	 * @return
	 */
	public String getIP(HttpServletRequest request){
		String ip = request.getHeader("x-forwarded-for");
		if(ip == null || ip.length() == 0 || "unknow".equalsIgnoreCase(ip)){
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknow".equalsIgnoreCase(ip)){
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknow".equalsIgnoreCase(ip)){
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	/**
	 * 随机生成cookieID
	 * @param
	 * @return：cookieid的值
	 */
	public String CreateCookieID() {
		StringBuilder sb = new StringBuilder();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
		Random rd = new Random();//随机数
		
		sb.append(df.format(new Date()));
		sb.append(rd.nextInt());
		
		return sb.toString();
	}
}
