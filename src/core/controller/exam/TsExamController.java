package core.controller.exam;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.item.TsItemService;
import core.controller.system.dept.SysDeptService;
import core.entity.TsExam;
import core.entity.TsFinger;
import core.entity.TsItem;
import core.entity.system.SysDept;
import core.util.Page;
import core.util.PageData;

@Controller
public class TsExamController extends BaseController {

	@Resource
	private TsExamService examService;// 考核打分
	@Resource
	private TsItemService itemService;// 考核内容
	@Resource
	private SysDeptService deptService;// 考核部门

	/**
	 * 综合考核明细
	 * 
	 * @return
	 */
	@RequestMapping("mExamMain.do")
	public ModelAndView examMain(Page page) {
		mv.clear();

		// 考核单位
		List<SysDept> deptList = deptService.selectExamDept();// 查询出需要考核的部门
		mv.addObject("deptList", deptList);

		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> pdList = examService.selectByPage(page);
		mv.addObject("pdList", pdList);
		mv.setViewName("exam/examMain");
		return mv;
	}

	/**
	 * 综合考核新增 UI
	 */
	@RequestMapping("mExamUI.do")
	public ModelAndView examUI(String fYear) {
		mv.clear();

		// 考核单位
		List<SysDept> deptList = deptService.selectExamDept();// 查询出需要考核的部门
		mv.addObject("deptList", deptList);

		mv.addObject("fYear", fYear);// 传入年份

		// 考核条目
		List<TsItem> itemList = itemService.selectByfYear(fYear);
		mv.addObject("itemList", itemList);

		mv.setViewName("exam/examUI");
		return mv;
	}

	/**
	 * 综合考核修改UI
	 */
	@RequestMapping("mExamUpdateUI.do")
	public ModelAndView examUpdateUI(Integer fId) {
		mv.clear();

		// 考核单位
		List<SysDept> deptList = deptService.selectExamDept();// 查询出需要考核的部门
		mv.addObject("deptList", deptList);

		TsExam exam = examService.selectById(fId);
		mv.addObject("exam", exam);

		// 考核条目
		List<TsItem> itemList = itemService.selectByfYear(exam.getfYear());
		mv.addObject("itemList", itemList);

		mv.setViewName("exam/examUpdateUI");
		return mv;
	}

	// =========================以下CRUD=============================================

	/**
	 * 增
	 * 
	 * @param exam
	 * @return
	 */
	@RequestMapping("mExamInsert.do")
	@ResponseBody
	public int examInsert(TsExam exam) {
		exam.setfDate(nowDate);// 当前时间
		return examService.insert(exam);
	}

	/**
	 * 删
	 * 
	 * @param exam
	 * @return
	 */
	@RequestMapping("mExamDelete.do")
	@ResponseBody
	public int mExamDelete(String fIds) {
		pd.put("fIds", fIds);
		return examService.deleteByIds(pd);
	}

	/**
	 * 改
	 * 
	 * @param exam
	 * @return
	 */
	@RequestMapping("mExamUpdate.do")
	@ResponseBody
	public int mExamUpdate(TsExam exam) {
		return examService.update(exam);
	}

	// ============================数据导出============================================

	@RequestMapping("examExcel.do")
	@SuppressWarnings("deprecation")
	public void web_dealDataExcel(HttpServletResponse response)
			throws Exception {

		// 第一步，创建一个webbook，对应一个Excel文件
		HSSFWorkbook wb = new HSSFWorkbook();
		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		HSSFSheet sheet = wb.createSheet("sheet1");
		// sheet.setVerticallyCenter(true);

		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
		HSSFRow row;// 定义行
		HSSFCell cell;// 定义列

		row = sheet.createRow((int) 0);

		cell = row.createCell((short) 0);
		cell.setCellValue("序号");
		cell = row.createCell((short) 1);
		cell.setCellValue("年份");
		cell = row.createCell((short) 2);
		cell.setCellValue("考核开始月份");
		cell = row.createCell((short) 3);
		cell.setCellValue("考核结束月份");
		cell = row.createCell((short) 4);
		cell.setCellValue("单位");
		cell = row.createCell((short) 5);
		cell.setCellValue("项目");
		cell = row.createCell((short) 6);
		cell.setCellValue("加分");
		cell = row.createCell((short) 7);
		cell.setCellValue("减分");
		cell = row.createCell((short) 8);
		cell.setCellValue("说明");
		cell = row.createCell((short) 9);
		cell.setCellValue("添加时间");

		// 第五步，写入实体数据 ,此处数据由前台表单传送过来

		pd = this.getPageData();
		List<PageData> pdList = examService.selectByPageData(pd);

		float addSum = 0;
		float subSum = 0;
		int i;

		for (i = 0; i < pdList.size(); i++) {
			// 表体

			row = sheet.createRow((int) i + 1);

			cell = row.createCell((short) 0);
			cell.setCellValue(i + 1);

			cell = row.createCell((short) 1);
			cell.setCellValue(pdList.get(i).getString("F_YEAR"));

			cell = row.createCell((short) 2);
			cell.setCellValue(pdList.get(i).getString("F_MONTH"));
			
			cell = row.createCell((short) 3);
			cell.setCellValue(pdList.get(i).getString("F_END_MONTH"));

			cell = row.createCell((short) 4);
			cell.setCellValue(pdList.get(i).getString("F_NAME"));

			cell = row.createCell((short) 5);
			cell.setCellValue(pdList.get(i).getString("F_ITEM"));

			cell = row.createCell((short) 6);
			cell.setCellValue(Float.valueOf(pdList.get(i).getString("F_ADD")
					.equals("") ? "0" : pdList.get(i).getString("F_ADD")));

			cell = row.createCell((short) 7);
			cell.setCellValue(Float.valueOf(pdList.get(i).getString("F_SUB")
					.equals("") ? "0" : pdList.get(i).getString("F_SUB")));

			cell = row.createCell((short) 8);
			cell.setCellValue(pdList.get(i).getString("F_REMARK"));

			cell = row.createCell((short) 9);
			cell.setCellValue(pdList.get(i).getString("F_DATE"));

			addSum += Float
					.valueOf(pdList.get(i).getString("F_ADD").equals("") ? "0"
							: pdList.get(i).getString("F_ADD"));
			subSum += Float
					.valueOf(pdList.get(i).getString("F_SUB").equals("") ? "0"
							: pdList.get(i).getString("F_SUB"));

		}

		row = sheet.createRow((int) i + 1);
		cell = row.createCell((short) 0);
		cell.setCellValue("总计：");

		cell = row.createCell((short) 1);
		cell.setCellValue("");

		cell = row.createCell((short) 2);
		cell.setCellValue("");

		cell = row.createCell((short) 3);
		cell.setCellValue("");
		
		cell = row.createCell((short) 4);
		cell.setCellValue("");
		
		cell = row.createCell((short) 5);
		cell.setCellValue("");
		
		cell = row.createCell((short) 6);
		cell.setCellValue(addSum);
		
		cell = row.createCell((short) 7);
		cell.setCellValue(subSum);
		
		cell = row.createCell((short) 8);
		cell.setCellValue(addSum - subSum);
		
		cell = row.createCell((short) 9);
		cell.setCellValue("");

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
