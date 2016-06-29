package core.controller.group;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsGroup;


@Controller
public class TsGroupController extends BaseController{

	@Resource
	private TsGroupService groupService;
	
	/**
	 * 组别管理 页面
	 * @return
	 */
	@RequestMapping("mTsGroupMain.do")
	public ModelAndView tsGroup(TsGroup group){
		mv.clear();
		mv.addObject("fType", group.getfType());//类别
		List<TsGroup> groups=groupService.selectByModel(group);
		mv.addObject("groups", groups);
		mv.setViewName("group/tsGroupMain");
		return mv;
	}
	
	/**
	 * 组别、新增 编辑页面
	 * @param fId
	 * @return
	 */
	@RequestMapping("mTsGroupUI.do")
	public ModelAndView tsGroupUI(Integer fId,String fType){
		mv.clear();
		mv.addObject("fType", fType);//类别
		TsGroup group=groupService.selectById(fId);
		mv.addObject("group", group);
		mv.setViewName("group/tsGroupUI");
		return mv;
	}
	
	/**
	 * 新增
	 * @param group
	 * @return
	 */
	@RequestMapping("mTsGroupInsert.do")
	@ResponseBody
	public int tsGroupInsert(TsGroup group){
		return groupService.insert(group);
	}
	/**
	 * 删除
	 * @param group
	 * @return
	 */
	@RequestMapping("mTsGroupDelete.do")
	@ResponseBody
	public int tsGroupDelete(String fIds){
		pd.put("fIds", fIds);
		return groupService.deleteByIds(pd);
	}
	/**
	 * 修改
	 * @param group
	 * @return
	 */
	@RequestMapping("mTsGroupUpdate.do")
	@ResponseBody
	public int mTsGroupUpdate(TsGroup group){
		
		group.setfImg(group.getfImg() == null ? "" : group.getfImg());
		group.setfImgUrl(group.getfImgUrl() == null ? "" : group.getfImgUrl());
		
		return groupService.update(group);
	}
}
