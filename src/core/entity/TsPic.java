package core.entity;

public class TsPic {
    private Integer fId;

    private String fImg;

    private String fImgUrl;

    private String fLink;

    private String fSort;
    
    private String fType;//类别

    public String getfType() {
		return fType;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfImg() {
        return fImg;
    }

    public void setfImg(String fImg) {
        this.fImg = fImg == null ? null : fImg.trim();
    }

    public String getfImgUrl() {
        return fImgUrl;
    }

    public void setfImgUrl(String fImgUrl) {
        this.fImgUrl = fImgUrl == null ? null : fImgUrl.trim();
    }

    public String getfLink() {
        return fLink;
    }

    public void setfLink(String fLink) {
        this.fLink = fLink == null ? null : fLink.trim();
    }

    public String getfSort() {
        return fSort;
    }

    public void setfSort(String fSort) {
        this.fSort = fSort == null ? null : fSort.trim();
    }
}