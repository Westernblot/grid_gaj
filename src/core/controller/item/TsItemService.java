package core.controller.item;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsItem;

@Service
public class TsItemService extends BaseService<TsItem>{

	/**
	 * 查找考核条目 by fYear
	 * @param fYear
	 * @return
	 */
	public List<TsItem> selectByfYear(String fYear) {
		// TODO Auto-generated method stub
		return  (List<TsItem>) dao.findForList("TsItemMapper.selectByfYear", fYear);
	}

}
