package core.controller.file;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsFile;
import core.entity.system.SysUser;
import core.util.DateUtil;
import core.util.Page;

@Controller
public class TsFileController extends BaseController{

	@Resource
	private TsFileService fileService;
	
	/**
	 * 文件管理
	 * @param page
	 * @return
	 */
	@RequestMapping("mTsFileMain.do")
	public ModelAndView TsFileMain(Page page,String fType){
		mv.clear();
		mv.addObject("fType", fType);//类别
		
		pd.put("fType", fType);
		page.setPd(pd);
		List<TsFile> fileList=fileService.selectByPage(page);
		mv.addObject("fileList", fileList);
		mv.setViewName("file/fileMain");
		return mv;
	}
	
	
	/**
	 * 文件 编辑 页面
	 * @return
	 */
	@RequestMapping("mTsFileUI.do")
	public ModelAndView fileUI(Integer fId,String fType){
		mv.clear();
		mv.addObject("fType", fType);//类别
		
		TsFile file=fileService.selectById(fId);
		mv.addObject("file", file);
		mv.setViewName("file/fileUI");
		return mv;
	}
	
	
	//======================CRUD================================
	/**
	 * 增
	 * @param file
	 * @return
	 */
	@RequestMapping("mFileInsert.do")
	@ResponseBody
	public int fileInsert(TsFile file,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("user");
		Integer fAddId=user.getfId();
		String fAddName=user.getfCname();
		String fAddDate=DateUtil.getDay();
		
		file.setfAddId(fAddId);
		file.setfAddName(fAddName);
		file.setfAddDate(fAddDate);
		
		return fileService.insert(file);
	}
	/**
	 * 删
	 * @param file
	 * @return
	 */
	@RequestMapping("mFileDelete.do")
	@ResponseBody
	public int mFileDelete(String fIds){
		pd.put("fIds", fIds);
		return fileService.deleteByIds(pd);
	}
	/**
	 * 改
	 * @param file
	 * @return
	 */
	@RequestMapping("mFileUpdate.do")
	@ResponseBody
	public int mFileUpdate(TsFile file){
		
		file.setfAttachment(file.getfAttachment() == null ? "" : file
				.getfAttachment());
		file.setfAttachmentUrl(file.getfAttachmentUrl() == null ? "" : file
				.getfAttachmentUrl());
		
		file.setfRecDept(file.getfRecDept()==null?"":file.getfRecDept());//签收部门处理
		
		return fileService.update(file);
	}
	
}
