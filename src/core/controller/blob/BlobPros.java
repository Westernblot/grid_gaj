package core.controller.blob;

import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import core.dao.DaoSupport;
import core.util.PageData;
import core.util.PropertiesUtil;

@Controller
public class BlobPros {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	//@Resource
	//private JdbcTemplate jdbc;
	
	
	//private static final String URL = "jdbc:mysql://127.0.0.1:3306/grid_gaj?user=root&password=7788919&useUnicode=true&amp;characterEncoding=utf8";
    private String URL="";
	private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
//    private File file = null;
    
    public BlobPros()
    {
    	//初始化URL路径
    	URL=new PropertiesUtil().getPropertiesURL("jdbc.properties");
 
    }

    /**
    * 向数据库中插入一个新的BLOB对象(图片)
    * @param infile 要输入的数据文件
    * @throws java.lang.Exception
    */
//   public void blobInsert(String infile,Integer fId) throws Exception
//   {
//       FileInputStream fis = null;   
//           try 
//           {
//               Class.forName("org.gjt.mm.mysql.Driver").newInstance();
//               conn = (Connection) DriverManager.getConnection(URL);
//            
//               file = new File(infile);
//               fis = new FileInputStream(file);
//               System.out.println(file.getName());
//               
//               
//               //InputStream fis = new FileInputStream(infile);
//      //   pstmt = conn.prepareStatement("insert into attachment(f_name,f_content) values(?,?)");
//         pstmt = conn.prepareStatement("update attachment set f_name = f_name+'||'+ ?,f_content = f_content+ '||' + ? where f_id = ?");
//         pstmt.setString(1,file.getName());    //把传过来的第一个参数设为文件名
//               //pstmt.setBinaryStream(2,fis,(int)file.length());   //这种方法原理上会丢数据，因为file.length()返回的是long型
//         pstmt.setBinaryStream(2,fis,fis.available());  //第二个参数为文件的内容
//         pstmt.setLong(3,fId);
//         pstmt.executeUpdate();
//      }
//           catch(Exception ex)
//           {
//          System.out.println("[blobInsert error : ]" + ex.toString());
//           }
//        finally
//        {
//               //关闭所打开的对像//
//               pstmt.close();
//               fis.close();
//               conn.close();
//           }
//    }

/**
    * 从数据库中读出BLOB对象《临时附件表》
    * @param outfile 输出的数据文件
    * @param picID 要取的图片在数据库中的ID
    * @throws java.lang.Exception
    */

   @RequestMapping("blobRead")
    public void blobRead(Integer fId,String tableName,HttpServletResponse response) throws Exception
    { 
        BufferedOutputStream fos = null;
        InputStream is = null;
        byte[] Buffer = new byte[4096];
 
            try
            {
                Class.forName("org.gjt.mm.mysql.Driver").newInstance();
                conn = DriverManager.getConnection(URL);
                
                tableName="attachment";
                String sql="select F_NAME,F_CONTENT from "+tableName+" where F_ID ="+fId;
                
                pstmt = conn.prepareStatement(sql);
                
                //pstmt.setInt(1,fId);            //传入要输出的附件id
                rs = pstmt.executeQuery();
                rs.next();
                      
//                file = new File(outfile);
//                if(!file.exists())
//                {
//                    file.createNewFile();     //如果文件不存在，则创建
//                }
                
                String fileName=rs.getString("F_NAME");//文件名
                
                response.setContentType("application/x-msdownload;");
        		response.setHeader("Content-Disposition", "attachment;filename="
        				+ new String(fileName.getBytes("utf-8"), "ISO8859-1"));
                                
                fos = new BufferedOutputStream(response.getOutputStream());
                                
                is = rs.getBinaryStream("F_CONTENT");//文件内容
                              
                int size = 0;
               /* while(size != -1)
                {
                    size = is.read(Buffer);    //从数据库中一段一段的读出数据
                    //System.out.println(size);
                    if(size != -1)            //-1表示读到了文件末
                        fos.write(Buffer,0,size);
                }  */
                while((size = is.read(Buffer)) != -1){
                    //System.out.println(size);
                    fos.write(Buffer,0,size);
                }
                               
         }
            catch(Exception e)
            {
                System.out.println("[OutPutFile error : ]" + e.getMessage()); 
            }
            finally
            {
                //关闭用到的资源
                fos.close();
                rs.close();
                pstmt.close();
                conn.close();
            }
    }
    
   
   /**
    * 从数据库中读出BLOB对象《邮件库》
    * @param outfile 输出的数据文件
    * @param picID 要取的图片在数据库中的ID
    * @throws java.lang.Exception
    */

   @RequestMapping("blobDowload")
    public void blobDowload(Integer fId,String tableName,HttpServletResponse response) throws Exception
    { 
        BufferedOutputStream fos = null;
        InputStream is = null;
        byte[] Buffer = new byte[4096];
 
            try
            {
            	//System.out.println("URL地址为："+URL);
                Class.forName("org.gjt.mm.mysql.Driver").newInstance();
                conn = DriverManager.getConnection(URL);
                
                String sql="select F_ATTACHMENT,F_ATTACHMENT_URL from "+tableName+" where F_ID ="+fId;

                pstmt = conn.prepareStatement(sql);
                
                rs = pstmt.executeQuery();
                rs.next();
                      
                String fileName=rs.getString("F_ATTACHMENT");//下载的文件名
                
                response.setContentType("application/x-msdownload;");
        		response.setHeader("Content-Disposition", "attachment;filename="
        				+ new String(fileName.getBytes("utf-8"), "ISO8859-1"));
                                
                fos = new BufferedOutputStream(response.getOutputStream());
                                
                is = rs.getBinaryStream("F_ATTACHMENT_URL");//文件内容
                              
                int size = 0;
              
                while((size = is.read(Buffer)) != -1){
                   
                    fos.write(Buffer,0,size);
                }
                               
         }
            catch(Exception e)
            {
                System.out.println("[OutPutFile error : ]" + e.getMessage()); 
            }
            finally
            {
                //关闭用到的资源
                fos.close();
                rs.close();
                pstmt.close();
                conn.close();
            }
    }
   
   
   /**
    * 测试文件复制
    */
   @RequestMapping("copyTest")
   public void copyTest(){
	   PageData pd=(PageData) dao.findForObject("AttachmentMapper.selectById", 12);
	   
	   PageData pdm=new PageData();
	   pdm.put("fName", pd.getString("F_NAME"));
	   pdm.put("fContent", pd.get("F_CONTENT"));
	   
	   dao.save("AttachmentMapper.insert", pdm);
	   
	   System.out.println( pdm.get("F_ID") );
	   
   }
  
   
   /**
    * 本实例入口方法
    * @param args
    */
    public static void main(String[] args)
    {
        try
        {
            
            BlobPros blob = new BlobPros();
           // blob.blobInsert("e:/目录.doc");           
            //blob.blobRead("c:/黄石市公安.doc",15);
            
            
        }
        catch(Exception e)
        {
            System.out.println("[Main func error: ]" + e.getMessage()); 
        }
    }
}
