package core.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.exam.TsExamService;
import core.controller.file.TsFileService;
import core.controller.group.TsGroupService;
import core.controller.info.TsInfoService;
import core.controller.link.TsLinkService;
import core.controller.news.TsNewsService;
import core.controller.onduty.TsOndutyService;
import core.controller.pic.TsPicService;
import core.controller.system.dept.SysDeptService;
import core.controller.system.user.SysUserService;
import core.controller.vedio.TsVedioService;
import core.entity.TsExam;
import core.entity.TsFile;
import core.entity.TsGroup;
import core.entity.TsInfo;
import core.entity.TsLink;
import core.entity.TsNews;
import core.entity.TsOnduty;
import core.entity.TsVedio;
import core.entity.system.SysDept;
import core.entity.system.SysUser;
import core.util.DateUtil;
import core.util.Page;
import core.util.PageData;

@Controller
public class MainController extends BaseController {

	@Resource
	private TsNewsService newsService;//新闻
	@Resource
	private TsGroupService groupService;//组别：中心工作、专项工作
	@Resource
	private TsOndutyService ondutyService;//值班
	@Resource
	private SysUserService userService;//用户
	@Resource
	private TsVedioService vedioService;//视频
	@Resource
	private TsLinkService linkService;//外部链接
	@Resource
	private TsInfoService infoService;//辅助信息
	@Resource
	private TsPicService picService;//图片更换信息

	/**
	 * 网站首页
	 * 
	 * @return
	 */
	@RequestMapping("home")
	public ModelAndView home() {
		mv.clear();
		// 获取普通新闻分组后，前10条的数据显示在页面上
		pd.put("fStatus", "审核通过");
		List<TsNews> newsList = newsService.findTopOrderByfGroup(pd);
		mv.addObject("newsList", newsList);
		
		
		//中心工作 AND 专项工作
		List<TsGroup> groupList=groupService.selectByModel(new TsGroup());
		mv.addObject("groupList", groupList);
		
		//滚动图片
		List<TsNews> loopNewsList=newsService.findLoopNewsList(pd);
		mv.addObject("loopNewsList", loopNewsList);
		
		//今日值班
		String fMonth=DateUtil.getDay().substring(0,7);
		pd.put("fMonth", fMonth);
		TsOnduty onduty=ondutyService.selectByfMonth(pd);
		if(onduty!=null){
		Integer num=Integer.valueOf(DateUtil.getDay().substring(8,10))-1;
		System.out.println(num);
		String fLeader=onduty.getfLeader().split(",")[num];
		String fPolice=onduty.getfPolice().split(",")[num];
		mv.addObject("fLeader", fLeader);
		mv.addObject("fPolice", fPolice);
		}
		
		//值班电话
		TsInfo info=infoService.findInfoByName("值班电话");
		String fDutyPhone=info.getfContent();
		mv.addObject("fDutyPhone", fDutyPhone);
		
		//治安考核的部门
		List<SysDept> deptList=deptService.selectExamDept();
		mv.addObject("deptList", deptList);
		
		//外部链接
		List<TsLink> linkList=linkService.selectByModel(new TsLink());
		mv.addObject("linkList", linkList);
		
		//根据当前时间倒退3天，以确定3天内的数据都是new
		String bfDate=DateUtil.getAfterDayDate("-3");
		mv.addObject("bfDate", bfDate);
		
		
		//网站图片更换
		String centerPics=picService.findPicOne("center");
		mv.addObject("centerPics", centerPics);
		
		String footPics=picService.findPicFiles("foot");
		mv.addObject("footPics",footPics);
		
		
		//网站底部地址更换
		String footAddress=infoService.findStringInfoByName("网站底部地址");
		String footPhone=infoService.findStringInfoByName("网站底部电话");
		mv.addObject("footAddress", footAddress);
		mv.addObject("footPhone", footPhone);
		
		mv.setViewName("website/index");
		return mv;
	}

	
	
	//=============================分割线=============================================
	
	/**
	 * 栏目列表
	 * @return
	 */
	@RequestMapping("list")
	public ModelAndView list(Page page,String fGroup){
		mv.clear();
		mv.addObject("fGroup", fGroup);//
		pd.put("fGroup", fGroup);//栏目组别
		page.setPd(pd);
		
        //信息排行
		pd.put("fStatus", "审核通过");
		List<TsNews> topNewsList=newsService.selectTopNewsList(pd);
		mv.addObject("topNewsList", topNewsList);
		
		List<TsNews> newsList=newsService.selectByPage(page);
		mv.addObject("newsList", newsList);  //新闻分页列表
		
		//显示指定列表页面
		String viewName="website/list";
		if(fGroup !=null &&(fGroup.equals("办公室动态") || fGroup.equals("治安管理大队") || fGroup.equals("社区警务管理大队") || fGroup.equals("治安行动大队"))){
			viewName="website/list02";
		}
		mv.setViewName(viewName);
		return mv;
	}
	
	
	/**
	 * 文件显示
	 * @return
	 */
	@RequestMapping("show")
	public ModelAndView show(Integer fId,String fRed){
		mv.clear();
		
		TsNews news=newsService.selectById(fId);
		mv.addObject("news", news);
		
		//点击查看阅读次数加1
		newsService.addnewsfRead(fId);
		
		//显示指定显示页面
		String viewName="website/show";
		if(fRed!=null && fRed.equals("非红头样式")){
			viewName="website/showNotRed";
		}else if(fRed!=null && fRed.equals("黄石治安简报")){
			viewName="website/showRed1";
		}else if(fRed!=null && fRed.equals("黄石市公安局")){
			viewName="website/showRed2";
		}else if(fRed!=null && fRed.equals("黄石市公安局政治部文件")){
			viewName="website/showRed3";
		}
		mv.setViewName(viewName);
		return mv;
	}
	
	/**
	 * 前台登陆
	 * @return
	 */
	@RequestMapping("webLogin")
	public String webLogin(){
		return "website/webLogin";
	}
	
	/**
	 * 判断是否已经签核
	 * @return
	 */
	@RequestMapping("checkSign")
	@ResponseBody
	public int checkSign(){
		pd=this.getPageData();
		return newsService.checkSign(pd);
	}
	
	/**
	 * 文件 签核操作
	 * @return
	 */
	@RequestMapping("doSignNews.do")
	@ResponseBody
	public int doSignNews(){
		pd=this.getPageData();
		return newsService.signNews(pd);
	}
	
	//=====================================================================
	
	/**
	 * 支队每月 排班表
	 * @return
	 */
	@RequestMapping("ondutyMonth")
	public ModelAndView tsOnduty(){
		mv.clear();
		String fMonth=DateUtil.getDay().substring(0,7);
		pd.put("fMonth", fMonth);
		TsOnduty onduty=ondutyService.selectByfMonth(pd);
		if(onduty!=null){
			mv.addObject("onduty", onduty);
		}
		mv.setViewName("website/onduty");
		return mv;
	}


	/**
	 * 通讯录
	 * @return
	 */
	@RequestMapping("phonebook")
	public ModelAndView phoneBook(Page page){
		mv.clear();
		List<SysUser> userList=userService.selectByPage(page);
		mv.addObject("userList", userList);
		mv.setViewName("website/phonebook");
		return mv;
	}
	
	/**
	 * 视频列表
	 * @return
	 */
	@RequestMapping("vedioList")
	public ModelAndView vedioList(Page page){
		mv.clear();
		List<TsVedio> vedioList=vedioService.selectByPage(page);
		mv.addObject("vedioList", vedioList);
		mv.setViewName("website/vedioList");
		return mv;
	}
	
	/**
	 * 视频显示
	 * @return
	 */
	@RequestMapping("vedioShow")
	public ModelAndView vedioShow(Integer fId){
		mv.clear();
		TsVedio vedio=vedioService.selectById(fId);
		mv.addObject("vedio", vedio);
		mv.setViewName("website/vedioShow");
		return mv;
	}
	
	
	//=============================分割线===================================================

	@Resource
	private TsFileService fileService;//文件上传下载
	@Resource
	private SysDeptService deptService;//部门service
	
	
	/**
	 * 下载中心 《普通文件》
	 * @param page
	 * @return
	 */
	@RequestMapping("downlist")
	public ModelAndView fileList(Page page){
		mv.clear();
		pd.put("fType", "普通文件");
		page.setPd(pd);
		List<TsFile> fileList=fileService.selectByPage(page);
		mv.addObject("fileList", fileList);
		mv.setViewName("website/downlist");
		return mv;
	}
	
	
	/**
	 * 文件上传下载
	 * @return
	 */
	@RequestMapping("upload2download")
	public ModelAndView upload2download(HttpSession session,Page page){
		mv.clear();
		SysUser user=(SysUser) session.getAttribute("user");
		if(user==null){
			mv.setViewName("website/webLogin");//如果用户没有登陆，则转去前台登陆页面
			return mv;
		}
		
		//查询条件
		//List<SysDept> deptList=deptService.selectByModel(new SysDept());
		//mv.addObject("deptList", deptList);
		
		pd=this.getPageData();//获取页面的查询条件
		pd.put("fType", "签收文件");
		pd.put("fRecDept", user.getfDept());
		page.setPd(pd);
		List<TsFile> fileList=fileService.selectByPage(page);
		mv.addObject("fileList", fileList);
		
		mv.setViewName("website/upload2download");
		return mv;
	}
	
	//=========================文件搜索======================================
	
	/**
	 * 搜索引擎
	 * @return
	 */
	@RequestMapping("search")
	public ModelAndView search(Page page){
		mv.clear();
		pd=this.getPageData();
		pd.put("fStatus", "审核通过");
		page.setPd(pd);
		List<TsNews> newsList=newsService.selectByPage(page);
		mv.addObject("newsList", newsList);
		mv.setViewName("website/search");
		return mv;
	}
	
	
	//==================================治安考核前台显示=======================================
	
	@Resource
	private TsExamService examService;
	
	/**
	 * 治安考核前台显示
	 */
	@RequestMapping("examShow")
	public ModelAndView examShow(Page page){
		mv.clear();
		
		//治安考核的部门
		List<SysDept> deptList=deptService.selectExamDept();
		mv.addObject("deptList", deptList);
		
		pd=this.getPageData();
		page.setPd(pd);
		List<PageData> pdList = examService.selectByPage(page);
		mv.addObject("pdList", pdList);
		mv.setViewName("website/examShow");
		return mv;
	}
}
