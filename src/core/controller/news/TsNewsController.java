package core.controller.news;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsNews;
import core.entity.system.SysUser;
import core.util.Page;

@Controller
public class TsNewsController extends BaseController {

	@Resource
	private TsNewsService newsService;

	/**
	 * 新闻、摘要列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping("mNewsMain.do")
	public ModelAndView newsMain(Page page) {
		mv.clear();
		pd = this.getPageData();
		page.setPd(pd);
		List<TsNews> newsList = newsService.manageSelectByPage(page);
		mv.addObject("newsList", newsList);
		mv.setViewName("news/newsMain");
		return mv;
	}

	/**
	 * 新闻、摘要 新增、编辑页面
	 * 
	 * @param fId
	 * @return
	 */
	@RequestMapping("mNewsUI.do")
	public ModelAndView newsUI(Integer fId,String fGroup) {
		mv.clear();
		mv.addObject("fGroup", fGroup);//文章栏目分类
		
		Integer maxNumber=newsService.selectMaxNumber();
		mv.addObject("maxNumber", maxNumber==null?1:maxNumber);
		
		TsNews news = newsService.selectById(fId);
		mv.addObject("news", news);
		mv.addObject("nowDate", nowDate);// 当前时间
		mv.setViewName("news/newsUI");
		return mv;
	}

	/**
	 * 新增
	 * 
	 * @param news
	 * @return
	 */
	@RequestMapping("mNewsInsert.do")
	@ResponseBody
	public int newsInsert(HttpSession session, TsNews news) {
		SysUser user = (SysUser) session.getAttribute("user");
		news.setfAddId(user.getfId());
		news.setfAddName(user.getfCname());
		news.setfAddDept(user.getfDept());
		news.setfAddDate(nowDate);

		return newsService.insert(news);
	}

	/**
	 * 删除
	 * 
	 * @param news
	 * @return
	 */
	@RequestMapping("mNewsDelete.do")
	@ResponseBody
	public int mNewsDelete(HttpSession session, String fIds) {

		pd.put("fIds", fIds);
		return newsService.deleteByIds(pd);
	}

	/**
	 * 修改
	 * 
	 * @param news
	 * @return
	 */
	@RequestMapping("mNewsUpdate.do")
	@ResponseBody
	public int mNewsUpdate(HttpSession session,TsNews news) {

		news.setfImg(news.getfImg() == null ? "" : news.getfImg());
		news.setfImgUrl(news.getfImgUrl() == null ? "" : news.getfImgUrl());
		news.setfAttachment(news.getfAttachment() == null ? "" : news
				.getfAttachment());
		news.setfAttachmentUrl(news.getfAttachmentUrl() == null ? "" : news
				.getfAttachmentUrl());
		
		news.setfRecDept(news.getfRecDept()==null?"":news.getfRecDept());//签收部门处理
		news.setfTop(news.getfTop()==null?"":news.getfTop());//是否置顶显示
		
		return newsService.update(news);
	}

}
