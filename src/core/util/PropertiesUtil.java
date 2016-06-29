package core.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Properties;

import org.apache.catalina.startup.Bootstrap;

/**
 * 读取properties 文件 工具类
 * @author Administrator
 *
 */
public class PropertiesUtil {

	//根据key读取value
	 public static String readValue(String filePath,String key) {
	  Properties props = new Properties();
	        try {
	         InputStream in = new BufferedInputStream (new FileInputStream(filePath));
	         props.load(in);
	         String value = props.getProperty (key);
	            System.out.println(key+value);
	            return value;
	        } catch (Exception e) {
	         e.printStackTrace();
	         return null;
	        }
	 }
	 
	 //读取properties的全部信息
	    public static void readProperties(String filePath) {
	     Properties props = new Properties();
	        try {
	         InputStream in = new BufferedInputStream (new FileInputStream(filePath));
	         props.load(in);
	            Enumeration en = props.propertyNames();
	             while (en.hasMoreElements()) {
	              String key = (String) en.nextElement();
	                    String Property = props.getProperty (key);
	                    System.out.println(key+Property);
	                }
	        } catch (Exception e) {
	         e.printStackTrace();
	        }
	    }

	    //写入properties信息
	    public static void writeProperties(String filePath,String parameterName,String parameterValue) {
	     Properties prop = new Properties();
	     try {
	      InputStream fis = new FileInputStream(filePath);
	            //从输入流中读取属性列表（键和元素对）
	            prop.load(fis);
	            //调用 Hashtable 的方法 put。使用 getProperty 方法提供并行性。
	            //强制要求为属性的键和值使用字符串。返回值是 Hashtable 调用 put 的结果。
	            OutputStream fos = new FileOutputStream(filePath);
	            prop.setProperty(parameterName, parameterValue);
	            //以适合使用 load 方法加载到 Properties 表中的格式，
	            //将此 Properties 表中的属性列表（键和元素对）写入输出流
	            prop.store(fos, "Update '" + parameterName + "' value");
	        } catch (IOException e) {
	         System.err.println("Visit "+filePath+" for updating "+parameterName+" value error");
	        }
	    }

	    
	    //==============================分割线===========================================
	    
	    //读取classpath下 properties 的文件
	    public String getPropertiesValue(String fileName,String key) {
	  	  Properties props = new Properties();
	  	        try {
	  	         InputStream in= this.getClass().getClassLoader().getResourceAsStream(fileName);
	  	         props.load(in);
	  	         String value = props.getProperty (key);
	  	          //  System.out.println(key+value);
	  	            return value;
	  	        } catch (Exception e) {
	  	         e.printStackTrace();
	  	         return null;
	  	        }
	  	 } 
	    
	    //直接获取classpath 下 properties 文件的 组合url
	    public String getPropertiesURL(String fileName){
	    	 Properties props = new Properties();
	  	        try {
	  	         InputStream in= this.getClass().getClassLoader().getResourceAsStream(fileName);
	  	         props.load(in);
	  	         String url = props.getProperty ("jdbc.url");
	  	         String username = props.getProperty ("jdbc.username");
	  	         String password = props.getProperty ("jdbc.password");
	  	          //  System.out.println(key+value);
	  	         
	  	         String URL=url+"&user="+username+"&password="+password;
	  	         
	  	         //System.out.println(URL);
	  	         
	  	            return URL;
	  	        } catch (Exception e) {
	  	         e.printStackTrace();
	  	         return null;
	  	        }
	    }
	    
	    //入口测试方法
	    public static void main(String[] args) {
	         
	        // readValue("info.properties","url");
	       // writeProperties("info.properties","age","21");
	        //readProperties("info.properties" );
	        //System.out.println("OK");
	        String url=new PropertiesUtil().getPropertiesURL("jdbc.properties");
	        System.out.println(url);
	        
	       // System.out.println(Bootstrap.class.getResource("/jdbc.properties"));  
	    }
	
}
