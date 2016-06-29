package core.entity.system;


public class SysMenu {
    private Integer fId;

    private Integer fPid;//父Id

    private String fName;//名称

    private String fAction;//方法

    private String fSort;//排序

    private String fLevel;//层级

    private String fType;//类型
    
    
	public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public Integer getfPid() {
        return fPid;
    }

    public void setfPid(Integer fPid) {
        this.fPid = fPid;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName == null ? null : fName.trim();
    }

    public String getfAction() {
        return fAction;
    }

    public void setfAction(String fAction) {
        this.fAction = fAction == null ? null : fAction.trim();
    }

    public String getfSort() {
        return fSort;
    }

    public void setfSort(String fSort) {
        this.fSort = fSort == null ? null : fSort.trim();
    }

    public String getfLevel() {
        return fLevel;
    }

    public void setfLevel(String fLevel) {
        this.fLevel = fLevel == null ? null : fLevel.trim();
    }

    public String getfType() {
        return fType;
    }

    public void setfType(String fType) {
        this.fType = fType == null ? null : fType.trim();
    }
}