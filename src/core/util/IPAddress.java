package core.util;

import java.net.InetAddress;

public class IPAddress {

	/**
	 * 获取登陆用户的ip地址
	 * @return
	 * @throws Exception
	 */
	public static String getHostIP() throws Exception{
		 // 获取计算机名
        String name = InetAddress.getLocalHost().getHostName();
        // 获取IP地址
        String ip = InetAddress.getLocalHost().getHostAddress();
        System.out.println("计算机名："+name);
        System.out.println("IP地址："+ip);
		return ip;
	}
}
