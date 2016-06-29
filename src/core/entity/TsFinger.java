package core.entity;

public class TsFinger {
    private Integer fId;

    private String fCode;

    private String fTime;

    private String fYear;

    private String fMonth;

    private String fDay;

    private String fWeek;

    private String fStatus;

    public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfCode() {
        return fCode;
    }

    public void setfCode(String fCode) {
        this.fCode = fCode == null ? null : fCode.trim();
    }

    public String getfTime() {
        return fTime;
    }

    public void setfTime(String fTime) {
        this.fTime = fTime == null ? null : fTime.trim();
    }

    public String getfYear() {
        return fYear;
    }

    public void setfYear(String fYear) {
        this.fYear = fYear == null ? null : fYear.trim();
    }

    public String getfMonth() {
        return fMonth;
    }

    public void setfMonth(String fMonth) {
        this.fMonth = fMonth == null ? null : fMonth.trim();
    }

    public String getfDay() {
        return fDay;
    }

    public void setfDay(String fDay) {
        this.fDay = fDay == null ? null : fDay.trim();
    }

    public String getfWeek() {
        return fWeek;
    }

    public void setfWeek(String fWeek) {
        this.fWeek = fWeek == null ? null : fWeek.trim();
    }

    public String getfStatus() {
        return fStatus;
    }

    public void setfStatus(String fStatus) {
        this.fStatus = fStatus == null ? null : fStatus.trim();
    }
}