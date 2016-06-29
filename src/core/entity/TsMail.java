package core.entity;

public class TsMail {
    private Integer fId;

    private String fSendId;

    private String fSend;

    private String fReceivedId;

    private String fReceived;

    private String fSubject;

    private String fContent;

    private String fSendTime;

    private String fAttachmentId;//附件编号
    
    private String fAttachment;

    private Object fAttachmentUrl;//BLOB 附件内容

    private String fFolder;

    private String fStatus;

    private String fType;

    private String fReceipt;

    private String fSms;
    
    private String fSmsMsg;//短信内容
    
    

    public String getfAttachmentId() {
		return fAttachmentId;
	}

	public void setfAttachmentId(String fAttachmentId) {
		this.fAttachmentId = fAttachmentId;
	}

	public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfSendId() {
        return fSendId;
    }

    public void setfSendId(String fSendId) {
        this.fSendId = fSendId == null ? null : fSendId.trim();
    }

    public String getfSend() {
        return fSend;
    }

    public void setfSend(String fSend) {
        this.fSend = fSend == null ? null : fSend.trim();
    }

    public String getfReceivedId() {
        return fReceivedId;
    }

    public void setfReceivedId(String fReceivedId) {
        this.fReceivedId = fReceivedId == null ? null : fReceivedId.trim();
    }

    public String getfReceived() {
        return fReceived;
    }

    public void setfReceived(String fReceived) {
        this.fReceived = fReceived == null ? null : fReceived.trim();
    }

    public String getfSubject() {
        return fSubject;
    }

    public void setfSubject(String fSubject) {
        this.fSubject = fSubject == null ? null : fSubject.trim();
    }

    public String getfContent() {
        return fContent;
    }

    public void setfContent(String fContent) {
        this.fContent = fContent == null ? null : fContent.trim();
    }

    public String getfSendTime() {
        return fSendTime;
    }

    public void setfSendTime(String fSendTime) {
        this.fSendTime = fSendTime == null ? null : fSendTime.trim();
    }

    public String getfAttachment() {
        return fAttachment;
    }

    public void setfAttachment(String fAttachment) {
        this.fAttachment = fAttachment == null ? null : fAttachment.trim();
    }

    public Object getfAttachmentUrl() {
		return fAttachmentUrl;
	}

	public void setfAttachmentUrl(Object fAttachmentUrl) {
		this.fAttachmentUrl = fAttachmentUrl;
	}

	public String getfFolder() {
        return fFolder;
    }

    public void setfFolder(String fFolder) {
        this.fFolder = fFolder == null ? null : fFolder.trim();
    }

    public String getfStatus() {
        return fStatus;
    }

    public void setfStatus(String fStatus) {
        this.fStatus = fStatus == null ? null : fStatus.trim();
    }

    public String getfType() {
        return fType;
    }

    public void setfType(String fType) {
        this.fType = fType == null ? null : fType.trim();
    }

    public String getfReceipt() {
        return fReceipt;
    }

    public void setfReceipt(String fReceipt) {
        this.fReceipt = fReceipt == null ? null : fReceipt.trim();
    }

    public String getfSms() {
        return fSms;
    }

    public void setfSms(String fSms) {
        this.fSms = fSms == null ? null : fSms.trim();
    }

	public String getfSmsMsg() {
		return fSmsMsg;
	}

	public void setfSmsMsg(String fSmsMsg) {
		this.fSmsMsg = fSmsMsg;
	}
    
}