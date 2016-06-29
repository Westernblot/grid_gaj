package core.entity.system;

public class SysDept {
    private Integer fId;

    private Integer fPid;

    private String fName;

    private Integer fSort;

    private String fAddress;
    
    private String fPhone;//部门电话
    
    private Integer fLevel;//部门层级
    
    private String fDutyPerson;//部门责任人
    
    
    public String getfDutyPerson() {
		return fDutyPerson;
	}

	public void setfDutyPerson(String fDutyPerson) {
		this.fDutyPerson = fDutyPerson;
	}

	public Integer getfLevel() {
		return fLevel;
	}

	public void setfLevel(Integer fLevel) {
		this.fLevel = fLevel;
	}

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

    public Integer getfSort() {
        return fSort;
    }

    public void setfSort(Integer fSort) {
        this.fSort = fSort;
    }

    public String getfAddress() {
        return fAddress;
    }

    public void setfAddress(String fAddress) {
        this.fAddress = fAddress == null ? null : fAddress.trim();
    }

	public String getfPhone() {
		return fPhone;
	}

	public void setfPhone(String fPhone) {
		this.fPhone = fPhone;
	}
    
}