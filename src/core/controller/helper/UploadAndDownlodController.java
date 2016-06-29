package core.controller.helper;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Controller
public class UploadAndDownlodController {

	// =================================附件上传===============================================

	/**
	 * 附件上传
	 */
	@RequestMapping("sUpload/{dir}")
	public @ResponseBody
	void erpAccessoryUpload(HttpServletRequest req, HttpServletResponse res,
			@PathVariable String dir) throws IllegalStateException, IOException {
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=UTF-8");
		JSONObject json = new JSONObject();
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				req.getSession().getServletContext());
		final String fFilePath = "upload/" + dir + "/";
		if (multipartResolver.isMultipart(req)) {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;

			Iterator<String> iter = multipartRequest.getFileNames();
			while (iter.hasNext()) {
			  
				MultipartFile uploadFile = multipartRequest
						.getFile(iter.next());
				if (uploadFile != null && !uploadFile.isEmpty()) {
					String oldPath = req.getSession().getServletContext()
							.getRealPath("/")
							+ fFilePath;
					File file = new File(oldPath);
					if (!file.exists()) {
						file.mkdirs();
					}
					String fileName = uploadFile.getOriginalFilename();
					
					String fileType = fileName.substring(
							fileName.lastIndexOf("."), fileName.length())
							.toLowerCase();
					String newname = new Date().getTime() + fileType;// 文件重命名
					uploadFile.transferTo(new File(oldPath + newname));

					json.accumulate("fAttachment", fileName);
					json.accumulate("fAttachmentUrl", fFilePath + newname);

					//System.out.println("===文件名=="+fileName);
					//System.out.println("===文件路径=="+fFilePath+newname);
				}

			}

		}

		res.getWriter().print(json);
	}

	// =====================================编辑器上传==================================================
	@RequestMapping(value = "manage/upload")
	public void doUpload(HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=UTF-8");
		JSONObject json = new JSONObject();
		// 获得根目录的物理路径
		String path = req.getSession().getServletContext().getRealPath("/");
		// 设置存储路径
		String savePath = path + "upload/EditorFile";
		File file = new File(savePath);
		if (!file.exists()) {
			file.mkdirs();
		}

		String basePath = req.getScheme() + "://" + req.getServerName() + ":"
				+ req.getServerPort() + req.getContextPath() + "/";
		// 文件保存目录URL
		String saveUrl = basePath + "upload/EditorFile/";
		// 文件类型
		HashMap<String, String> extMap = new HashMap<String, String>();
		extMap.put("image", "gif,jpg,jpeg,png,bmp");
		extMap.put("flash", "swf,flv");
		extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
		extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

		// 每个文件最大5m,最多3个文件,所以...
		long maxSize = 3 * 5 * 1024 * 1024;

		PrintWriter out = res.getWriter();
		if (!ServletFileUpload.isMultipartContent(req)) {
			json.accumulate("error", 1);
			json.accumulate("message", "请选择文件。");
			out.print(json);
		}

		String dirName = req.getParameter("dir");
		if (dirName == null) {
			dirName = "image";
		}

		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				req.getSession().getServletContext());

		if (multipartResolver.isMultipart(req)) {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
			Iterator<String> iter = multipartRequest.getFileNames();

			while (iter.hasNext()) {
				MultipartFile uploadFile = multipartRequest
						.getFile(iter.next());
				if (uploadFile != null && !uploadFile.isEmpty()) {
					String fileName = uploadFile.getOriginalFilename();

					// 检查文件大小
					if (uploadFile.getSize() > maxSize) {
						json.accumulate("error", 1);
						json.accumulate("message", "上传文件大小超过限制。");
						out.print(json);
					}
					// 检查扩展名
					String fileExt = fileName.substring(
							fileName.lastIndexOf(".") + 1).toLowerCase();
					if (!Arrays.<String> asList(extMap.get(dirName).split(","))
							.contains(fileExt)) {
						json.accumulate("error", 1);
						json.accumulate("message", "上传文件扩展名是不允许的扩展名。\n只允许"
								+ extMap.get(dirName) + "格式。");
						out.print(json);
					}

					// SimpleDateFormat df = new
					// SimpleDateFormat("yyyyMMddHHmmss");
					// String newFileName = df.format(new Date()) + "_" + new
					// Random().nextInt(1000) + "." + fileExt;
					String newFileName = new Date().getTime() + "." + fileExt;// 文件重命名
					try {
						File uploadedFile = new File(savePath, newFileName);
						uploadFile.transferTo(uploadedFile);

					} catch (Exception e) {
						json.accumulate("error", 1);
						json.accumulate("message", "上传文件失败！");
						out.print(json);
					}
					json.put("error", 0);
					json.put("url", saveUrl + newFileName);
					out.print(json);
				}
			}
		}
	}

	// =================================附件下载==============================================

	/**
	 * 文件下载
	 * 
	 * @throws Exception
	 * */
	@RequestMapping("sDownload")
	public void download(String fileName, String fileURL,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		String ctxPath = request.getSession().getServletContext()
				.getRealPath("/");
		String downLoadPath = ctxPath + fileURL;

		Long fileLength = new File(downLoadPath).length();
		response.setContentType("application/x-msdownload;");
		//response.setHeader("Content-Disposition", "attachment;filename="
		//		+ new String(fileName.getBytes("utf-8"), "ISO8859-1"));
		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8")); 
		
		//response.setHeader( "Content-Disposition", "attachment;filename=" + new String( fileName.getBytes("gb2312"), "ISO8859-1" ) );
		
		response.setHeader("Content-Length", String.valueOf(fileLength));
		bis = new BufferedInputStream(new FileInputStream(downLoadPath));
		bos = new BufferedOutputStream(response.getOutputStream());
		byte[] buff = new byte[2048];
		int bytesRead;

		while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
			bos.write(buff, 0, bytesRead);
		}

		bis.close();
		bos.close();

	}
}
