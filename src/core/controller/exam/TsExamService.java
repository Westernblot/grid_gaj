package core.controller.exam;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsExam;
import core.util.PageData;

@Service
public class TsExamService extends BaseService<TsExam>{

	
	/**
	 * 数据导出查询
	 * @param pd
	 * @return
	 */
	public List<PageData> selectByPageData(PageData pd) {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("TsExamMapper.selectByPageData", pd);
	}

}
