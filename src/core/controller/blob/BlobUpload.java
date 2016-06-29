package core.controller.blob;

import java.io.IOException;
import java.util.Iterator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import core.controller.base.BaseController;
import core.dao.DaoSupport;
import core.entity.Attachment;

/**
 * 文件上传到数据库 ，存为BLOB 字段。读 写 操作
 * @author Administrator
 *
 */
@Controller
public class BlobUpload extends BaseController{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	//==================================分割线============================================
	
	/**
	 * Blob附件上传：
	 * 1.为了适应多附件上传，此处每次上传把文件写入临时附件表  attachment
	 */
	@RequestMapping("blobUpload")
	public @ResponseBody
	void erpAccessoryUpload(HttpServletRequest req, HttpServletResponse res) throws IllegalStateException, IOException {
		
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=UTF-8");
		JSONObject json = new JSONObject();
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				req.getSession().getServletContext());

		
		if (multipartResolver.isMultipart(req)) {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;

			Iterator<String> iter = multipartRequest.getFileNames();
			while (iter.hasNext()) {
			  
				MultipartFile uploadFile = multipartRequest
						.getFile(iter.next());
				
				
				Attachment att=new Attachment();
				
				att.setfName(uploadFile.getOriginalFilename());				
				att.setfContent(uploadFile.getBytes());
				
				dao.save("AttachmentMapper.insert", att); 
				
				json.accumulate("fAttachmentId", att.getfId());
				json.accumulate("fAttachment", att.getfName());

			}

		}

		res.getWriter().print(json);
	}
	
	
	/**
	 * 阅读 blob 字段
	 * @throws UnsupportedEncodingException 
	 * @throws Exception 
	 */
//	@RequestMapping("bolbDowload")
//	public void  bolbDowload(Integer fId,HttpServletResponse response) throws UnsupportedEncodingException, Exception{
//		BufferedInputStream bis = null;
//		BufferedOutputStream bos = null;
//
//	   PageData pData=(PageData) dao.findForObject("AttachmentMapper.selectById", fId);
//	   
//	   String fileName=pData.getString("F_NAME");
//	   
//	   System.out.println(pData.get("F_CONTENT"));
//
//		//Long fileLength = new File(downLoadPath).length();
//		response.setContentType("application/x-msdownload;");
//		response.setHeader("Content-Disposition", "attachment;filename="
//				+ new String(fileName.getBytes("utf-8"), "ISO8859-1"));
//		//response.setHeader("Content-Length", String.valueOf(fileLength));
//		bis = new BufferedInputStream(new FileInputStream((File) pData.get("F_CONTENT")));
//		bos = new BufferedOutputStream(response.getOutputStream());
//		byte[] buff = new byte[2048];
//		int bytesRead;
//
//		while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
//			bos.write(buff, 0, bytesRead);
//		}
//
//		bis.close();
//		bos.close();
//	}
	
}
