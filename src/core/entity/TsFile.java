package core.entity;

public class TsFile {
    private Integer fId;

    private String fSubject;

    private String fAttachment;

    private String fAttachmentUrl;

    private String fSort;

    private String fRemark;

    private Integer fAddId;

    private String fAddName;

    private String fAddDate;
    
    private String fType;
    
    private String fRecDept;
    
    private String fSignDept;
    
    private String fSms;//是否短信提醒
    
    private String fSmsMsg;//短信内容

    public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfSubject() {
        return fSubject;
    }

    public void setfSubject(String fSubject) {
        this.fSubject = fSubject == null ? null : fSubject.trim();
    }

    public String getfAttachment() {
        return fAttachment;
    }

    public void setfAttachment(String fAttachment) {
        this.fAttachment = fAttachment == null ? null : fAttachment.trim();
    }

    public String getfAttachmentUrl() {
        return fAttachmentUrl;
    }

    public void setfAttachmentUrl(String fAttachmentUrl) {
        this.fAttachmentUrl = fAttachmentUrl == null ? null : fAttachmentUrl.trim();
    }

    public String getfSort() {
        return fSort;
    }

    public void setfSort(String fSort) {
        this.fSort = fSort == null ? null : fSort.trim();
    }

    public String getfRemark() {
        return fRemark;
    }

    public void setfRemark(String fRemark) {
        this.fRemark = fRemark == null ? null : fRemark.trim();
    }

    public Integer getfAddId() {
        return fAddId;
    }

    public void setfAddId(Integer fAddId) {
        this.fAddId = fAddId;
    }

    public String getfAddName() {
        return fAddName;
    }

    public void setfAddName(String fAddName) {
        this.fAddName = fAddName == null ? null : fAddName.trim();
    }

    public String getfAddDate() {
        return fAddDate;
    }

    public void setfAddDate(String fAddDate) {
        this.fAddDate = fAddDate == null ? null : fAddDate.trim();
    }

	public String getfType() {
		return fType;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public String getfRecDept() {
		return fRecDept;
	}

	public void setfRecDept(String fRecDept) {
		this.fRecDept = fRecDept;
	}

	public String getfSignDept() {
		return fSignDept;
	}

	public void setfSignDept(String fSignDept) {
		this.fSignDept = fSignDept;
	}

	public String getfSms() {
		return fSms;
	}

	public void setfSms(String fSms) {
		this.fSms = fSms;
	}

	public String getfSmsMsg() {
		return fSmsMsg;
	}

	public void setfSmsMsg(String fSmsMsg) {
		this.fSmsMsg = fSmsMsg;
	}
    
	
}