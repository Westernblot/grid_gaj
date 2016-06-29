package core.controller.pic;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsPic;
import core.util.Page;

@Controller
public class TsPicController extends BaseController{

	@Resource
	private TsPicService picService;
	
	/**
	 * 图片 轮换 主要页
	 * @return
	 */
	@RequestMapping("mPicMain.do")
	public ModelAndView picMain(Page page){
		mv.clear();
		pd=this.getPageData();
		mv.addObject("fType", pd.getString("fType"));//类别区分
		
		page.setPd(pd);
		List<TsPic> picList=picService.selectByPage(page);
		mv.addObject("picList", picList);
		mv.setViewName("pic/picMain");
		return mv;
	}
	
	
	/**
	 * 图片修改页面
	 */
	@RequestMapping("mPicUI.do")
	public ModelAndView picUI(Integer fId,String fType){
		mv.clear();
		mv.addObject("fType", fType);//类别区分
		
		TsPic pic=picService.selectById(fId);
		mv.addObject("pic", pic);
		mv.setViewName("pic/picUI");
		return mv;
	}
	
	//====================以下CRUD=============================
	
	/**
	 * 增
	 * @param pic
	 * @return
	 */
	@RequestMapping("mPicInsert.do")
	@ResponseBody
	public int picInsert(TsPic pic){
		return picService.insert(pic);
	}
	
	/**
	 * 删
	 * @param pic
	 * @return
	 */
	@RequestMapping("mPicDelete.do")
	@ResponseBody
	public int mPicDelete(String fIds){
		pd=this.getPageData();
		return picService.deleteByIds(pd);
	}
	
	/**
	 * 改
	 * @param pic
	 * @return
	 */
	@RequestMapping("mPicUpdate.do")
	@ResponseBody
	public int mPicUpdate(TsPic pic){
		return picService.update(pic);
	}
}
