package core.controller.topics;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.group.TsGroupService;
import core.controller.news.TsNewsService;
import core.entity.TsGroup;
import core.entity.TsNews;
import core.util.Page;

@Controller
public class TopicsController extends BaseController{

	@Resource
	private TsNewsService newsService;
	@Resource
	private TopicsService topService;
	@Resource
	private TsGroupService groupService;
	
	
	/**
	 * 专项工作、中心工作
	 * @param page
	 * @return
	 */
	@RequestMapping("mTopicsMain.do")
	public ModelAndView topicsMain(Page page){
		mv.clear();
		pd=this.getPageData();
		page.setPd(pd);//获取查询条件
		List<TsNews> newsList=topService.selectTopicsNewsByPage(page);
		mv.addObject("newsList", newsList);
		mv.setViewName("topics/topicsMain");
		return mv;
	}
	
	/**
	 * 新增、编辑页面
	 * @param fId
	 * @return
	 */
	@RequestMapping("mTopicsUI.do")
	public ModelAndView topicsUI(Integer fId,String fType){
		mv.clear();
		mv.addObject("fType", fType);//
		
		Integer maxNumber=newsService.selectMaxNumber();
		mv.addObject("maxNumber", maxNumber==null?1:maxNumber);//排序号
		mv.addObject("nowDate", nowDate);                      //当前日期
		
		TsGroup group=new TsGroup();
		group.setfType(fType);//专项工作 OR 中心工作
		List<TsGroup> groupList=groupService.selectByModel(group);
		mv.addObject("groupList", groupList);// 专题栏目数据
		
		TsNews news = newsService.selectById(fId);
		mv.addObject("news", news);
		mv.setViewName("topics/topicsUI");
		return mv;
	}
	
}
