package core.entity;

public class TsGroup {
    private Integer fId;

    private String fName;

    private String fSort;
    
    private String fType;
    
    private String fImg;
    
    private String fImgUrl;

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

    public String getfSort() {
        return fSort;
    }

    public void setfSort(String fSort) {
        this.fSort = fSort == null ? null : fSort.trim();
    }

	public String getfType() {
		return fType;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public String getfImg() {
		return fImg;
	}

	public void setfImg(String fImg) {
		this.fImg = fImg;
	}

	public String getfImgUrl() {
		return fImgUrl;
	}

	public void setfImgUrl(String fImgUrl) {
		this.fImgUrl = fImgUrl;
	}
    
	
}