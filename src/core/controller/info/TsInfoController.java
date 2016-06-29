package core.controller.info;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsInfo;

@Controller
public class TsInfoController extends BaseController{

	
	@Resource
	private TsInfoService infoService;
	
	/**
	 * 显示页
	 * @param fName
	 * @return
	 */
	@RequestMapping("mInfoMain.do")
	public ModelAndView tsInfo(String fName){
		mv.clear();
		mv.addObject("fName", fName);  //信息标识
		TsInfo info=infoService.findInfoByName(fName);
		mv.addObject("info", info);
		mv.setViewName("info/phone");
		return mv;
	}
	
	//========================CRUD============================
	
	/**
	 * 增
	 * @param info
	 * @return
	 */
	@RequestMapping("mInfoInsert.do")
	@ResponseBody
	public int mtsInfoInsert(TsInfo info){
		return infoService.insert(info);
	}
	
	/**
	 * 改
	 * @param info
	 * @return
	 */
	@RequestMapping("mInfoUpdate.do")
	@ResponseBody
	public int mTsInfoUpdate(TsInfo info){
		return infoService.update(info);
	}
	
	
}
