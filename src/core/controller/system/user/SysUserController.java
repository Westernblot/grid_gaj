package core.controller.system.user;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.system.menu.SysMenuService;
import core.entity.system.SysMenu;
import core.entity.system.SysUser;
import core.util.Page;

@Controller
public class SysUserController extends BaseController {

	@Resource
	private SysUserService userService;
	@Resource
	private SysMenuService sysMenuService;
	
	/**
	 * 系统用户 列表
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping("mUserMain.do")
	public ModelAndView userMain(Page page) {
		mv.clear();
		pd = this.getPageData();// 获取查询条件
		page.setPd(pd);
		List<SysUser> users = userService.selectByPage(page);
		mv.addObject("page", page);
		System.out.println(page.toString());
		mv.addObject("users", users);
		mv.setViewName("system/user/userMain");
		return mv;
	}
	
	/**
	 * 新增、编辑用户
	 * 
	 * @param fId
	 * @return
	 */
	@RequestMapping("mUserUI.do")
	public ModelAndView userUI(Integer fId) {
		mv.clear();
		SysUser sUser=userService.selectById(fId);
		mv.addObject("sUser", sUser);
		mv.setViewName("system/user/userUI");
		return mv;
	}
	
	/**
	 * 设置用户权限页面
	 * @return
	 */
	@RequestMapping("mSetPrivilageUI.do")
	public ModelAndView setPrivilage(Integer fId){
		mv.clear();
		//选择用户信息
		SysUser user=userService.selectById(fId);
		mv.addObject("user", user);
		
		SysMenu menu=new SysMenu();
		//一级菜单
		menu.setfLevel("1");
	    List<SysMenu> fMenu =sysMenuService.selectByModel(menu);
	    
	    //二级菜单
	    menu.setfLevel("2");
	    List<SysMenu> sMenu =sysMenuService.selectByModel(menu);
	    
		mv.addObject("fMenu", fMenu);
		mv.addObject("sMenu", sMenu);
		mv.setViewName("system/user/setPrivilageUI");
		return mv;
	}
	
	
	/**
	 * 修改密码页面
	 * 
	 * @return
	 */
	@RequestMapping("mUpdatePasswordUI.do")
	public ModelAndView updatePasswordUI(Integer fId) {
		mv.clear();
		SysUser user = userService.selectById(fId);
		mv.addObject("user", user);
		mv.setViewName("system/user/updatePasswordUI");
		return mv;
	}

	
	/**
	 * 批量重置密码
	 */
	@RequestMapping("mResetPassword.do")
	@ResponseBody
	public int mResetPassword(String fIds){
		pd.put("fIds", fIds);
		return userService.resetPassword(pd);
	}
	
	
	/**
	 * 检查账号唯一性
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("mCheckUser.do")
	@ResponseBody
	public int checkUser(SysUser user) {
		int flag = 0;
		List<SysUser> users = userService.selectByModel(user);
		if (users != null && users.size() > 0) {
			flag = 1;
		}
		return flag;
	}

	/**
	 * 新增
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("mUserInsert.do")
	@ResponseBody
	public int userInsert(HttpSession session, SysUser user) {
		return userService.relateInsert(user);
	}

	/**
	 * 删除
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("mUserDelete.do")
	@ResponseBody
	public int userDelete(HttpSession session,String fIds) {
		pd.put("fIds", fIds);
		return userService.relateDelete(pd);
	}

	/**
	 * 修改
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("mUserUpdate.do")
	@ResponseBody
	public int userUpdate(HttpSession session, SysUser user) {
		return userService.update(user);
	}

}
