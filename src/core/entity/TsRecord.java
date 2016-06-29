package core.entity;

public class TsRecord {
    private Integer fId;

    private String fSubject;

    private String fContent;

    private Integer fAddId;

    private String fAddName;

    private String fAddDate;

    private String fType;
    
    private String fRemindTime;//重复提醒 发送时间

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

    public String getfContent() {
        return fContent;
    }

    public void setfContent(String fContent) {
        this.fContent = fContent == null ? null : fContent.trim();
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
        this.fType = fType == null ? null : fType.trim();
    }

	public String getfRemindTime() {
		return fRemindTime;
	}

	public void setfRemindTime(String fRemindTime) {
		this.fRemindTime = fRemindTime;
	}
    
    
}