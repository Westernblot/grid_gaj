package core.entity.system;

public class SysUser {
    private Integer fId;

    private String fUname;

    private String fCname;

    private String fPassword;

    private String fLasttime;

    private String fLoginip;

    private String fPower;

    private String fDept;

    private String fStatus;
    
    private String fPosition;
    
    private String fPhone;
    
    private Integer fDeptId;
    
    private Integer fSort;//排序号

   
    public Integer getfSort() {
		return fSort;
	}

	public void setfSort(Integer fSort) {
		this.fSort = fSort;
	}

	public String getfPosition() {
		return fPosition;
	}

	public void setfPosition(String fPosition) {
		this.fPosition = fPosition;
	}

	public String getfPhone() {
		return fPhone;
	}

	public void setfPhone(String fPhone) {
		this.fPhone = fPhone;
	}

	public Integer getfDeptId() {
		return fDeptId;
	}

	public void setfDeptId(Integer fDeptId) {
		this.fDeptId = fDeptId;
	}

	public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfUname() {
        return fUname;
    }

    public void setfUname(String fUname) {
        this.fUname = fUname == null ? null : fUname.trim();
    }

    public String getfPassword() {
        return fPassword;
    }

    public void setfPassword(String fPassword) {
        this.fPassword = fPassword == null ? null : fPassword.trim();
    }

    public String getfLasttime() {
        return fLasttime;
    }

    public void setfLasttime(String fLasttime) {
        this.fLasttime = fLasttime == null ? null : fLasttime.trim();
    }

    public String getfLoginip() {
        return fLoginip;
    }

    public void setfLoginip(String fLoginip) {
        this.fLoginip = fLoginip == null ? null : fLoginip.trim();
    }

    public String getfPower() {
        return fPower;
    }

    public void setfPower(String fPower) {
        this.fPower = fPower == null ? null : fPower.trim();
    }

    public String getfDept() {
        return fDept;
    }

    public void setfDept(String fDept) {
        this.fDept = fDept == null ? null : fDept.trim();
    }

    public String getfStatus() {
        return fStatus;
    }

    public void setfStatus(String fStatus) {
        this.fStatus = fStatus == null ? null : fStatus.trim();
    }

    public String getfCname() {
        return fCname;
    }

    public void setfCname(String fCname) {
        this.fCname = fCname == null ? null : fCname.trim();
    }
}