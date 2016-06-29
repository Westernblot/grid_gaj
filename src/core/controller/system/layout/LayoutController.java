package core.controller.system.layout;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.mail.TsMailService;
import core.controller.system.menu.SysMenuService;
import core.entity.system.SysMenu;
import core.entity.system.SysUser;
import core.util.PageData;

@Controller
public class LayoutController extends BaseController{

	@Resource
	private SysMenuService menuService;
	@Resource
	private TsMailService mailService;
	
	/**
	 * 后台管理首页
	 * @return
	 */
	@RequestMapping("mIndex.do")
	public String IndexInit(){
		return "system/layout/index";
	}

	/**
	 * 顶部jsp
	 */
	@RequestMapping("mTop.do")
	public String webTop(){
		return "system/layout/top";
	}
	
	/**
	 * 左边jsp
	 */
	@RequestMapping("mLeft.do")
	public ModelAndView webLeft(HttpSession session){
		mv.clear();
		SysUser user=(SysUser) session.getAttribute("user");
		List<SysMenu> fMenu=null;//一级菜单
		List<SysMenu> sMenu=null;//二级菜单
		if(user.getfUname().equals("admin")){
			SysMenu menu=new SysMenu();
			menu.setfLevel("1");
			fMenu=menuService.selectByModel(menu);
			menu.setfLevel("2");
			sMenu=menuService.selectByModel(menu);
		}else{
			PageData pd=new PageData();
			pd.put("fIds", user.getfPower());
			pd.put("fLevel", "1");
			fMenu=menuService.selectPrivilage(pd);
			pd.put("fLevel", "2");
			sMenu=menuService.selectPrivilage(pd);
		}
		mv.addObject("fMenu", fMenu);
		mv.addObject("sMenu", sMenu);
		mv.setViewName("system/layout/left");
		return mv;
	}
	
	/**
	 * 右边jsp
	 */
	@RequestMapping("mRight.do")
	public ModelAndView webRight(HttpSession session){
		mv.clear();
		String tableName=this.getPersonMail(session);
		pd.put("tableName", tableName);
		int mailNum=mailService.countNoReadMail(pd);
		mv.addObject("mailNum", mailNum);//未读邮件
		
		PageData pData=mailService.selectTableDataSize(pd);
		float mSize= Float.parseFloat(pData.getString("data_size"));
		//System.out.println(mSize);
		mv.addObject("mSize", mSize);//我的邮箱空间大小
		
		mv.setViewName("system/layout/right");
		return mv;
	}
}
