package core.controller.info;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsInfo;

@Service
public class TsInfoService extends BaseService<TsInfo>{

	/**
	 * 查找by name
	 * @param fName
	 * @return
	 */
	public TsInfo findInfoByName(String fName) {
		// TODO Auto-generated method stub
		return (TsInfo) dao.findForObject("TsInfoMapper.findInfoByName", fName);
	}

	/**
	 * 查找 by name
	 * @param string
	 * @return
	 */
	public String findStringInfoByName(String fName) {
		// TODO Auto-generated method stub
		return (String) dao.findForObject("TsInfoMapper.findStringInfoByName", fName);
	}

}
