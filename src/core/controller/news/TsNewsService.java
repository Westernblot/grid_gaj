package core.controller.news;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsNews;
import core.util.Page;
import core.util.PageData;

@Service
public class TsNewsService extends BaseService<TsNews>{

	/**
	 * 查询分组后，每组前10条的数据
	 * @param pd
	 * @return
	 */
	public List<TsNews> findTopOrderByfGroup(PageData pd){
		return (List<TsNews>) dao.findForList("TsNewsMapper.findTopOrderByfGroup", pd);
	}

	/**
	 * 查找栏目下的子栏目列表
	 * @param fGroup
	 * @return
	 */
	public List<PageData> selectSubList(PageData pd) {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("TsNewsMapper.selectSubList", pd);
	}

	/**
	 * 分类查找 所有 前10条的数据，封装成一个 List
	 * @param pd
	 * @return
	 */
	public List<TsNews> findDistinctTop10(PageData pd) {
		// TODO Auto-generated method stub
		List<TsNews> newsList=new ArrayList<TsNews>();
		
		List<PageData> fGroups=(List<PageData>) dao.findForList("TsNewsMapper.selectDistinctfGroup", null);
		
		for(int i=0;i<fGroups.size();i++){
			//System.out.println(fGroups.get(i).get("F_NAME"));
			pd.clear();
			pd.put("fGroup", fGroups.get(i).get("F_NAME"));
			List<TsNews>  nwList=(List<TsNews>) dao.findForList("TsNewsMapper.findTopGroup10", pd);
			for(TsNews n:nwList){
				//System.out.println(n.getfSubject()+","+n.getfGroup());
				newsList.add(n);
			}
			
		}
		
		return newsList;
	}

	/**
	 * 后台管理分页
	 * @param page
	 * @return
	 */
	public List<TsNews> manageSelectByPage(Page page) {
		// TODO Auto-generated method stub
		return (List<TsNews>) dao.findForList("TsNewsMapper.manageSelectByPage", page);
	}

	/**
	 * 查找最大的 排序号
	 * @return
	 */
	public Integer selectMaxNumber() {
		// TODO Auto-generated method stub
		return (Integer) dao.findForObject("TsNewsMapper.selectMaxNumber", null);
	}

	/**
	 * 获取今日关注、要闻排行、编辑推荐
	 * @param pd
	 * @return
	 */
	public List<TsNews> selectDataLimit(PageData pd) {
		// TODO Auto-generated method stub
		return (List<TsNews>) dao.findForList("TsNewsMapper.selectDataLimit", pd);
	}

	/**
	 * 查找信息排行 前11的数据
	 * @return
	 */
	public List<TsNews> selectTopNewsList(PageData pd) {
		// TODO Auto-generated method stub
		return (List<TsNews>) dao.findForList("TsNewsMapper.selectTopNewsList", pd);
	}

	/**
	 * 滚动新闻查找，前5个
	 * @return
	 */
	public List<TsNews> findLoopNewsList(PageData pd) {
		// TODO Auto-generated method stub
		return (List<TsNews>) dao.findForList("TsNewsMapper.findLoopNewsList", pd);
	}

	
	/**
	 * 通知通报签核
	 * @return
	 */
	public int signNews(PageData pd) {
		// TODO Auto-generated method stub
		return (int) dao.update("TsNewsMapper.signNews", pd);
	}

	/**
	 * 判断是否已经签核
	 * @param pd
	 * @return
	 */
	public int checkSign(PageData pd) {
		// TODO Auto-generated method stub
		return (int) dao.findForObject("TsNewsMapper.checkSign", pd);
	}

	/**
	 * 批量审核修改
	 * @param pd
	 * @return
	 */
	public int batchAuditUpdate(PageData pd) {
		// TODO Auto-generated method stub
		return (int) dao.update("TsNewsMapper.batchAuditUpdate", pd);
	}

	/**
	 * 点击查看阅读次数加1
	 * @param fId
	 */
	public void addnewsfRead(Integer fId) {
		dao.update("TsNewsMapper.addnewsfRead", fId);
		
	}
}
