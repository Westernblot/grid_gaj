package core.controller.signfile;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.controller.file.TsFileService;
import core.controller.system.dept.SysDeptService;
import core.entity.TsFile;
import core.entity.system.SysDept;
import core.util.Page;

@Controller
public class TsSignFileController extends BaseController{

	@Resource
	private TsFileService fileService;
	@Resource
	private SysDeptService deptService;//部门

	
	/**
	 * 签收文件管理
	 * @param page
	 * @return
	 */
	@RequestMapping("mSignFileMain.do")
	public ModelAndView mSignFileMain(Page page,String fType){
		mv.clear();
		mv.addObject("fType", fType);//类别
		
		pd.put("fType", fType);
		page.setPd(pd);
		List<TsFile> fileList=fileService.selectByPage(page);
		mv.addObject("fileList", fileList);
		mv.setViewName("signfile/signfileMain");
		return mv;
	}
	
	
	/**
	 * 签收文件 编辑 页面
	 * @return
	 */
	@RequestMapping("mSignFileUI.do")
	public ModelAndView mSignFileUI(Integer fId,String fType){
		mv.clear();
		mv.addObject("fType", fType);//类别
		
		//==============列出所有部门=======================
		List<SysDept> deptList=deptService.selectByModel(new SysDept());
		mv.addObject("deptList", deptList);
		
		TsFile file=fileService.selectById(fId);
		mv.addObject("file", file);
		mv.setViewName("signfile/signfileUI");
		return mv;
	}
	
	
}
