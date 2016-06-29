package core.controller.vedio;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsVedio;
import core.util.Page;

@Controller
public class TsVedioController extends BaseController{

	@Resource
	private TsVedioService vedioService;
	
	/**
	 * 视频 首页
	 * @return
	 */
	@RequestMapping("mVedioMain.do")
	public ModelAndView vedioMain(Page page){
		mv.clear();
		List<TsVedio> vedioList=vedioService.selectByPage(page);
		mv.addObject("vedioList", vedioList);
		mv.setViewName("vedio/vedioMain");
		return mv;
	}
	
	/**
	 * 视频添加页面
	 * @return
	 */
	@RequestMapping("mVedioUI.do")
	public ModelAndView vedioUI(Integer fId){
		mv.clear();
		TsVedio vedio=vedioService.selectById(fId);
		mv.addObject("vedio", vedio);
		mv.setViewName("vedio/vedioUI");
		return mv;
	}
	
	//===================CRUD=============================
	
	/**
	 * 增
	 * @param vedio
	 * @return
	 */
	@RequestMapping("mVedioInsert.do")
	@ResponseBody
	public int vedioInsert(TsVedio vedio){
		return vedioService.insert(vedio);
	}
	
	/**
	 * 删
	 * @param vedio
	 * @return
	 */
	@RequestMapping("mVedioDelete.do")
	@ResponseBody
	public int vedioInsert(String fIds){
		pd.put("fIds", fIds);
		return vedioService.deleteByIds(pd);
	}
	
	/**
	 * 改
	 * @param vedio
	 * @return
	 */
	@RequestMapping("mVedioUpdate.do")
	@ResponseBody
	public int mVedioUpdate(TsVedio vedio){
		
		vedio.setfImg(vedio.getfImg() == null ? "" : vedio.getfImg());
		vedio.setfImgUrl(vedio.getfImgUrl() == null ? "" : vedio.getfImgUrl());
		vedio.setfVedio(vedio.getfVedio()==null?"":vedio.getfVedio());
		vedio.setfVedioUrl(vedio.getfVedioUrl()==null?"":vedio.getfVedioUrl());
		
		return vedioService.update(vedio);
	}
}
