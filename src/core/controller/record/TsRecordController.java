package core.controller.record;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsRecord;
import core.util.Page;

@Controller
public class TsRecordController extends BaseController{

	
	@Resource
	private TsRecordService recordService;
	
	/**
	 * 消息记录查看
	 * @param page
	 * @return
	 */
	@RequestMapping("mRecordMain.do")
	public ModelAndView tsRecordMain(Page page){
		mv.clear();
		List<TsRecord> recordList=recordService.selectByPage(page);
		mv.addObject("recordList", recordList);
		mv.setViewName("record/recordMain");
		return mv;
	}
	
}
