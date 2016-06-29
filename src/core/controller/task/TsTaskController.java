package core.controller.task;

import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.system.dept.SysDeptService;
import core.entity.TsTask;
import core.entity.system.SysDept;
import core.entity.system.SysUser;
import core.util.Page;

@Controller
public class TsTaskController extends BaseController {

	@Resource
	private TsTaskService taskService;
	@Resource
	private SysDeptService deptService;

	/**
	 * 部门任务首页
	 * 
	 * @return
	 */
	@RequestMapping("mDeptTaskMain.do")
	public ModelAndView mDeptTaskMain(Page page,HttpSession session) {
		mv.clear();
		pd = this.getPageData();
		SysUser user=(SysUser) session.getAttribute("user");
		String fDept=user.getfDept();
		
		pd.put("fDept", fDept);
		page.setPd(pd);
		List<TsTask> taskList = taskService.selectByPage(page);
		mv.addObject("taskList", taskList);
		
		mv.setViewName("task/deptTaskMain");
		return mv;
	}
	
	
	/**
	 * 部门任务编辑页面UI
	 */
	@RequestMapping("mDeptTaskUI.do")
	public ModelAndView mDeptTaskUI(Integer fId,HttpSession session) {
		mv.clear();
		
		TsTask task = taskService.selectById(fId);
		mv.addObject("task", task);
		
		//部门责任人
		SysUser user=(SysUser) session.getAttribute("user");
		String fDept=user.getfDept();
		String fDutyPerson=deptService.findDutyPersonByDept(fDept);
		mv.addObject("fDutyPerson", fDutyPerson);
		
		mv.addObject("nowDate", nowDate);
		
		mv.setViewName("task/deptTaskUI");
		return mv;
	}
	
	//=============================分割线===================================
	
	/**
	 * 全部任务首页
	 * 
	 * @return
	 */
	@RequestMapping("mTaskMain.do")
	public ModelAndView taskMain(Page page) {
		mv.clear();

		// 需提交任务上报的部门
		List<SysDept> deptList = deptService.selectTaskDept();
		mv.addObject("deptList", deptList);

		pd = this.getPageData();
		page.setPd(pd);
		List<TsTask> taskList = taskService.selectByPage(page);
		mv.addObject("taskList", taskList);
		
		mv.setViewName("task/taskMain");
		return mv;
	}

	/**
	 * 全部任务编辑页面UI
	 */
	@RequestMapping("mTaskUI.do")
	public ModelAndView taskUI(Integer fId) {
		mv.clear();

		// 需提交任务上报的部门
		List<SysDept> deptList = deptService.selectTaskDept();
		mv.addObject("deptList", deptList);

		TsTask task = taskService.selectById(fId);
		mv.addObject("task", task);

		mv.addObject("nowDate", nowDate);

		mv.setViewName("task/taskUI");
		return mv;
	}
	
	/**
	 * 查询部门下的责任人
	 * @param fDept
	 * @return
	 */
	@RequestMapping("mFindDutyPerson.do")
	@ResponseBody
	public String findDutyPerson(String fDept){
		return deptService.findDutyPersonByDept(fDept);
	}
	
	//============================任务查看===============================
	
	/**
	 * 全部任务编辑页面UI
	 */
	@RequestMapping("mTaskShow.do")
	public ModelAndView mTaskShow(Integer fId) {
		mv.clear();
		TsTask task = taskService.selectById(fId);
		mv.addObject("task", task);
		mv.setViewName("task/taskShow");
		return mv;
	}
	

	// ========================以下CRUD=================================

	/**
	 * 增
	 * 
	 * @param task
	 * @return
	 */
	@RequestMapping("mTaskInsert.do")
	@ResponseBody
	public int taskInsert(TsTask task) {
        return taskService.insert(task);
		//return taskService.remindPersonAndInsert(task);
	}
	
	/**
	 * 保存是发送提醒短信
	 */
	@RequestMapping("mFirstSendMsg.do")
    public void mFirstSendMsg(TsTask task){
		taskService.mFirstSendMsg(task);
	}
	/**
	 * 删
	 * 
	 * @param task
	 * @return
	 */
	@RequestMapping("mTaskDelete.do")
	@ResponseBody
	public int mTaskDelete(String fIds) {
		pd = this.getPageData();
		return taskService.deleteByIds(pd);
	}

	/**
	 * 改
	 * 
	 * @param task
	 * @return
	 */
	@RequestMapping("mTaskUpdate.do")
	@ResponseBody
	public int mTaskUpdate(TsTask task) {
		task.setfAttachment(task.getfAttachment() == null ? "" : task
				.getfAttachment());
		task.setfAttachmentUrl(task.getfAttachmentUrl() == null ? "" : task
				.getfAttachmentUrl());
		
		task.setfLeadKnow(task.getfLeadKnow()==null?"":task.getfLeadKnow());//上级知晓
		
		return taskService.update(task);
	}
	
	// ============================数据导出============================================

		@RequestMapping("taskExcel.do")
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
			cell.setCellValue("单位");
			cell = row.createCell((short) 2);
			cell.setCellValue("重点工作内容");
			cell = row.createCell((short) 3);
			cell.setCellValue("开始时间");
			cell = row.createCell((short) 4);
			cell.setCellValue("完成时间");
			cell = row.createCell((short) 5);
			cell.setCellValue("进度情况");
			cell = row.createCell((short) 6);
			cell.setCellValue("责任单位");
			cell = row.createCell((short) 7);
			cell.setCellValue("配合单位");
			cell = row.createCell((short) 8);
			cell.setCellValue("责任人");
			cell = row.createCell((short) 9);
			cell.setCellValue("上级知晓");

			// 第五步，写入实体数据 ,此处数据由前台表单传送过来

			pd = this.getPageData();
			List<TsTask> taskList = taskService.selectByPageData(pd);


			for (int i = 0; i < taskList.size(); i++) {
				// 表体

				row = sheet.createRow((int) i + 1);

				cell = row.createCell((short) 0);
				cell.setCellValue(i + 1);

				cell = row.createCell((short) 1);
				cell.setCellValue(taskList.get(i).getfDept());

				cell = row.createCell((short) 2);
				cell.setCellValue(taskList.get(i).getfContent());

				cell = row.createCell((short) 3);
				cell.setCellValue(taskList.get(i).getfSdate());

				cell = row.createCell((short) 4);
				cell.setCellValue(taskList.get(i).getfEdate());
				
				cell = row.createCell((short) 5);
				cell.setCellValue(taskList.get(i).getfWork());
				
				cell = row.createCell((short) 6);
				cell.setCellValue(taskList.get(i).getfDutyDept());
				
				cell = row.createCell((short) 7);
				cell.setCellValue(taskList.get(i).getfFitDept());
				
				cell = row.createCell((short) 8);
				cell.setCellValue(taskList.get(i).getfDutyPerson());
				
				cell = row.createCell((short) 9);
				cell.setCellValue(taskList.get(i).getfLeadKnow());

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
