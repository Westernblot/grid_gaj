package core.controller.rednews;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.news.TsNewsService;
import core.controller.system.dept.SysDeptService;
import core.entity.TsNews;
import core.entity.system.SysDept;
import core.util.Page;

@Controller
public class RedNewsController extends BaseController{

	
	@Resource
	private TsNewsService newsService;//新闻
	@Resource
	private SysDeptService deptService;//部门
	
	/**
	 * 普通新闻发布
	 * @return
	 */
	@RequestMapping("mRedNewsMain.do")
	public ModelAndView comnewsMain(Page page){
		mv.clear();
		pd = this.getPageData();
		page.setPd(pd);
		List<TsNews> newsList=newsService.selectByPage(page);
		mv.addObject("newsList", newsList);
		mv.setViewName("rednews/rednewsMain");
		return mv;
	}
	
	/**
	 * 普通新闻、摘要 新增、编辑页面
	 * 
	 * @param fId
	 * @return
	 */
	@RequestMapping("mRedNewsUI.do")
	public ModelAndView comnewsUI(Integer fId,String fGroup) {
		mv.clear();
		mv.addObject("fGroup", fGroup);//文章栏目分类
		
		//==============列出需要签收的部门=======================
		List<SysDept> deptList=deptService.selectMsgRecDept();
		mv.addObject("deptList", deptList);
		
		Integer maxNumber=newsService.selectMaxNumber();
		mv.addObject("maxNumber", maxNumber==null?1:maxNumber);
		
		TsNews news = newsService.selectById(fId);
		mv.addObject("news", news);
		mv.addObject("nowDate", nowDate);// 当前时间
		mv.setViewName("rednews/rednewsUI");
		return mv;
	}
	
}
