package core.controller.comnews;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.news.TsNewsService;
import core.entity.TsNews;
import core.util.Page;

@Controller
public class ComNewsController extends BaseController{

	
	@Resource
	private TsNewsService newsService;
	
	/**
	 * 普通新闻发布
	 * @return
	 */
	@RequestMapping("mComNewsMain.do")
	public ModelAndView comnewsMain(Page page){
		mv.clear();
		pd = this.getPageData();
		page.setPd(pd);
		List<TsNews> newsList=newsService.selectByPage(page);
		mv.addObject("newsList", newsList);
		mv.setViewName("comnews/comnewsMain");
		return mv;
	}
	
	/**
	 * 普通新闻、摘要 新增、编辑页面
	 * 
	 * @param fId
	 * @return
	 */
	@RequestMapping("mComNewsUI.do")
	public ModelAndView comnewsUI(Integer fId,String fGroup) {
		mv.clear();
		mv.addObject("fGroup", fGroup);//文章栏目分类
		
		Integer maxNumber=newsService.selectMaxNumber();
		mv.addObject("maxNumber", maxNumber==null?1:maxNumber);
		
		TsNews news = newsService.selectById(fId);
		mv.addObject("news", news);
		mv.addObject("nowDate", nowDate);// 当前时间
		mv.setViewName("comnews/comnewsUI");
		return mv;
	}
	
}
