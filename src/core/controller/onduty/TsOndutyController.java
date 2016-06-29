package core.controller.onduty;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.system.user.SysUserService;
import core.entity.TsOnduty;
import core.util.ComUtil;
import core.util.DateUtil;
import core.util.Page;

@Controller
public class TsOndutyController extends BaseController{

	@Resource
	private TsOndutyService ondutyService;
	@Resource
	private SysUserService userService;
	
	/**
	 * 支队月 值班表
	 * @return
	 */
	@RequestMapping("mOndutyMain.do")
	public ModelAndView ondutyMain(Page page){
		mv.clear();
		List<TsOnduty> ondutyList=ondutyService.selectByPage(page);
		mv.addObject("ondutyList", ondutyList);
		mv.setViewName("onduty/ondutyMain");
		return mv;
	}
	
	/**
	 * 支队 月值班表 新增、编辑
	 * @return
	 */
	@RequestMapping("mOndutyUI.do")
	public ModelAndView ondutyUI(Integer fId){
		mv.clear();
		//List<TsOnduty> ondutyList=ondutyService.selectByfMonth(pd);
		TsOnduty onduty=ondutyService.selectById(fId);
		mv.addObject("onduty", onduty);
		mv.setViewName("onduty/ondutyUI");
		return mv;
	}
	
	/**
	 * 判断当前月份值班表是否已经添加
	 * @param fMonth
	 * @return
	 */
	@RequestMapping("mOndutyCheckMonth.do")
	@ResponseBody
	public int  ondutyCheck(String fMonth){
		pd.put("fMonth", fMonth);
		return ondutyService.checkfMonth(pd);
	}
	
	
	//========================分割线================================
	
	/**
	 * 值班表数据导入
	 * @return
	 */
	@RequestMapping("mOndutyImportUI.do")
	public String ondutyImportUI(){
		return "onduty/ondutyImportUI";
	}
	
	
	/**
	 * 值班表导入
	 */
	@RequestMapping(value = "mOndutyImportExcel.do")
	public void ondutyImport(HttpServletRequest req, HttpServletResponse res,TsOnduty onduty) throws IOException {
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=UTF-8");
		JSONObject json = new JSONObject();
		try {
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(req.getSession().getServletContext());
			if (multipartResolver.isMultipart(req)) {
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
				Iterator<String> iter = multipartRequest.getFileNames();
				while (iter.hasNext()) {
					MultipartFile uploadFile = multipartRequest.getFile(iter.next());
					String fileName = uploadFile.getOriginalFilename();
					// 验证文件类型
					String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length()).toLowerCase();
					InputStream is = uploadFile.getInputStream();
					if (fileType.equals(".xls")) {
						HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
						HSSFSheet sheet = hssfWorkbook.getSheetAt(0);
						
						String fLeader="";//带班领导
						String fPolice="";//值班人员
						
						int rows = sheet.getLastRowNum();
						for (int i = 1; i <= rows; i++) {
							HSSFRow row = sheet.getRow(i);
							
							if(fLeader.equals("")){
								fLeader=getValue(row.getCell(1));
							}else{
								fLeader+=","+getValue(row.getCell(1));
							}
							
							
							if(fPolice.equals("")){
								fPolice=getValue(row.getCell(2));
							}else{
								fPolice+=","+getValue(row.getCell(2));
							}
						}
							onduty.setfLeader(fLeader);
							onduty.setfPolice(fPolice);
							onduty.setfDate(nowDate);
							
					    int flag=ondutyService.insert(onduty);		
						json.accumulate("flag", flag);
					
					}
					else {
						XSSFWorkbook workbook = new XSSFWorkbook(is);
						XSSFSheet sheet = workbook.getSheetAt(0);
						
						
						String fLeader="";//带班领导
						String fPolice="";//值班人员
		
						int rows = sheet.getLastRowNum();
						for (int i = 1; i <= rows; i++) {
							XSSFRow row = sheet.getRow(i);
							
							if(fLeader.equals("")){
								fLeader=row.getCell(1).getRawValue();
							}else{
								fLeader+=","+row.getCell(1).getRawValue();
							}
							
							
							if(fPolice.equals("")){
								fPolice=row.getCell(2).getRawValue();
							}else{
								fPolice+=","+row.getCell(2).getRawValue();
							}
							
						}
						
						onduty.setfLeader(fLeader);
						onduty.setfPolice(fPolice);
						onduty.setfDate(nowDate);
						
				    int flag=ondutyService.insert(onduty);		
					json.accumulate("flag", flag);
					
					}
				}
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			json.accumulate("flag", 0);
		}
		res.getWriter().print(json);
	}
	
	
	@SuppressWarnings("static-access")
	private String getValue(HSSFCell cell) {
		if (cell == null) {
			return "";
		}
		else if (cell.getCellType() == cell.CELL_TYPE_BOOLEAN) {
			// 返回布尔类型的值
			return String.valueOf(cell.getBooleanCellValue());
		}
		else if (cell.getCellType() == cell.CELL_TYPE_NUMERIC) {
			if (HSSFDateUtil.isCellDateFormatted(cell)) {
				double d = cell.getNumericCellValue();
				Date date = HSSFDateUtil.getJavaDate(d);
				return new SimpleDateFormat("yyyy-MM-dd").format(date);
			}
			else {
				// 返回数值类型的值
				return String.valueOf(cell.getNumericCellValue());
			}
		}
		else {
			// 返回字符串类型的值
			return String.valueOf(cell.getStringCellValue());
		}
	}
	
	
	//========================CRUD=================================
	
	/**
	 * 增
	 * @param onduty
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("mOndutyInsert.do")
	@ResponseBody
	public int ondutyInsert(TsOnduty onduty) throws Exception{
		int flag=ondutyService.insert(onduty);
		return flag;
	}
	
	/**
	 * 删
	 * @param onduty
	 * @return
	 */
	@RequestMapping("mOndutyDelete.do")
	@ResponseBody
	public int ondutyDelete(String fIds){
		pd.put("fIds", fIds);
		return ondutyService.deleteByIds(pd);
	}
	
	/**
	 * 改
	 * @param onduty
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("mOndutyUpdate.do")
	@ResponseBody
	public int ondutyUpdate(TsOnduty onduty) throws Exception{
		int flag=ondutyService.update(onduty);
		return flag;
	}
	
	/**
	 * 向LED屏幕发送命令
	 * @throws Exception
	 */
	@RequestMapping("sendLedMsg.do")
	public void showLED() throws Exception {

		// 今日值班
		String fMonth = DateUtil.getDay().substring(0, 7);
		pd.put("fMonth", fMonth);
		System.out.println(fMonth);
		TsOnduty onduty = ondutyService.selectByfMonth(pd);
		if (onduty != null) {
			Integer num = Integer.valueOf(DateUtil.getDay().substring(8, 10)) - 1;
			System.out.println(num);
			String fLeader = onduty.getfLeader().split(",")[num];
			String fPolice = onduty.getfPolice().split(",")[num];
			
		
			//取用户的号码
			String fLeaderPhone=userService.findPhoneByName(fLeader);
			String fPolicePhone=userService.findPhoneByName(fPolice);
			
		//	System.out.println("带班领导："+fLeader+"值班人员："+fPolice);
			
			String msg1="带班领导："+fLeader+"    "+fLeaderPhone;
			if(fLeader.length()==2){
				msg1="带班领导："+fLeader+"      "+fLeaderPhone;
			}
			
			String msg2="值班人员："+fPolice+"    "+fPolicePhone;
			if(fPolice.length()==2){
				msg2="值班人员："+fPolice+"      "+fPolicePhone;
			}
			
			//向LED 屏幕写数据
			ComUtil.sendComLED(2, msg1);
			Thread.sleep(10000);
			ComUtil.sendComLED(3, msg2);
		}

	}
	
}
