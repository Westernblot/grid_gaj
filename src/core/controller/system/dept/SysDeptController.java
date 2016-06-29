package core.controller.system.dept;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.system.SysDept;
import core.util.PageData;

@Controller
public class SysDeptController extends BaseController{

	@Resource
	private SysDeptService deptService;
	
	/**
	 * 部门管理 主页面
	 * @return
	 */
	@RequestMapping("mDeptMain.do")
	public ModelAndView deptMain(SysDept dept){
		mv.clear();
		List<PageData> pdList=deptService.selectTreeData();
		mv.addObject("pdList", pdList);
		mv.setViewName("system/dept/deptMain");
		return mv;
	}
	
	
	/**
	 * 部门 新增、编辑 页面
	 * @param fId
	 * @return
	 */
	@RequestMapping("mDeptUI.do")
	public ModelAndView deptUI(Integer fId){
		mv.clear();
		List<SysDept> deptList=deptService.selectByModel(new SysDept());
		mv.addObject("deptList", deptList);
		
		pd.put("fId", fId);
		PageData pDept=deptService.relateSelectById(pd);
		mv.addObject("pDept", pDept);
		mv.setViewName("system/dept/deptUI");
		return mv;
	}
	
	
	/**
	 * 获取 部门树数据
	 * @return
	 */
	@RequestMapping("mDeptList.do")
	@ResponseBody
	public List<PageData> deptList(){
		return deptService.selectTreeData();
	}
	
	
	//============================以下CRUD=============================
	/**
	 * 部门关联删除；删除父部门的同时,删除子部门
	 * @param fIds
	 * @return
	 */
	@RequestMapping("mDeptRelateDelete.do")
	@ResponseBody
	public int deptRelateDelete(String fIds){
		pd.put("fIds", fIds);
		return deptService.relateDelte(pd);
	}
	
	/**
	 * 增
	 * @param dept
	 * @return
	 */
	@RequestMapping("mDeptInsert.do")
	@ResponseBody
	public int deptInsert(SysDept dept){
		Integer fLevel;
		if(dept.getfPid()==0){//如果是根节点，则层级为1
			fLevel=1;
		}else{                //如果不是根节点，则层级为 父级层级+1
			fLevel=deptService.findParentLevel(dept.getfPid())+1;
		}
		
		dept.setfLevel(fLevel);
		return deptService.relateInsert(dept);
	}
	
	
	/**
	 * 改
	 * @param dept
	 * @return
	 */
	@RequestMapping("mDeptUpdate.do")
	@ResponseBody
	public int mDeptUpdate(SysDept dept){
		Integer fLevel;
		if(dept.getfPid()==0){//如果是根节点，则层级为1
			fLevel=1;
		}else{                //如果不是根节点，则层级为 父级层级+1
			fLevel=deptService.findParentLevel(dept.getfPid())+1;
		}
		
		dept.setfLevel(fLevel);
		return deptService.update(dept);
	}
	
//	/**
//	 * 删
//	 * @param fIds
//	 * @return
//	 */
//	@RequestMapping("mDeptDelete.do")
//	@ResponseBody
//	public int mDeptDelete(String fIds){
//		pd.put("fIds", fIds);
//		return deptService.deleteByIds(pd);
//	}
	
}
