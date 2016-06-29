package core.controller.pic;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsPic;

@Service
public class TsPicService extends BaseService<TsPic>{

	/**
	 * 查询前3条显示图片在页面上，按f_sort 由高到低的顺序
	 * @param fType 
	 * @return
	 */
	public String findPicFiles(String fType) {
		// TODO Auto-generated method stub
		
		String files="";
		
		List<TsPic> picList=(List<TsPic>) dao.findForList("TsPicMapper.findPicFiles", fType);
		
		for(TsPic pic:picList){
			
			if(files.equals("")){
				files=pic.getfImgUrl();
			}else{
				files+="|"+pic.getfImgUrl();
			}
		}
		
		return files;
	}

	/**
	 * 查询一条图片显示
	 * @param string
	 * @return
	 */
	public String findPicOne(String fType) {
		// TODO Auto-generated method stub
		return (String) dao.findForObject("TsPicMapper.findPicOne", fType);
	}

}
