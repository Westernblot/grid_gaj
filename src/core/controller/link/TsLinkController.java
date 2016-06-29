package core.controller.link;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsLink;

@Controller
public class TsLinkController extends BaseController {

	@Resource
	private TsLinkService linkService;


	/**
	 * 外部链接 主页面
	 * 
	 * @param link
	 * @return
	 */
	@RequestMapping("mLinkMain.do")
	public ModelAndView linkMain(TsLink link,String fType) {
		mv.clear();
		mv.addObject("fType", fType);//类别
		List<TsLink> links = linkService.selectByModel(link);
		mv.addObject("links", links);
		mv.setViewName("link/linkMain");
		return mv;
	}

	/**
	 * 外部链接 新增、编辑 页面
	 * 
	 * @param fId
	 * @param fType
	 * @return
	 */
	@RequestMapping("mLinkUI.do")
	public ModelAndView linkUI(Integer fId,String fType) {
		mv.clear();
		mv.addObject("fType", fType);//类别
		TsLink link = linkService.selectById(fId);
		mv.addObject("link", link);
		mv.setViewName("link/linkUI");
		return mv;
	}

	/**
	 * 增
	 * 
	 * @param link
	 * @return
	 */
	@RequestMapping("mLinkInsert.do")
	@ResponseBody
	public int linkInsert(HttpSession session,TsLink link) {
		return linkService.insert(link);
	}

	/**
	 * 删
	 * 
	 * @param link
	 * @return
	 */
	@RequestMapping("mLinkDelete.do")
	@ResponseBody
	public int mLinkDelete(HttpSession session, String fIds) {
		pd.put("fIds", fIds);
		return linkService.deleteByIds(pd);
	}

	/**
	 * 改
	 * 
	 * @param link
	 * @return
	 */
	@RequestMapping("mLinkUpdate.do")
	@ResponseBody
	public int mLinkUpdate(HttpSession session, TsLink link) {
		return linkService.update(link);
	}
}
