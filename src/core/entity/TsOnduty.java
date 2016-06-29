package core.entity;

public class TsOnduty {
    private Integer fId;

    private String fLeader;

    private String fPolice;

    private String fTel;

    private String fDate;

    private String fWeek;
    
    private String fMonth;//年月

    public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfLeader() {
        return fLeader;
    }

    public void setfLeader(String fLeader) {
        this.fLeader = fLeader == null ? null : fLeader.trim();
    }

    public String getfPolice() {
        return fPolice;
    }

    public void setfPolice(String fPolice) {
        this.fPolice = fPolice == null ? null : fPolice.trim();
    }

    public String getfTel() {
        return fTel;
    }

    public void setfTel(String fTel) {
        this.fTel = fTel == null ? null : fTel.trim();
    }

    public String getfDate() {
        return fDate;
    }

    public void setfDate(String fDate) {
        this.fDate = fDate == null ? null : fDate.trim();
    }

    public String getfWeek() {
        return fWeek;
    }

    public void setfWeek(String fWeek) {
        this.fWeek = fWeek == null ? null : fWeek.trim();
    }

	public String getfMonth() {
		return fMonth;
	}

	public void setfMonth(String fMonth) {
		this.fMonth = fMonth;
	}
    
}