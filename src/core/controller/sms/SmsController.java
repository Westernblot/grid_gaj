package core.controller.sms;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.record.TsRecordService;
import core.controller.system.dept.SysDeptService;
import core.controller.system.user.SysUserService;
import core.entity.TsRecord;
import core.entity.system.SysDept;
import core.entity.system.SysUser;
import core.util.DateUtil;
import core.util.PropertiesUtil;
import core.util.SmsUtil.SMSDLL;

@Controller
public class SmsController extends BaseController{

	@Resource
	private SysUserService userService;
	@Resource
	private TsRecordService recordService;
	
	private int port;//定义短信猫接口
	
	/**
	 * 发送短信
	 * @return
	 */
	@RequestMapping("mSendSms.do")
	public ModelAndView sendSms(){
		mv.clear();
		mv.setViewName("sms/sendSms");
		return mv;
	}
	
	/**
	 * 按号码发送短信
	 * @return
	 */
	@RequestMapping("mSendSmsPhone.do")
	public ModelAndView sendSmsPhone(){
		mv.clear();
		mv.setViewName("sms/sendSmsPhone");
		return mv;
	}
	
	//=======================分割线=================================
	
	/**
	 * 发送短信
	 * @throws Exception
	 */
	@RequestMapping("sendMessage.do")
	@ResponseBody
	public int sendMessage(String fReceivedIds,String fSmsMsg,String fRemindTime,HttpSession session) throws Exception{
		int flag=this.startService();
		if(flag==0){
		//	return 0;
		}

		pd.put("fIds", fReceivedIds);
		List<SysUser> userList=userService.findUserByIds(pd);
		for(SysUser u:userList){
			String phone=u.getfPhone();
			SMSDLL.INSTANCE.SMSSendMessage(fSmsMsg, phone);
			
			//写入消息记录表
			TsRecord record=new TsRecord();
			SysUser user=(SysUser) session.getAttribute("user");
			record.setfAddId(user.getfId());
			record.setfAddName(user.getfCname());
			record.setfAddDate(DateUtil.getTime());
			record.setfType("邮件-短信提醒");
			record.setfSubject(phone);
			record.setfContent(fSmsMsg);
			record.setfRemindTime(fRemindTime);//重复提醒时间
			recordService.insert(record);
		}
		
		return 1;
		
//		int smscode = SMSDLL.INSTANCE.SMSSendMessage(msg, phone);
//		for (int i = 0; i < 10; i++) {
//			Thread.sleep(1000);
//			System.out.println("第" + Integer.toString(i) + "秒 -- "
//					+ SMSDLL.INSTANCE.SMSQuery(smscode));
//		}
	}
	
	
	//=========================分割线===========================================
	@RequestMapping("sendMessagePhone.do")
	@ResponseBody
	public int sendMessagePhone(String phones,String msg,HttpSession session) throws Exception{
		
		int flag=this.startService();
		if(flag==0){
			return 0;
		}

		String[] phoneArry=phones.split(",");
		
		for(int i=0;i<phoneArry.length;i++){
			String phone=phoneArry[i];
			SMSDLL.INSTANCE.SMSSendMessage(msg, phone);
			
			//写入消息记录表
			TsRecord record=new TsRecord();
			SysUser user=(SysUser) session.getAttribute("user");
			record.setfAddId(user.getfId());
			record.setfAddName(user.getfCname());
			record.setfAddDate(DateUtil.getTime());
			record.setfType("号码群发-短信提醒");
			record.setfSubject(phone);
			record.setfContent(msg);
			recordService.insert(record);
		}
		
		return 1;
		
	} 
	
	
	//==========================部门短信提醒========================================
	
	@Resource
	private SysDeptService deptService;
	
	/**
	 * 签收文件 给部门手机 发短信提醒：
	 * 1.此处为新加功能，传递参数为 部门名称。
	 * @return
	 */
	@RequestMapping("sendMessageDept.do")
	@ResponseBody
	public int sendMessageDept(String fRecDept,String fSmsMsg,HttpSession session){
       
		int flag=this.startService();
		if(flag==0){
			return 0;
		}

		fRecDept="'"+fRecDept.replace(",", "','")+"'";   //处理部门字符串
		pd.put("fDeptName", fRecDept);
		List<SysDept> deptList=deptService.selectByDeptName(pd);
		
		for(SysDept dept:deptList){
			String phone=dept.getfPhone();
			SMSDLL.INSTANCE.SMSSendMessage(fSmsMsg, phone);
			
			//写入消息记录表
			TsRecord record=new TsRecord();
			SysUser user=(SysUser) session.getAttribute("user");
			record.setfAddId(user.getfId());
			record.setfAddName(user.getfCname());
			record.setfAddDate(DateUtil.getTime());
			record.setfType("文件签收-短信提醒");
			record.setfSubject(phone);
			record.setfContent(fSmsMsg);
			recordService.insert(record);
		}
		
		return 1;
	}
	
	
	
	//=====================通用方法===================================
	
	/**
	 * 开启短信服务
	 * @return
	 */
	public int startService(){
	      System.setProperty("jna.encoding", "GBK"); // 改变JNA的编码，解决短信接收乱码的问题
			
	      //读取配置文件sms.port信息,port 默认配置为 int port = 1;
	      port=Integer.valueOf(new PropertiesUtil().getPropertiesValue("jdbc.properties","sms.port"));	

			//查询服务是否正常
			int bb = SMSDLL.INSTANCE.SMSServiceStartedByPort(port);
			System.out.println(bb);
			
			if(bb>0){
				System.out.println(bb+"服务已启动！");
				return 1;
			}else{
				
				//打开服务
				int aa = SMSDLL.INSTANCE.SMSStartService(port, 115200, 2, 8, 0, 0,"card");
				if(aa>0){
					System.out.println(aa+"服务启动OK！");
					return 1;
				}else{
					System.out.println(aa+"服务启动失败！");
					return 0;
				}
			}
	}
}
