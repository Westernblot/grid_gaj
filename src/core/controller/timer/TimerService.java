package core.controller.timer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import core.dao.DaoSupport;

@Service
public class TimerService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	
	/**
	 * 每天清除临时附件表，只保留1000条最新数据
	 */
	public void deleteAttachment() {
		
		//查询出目前表中的记录数
		int record=(int) dao.findForObject("AttachmentMapper.findCountNum", null);
		
		if(record>1000){
			int num=record-1000;
			dao.delete("AttachmentMapper.deleteRetailNum", num);
		}
		
	}

	
	
}
