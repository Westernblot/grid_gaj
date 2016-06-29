package core.controller.attachment;

import java.io.File;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import core.controller.base.BaseController;
import core.entity.Attachment;

@Controller
public class AttachmentController extends BaseController{

	@Resource
	private AttachmentService attService;
	
	
	@RequestMapping("insertAttachment")
	public void insertAttachment(Attachment attachment){
		File file=new File("E:\\oracle.txt");
		System.out.println(file);
		/*获取文件名*/  
        String name=file.getName();  
        /*获取文件路径*/  
        String path_=file.getPath();  
        /*获取绝对路径名*/  
        String absPath=file.getAbsolutePath();  
        /*获取父亲文件路径*/  
        String parent=file.getParent();  
        /*文件大小*/  
        long size=file.length();  
        /*最后一次修改时间*/  
        long time=file.lastModified();  
        System.out.println("文件名:"+name);  
        System.out.println("文件路径:"+path_);  
        System.out.println("文件的绝对路径:"+absPath);  
        System.out.println("文件的父文件路径:"+parent);  
        System.out.println("文件的大小:"+size);  
        System.out.println("文件最后一次修改时间:"+time);  
        
        attachment.setfName(name);
		//attService.insertAttachment(attachment,file);
	}
}
