package core.entity;

public class TsExam {
    private Integer fId;

    private String fName;

    private String fDate;

    private Integer fItemId;

    private String fAdd;

    private String fSub;

    private String fRemark;
    
    private String fYear;
    
    private String fMonth;   //开始月份
    
    private String fEndMonth;//结束月份
    

    public String getfEndMonth() {
		return fEndMonth;
	}

	public void setfEndMonth(String fEndMonth) {
		this.fEndMonth = fEndMonth;
	}

	public String getfMonth() {
		return fMonth;
	}

	public void setfMonth(String fMonth) {
		this.fMonth = fMonth;
	}

	public String getfYear() {
		return fYear;
	}

	public void setfYear(String fYear) {
		this.fYear = fYear;
	}

	public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName == null ? null : fName.trim();
    }

    public String getfDate() {
        return fDate;
    }

    public void setfDate(String fDate) {
        this.fDate = fDate == null ? null : fDate.trim();
    }

    

    public Integer getfItemId() {
		return fItemId;
	}

	public void setfItemId(Integer fItemId) {
		this.fItemId = fItemId;
	}

	public String getfAdd() {
        return fAdd;
    }

    public void setfAdd(String fAdd) {
        this.fAdd = fAdd == null ? null : fAdd.trim();
    }

    public String getfSub() {
        return fSub;
    }

    public void setfSub(String fSub) {
        this.fSub = fSub == null ? null : fSub.trim();
    }

    public String getfRemark() {
        return fRemark;
    }

    public void setfRemark(String fRemark) {
        this.fRemark = fRemark == null ? null : fRemark.trim();
    }
}