package core.util;

import com.sun.jna.Library;
import com.sun.jna.Native;

/**
 * 短信发送工具类
* 
* 项目名称：grid_gaj 
* 类名称：SmsUtil 
* 类描述： 
* 创建人：WS
* 创建时间：2015-2-26 下午4:59:22 
* 修改人：WS 
* 修改时间：2015-2-26 下午4:59:22 
* 修改备注： 
* @version 
*
 */
public class SmsUtil {

	
	//必须继承Library 这个是jna标准  
    //必须定义一个接口,描述所调用的dll或者so文件的方法结构  
	public interface SMSDLL extends Library {
		
		//加载动态链接库，SMSDLL.dll应该放在JAVA环境变量下加载
		SMSDLL INSTANCE = (SMSDLL) Native.loadLibrary("SMSDLL", SMSDLL.class);

		// 启动服务,打开串口，初始化Modem
		// 返回=< 0 表示启动失败。> 0 表示启动成功，返回服务编号
		public int SMSStartService(int nPort, // 端口号
				int uBaudRate, // 波特率
				int nParity, // 校验位（现已无用）
				int nDataBits, // 数据位（现已无用）
				int nStopBits, // 停止位（现已无用）
				int nFlowControl, // 流控位（现已无用）
				String pCsca);

		// 查询服务是否启动
		public int SMSServiceStartedByPort(int nPort);

		// 发送短信
		public int SMSSendMessage(String pMsg,String pPhone);

		// 查询是否发送成功
		public int SMSQuery(int index);

	}

	
	//短信测试代码
	public static void main(String[] args) throws InterruptedException,
			Exception {

		System.setProperty("jna.encoding", "GBK"); // 改变JNA的编码，解决短信接收乱码的问题

		int port = 1;

		int aa = SMSDLL.INSTANCE.SMSStartService(port, 115200, 2, 8, 0, 0,
				"card");
		System.out.println(aa);
	
//		int bb = SMSDLL.INSTANCE.SMSServiceStartedByPort(port);
//		System.out.println(bb);

		String phone = "13297234911";
		String msg = "信息测试,湖北网格软件！！！";

		int smscode = SMSDLL.INSTANCE.SMSSendMessage(msg, phone);

		for (int i = 0; i < 10; i++) {
			Thread.sleep(1000);
			System.out.println("第" + Integer.toString(i) + "秒 -- "
					+ SMSDLL.INSTANCE.SMSQuery(smscode));
		}

	}

}
