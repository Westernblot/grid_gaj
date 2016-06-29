package core.controller.onduty;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsOnduty;
import core.util.PageData;

@Service
public class TsOndutyService extends BaseService<TsOnduty>{

	
	/**
	 * 判断当前月份值班表 是否已经添加
	 * @param pd
	 * @return
	 */
	public int checkfMonth(PageData pd) {
		// TODO Auto-generated method stub
		return (int) dao.findForObject("TsOndutyMapper.checkfMonth", pd);
	}

	/**
	 * 查找本月值班表
	 * @param pd
	 * @return
	 */
	public TsOnduty selectByfMonth(PageData pd) {
		// TODO Auto-generated method stub
		List<TsOnduty> ondutyList=(List<TsOnduty>) dao.findForList("TsOndutyMapper.selectByfMonth", pd);
		if(ondutyList.size()>0){
			return ondutyList.get(0);
		}
		return null;
	}

}
