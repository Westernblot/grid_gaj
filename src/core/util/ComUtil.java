package core.util;

import gnu.io.CommPortIdentifier;
import gnu.io.SerialPort;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;





import org.junit.Test;


/**
 * JAVA 写串口，控制LED屏幕数据显示
 * @author Administrator
 *
 */
public class ComUtil {


	private static String comPort="";//定义串口
	
	/**
	 *  LED 屏
	 *  第0 ,1分区输出显示
	 * @throws Exception 
	 */
	@Test
	public static void sendComLED(Integer flag,String msg) {
		
		String head="";
		if(flag==1){
			head="*#1E000035X1010";//标题。第1分区，消息地址000,需 msg
		}else if(flag==2){
			head="*#1E001035X1110";//带班领导,分区；第2分区，消息地址是001，需 msg
		}else if(flag==3){
			head="*#1E002035X1210";//值班人员,分区；第3分区，消息地址是002，需 msg
		}else if(flag==4){
			head="*#1E003025X1310";//第4分区，消息地址003，需 msg
		}else if(flag==0){
			head="*#1GDEL";        //删除消息，消息地址== 以上四个，需 msg
		}else if(flag==19){
			head="*#1OZRS";        //取消全部分区
		}else if(flag==20){
			head="*#1MZON4:0,0,128,16|0,16,128,32|0,48,128,32|0,80,128,16|";//上下分四区
		}else if(flag==40){
			head="*#1LSET0128x096,110000";//设置屏幕参数
		}else if(flag==18){
			head="*#1KSLP001";       //开机
		}else if(flag==17){
			head="*#1KSLP999";       //关机
		}else if(flag==21){
			head="*#1HALL999";       //删除所有消息
		}
		
		
		SerialPort   port=null;
		CommPortIdentifier serialPortId=null;
		OutputStream outputStream=null;
//    	InputStream  inputStream=null;
		
		try {
			
			comPort=new PropertiesUtil().getPropertiesValue("jdbc.properties","led.comPort");
			
			System.out.println("======串口===="+comPort);
			
			serialPortId = CommPortIdentifier
					.getPortIdentifier(comPort);
			port = (SerialPort) serialPortId.open("Serial_Communication", 30); // 打开COM4串口，其中30是打开串口的超时时间
			port.setSerialPortParams(57600, 8, 1, 0); // 设置COM4的波特率，数据位，停止位，校验方式
			
			msg=head+msg;//拼接字符串
			
			System.out.println(msg);
			
			outputStream = port.getOutputStream();
			outputStream.write(msg.getBytes("GBK")); // 写入byte[],转为GBK 编码，以解决中文乱码显示问题
	
           // inputStream = port.getInputStream();
			//System.out.println("数据返回："+inputStream.read());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally {
			System.out.println("...串口写入OK...");
		
			 //关闭流和端口
//			try {
//				inputStream.close();
//			} catch (IOException e1) {
//				System.out.println("关闭输入流时异常出现：" + e1.getMessage());
//			}
			try {
				outputStream.close();
			} catch (IOException e) {
				System.out.println("关闭输出流时异常出现：" + e.getMessage());
			}
			try {
				port.close();
			} catch (Exception e) {
				System.out.println("关闭端口时异常出现：" + e.getMessage());
			}
		}
		
	}
	
	
	
	//===============================分割线==============================================
	
	/**
	 * 读写串口 演示代码
	 * 
	 * @param args
	 * @throws Exception
	 */
	// JAVA 写串口测试程序
	public static void main(String[] args){

		SerialPort      port=null;
		OutputStream    outputStream=null;
		InputStream     inputStream=null;

	
		try {
			
			comPort=new PropertiesUtil().getPropertiesValue("jdbc.properties","led.comPort");
			
			System.out.println(comPort);
			
			CommPortIdentifier serialPortId = CommPortIdentifier
					.getPortIdentifier(comPort);
			port = (SerialPort) serialPortId.open("Serial_Communication", 30); // 打开COM4串口，其中30是打开串口的超时时间
			port.setSerialPortParams(57600, 8, 1, 0); // 设置COM4的波特率，数据位，停止位，校验方式

			String msg = "*#1KSLP001";   //简单输出
			
//			String content ="值班人员：李思明    18900001111"; 
			
			msg="*#1E000035X1010治安支队今日值班";   //第0分区
			
			//msg="*#1E000035X1010"+"带班领导：张  三    18900001111";  //带班领导 张三
			
			//msg="*#1E001035X1110"+"值班人员：李四名    18900001111"; //正常显示
			
			//msg="*#1OZRS";//取消全部分区
			
			//msg="*#1LSET0128x096,110000";//设置屏幕参数
			
			//msg="*#1MZON4:0,0,128,16|0,16,128,32|0,48,128,32|0,80,128,16|";//上下分四区

			System.out.println("===============写入开始====================");
			
			// 从串口中得到输入输出流了
			outputStream = port.getOutputStream();
			outputStream.write(msg.getBytes("GBK")); // 写入byte[]
	
			
			inputStream = port.getInputStream();
			
			System.out.println(inputStream.read());
			

		} catch (Exception e) {
			System.out.println("异常出现：" + e.getMessage());
		} finally {
			System.out.println("finally...");

			 //关闭流和端口
			try {
				inputStream.close();
			} catch (IOException e1) {
				System.out.println("关闭输入流时异常出现：" + e1.getMessage());
			}
			
			try {
				outputStream.close();
			} catch (IOException e) {
				System.out.println("关闭输出流时异常出现：" + e.getMessage());
			}
			try {
				port.close();
			} catch (Exception e) {
				System.out.println("关闭端口时异常出现：" + e.getMessage());
			}
		}

	}

	/**
	 * 扫描串口
	 */
	@Test
	public void listPortChoices() {
		CommPortIdentifier portId;
		Enumeration en = CommPortIdentifier.getPortIdentifiers();
		// iterate through the ports.
		while (en.hasMoreElements()) {
			portId = (CommPortIdentifier) en.nextElement();
			if (portId.getPortType() == CommPortIdentifier.PORT_SERIAL) {
				System.out.println(portId.getName());
			}
		}
	
	}
	
}
