package core.controller.system.login;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.system.user.SysUserService;
import core.entity.system.SysUser;

@Controller
public class LoginController extends BaseController{

	@Resource
	private SysUserService userService;
	
	/**
	 * 后台登陆页面
	 * @return
	 */
	@RequestMapping("toLogin")
	public String login(){
		return "system/login";
	}

	/**
	 * 用户退出
	 */
	@RequestMapping("logout")
	public ModelAndView layout(HttpSession session) {
		mv.clear();
		session.removeAttribute("user");
		mv.setViewName("redirect:/toLogin");
		return mv;
	}

	/**
	 * 用户登陆
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("userLogin")
	@ResponseBody
	public int userLogin(HttpSession session, SysUser user) {
		int flag = 0;
		List<SysUser> users = userService.selectByModel(user);
		if (users != null && users.size() > 0) {
			SysUser u = users.get(0); // 取系统用户，设置session值
			session.setAttribute("user", u);// 设置用户
			flag = 1;
		}
		return flag;
	}

}
