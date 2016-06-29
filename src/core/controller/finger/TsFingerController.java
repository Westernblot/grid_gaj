package core.controller.finger;

import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsFinger;
import core.util.DateUtil;
import core.util.Page;
import core.util.PageData;

@Controller
public class TsFingerController extends BaseController{

	@Resource
	private TsFingerService fingerService;
	
	
	/**
	 * 查询每月考勤表
	 */
	@RequestMapping("mTsFingerMonth.do")
	public ModelAndView fingerMain(Page page,String fTime){
		mv.clear();
		String nowMonth=nowDate.substring(0,7);
		if(fTime==null || fTime.equals("")){
			fTime=nowMonth;
		}
		pd.put("fTime", fTime);
		page.setPd(pd);
		List<PageData> pdList=fingerService.selectByPage(page);
		mv.addObject("pdList", pdList);
		
		mv.addObject("nowMonth", nowMonth);//当前月份
		mv.setViewName("finger/fingerMonth");
		return mv;
	}
	
	/**
	 * 查询每个人的，某个月的考勤记录
	 * @return
	 */
	@RequestMapping("mTsFingerCode.do")
	public ModelAndView fingerByCode(TsFinger finger){
		mv.clear();
		
		if(finger.getfCode()==null || finger.getfCode().equals("")){
			finger.setfCode("-1");//如果fCode没填，则赋-1值
		}
		
		List<PageData> pdList=fingerService.selectByModel(finger);
		mv.addObject("pdList", pdList);
		mv.addObject("finger", finger);
		mv.addObject("nowMonth", nowDate.substring(0,7));//当前月份
		mv.setViewName("finger/fingerCode");
		return mv;
	}
	
	
	
	//============================数据导出============================================
	
	
//	@RequestMapping("fingerExcel.do")
//	@SuppressWarnings("deprecation")
//	public void web_dealDataExcel(TsFinger finger,HttpServletResponse response) throws Exception {
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
//		cell.setCellValue("工号");
//		cell = row.createCell((short) 1);
//		cell.setCellValue("姓名");
//		cell = row.createCell((short) 2);
//		cell.setCellValue("打卡时间");
//
//		// 第五步，写入实体数据 ,此处数据由前台表单传送过来
//		
//		List<PageData> pdList=fingerService.selectByModel(finger);
//	
//		
//		for (int i=0;i<pdList.size();i++) {
//			// 表体
//			
//			row = sheet.createRow((int) i + 1);
//
//			cell = row.createCell((short) 0);
//			cell.setCellValue(pdList.get(i).getString("F_CODE"));
//
//			cell = row.createCell((short) 1);
//			cell.setCellValue(pdList.get(i).getString("F_CNAME"));
//
//			cell = row.createCell((short) 2);
//			cell.setCellValue(pdList.get(i).getString("F_TIME"));
//
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
	
	
	@RequestMapping("fingerExcel.do")
	@SuppressWarnings("deprecation")
	public void web_dealDataExcel(TsFinger finger,HttpServletResponse response,String fTime) throws Exception {

		// 第一步，创建一个webbook，对应一个Excel文件
		HSSFWorkbook wb = new HSSFWorkbook();
		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		HSSFSheet sheet = wb.createSheet("sheet1");
		//sheet.setVerticallyCenter(true);

		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
		HSSFRow row;// 定义行
		HSSFCell cell;// 定义列

		row = sheet.createRow((int) 0);

		cell = row.createCell((short) 0);
		cell.setCellValue("月份");
		cell = row.createCell((short) 1);
		cell.setCellValue("警号");
		cell = row.createCell((short) 2);
		cell.setCellValue("姓名");
		
		//根据月份查询出当月天数，显示成横向条
		int days=DateUtil.getMonthDays(fTime);	
		for(int m=0;m<days;m++){			
		cell = row.createCell((short) m+3);
		cell.setCellValue(m+1+"号");
		}
		

		// 第五步，写入实体数据 ,此处数据由前台表单传送过来
		
		List<PageData> pdList=fingerService.selectFingerByMonth(fTime,days);
	
		
		for (int i=0;i<pdList.size();i++) {
			// 表体
			
			row = sheet.createRow((int) i + 1);

			cell = row.createCell((short) 0);
			cell.setCellValue(fTime);
			cell = row.createCell((short) 1);
			cell.setCellValue(pdList.get(i).getString("F_CODE"));
			cell = row.createCell((short) 2);
			cell.setCellValue(pdList.get(i).getString("F_NAME"));

			for(int j=0;j<days;j++){			
				cell = row.createCell((short) j+3);
				cell.setCellValue(pdList.get(i).getString("F_D"+j));
				}
		}
		
		// 第六步，将文件存到指定位置
		String fileName = new Date().getTime() + ".xls";// 时间戳命名文件
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename="
				+ fileName);
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();

	}
	
	
	//====================================分割线；考勤数据导出======================================================
	
	
	@RequestMapping("fingerExcelByCode2Month.do")
	@SuppressWarnings("deprecation")
	public void fingerExcelAll(TsFinger finger,HttpServletResponse response) throws Exception {

		// 第一步，创建一个webbook，对应一个Excel文件
		HSSFWorkbook wb = new HSSFWorkbook();
		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		HSSFSheet sheet = wb.createSheet("sheet1");
		//sheet.setVerticallyCenter(true);

		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
		HSSFRow row;// 定义行
		HSSFCell cell;// 定义列

		row = sheet.createRow((int) 0);

		cell = row.createCell((short) 0);
		cell.setCellValue("日期");
		cell = row.createCell((short) 1);
		cell.setCellValue("警号");
		cell = row.createCell((short) 2);
		cell.setCellValue("姓名");
		cell = row.createCell((short) 3);
		cell.setCellValue("第一次打卡");
		cell = row.createCell((short) 4);
		cell.setCellValue("第二次打卡");
		cell = row.createCell((short) 5);
		cell.setCellValue("第三次打卡");
		cell = row.createCell((short) 6);
		cell.setCellValue("第四次打卡");
		cell = row.createCell((short) 7);
		cell.setCellValue("第五次打卡");
		cell = row.createCell((short) 8);
		cell.setCellValue("第六次打卡");
		cell = row.createCell((short) 9);
		cell.setCellValue("第七次打卡");
		cell = row.createCell((short) 10);
		cell.setCellValue("第八次打卡");
		cell = row.createCell((short) 11);
		cell.setCellValue("第九次打卡");
		cell = row.createCell((short) 12);
		cell.setCellValue("第十次打卡");

		// 第五步，写入实体数据 ,此处数据由前台表单传送过来
		
		List<PageData> pdList=fingerService.selectExcelData(finger);
	
		for (int i=0;i<pdList.size();i++) {
			// 表体
			
			row = sheet.createRow((int) i + 1);

			cell = row.createCell((short) 0);
			cell.setCellValue(pdList.get(i).getString("F_DATE"));

			cell = row.createCell((short) 1);
			cell.setCellValue(pdList.get(i).getString("F_CODE"));

			cell = row.createCell((short) 2);
			cell.setCellValue(pdList.get(i).getString("F_NAME"));
			
			cell = row.createCell((short) 3);
			cell.setCellValue(pdList.get(i).getString("F_D0"));
			cell = row.createCell((short) 4);
			cell.setCellValue(pdList.get(i).getString("F_D1"));
			cell = row.createCell((short) 5);
			cell.setCellValue(pdList.get(i).getString("F_D2"));
			cell = row.createCell((short) 6);
			cell.setCellValue(pdList.get(i).getString("F_D3"));
			cell = row.createCell((short) 7);
			cell.setCellValue(pdList.get(i).getString("F_D4"));
			cell = row.createCell((short) 8);
			cell.setCellValue(pdList.get(i).getString("F_D5"));
			cell = row.createCell((short) 9);
			cell.setCellValue(pdList.get(i).getString("F_D6"));
			cell = row.createCell((short) 10);
			cell.setCellValue(pdList.get(i).getString("F_D7"));
			cell = row.createCell((short) 11);
			cell.setCellValue(pdList.get(i).getString("F_D8"));
			cell = row.createCell((short) 12);
			cell.setCellValue(pdList.get(i).getString("F_D9"));

		}
		// 第六步，将文件存到指定位置
		String fileName = new Date().getTime() + ".xls";// 时间戳命名文件
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename="
				+ fileName);
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();

	}
	
	
}
