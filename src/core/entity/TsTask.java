package core.entity;

public class TsTask {
    private Integer fId;

    private String fDept;

    private String fContent;

    private String fAttachment;

    private String fAttachmentUrl;

    private String fSdate;

    private String fEdate;

    private String fWork;

    private String fDutyDept;

    private String fFitDept;

    private String fDutyPerson;

    private String fLeadKnow;
    
    private String fFlag;//是否已提醒

    
    public String getfFlag() {
		return fFlag;
	}

	public void setfFlag(String fFlag) {
		this.fFlag = fFlag;
	}

	public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfDept() {
        return fDept;
    }

    public void setfDept(String fDept) {
        this.fDept = fDept == null ? null : fDept.trim();
    }

    public String getfContent() {
        return fContent;
    }

    public void setfContent(String fContent) {
        this.fContent = fContent == null ? null : fContent.trim();
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

    public String getfSdate() {
        return fSdate;
    }

    public void setfSdate(String fSdate) {
        this.fSdate = fSdate == null ? null : fSdate.trim();
    }

    public String getfEdate() {
        return fEdate;
    }

    public void setfEdate(String fEdate) {
        this.fEdate = fEdate == null ? null : fEdate.trim();
    }

    public String getfWork() {
        return fWork;
    }

    public void setfWork(String fWork) {
        this.fWork = fWork == null ? null : fWork.trim();
    }

    public String getfDutyDept() {
        return fDutyDept;
    }

    public void setfDutyDept(String fDutyDept) {
        this.fDutyDept = fDutyDept == null ? null : fDutyDept.trim();
    }

    public String getfFitDept() {
        return fFitDept;
    }

    public void setfFitDept(String fFitDept) {
        this.fFitDept = fFitDept == null ? null : fFitDept.trim();
    }

    public String getfDutyPerson() {
        return fDutyPerson;
    }

    public void setfDutyPerson(String fDutyPerson) {
        this.fDutyPerson = fDutyPerson == null ? null : fDutyPerson.trim();
    }

    public String getfLeadKnow() {
        return fLeadKnow;
    }

    public void setfLeadKnow(String fLeadKnow) {
        this.fLeadKnow = fLeadKnow == null ? null : fLeadKnow.trim();
    }
}