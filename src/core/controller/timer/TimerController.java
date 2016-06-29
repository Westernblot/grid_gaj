package core.controller.timer;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import core.controller.base.BaseController;
import core.controller.onduty.TsOndutyService;
import core.controller.record.TsRecordService;
import core.controller.sms.SmsController;
import core.controller.system.user.SysUserService;
import core.controller.task.TsTaskService;
import core.entity.TsOnduty;
import core.entity.TsRecord;
import core.util.ComUtil;
import core.util.DateUtil;
import core.util.SmsUtil.SMSDLL;

/**
 * spring 定时器
 * 
 * @author Administrator
 * 
 */
@Controller
public class TimerController extends BaseController {

	@Resource
	private TsRecordService recordService;// 消息记录service
	@Resource
	private TsOndutyService ondutyService;// 值班service
	@Resource
	private SysUserService userService;// 用户service
	@Resource
	private TsTaskService taskService;// 重点工作内容
	@Resource
	private TimerService timerService;// 定时service

	/**
	 * 定时器测试 每10秒执行一次
	 */
	@Scheduled(cron = "0/10 * * * * ?")
	public void testTimer() {
		new SmsController().startService();// 开启服务
		// SMSDLL.INSTANCE.SMSSendMessage("湖北网格软件测试短信", "13297234911");
		System.out.println("========10秒定时器执行=========");
	}

	/**
	 * 按时间点 短信提醒
	 */
	@Scheduled(cron = "0 0/5 * * * ?")
	public void remindSms() {

		List<TsRecord> recordList = recordService.selectRemindData();

		if (recordList.size() > 0) {
			new SmsController().startService();// 开启服务

			for (TsRecord record : recordList) {
				String phone = record.getfSubject();
				String msg = record.getfContent();
				SMSDLL.INSTANCE.SMSSendMessage(msg, phone);

				// 写入消息记录表
				record.setfRemindTime("");// 取消重复提醒
				recordService.insert(record);
			}
		}
	}

	/**
	 * LED 屏数据输出,每天早上0点5分执行 0 5 0 * * ? 每天早上8点执行 0 0 8 * * ?
	 * 
	 * @throws Exception
	 */
	@Scheduled(cron = "0 0 8 * * ?")
	public void showLED() throws Exception {

		// 今日值班
		String fMonth = DateUtil.getDay().substring(0, 7);
		pd.put("fMonth", fMonth);
		TsOnduty onduty = ondutyService.selectByfMonth(pd);
		if (onduty != null) {
			Integer num = Integer.valueOf(DateUtil.getDay().substring(8, 10)) - 1;
			System.out.println(num);
			String fLeader = onduty.getfLeader().split(",")[num];
			String fPolice = onduty.getfPolice().split(",")[num];

			// 取用户的号码
			String fLeaderPhone = userService.findPhoneByName(fLeader);
			String fPolicePhone = userService.findPhoneByName(fPolice);

			// System.out.println("带班领导："+fLeader+"值班人员："+fPolice);

			String msg1 = "带班领导：" + fLeader + "    " + fLeaderPhone;
			if (fLeader.length() == 2) {
				msg1 = "带班领导：" + fLeader + "      " + fLeaderPhone;
			}

			String msg2 = "值班人员：" + fPolice + "    " + fPolicePhone;
			if (fPolice.length() == 2) {
				msg2 = "值班人员：" + fPolice + "      " + fPolicePhone;
			}

			// 向LED 屏幕写数据
			ComUtil.sendComLED(2, msg1);
			Thread.sleep(10000);
			ComUtil.sendComLED(3, msg2);
		}

	}

	// ==============================分割线==============================================

	/**
	 * 重点工作内容：短信提醒相关人员 每天下午16点执行 0 0 16 * * ?
	 * 
	 * @throws Exception
	 */
	@Scheduled(cron = "0 0 16 * * ?")
	// @RequestMapping("task")
	public void taskRemind() throws Exception {
		String bfDate = DateUtil.getAfterDayDate("3");
		taskService.SmsRemind(bfDate);
	}

	/**
	 * 临时附件表 attachmnet 清除,只保留1000条最新附件 每天晚上2点执行 0 0 2 * * ?
	 * 
	 * @throws Exception
	 */
	@Scheduled(cron = "0 0 2 * * ?")
	// @RequestMapping("delAttachment")
	public void deleteAttachment() {
		timerService.deleteAttachment();
	}

	@Test
	public void test1() {

		String name1 = "张三";
		String name2 = "李思明";

		if (name1.length() == 2) {
			name1 = name1.substring(0, 1) + "  " + name1.substring(1, 2);
			;
		}

		System.out.println(name1);

		System.out.println(name1.length());
		System.out.println(name2.length());

	}

}
