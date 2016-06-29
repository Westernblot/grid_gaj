package core.controller.system.menu;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.system.SysMenu;
import core.util.PageData;

@Service
public class SysMenuService extends BaseService<SysMenu> {
	
	
	/**
	 * 根据权限查找列表
	 */
	public List<SysMenu> selectPrivilage(PageData pd){
		List<SysMenu> menus=null;
		menus = (List<SysMenu>) dao.findForList("SysMenuMapper.selectPrivilage", pd);
		return menus;
		
	}

}
