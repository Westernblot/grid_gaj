package core.controller.topics;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsNews;
import core.util.Page;

@Service
public class TopicsService extends BaseService{

	
	/**
	 * 专项工作 查询
	 * @param page
	 * @return
	 */
	public List<TsNews> selectTopicsNewsByPage(Page page) {
		// TODO Auto-generated method stub
		return (List<TsNews>) dao.findForList("TsNewsMapper.selectTopicsNewsByPage", page);
	}

	
}
