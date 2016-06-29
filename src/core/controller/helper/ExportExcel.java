package core.controller.helper;

import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.bind.annotation.RequestMapping;

public class ExportExcel {

	
	//==============================分割线==========================================
	/**
	 * 数据导出
	 * 
	 * @throws Exception
	 */
//	@RequestMapping("web_dealDataExcel.do")
//	@SuppressWarnings("deprecation")
//	public void web_dealDataExcel(detail_reward reward,HttpServletResponse response) throws Exception {
//
//		// 第一步，创建一个webbook，对应一个Excel文件
//		HSSFWorkbook wb = new HSSFWorkbook();
//		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
//		HSSFSheet sheet = wb.createSheet("sheet1");
//		//sheet.setVerticallyCenter(true);
//
//		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
//		HSSFRow row;// 定义行
//		HSSFCell cell;// 定义列
//
//		row = sheet.createRow((int) 0);
//
//		cell = row.createCell((short) 0);
//		cell.setCellValue("交易流水号");
//		cell = row.createCell((short) 1);
//		cell.setCellValue("经纪人");
//		cell = row.createCell((short) 2);
//		cell.setCellValue("经纪人编号");
//		cell = row.createCell((short) 3);
//		cell.setCellValue("客户");
//		cell = row.createCell((short) 4);
//		cell.setCellValue("电话");
//		cell = row.createCell((short) 5);
//		cell.setCellValue("房产");
//		cell = row.createCell((short) 6);
//		cell.setCellValue("成交日期");
//		cell = row.createCell((short) 7);
//		cell.setCellValue("佣金");
//
//		// 第五步，写入实体数据 ,此处数据由前台表单传送过来
//		
//		List<detail_reward> rwdList=dealService.selectByModel(reward);
//	
//		int i=0;
//		for (detail_reward rwd:rwdList) {
//			// 表体
//			
//			row = sheet.createRow((int) i + 1);
//
//			cell = row.createCell((short) 0);
//			cell.setCellValue(rwd.getDealcode());
//
//			cell = row.createCell((short) 1);
//			cell.setCellValue(rwd.getBrokername());
//
//			cell = row.createCell((short) 2);
//			cell.setCellValue(rwd.getBrokercode());
//
//			cell = row.createCell((short) 3);
//			cell.setCellValue(rwd.getName());
//
//			cell = row.createCell((short) 4);
//			cell.setCellValue(rwd.getPhone());
//
//			cell = row.createCell((short) 5);
//			cell.setCellValue(rwd.getHouseid());
//
//			cell = row.createCell((short) 6);
//			cell.setCellValue(rwd.getDealdate());
//			
//			cell = row.createCell((short) 7);
//			cell.setCellValue(rwd.getAmount());
//            
//			i+=1;
//		}
//		// 第六步，将文件存到指定位置
//		String fileName = new Date().getTime() + ".xls";// 时间戳命名文件
//		response.setContentType("application/vnd.ms-excel");
//		response.setHeader("Content-disposition", "attachment;filename="
//				+ fileName);
//		OutputStream ouputStream = response.getOutputStream();
//		wb.write(ouputStream);
//		ouputStream.flush();
//		ouputStream.close();
//
//	}

}
