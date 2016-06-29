package core.controller.base;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.sun.istack.internal.logging.Logger;

import core.entity.system.SysUser;
import core.util.DateUtils;
import core.util.Page;
import core.util.PageData;
import core.util.UuidUtil;

public class BaseController {
	
	protected Logger logger = Logger.getLogger(this.getClass());

	private static final long serialVersionUID = 6357869213649815390L;
	
	protected ModelAndView mv = this.getModelAndView();

	protected JSONObject json=this.getJSONObject();
	
	protected PageData pd = new PageData();
	
	protected String nowDate=this.getNowDate();
	
	/**
	 * 获取当前时间		
	 */
    public String getNowDate(){
		DateUtils dt=new DateUtils();
		return dt.showDate("yyyy-MM-dd");
		
	}

	
	/**
	 * 切换菜单
	 */
	public void setPdmenu(PageData pd){
		mv.addObject("pdm",pd);
	}
	
	
	/**
	 * 得到PageData
	 */
	public PageData getPageData(){
		return new PageData(this.getRequest());
	}
	
	/**
	 * 得到ModelAndView
	 */
	public ModelAndView getModelAndView(){
		
		return new ModelAndView();
	}
	
	/**
	 * 得到JSONObject
	 */
	public JSONObject getJSONObject(){

		return new JSONObject();
	}
	
	/**
	 * 得到request对象
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		return request;
	}

	/**
	 * 得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		
		return UuidUtil.get32UUID();
	}
	
	/**
	 * 得到分页列表的信息 
	 */
	public Page getPage(){
		
		return new Page();
	}
	
	public static void logBefore(Logger logger, String interfaceName){
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}
	
	public static void logAfter(Logger logger){
		logger.info("end");
		logger.info("");
	}
	
	
	//=======================分割线====================================
	
	/**
	 * 获取个人 邮箱表
	 * @param session
	 * @return
	 */
	public String getPersonMail(HttpSession session){
		SysUser user=(SysUser) session.getAttribute("user");
		String fId=String.valueOf(user.getfId());
		String tableName="personmail_"+fId;//获取个人邮件表名称
		return tableName;
	}
	
	
}
