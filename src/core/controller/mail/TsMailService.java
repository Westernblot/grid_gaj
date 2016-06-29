package core.controller.mail;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.Attachment;
import core.entity.TsRecord;
import core.entity.system.SysUser;
import core.util.DateUtil;
import core.util.Page;
import core.util.PageData;

@Service
public class TsMailService extends BaseService{

	/**
	 * 创建用户邮箱
	 * @param pd
	 */
	public void mailCreate(PageData pd) {
		dao.update("TsMailMapper.createTsMail", pd);
		
	}
    
	/**
	 * 删除用户 邮箱
	 */
	public void mTsMailDrop(PageData pd) {
		dao.update("TsMailMapper.dropTsMail", pd);
		
	}

	/**
	 * 收件箱
	 * @param page
	 * @return
	 */
	public List<PageData> recMail(Page page) {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("TsMailMapper.recMail",page);
	}

	/**
	 * 查找20位用户 like
	 * @return
	 */
//	public List<PageData> searchPersonTop20(PageData pd) {
//		// TODO Auto-generated method stub
//		return (List<PageData>) dao.findForList("TsMailMapper.searchPersonTop20", pd);
//	}

	
	//===================================公共调用方法 《开始》=====================================================
	/**
	 * 附件操作 公共类
	 */
	public String getAttachmentSaveIds(String tableName,String fAttachmentIds){
		//写入附件信息:
		//1.查询临时附件表的附件数据
		//2.关联写入邮箱表
		String fAttachmentId="";
		
		String[] attachmentIds=fAttachmentIds.split(",");
		for(int i=0;i<attachmentIds.length;i++){
			Attachment attachment=(Attachment) dao.findForObject("AttachmentMapper.selectById", attachmentIds[i]);
			if(attachment !=null){
				PageData pMail=new PageData();
				System.out.println(tableName+","+attachment.getfName()+","+attachment.getfContent());
				pMail.put("tableName", tableName);//表名
				pMail.put("fAttachment", attachment.getfName());//附件名
				pMail.put("fAttachmentUrl", attachment.getfContent());//附件内容
				dao.save("TsMailMapper.insert", pMail);
						
				if(fAttachmentId.equals("")){
					fAttachmentId=String.valueOf(pMail.get("F_ID"));
				}else{
					fAttachmentId+=","+String.valueOf(pMail.get("F_ID"));
				}
				
			}else{
				
				if(fAttachmentId.equals("")){
					fAttachmentId=attachmentIds[i];
				}else{
					fAttachmentId+=","+attachmentIds[i];
				}
				
			}
		
		}
		
		return fAttachmentId;
	}
	//===================================公共调用方法 《结束》=====================================================
	
	/**
	 * 存草稿箱
	 * @param pd
	 * @return
	 */
	public int saveDrafts(PageData pd) {
		// TODO Auto-generated method stub
		int flag=0;
	
		String attIds=pd.getString("fAttachmentId");//传递过来的临时附件表的 ————附件 ids
		if (attIds != null && !attIds.equals("")) {
			String fAttachmentId = this.getAttachmentSaveIds(pd.getString("tableName"), attIds);
			pd.put("fAttachmentId", fAttachmentId);// 邮箱表下的 附件编号
		} else {
			pd.put("fAttachmentId", "0");// 邮箱表下的 附件编号
		}
		
		String fId=pd.getString("fId");
		if(fId==null || fId.equals("")){
			flag+=(int)dao.save("TsMailMapper.insert", pd);
		}else{
			
			//======================================================修改前  先删除 不需要的附件=============================
			pd.put("fNewIds", (pd.getString("fAttachmentId")==null || pd.getString("fAttachmentId").equals(""))?0:pd.getString("fAttachmentId"));
			PageData delMail=(PageData) dao.findForObject("TsMailMapper.selectMailById", pd);
			pd.put("fOldIds", (delMail.getString("F_ATTACHMENT_ID")==null || delMail.getString("F_ATTACHMENT_ID").equals(""))?0:delMail.getString("F_ATTACHMENT_ID"));
			dao.delete("TsMailMapper.deleteOutAttachment", pd);
			
			flag+=(int)dao.update("TsMailMapper.update", pd);
		}
		
		return flag;
	}
	
	
	/**
	 * 发送个人邮件
	 * @return
	 */
	public int cmdSendPersonMail(PageData pd) {
		// TODO Auto-generated method stub
		
		int flag=0;
		String myMail=pd.getString("tableName");    //用户自己的邮箱
		String attIds=pd.getString("fAttachmentId");//传递过来的临时表的附件 ids
		if(attIds!=null && !attIds.equals("")){			
			String fAttachmentId=this.getAttachmentSaveIds(pd.getString("tableName"), attIds);
			pd.put("fAttachmentId", fAttachmentId);// 邮箱表下的 附件编号
		}else{
			pd.put("fAttachmentId", "0");// 邮箱表下的 附件编号
		}
		
		String fId=pd.getString("fId");
		if(fId==null || fId.equals("")){
			flag+=(int)dao.save("TsMailMapper.insert", pd);//若是新邮件：先写邮件到个人邮箱,文件夹分类为：已发送；状态为：已阅；
		}else{
			
			//======================================================修改前  先删除 不需要的附件=============================
			pd.put("fNewIds", (pd.getString("fAttachmentId")==null || pd.getString("fAttachmentId").equals(""))?0:pd.getString("fAttachmentId"));
			PageData delMail=(PageData) dao.findForObject("TsMailMapper.selectMailById", pd);
			pd.put("fOldIds", (delMail.getString("F_ATTACHMENT_ID")==null || delMail.getString("F_ATTACHMENT_ID").equals(""))?0:delMail.getString("F_ATTACHMENT_ID"));
			dao.delete("TsMailMapper.deleteOutAttachment", pd);
			
			pd.put("fFolder", "已发送");
			flag+=(int)dao.update("TsMailMapper.update", pd);//若是草稿箱：则修改文件夹分类为：已发送
		}


		pd.put("fFolder", "收件箱");
		pd.put("fStatus", "未阅");
		String[] fMailIds=pd.getString("fReceivedId").split(",");//发送邮件到其他人邮箱，文件夹分类为：收件箱；状态为：未阅；
		String myMailAttachment=pd.getString("fAttachmentId");
		
		//向其他邮箱发送邮件
		for(int i=0;i<fMailIds.length;i++){
			String tableName="personmail_"+fMailIds[i];


			//取本邮箱中的附件和数据信息，存入其他用户邮箱的收件箱
			PageData otherPd=new PageData();
			otherPd.put("tableName", myMail);                    //查询我的已发送中的附件
			otherPd.put("fIds", myMailAttachment);               //====================
			
			System.out.println("================================"+myMailAttachment);
			
			List<PageData> otherList=(List<PageData>) dao.findForList("TsMailMapper.selectMailAttachment", otherPd);
			String otherAttachmentId="";
			for(int j=0;j<otherList.size();j++){
				PageData otherData=new PageData();
				otherData.put("tableName", tableName);//表名
				otherData.put("fAttachment", otherList.get(j).getString("F_ATTACHMENT"));//附件名
				otherData.put("fAttachmentUrl", otherList.get(j).get("F_ATTACHMENT_URL"));//附件内容
				dao.save("TsMailMapper.insert", otherData);
				
				if(otherAttachmentId.equals("")){
					otherAttachmentId=String.valueOf(otherData.get("F_ID"));
				}else{
					otherAttachmentId+=","+String.valueOf(otherData.get("F_ID"));
				}
			}
			
			pd.put("tableName", tableName);
			pd.put("fAttachmentId", otherAttachmentId);
			flag+=(int)dao.save("TsMailMapper.insert", pd);
		}
		
		return flag;
	}
	
	

	/**
	 * 查看 收件箱 邮件
	 * @param pd
	 * @return
	 */
	public PageData selectMailById(PageData pd) {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("TsMailMapper.selectMailById", pd);
	}

	/**
	 * 查阅邮件 的操作，修改状态为：已阅，同时显示邮件;若邮件需要回执，则回发一份邮件
	 * @param pd
	 * @return
	 */
	public PageData seeMailById(PageData pd) {
		// TODO Auto-generated method stub
		
		PageData pData= (PageData) dao.findForObject("TsMailMapper.selectMailById", pd);//查找出邮件
		
		//查看邮件时，若需要回执。则由系统发送一份回执给 发件者
		String fReceipt=pData.getString("F_RECEIPT");
		String fStatus=pData.getString("F_STATUS");
		if(fReceipt.equals("是") && fStatus.equals("未阅")){
			PageData pdm=new PageData();
			pdm.put("tableName", "personmail_"+pData.get("F_SEND_ID"));//对方邮箱表
			
			pdm.put("fSend", "系统管理员");//当前用户
			pdm.put("fReceived", pData.get("F_SEND"));
			pdm.put("fSubject", "回执："+pData.getString("F_SUBJECT"));
			pdm.put("fContent", "用户您好：<br>您所发的邮件，<b>"+pd.get("fUserName")+"</b>已查阅！");
			pdm.put("fSendTime", DateUtil.getTime());
			pdm.put("fFolder", "收件箱");
			pdm.put("fStatus", "未阅");
			
			dao.save("TsMailMapper.insert", pdm);//发送回执
			
			
			//写入消息记录表
			TsRecord record=new TsRecord();
			//record.setfAddId(user.getfId());
			record.setfAddName(pd.getString("fUserName"));
			record.setfAddDate(DateUtil.getTime());
			record.setfType("邮箱回执");
			record.setfSubject("接收人："+pData.get("F_SEND"));
			record.setfContent("用户已阅读邮件回执");
			dao.save("TsRecordMapper.insert", record);
			
		}
		
		dao.update("TsMailMapper.updateMailStatus", pd);//修改收件箱 邮件为已阅
		
		return pData;
	}

	/**
	 * 我的 已发送
	 * @param pd
	 * @return
	 */
	public List<PageData> selectMySent(Page page) {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("TsMailMapper.selectMySent", page);
	}

	/**
	 * 我的 已删除 邮件
	 * @param page
	 * @return
	 */
	public List<PageData> selectMyDelete(Page page) {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("TsMailMapper.selectMyDelete", page);
	}

	/**
	 * 我的草稿箱
	 * @param page
	 * @return
	 */
	public List<PageData> selectMyDraftsMail(Page page) {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("TsMailMapper.selectMyDrafts", page);
	}

	/**
	 * 保留 删除 邮件
	 * @param pd
	 * @return
	 */
	public int reservedDelete(PageData pd) {
		// TODO Auto-generated method stub
		return (int) dao.update("TsMailMapper.reservedDelete", pd);
	}

	/**
	 * 彻底删除 邮件
	 * @param pd
	 * @return
	 */
	public int completeDelete(PageData pd) {
		// TODO Auto-generated method stub
		int flag=0;
		List<PageData> pList=(List<PageData>) dao.findForList("TsMailMapper.selectMailAttachment", pd);
		String attIds="";
		for(int i=0;i<pList.size();i++){
			String fAttachmentId=(pList.get(i).getString("F_ATTACHMENT_ID")==null || pList.get(i).getString("F_ATTACHMENT_ID").equals(""))?"0":pList.get(i).getString("F_ATTACHMENT_ID");
			if(attIds.equals("")){
				attIds+=fAttachmentId;
			}else{
				attIds+=","+fAttachmentId;
			}
		}
        attIds+=","+pd.getString("fIds");
		pd.put("fIds", attIds);
		flag+=(int)dao.delete("TsMailMapper.deleteByIds", pd);//删除 邮件以及邮件中的附件

		return flag;
	}

	/**
	 * 搜索 通讯录 人员
	 * @param page
	 * @return
	 */
	public List<PageData> searchPerson(Page page) {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("TsMailMapper.searchPerson", page);
	}

	/**
	 * 查找未读邮件
	 * @param pd
	 * @return
	 */
	public int countNoReadMail(PageData pd) {
		// TODO Auto-generated method stub
		return (int) dao.findForObject("TsMailMapper.countNoReadMail", pd);
	}

	/**
	 * 查找表空间大小
	 * @param pd
	 * @return
	 */
	public PageData selectTableDataSize(PageData pd) {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("TsMailMapper.selectTableDataSize", pd);
	}

}
