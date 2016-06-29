package core.entity;

public class TsVedio {
    private Integer fId;

    private String fSubject;

    private String fImg;

    private String fImgUrl;

    private String fVedio;

    private String fVedioUrl;

    public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfSubject() {
        return fSubject;
    }

    public void setfSubject(String fSubject) {
        this.fSubject = fSubject == null ? null : fSubject.trim();
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

    public String getfVedio() {
        return fVedio;
    }

    public void setfVedio(String fVedio) {
        this.fVedio = fVedio == null ? null : fVedio.trim();
    }

    public String getfVedioUrl() {
        return fVedioUrl;
    }

    public void setfVedioUrl(String fVedioUrl) {
        this.fVedioUrl = fVedioUrl == null ? null : fVedioUrl.trim();
    }
}