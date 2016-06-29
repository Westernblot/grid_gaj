package core.entity;

public class TsNews {
    private Integer fId;

    private Integer fAddId;

    private String fAddName;

    private String fAddDate;

    private String fSource;//来源

    private Integer fRead;//阅读次数

    private String fSubject;//标题
    
    private String fLink;//标题链接<新加字段>

    private String fAttachment;//附件名

    private String fAttachmentUrl;//附件路径

    private String fDate;//日期

    private String fGroup;//组别

    private String fContent;//正文、内容
    
    private String fImg;//图片
    
    private String fImgUrl;//图片路径
    
    private String fPart;//正文
    
    private Integer fSort;//排序
    
    private String fSummary;//摘要
    
    private String fSubhead;//副标题
    
    private String fAttention;//今日关注
    
    private String fImportant;//要闻排行
    
    private String fRecommend;//编辑推荐
    
    private String fScope;//查看范围
    
    private String fStatus;//审核状态
    
    private String fAddDept;//发布部门
    
    private String fSubGroup;//子分组
    
    private String fTop;//置顶显示
    
    //===============红头文件添加字段======================
    
    private String fRed;//红头样式
    
    private String fRecDept;//接收单位
    
    private String fSignDept;//已签收单位
    
    private String fCopy;//抄送
    
    private String fSign;//签发
    
    private String fCheckDraft;//核稿
    
    private String fUndertaker;//承办
    

    public String getfTop() {
		return fTop;
	}

	public void setfTop(String fTop) {
		this.fTop = fTop;
	}

	public String getfLink() {
		return fLink;
	}

	public void setfLink(String fLink) {
		this.fLink = fLink;
	}

	public String getfSubGroup() {
		return fSubGroup;
	}

	public void setfSubGroup(String fSubGroup) {
		this.fSubGroup = fSubGroup;
	}

	public String getfAddDept() {
		return fAddDept;
	}

	public void setfAddDept(String fAddDept) {
		this.fAddDept = fAddDept;
	}

	public String getfStatus() {
		return fStatus;
	}

	public void setfStatus(String fStatus) {
		this.fStatus = fStatus;
	}

	public String getfScope() {
		return fScope;
	}

	public void setfScope(String fScope) {
		this.fScope = fScope;
	}

	public Integer getfSort() {
		return fSort;
	}

	public void setfSort(Integer fSort) {
		this.fSort = fSort;
	}

	public String getfSummary() {
		return fSummary;
	}

	public void setfSummary(String fSummary) {
		this.fSummary = fSummary;
	}

	public String getfSubhead() {
		return fSubhead;
	}

	public void setfSubhead(String fSubhead) {
		this.fSubhead = fSubhead;
	}

	public String getfAttention() {
		return fAttention;
	}

	public void setfAttention(String fAttention) {
		this.fAttention = fAttention;
	}

	public String getfImportant() {
		return fImportant;
	}

	public void setfImportant(String fImportant) {
		this.fImportant = fImportant;
	}

	public String getfRecommend() {
		return fRecommend;
	}

	public void setfRecommend(String fRecommend) {
		this.fRecommend = fRecommend;
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

	public String getfPart() {
		return fPart;
	}

	public void setfPart(String fPart) {
		this.fPart = fPart;
	}

	public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public Integer getfAddId() {
        return fAddId;
    }

    public void setfAddId(Integer fAddId) {
        this.fAddId = fAddId;
    }

    public String getfAddName() {
        return fAddName;
    }

    public void setfAddName(String fAddName) {
        this.fAddName = fAddName == null ? null : fAddName.trim();
    }

    public String getfAddDate() {
        return fAddDate;
    }

    public void setfAddDate(String fAddDate) {
        this.fAddDate = fAddDate == null ? null : fAddDate.trim();
    }

    public String getfSource() {
        return fSource;
    }

    public void setfSource(String fSource) {
        this.fSource = fSource == null ? null : fSource.trim();
    }

    public Integer getfRead() {
        return fRead;
    }

    public void setfRead(Integer fRead) {
        this.fRead = fRead;
    }

    public String getfSubject() {
        return fSubject;
    }

    public void setfSubject(String fSubject) {
        this.fSubject = fSubject == null ? null : fSubject.trim();
    }

    public String getfAttachment() {
        return fAttachment;
    }

    public void setfAttachment(String fAttachment) {
        this.fAttachment = fAttachment == null ? null : fAttachment.trim();
    }

    public String getfAttachmentUrl() {
        return fAttachmentUrl;
    }

    public void setfAttachmentUrl(String fAttachmentUrl) {
        this.fAttachmentUrl = fAttachmentUrl == null ? null : fAttachmentUrl.trim();
    }

    public String getfDate() {
        return fDate;
    }

    public void setfDate(String fDate) {
        this.fDate = fDate == null ? null : fDate.trim();
    }

    public String getfGroup() {
        return fGroup;
    }

    public void setfGroup(String fGroup) {
        this.fGroup = fGroup == null ? null : fGroup.trim();
    }

    public String getfContent() {
        return fContent;
    }

    public void setfContent(String fContent) {
        this.fContent = fContent == null ? null : fContent.trim();
    }

	public String getfRecDept() {
		return fRecDept;
	}

	public void setfRecDept(String fRecDept) {
		this.fRecDept = fRecDept;
	}

	public String getfSignDept() {
		return fSignDept;
	}

	public void setfSignDept(String fSignDept) {
		this.fSignDept = fSignDept;
	}

	public String getfCopy() {
		return fCopy;
	}

	public void setfCopy(String fCopy) {
		this.fCopy = fCopy;
	}

	public String getfSign() {
		return fSign;
	}

	public void setfSign(String fSign) {
		this.fSign = fSign;
	}

	public String getfCheckDraft() {
		return fCheckDraft;
	}

	public void setfCheckDraft(String fCheckDraft) {
		this.fCheckDraft = fCheckDraft;
	}

	public String getfUndertaker() {
		return fUndertaker;
	}

	public void setfUndertaker(String fUndertaker) {
		this.fUndertaker = fUndertaker;
	}

	public String getfRed() {
		return fRed;
	}

	public void setfRed(String fRed) {
		this.fRed = fRed;
	}
    
}