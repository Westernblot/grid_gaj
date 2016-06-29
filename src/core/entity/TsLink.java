package core.entity;

public class TsLink {
    private Integer fId;

    private String fName;

    private String fUrl;

    private String fType;
    
    private String fImg;
    
    private String fImgUrl;
    
    

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

    public String getfUrl() {
        return fUrl;
    }

    public void setfUrl(String fUrl) {
        this.fUrl = fUrl == null ? null : fUrl.trim();
    }

    public String getfType() {
        return fType;
    }

    public void setfType(String fType) {
        this.fType = fType == null ? null : fType.trim();
    }
}