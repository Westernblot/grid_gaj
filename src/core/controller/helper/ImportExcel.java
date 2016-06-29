package core.controller.helper;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Controller
public class ImportExcel {

	
//	@RequestMapping(value = "sImportExcel")
//	public void importXzsp(HttpServletRequest req, HttpServletResponse res) throws IOException {
//		res.setCharacterEncoding("utf-8");
//		res.setContentType("text/html; charset=UTF-8");
//		JSONObject json = new JSONObject();
//		try {
//			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(req.getSession().getServletContext());
//			if (multipartResolver.isMultipart(req)) {
//				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
//				Iterator<String> iter = multipartRequest.getFileNames();
//				while (iter.hasNext()) {
//					MultipartFile uploadFile = multipartRequest.getFile(iter.next());
//					String fileName = uploadFile.getOriginalFilename();
//					// 验证文件类型
//					String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length()).toLowerCase();
//					InputStream is = uploadFile.getInputStream();
//					if (fileType.equals(".xls")) {
//						HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
//						HSSFSheet sheet = hssfWorkbook.getSheetAt(0);
//						TsXzsp tx = null;
//						int succNum = 0;
//						int failNum = 0;
//						int rows = sheet.getLastRowNum();
//						for (int i = 1; i < rows; i++) {
//							HSSFRow row = sheet.getRow(i);
//							tx = new TsXzsp();
//							tx.setfCode(getValue(row.getCell(0)));
//							tx.setfApply(getValue(row.getCell(1)));
//							tx.setfTdwz("");
//							tx.setfStatus(1);
//							tx.setfDept(dept);
//							tx.setfType("xzsp");
//							tx.setfWork(getValue(row.getCell(2)));
//							tx.setfTime(getValue(row.getCell(3)));
//							try {
//								if (tx.getfCode() != null && tx.getfCode().length() > 0) {
//									txService.insert(tx);
//									succNum++;
//								}
//							}
//							catch (Exception e) {
//								// TODO: handle exception
//								e.printStackTrace();
//								failNum++;
//							}
//						}
//						json.accumulate("status", "succ");
//						json.accumulate("msg", "成功导入 " + succNum + " 行数据；其中导入失败 " + failNum + " 行；");
//					}
//					else {
//						XSSFWorkbook workbook = new XSSFWorkbook(is);
//						XSSFSheet sheet = workbook.getSheetAt(0);
//						TsXzsp tx = null;
//						int succNum = 0;
//						int failNum = 0;
//						int rows = sheet.getLastRowNum();
//						for (int i = 1; i < rows; i++) {
//							XSSFRow row = sheet.getRow(i);
//							tx = new TsXzsp();
//							tx.setfCode(row.getCell(0).getRawValue());
//							tx.setfApply(row.getCell(1).getRawValue());
//							tx.setfTdwz("");
//							tx.setfStatus(1);
//							tx.setfDept(dept);
//							tx.setfType("xzsp");
//							tx.setfWork(row.getCell(2).getRawValue());
//							tx.setfTime(row.getCell(3).getRawValue());
//							try {
//								if (tx.getfCode() != null && tx.getfCode().length() > 0) {
//									txService.insert(tx);
//									succNum++;
//								}
//							}
//							catch (Exception e) {
//								// TODO: handle exception
//								e.printStackTrace();
//								failNum++;
//							}
//						}
//						json.accumulate("status", "succ");
//						json.accumulate("msg", "成功导入 " + succNum + " 行数据；其中导入失败 " + failNum + " 行；");
//					}
//				}
//			}
//		}
//		catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//			json.accumulate("status", "fail");
//		}
//		res.getWriter().print(json);
//	}
	
}
