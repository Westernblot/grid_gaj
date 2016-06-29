package core.controller.system.menu;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.system.SysMenu;

@Controller
public class SysMenuController extends BaseController{

	@Resource
	private SysMenuService sysMenuService;
	
	/**
	 * 菜单 管理 主页面
	 * @param page
	 * @return
	 */
	@RequestMapping("mMenuList.do")
	public ModelAndView menuMain(){
		mv.clear();
		SysMenu menu=new SysMenu();
		//一级菜单
		menu.setfLevel("1");
	    List<SysMenu> fMenu =sysMenuService.selectByModel(menu);
	    
	    //二级菜单
	    menu.setfLevel("2");
	    List<SysMenu> sMenu =sysMenuService.selectByModel(menu);
	    
		mv.addObject("fMenu", fMenu);
		mv.addObject("sMenu", sMenu);
		mv.setViewName("system/menu/menuList");
		return mv;
	}
	
	/**
	 * 菜单 新增、编辑UI
	 * @param fId
	 * @return
	 */
	@RequestMapping("mMenuUI.do")
	public ModelAndView menuUI(Integer fId){
		mv.clear();
		//一级菜单
		SysMenu sysMenu=new SysMenu();
		sysMenu.setfLevel("1");
		List<SysMenu> fMenuList = sysMenuService.selectByModel(sysMenu);
		mv.addObject("fMenuList", fMenuList);
	   
		SysMenu menu=sysMenuService.selectById(fId);
		mv.addObject("menu", menu);
		mv.setViewName("system/menu/menuUI");
		return mv;
	}
	
	/**
	 * 新增
	 * @param menu
	 * @return
	 */
	@RequestMapping("mMenuInsert.do")
	@ResponseBody
	public int menuInsert(SysMenu menu){
		if(menu.getfPid()==0){
			menu.setfLevel("1");
		}else{
			menu.setfLevel("2");
		}
		return sysMenuService.insert(menu);
	}
	
	/**
	 * 删除
	 * @param menu
	 * @return
	 */
	@RequestMapping("mMenuDelete.do")
	@ResponseBody
	public int menuDelete(String fIds){
		pd.put("fIds", fIds);
		return sysMenuService.deleteByIds(pd);
	}
	
	/**
	 * 修改
	 * @param menu
	 * @return
	 */
	@RequestMapping("mMenuUpdate.do")
	@ResponseBody
	public int menuUpdate(SysMenu menu){
		if(menu.getfPid()==0){
			menu.setfLevel("1");
		}else{
			menu.setfLevel("2");
		}
		return sysMenuService.update(menu);
	}

	
}
