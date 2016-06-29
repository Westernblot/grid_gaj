package core.controller.imglink;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsImglink;
import core.util.Page;

@Controller
public class TsImglinkController extends BaseController{

	@Resource
	private TsImglinkService imglinkService;
	
	/**
	 * 图片链接 主页
	 * @return
	 */
	@RequestMapping("mImglinkMain.do")
	public ModelAndView imglinkMain(Page page){
		mv.clear();
		List<TsImglink> imglinkList=imglinkService.selectByPage(page);
		mv.addObject("imglinkList", imglinkList);
		mv.setViewName("imglink/imglinkMain");
		return mv;
	}
	
	/**
	 * 图片链接 UI
	 * @return
	 */
	@RequestMapping("mImglinkUI.do")
	public ModelAndView imglinkUI(Integer fId){
		mv.clear();
		TsImglink imglink=imglinkService.selectById(fId);
		mv.addObject("imglink", imglink);
		mv.setViewName("imglink/imglinkUI");
		return mv;
	}
	
	
	
	//======================CRUD===============================
	
	/**
	 * 增
	 * @param imglink
	 * @return
	 */
	@RequestMapping("mImglinkInsert.do")
	@ResponseBody
	public int imglinkInsert(TsImglink imglink){
		return imglinkService.insert(imglink);
	}
	
	/**
	 * 删
	 * @param fIds
	 * @return
	 */
	@RequestMapping("mImglinkDelete.do")
	@ResponseBody
	public int mImglinkDelete(String fIds){
		pd.put("fIds", fIds);
		return imglinkService.deleteByIds(pd);
	}
	
	/**
	 * 改
	 * @param imglink
	 * @return
	 */
	@RequestMapping("mImglinkUpdate.do")
	@ResponseBody
	public int mImglinkUpdate(TsImglink imglink){
		return imglinkService.update(imglink);
	}
	
}
