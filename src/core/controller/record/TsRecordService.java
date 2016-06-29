package core.controller.record;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsRecord;

@Service
public class TsRecordService extends BaseService<TsRecord>{

	
	/**
	 * 查询出 需要重复提醒的数据
	 * @return
	 */
	public List<TsRecord> selectRemindData() {
		// TODO Auto-generated method stub
		return (List<TsRecord>) dao.findForList("TsRecordMapper.selectRemindData", null);
	}

}
