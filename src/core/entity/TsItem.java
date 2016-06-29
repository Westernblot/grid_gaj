package core.entity;

public class TsItem {
    private Integer fId;

    private String fItem;

    private String fMonth;

    private String fYear;
    
    private Integer fCode;
    
    
    

    public Integer getfCode() {
		return fCode;
	}

	public void setfCode(Integer fCode) {
		this.fCode = fCode;
	}

	public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfItem() {
        return fItem;
    }

    public void setfItem(String fItem) {
        this.fItem = fItem == null ? null : fItem.trim();
    }

    public String getfMonth() {
        return fMonth;
    }

    public void setfMonth(String fMonth) {
        this.fMonth = fMonth == null ? null : fMonth.trim();
    }

    public String getfYear() {
        return fYear;
    }

    public void setfYear(String fYear) {
        this.fYear = fYear == null ? null : fYear.trim();
    }
}