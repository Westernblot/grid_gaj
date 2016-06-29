package core.controller.task;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsRecord;
import core.entity.TsTask;
import core.entity.system.SysUser;
import core.util.DateUtil;
import core.util.PageData;
import core.util.PropertiesUtil;
import core.util.SmsUtil.SMSDLL;

@Service
public class TsTaskService extends BaseService<TsTask> {

	/**
	 * 定时短信提醒;每天下午4点执行
	 * 
	 * @param bfDate
	 */
	public void SmsRemind(String bfDate) {
		// TODO Auto-generated method stub

		//this.startService();// 开启短信服务
		int flag=this.startService();
		if(flag==0){
			return;
		} 

		// 查询出需要提醒的数据
		List<TsTask> taskList = (List<TsTask>) dao.findForList(
				"TsTaskMapper.selectNeedRemind", bfDate);

		for (TsTask task : taskList) {

			// =========================部门短信提醒====================================

			String fDutyDept = task.getfDutyDept();// 责任单位
			String fFitDept = task.getfFitDept(); // 配合单位

			String fDept = fDutyDept + "," + fFitDept; // 需要提醒的单位
			fDept = "'" + fDept.replace(",", "','") + "'"; // 处理部门字符串

			PageData pDept = new PageData();
			pDept.put("fDept", fDept); // 封装数据

			List<PageData> deptList = (List<PageData>) dao.findForList(
					"TsTaskMapper.selectDeptPhone", pDept);

			String msg = task.getfContent(); // 重点工作内容
			int length = msg.length();
			if (length > 20) {
				msg = msg.substring(0, 20) + "...";
			}

			String phone = ""; // 准备发送的电话号码链接字符串

			for (int i = 0; i < deptList.size(); i++) {

				if (phone.equals("")) {
					phone = deptList.get(i).getString("F_PHONE");
				} else if (phone.indexOf(deptList.get(i).getString("F_PHONE")) == -1) {
					phone += "," + deptList.get(i).getString("F_PHONE");
				}

			}

			// =========================责任人短信提醒====================================

			String fName = task.getfDutyPerson();// 责任人
			if (task.getfLeadKnow().equals("是")) {
				fName += ",上级知晓";
			}
			fName = "'" + fName.replace(",", "','") + "'"; // 处理姓名字符串

			PageData pPerson = new PageData();
			pPerson.put("fName", fName); // 封装数据

			List<PageData> userList = (List<PageData>) dao.findForList(
					"TsTaskMapper.selectPersonPhone", pPerson);

			for (int j = 0; j < userList.size(); j++) {

				if (phone.equals("")) {
					phone = userList.get(j).getString("F_PHONE");
				} else if (phone.indexOf(deptList.get(j).getString("F_PHONE")) == -1) {
					phone += "," + userList.get(j).getString("F_PHONE");
				}

			}

			// ======================电话号码获取完毕，开始发送短信==================================================

			//System.out.println("phone=" + phone);

			// 如果取到电话才发送短信提醒
			if (!phone.equals("")) {

				String[] phones = phone.split(",");

				for (int m = 0; m < phones.length; m++) {

					if (phones[m].length() == 11) {// 如果电话号码为11位，则发送短信

						SMSDLL.INSTANCE.SMSSendMessage("您有一个重点工作安排需要处理；内容为：" + msg, phones[m]);

						// 写入消息记录表
						TsRecord record = new TsRecord();
						record.setfAddId(0);
						record.setfAddName("系统");
						record.setfAddDate(DateUtil.getTime());
						record.setfType("重点工作内容-短信提醒");
						record.setfSubject(phones[m]);
						record.setfContent("您有一个重点工作安排需要处理；内容为：" + msg);
						dao.save("TsRecordMapper.insert", record);// 写入消息记录表
					}
				}
			}

		}

		// 修改已提醒人员状态:修改F_FLAG = 已提醒
		dao.update("TsTaskMapper.updateRemindTask", bfDate);

	}

	
    /**
     * 保存时，提醒上级知晓和责任人
     * @param task
     * @return
     */
	public void mFirstSendMsg(TsTask task) {
		// TODO Auto-generated method stub
		
		//this.startService();// 开启短信服务
		int flag=this.startService();
		if(flag==0){
			return;
		}
		
		// =========================责任人短信提醒====================================
		
		String phone = ""; // 准备发送的电话号码链接字符串
		
		String msg = task.getfContent(); // 重点工作内容
		int length = msg.length();
		if (length > 20) {
			msg = msg.substring(0, 20) + "...";
		}
		
					String fName = task.getfDutyPerson();// 责任人
					if (task.getfLeadKnow().equals("是")) {
						fName += ",上级知晓";
					}
					fName = "'" + fName.replace(",", "','") + "'"; // 处理姓名字符串

					PageData pPerson = new PageData();
					pPerson.put("fName", fName); // 封装数据

					List<PageData> userList = (List<PageData>) dao.findForList(
							"TsTaskMapper.selectPersonPhone", pPerson);

					for (int j = 0; j < userList.size(); j++) {

						if (phone.equals("")) {
							phone = userList.get(j).getString("F_PHONE");
						} else if (phone.indexOf(userList.get(j).getString("F_PHONE")) == -1) {
							phone += "," + userList.get(j).getString("F_PHONE");
						}

					}

					// ======================电话号码获取完毕，开始发送短信==================================================

					//System.out.println("phone=" + phone);

					// 如果取到电话才发送短信提醒
					if (!phone.equals("")) {

						String[] phones = phone.split(",");

						for (int m = 0; m < phones.length; m++) {

							if (phones[m].length() == 11) {// 如果电话号码为11位，则发送短信

								SMSDLL.INSTANCE.SMSSendMessage("您有一个重点工作安排需要处理；内容为：" + msg, phones[m]);

								// 写入消息记录表
								TsRecord record = new TsRecord();
								record.setfAddId(0);
								record.setfAddName("系统");
								record.setfAddDate(DateUtil.getTime());
								record.setfType("重点工作内容-短信提醒");
								record.setfSubject(phones[m]);
								record.setfContent("您有一个重点工作安排需要处理；内容为：" + msg);
								dao.save("TsRecordMapper.insert", record);// 写入消息记录表
							}
						}
					}
		
		//return (int) dao.save("TsTaskMapper.insert", task);
	}
	
	
	
	// =====================通用方法===================================

		/**
		 * 开启短信服务
		 * 
		 * @return
		 */
		public int startService() {
			System.setProperty("jna.encoding", "GBK"); // 改变JNA的编码，解决短信接收乱码的问题

			// 读取配置文件sms.port信息,port 默认配置为 int port = 1;
			int port = Integer.valueOf(new PropertiesUtil().getPropertiesValue(
					"jdbc.properties", "sms.port"));

			// 查询服务是否正常
			int bb = SMSDLL.INSTANCE.SMSServiceStartedByPort(port);
			System.out.println(bb);

			if (bb > 0) {
				System.out.println(bb + "服务已启动！");
				return 1;
			} else {

				// 打开服务
				int aa = SMSDLL.INSTANCE.SMSStartService(port, 115200, 2, 8, 0, 0,
						"card");
				if (aa > 0) {
					System.out.println(aa + "服务启动OK！");
					return 1;
				} else {
					System.out.println(aa + "服务启动失败！");
					return 0;
				}
			}
		}


	
	

	// 测试入口方法
	public static void main(String[] args) {
		String msg = "中国手机" + "...";
		int length = msg.length();
		
		msg = msg.substring(0, length < 20 ? length : 20);
		System.out.println(msg);
	}
}
