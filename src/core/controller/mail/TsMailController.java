package core.controller.mail;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsMail;
import core.entity.system.SysUser;
import core.util.DateUtil;
import core.util.Page;
import core.util.PageData;

@Controller
public class TsMailController extends BaseController{

	@Resource
	private TsMailService mailService;
	
	/**
	 * 搜索通讯录列表
	 * @return
	 */
	@RequestMapping("mSearchPerson.do")
	@ResponseBody
	public Page searchPerson(Page page){
		pd=this.getPageData();
		page.setPd(pd);
		List<PageData> results=mailService.searchPerson(page);
		page.setResults(results);
		return page;
	}
	
	//=========================发送个人邮件============================
	
	/**
	 * 发送个人邮件,(若有id则为从草稿箱取邮件)
	 * @return
	 */
	@RequestMapping("mSendPersonMail.do")
	public ModelAndView sendPersonMail(Integer fId,HttpSession session){
		mv.clear();
		String tableName=this.getPersonMail(session);
		pd.put("tableName", tableName);
		pd.put("fId", fId);
		PageData pData=mailService.selectMailById(pd);
		mv.addObject("pData", pData);
		mv.setViewName("mail/sendPersonMail");
		return mv;
	}
	
	/**
	 * 邮件发送
	 */
	@RequestMapping("mCmdSendPersonMail.do")
	@ResponseBody
	public int doSendPersonMail(HttpSession session,TsMail mail){
		SysUser user=(SysUser) session.getAttribute("user");
		String fId=String.valueOf(user.getfId());
		String tableName="personmail_"+fId;//获取个人邮件表名称
		
		pd=this.getPageData();
		pd.put("tableName", tableName);//自己的邮箱表
		
		pd.put("fSendId", user.getfId());//发件人id
		pd.put("fSend", user.getfCname());//发件人姓名
		pd.put("fSendTime", DateUtil.getTime());//发件时间
		pd.put("fFolder", "已发送");//发送文件夹分类
		pd.put("fStatus", "已阅");//邮件状态
		pd.put("fAttachmentId", mail.getfAttachmentId());//附件编号
		pd.put("fAttachment", mail.getfAttachment());//附件
				
		return mailService.cmdSendPersonMail(pd);
	}
	
	/**
	 * 存草稿箱 邮件
	 * @param session
	 * @return
	 */
	@RequestMapping("mSaveDrafts.do")
	@ResponseBody
	public int mSaveDrafts(HttpSession session,TsMail mail){
		SysUser user=(SysUser) session.getAttribute("user");
		String fId=String.valueOf(user.getfId());
		String tableName="personmail_"+fId;//获取个人邮件表名称
		
		pd=this.getPageData();
		pd.put("tableName", tableName);//自己的邮箱表
		
		pd.put("fSendId", user.getfId());//发件人id
		pd.put("fSend", user.getfCname());//发件人姓名
		pd.put("fSendTime", DateUtil.getTime());//发件时间
		pd.put("fFolder", "草稿箱");//发送文件夹分类
		pd.put("fStatus", "已阅");//邮件状态
		pd.put("fAttachmentId", mail.getfAttachmentId());//附件编号
		pd.put("fAttachment", mail.getfAttachment());//附件
		
		pd.put("fReceipt", pd.get("fReceipt")==null?"":pd.get("fReceipt"));//是否需要回执
		pd.put("fSms", pd.get("fSms")==null?"":pd.get("fSms"));//是否短信提醒
		
		return mailService.saveDrafts(pd);
	}
	
	
	//============================收件箱==================================
	
	/**
	 * 收件箱,查收邮件
	 */
	@RequestMapping("mRecMail.do")
	public ModelAndView recMail(Page page,HttpSession session){
		mv.clear();
		String tableName=this.getPersonMail(session);
		pd.put("tableName", tableName);
		page.setPd(pd);
		List<PageData> pdList=mailService.recMail(page);
		mv.addObject("pdList", pdList);
		mv.setViewName("mail/recMail");
		return mv;
	}
	
	/**
	 * 查看收到的 邮件
	 * @return
	 */
	@RequestMapping("mSeeRecMail.do")
	public ModelAndView mSeeRecMail(Integer fId,HttpSession session){
		mv.clear();
		//String tableName=this.getPersonMail(session);
		SysUser user=(SysUser) session.getAttribute("user");
		String fUserId=String.valueOf(user.getfId());
		String tableName="personmail_"+fUserId;//获取个人邮件表名称
		String fUserName=user.getfCname();
		
		pd.put("fUserName", fUserName);//当前用户
		pd.put("fId", fId);
		pd.put("tableName", tableName);
		PageData pData=mailService.seeMailById(pd);//查看邮件，如需回执则发送回执
		mv.addObject("pData", pData);
		mv.setViewName("mail/seeRecMail");
		return mv;
	}
	
	/**
	 * 回复个人邮件
	 * @return
	 */
	@RequestMapping("mReplyMail.do")
	public ModelAndView replyMail(Integer fId){
		mv.clear();
		pd.put("fId", fId);
		PageData pData=mailService.selectMailById(pd);
		mv.addObject("pData", pData);
		mv.setViewName("mail/replyPersonMail");
		return mv;
	}
	
	/**
	 * 转发个人邮件
	 * @param fId
	 * @return
	 */
	@RequestMapping("mTranMail.do")
	public ModelAndView tranMail(Integer fId){
		mv.clear();
		pd.put("fId", fId);
		PageData pData=mailService.seeMailById(pd);
		mv.addObject("pData", pData);
		mv.setViewName("mail/tranPersonMail");
		return mv;
	}
	
	
	//=============================已发送======================================
	
	/**
	 * 我的 已发送 邮件
	 * @return
	 */
	@RequestMapping("mMySentMail.do")
	public ModelAndView mySent(Page page,HttpSession session){
		mv.clear();
		String tableName=this.getPersonMail(session);//获取个人 邮箱地址
		pd.put("tableName", tableName);
		page.setPd(pd);
		List<PageData> pdList=mailService.selectMySent(page);
		mv.addObject("pdList", pdList);
		mv.setViewName("mail/mySentMail");
		return mv;
	}
	
	//=============================草稿箱======================================
	
	/**
	 * 我的 草稿箱 邮件
	 * @return
	 */
	@RequestMapping("mMyDraftsMail.do")
	public ModelAndView mMyDraftsMail(Page page,HttpSession session){
		mv.clear();
		String tableName=this.getPersonMail(session);//获取个人 邮箱地址
		pd.put("tableName", tableName);
		page.setPd(pd);
		List<PageData> pdList=mailService.selectMyDraftsMail(page);
		mv.addObject("pdList", pdList);
		mv.setViewName("mail/myDraftsMail");
		return mv;
	}
	
	
	//=============================已删除======================================
	
	/**
	 * 我的 已删除 邮件
	 * @return
	 */
	@RequestMapping("mMyDeleteMail.do")
	public ModelAndView myDeleteMail(Page page,HttpSession session){
		mv.clear();
		String tableName=this.getPersonMail(session);//获取个人 邮箱地址
		pd.put("tableName", tableName);
		page.setPd(pd);
		List<PageData> pdList=mailService.selectMyDelete(page);
		mv.addObject("pdList", pdList);
		mv.setViewName("mail/myDeleteMail");
		return mv;
	}
	
	/**
	 * 保留删除  邮件
	 * @param fIds
	 * @return
	 */
	@RequestMapping("mReservedDelete.do")
	@ResponseBody
	public int reservedDelete(HttpSession session,String fIds){
		String tableName=this.getPersonMail(session);
		pd.put("tableName", tableName);
		pd.put("fIds", fIds);
		return mailService.reservedDelete(pd);
	}
	
	/**
	 * 彻底删除 邮件
	 * @return
	 */
	@RequestMapping("mCompleteDelete.do")
	@ResponseBody
	public int completeDelete(HttpSession session,String fIds){
		String tableName=this.getPersonMail(session);
		pd.put("tableName", tableName);
		pd.put("fIds", fIds);
		return mailService.completeDelete(pd);
	}
	
	//=======================================================================
	
	/**
	 * 删除数据表 drop table
	 */
	@RequestMapping("mTsMailDrop")
	public void mTsMailDrop(){
		mailService.mTsMailDrop(pd);
	}
	
	/**
	 * 动态建表
	 */
	@RequestMapping("mTsMailCreate")
	public void TsMailCreate(){
		mailService.mailCreate(pd);
	}
}
