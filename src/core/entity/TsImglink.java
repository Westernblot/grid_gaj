package core.entity;

public class TsImglink {
    private Integer fId;

    private String fImg;

    private String fImgUrl;

    private String fLink;

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
}