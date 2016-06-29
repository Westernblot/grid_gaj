package core.controller.auditnews;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.news.TsNewsService;
import core.entity.TsNews;
import core.util.Page;

@Controller
public class TsAuditNewsController extends BaseController{
	
	
	@Resource
	private TsNewsService newsService;
	
	/**
	 * 一级审核，管理员审核
	 * @return
	 */
	@RequestMapping("mAuditMain1.do")
	public ModelAndView mAuditMain1(Page page){
		mv.clear();
		pd.put("fStatus", "未审核");
		page.setPd(pd);
		List<TsNews> newsList=newsService.selectByPage(page);
		mv.addObject("newsList", newsList);
		mv.setViewName("auditnews/auditMain1");
		return mv;
	}
	
	/**
	 * 审核页面
	 * @param fId
	 * @return
	 */
	@RequestMapping("auditUI1.do")
	public ModelAndView auditUI1(Integer fId){
		mv.clear();
		TsNews news=newsService.selectById(fId);
		mv.addObject("news", news);
		mv.setViewName("auditnews/auditUI1");
		return mv;
	}
	
	/**
	 * 审核修改
	 * @param news
	 * @return
	 */
	@RequestMapping("mAuditUpdate.do")
	@ResponseBody
	public int mAuditUpdate(TsNews news){
		return newsService.update(news);
	}
	
	
	/**
	 * 批量审核
	 */
	@RequestMapping("mBatchAuditUpdate.do")
	@ResponseBody
	public int mBatchAuditUpdate(String fIds,String fStatus){
		pd=this.getPageData();//封装数据
		return newsService.batchAuditUpdate(pd);
	}
	
	
	//==========================分割线========================================
	
	/**
	 * 二级审核，领导审核
	 * @return
	 */
	@RequestMapping("mAuditMain2.do")
	public ModelAndView mAuditMain2(Page page){
		mv.clear();
		pd.put("fStatus", "一级审核通过");
		page.setPd(pd);
		List<TsNews> newsList=newsService.selectByPage(page);
		mv.addObject("newsList", newsList);
		mv.setViewName("auditnews/auditMain2");
		return mv;
	}

	/**
	 * 审核页面
	 * @param fId
	 * @return
	 */
	@RequestMapping("auditUI2.do")
	public ModelAndView auditUI2(Integer fId){
		mv.clear();
		TsNews news=newsService.selectById(fId);
		mv.addObject("news", news);
		mv.setViewName("auditnews/auditUI2");
		return mv;
	}
	
	
}
