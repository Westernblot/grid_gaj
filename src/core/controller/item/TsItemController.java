package core.controller.item;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import core.controller.base.BaseController;
import core.entity.TsItem;
import core.util.Page;

@Controller
public class TsItemController extends BaseController{

	@Resource
	private TsItemService itemService;
	
	/**
	 * 考核条目
	 * @return
	 */
	@RequestMapping("mItemMain.do")
	public ModelAndView itemMain(Page page){
		mv.clear();
		List<TsItem> itemList=itemService.selectByPage(page);
		mv.addObject("itemList", itemList);
		mv.setViewName("item/itemMain");
		return mv;
	}
	
	
	/**
	 * 考核条目新增、编辑UI
	 */
	@RequestMapping("mItemUI.do")
	public ModelAndView itemUI(Integer fId){
		mv.clear();
		mv.addObject("nowYear", nowDate.substring(0, 4));//当前年份
		TsItem item=itemService.selectById(fId);
		mv.addObject("item", item);
		mv.setViewName("item/itemUI");
		return mv;
	}

	//======================以下CRUD===============================
	
	/**
	 * 增
	 * @param item
	 * @return
	 */
	@RequestMapping("mItemInsert.do")
	@ResponseBody
	public int itemInsert(TsItem item){
		return itemService.insert(item);
	}
	
	/**
	 * 删
	 * @param fIds
	 * @return
	 */
	@RequestMapping("mItemDelete.do")
	@ResponseBody
	public int itemDelete(String fIds){
		pd.put("fIds", fIds);
		return itemService.deleteByIds(pd);
	}
	
	/**
	 * 改
	 * @param item
	 * @return
	 */
	@RequestMapping("mItemUpdate.do")
	@ResponseBody
	public int mTsItemUpdate(TsItem item){
		return itemService.update(item);
	}
}
