package core.controller.attachment;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.mysql.jdbc.Blob;

import core.controller.base.BaseService;
import core.entity.Attachment;

@Service
public class AttachmentService extends BaseService{

	
	/**
	 * 插入附件
	 * @throws FileNotFoundException 
	 */
	@SuppressWarnings("null")
	public void insertAttachment(Attachment att,File file) throws FileNotFoundException {
		// TODO Auto-generated method stub
		
		
		//att.setfContent(file.get);
		
		dao.save("AttachmentMapper.insert", att); 
		
		InputStream is = new FileInputStream(file);
		
		
		
		
		
		
	   // Attachment att = attachmentDao.queryAttachmentById(attachment.getId());  
	    Blob content = (Blob) att.getfContent();
	    FileInputStream fis = null;  
	    OutputStream ops = null;  
	    try {  
	    
	        //ops =  content.getBinaryOutputStream();//暂时使用这个废弃的方法  
	        ops = content.setBinaryStream(0);//ojdbc14支持,ojdbc6,5都不支持  
	        
	       // blob.getBinaryStream(0, file.length());
	        
	        fis = new FileInputStream(file);  
	        byte[] data = null;  
	        data = FileCopyUtils.copyToByteArray(fis);  
	        ops.write(data);  
	        
	        System.out.println(data);
	        
	    } catch (Exception e) {  
	        e.printStackTrace();  
	    } finally {  
	        try {  
	            if(fis!=null){  
	                fis.close();  
	            }  
	            if(ops!=null){  
	                ops.close();  
	            }  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	    }  
		
	}

}
