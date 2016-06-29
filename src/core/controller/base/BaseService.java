package core.controller.base;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import core.dao.DaoSupport;
import core.util.GenericsUtils;
import core.util.Page;
import core.util.PageData;

@Transactional
public class BaseService<T> {

	@Resource(name = "daoSupport")
	public DaoSupport dao;

	private T model;

	@SuppressWarnings("unchecked")
	public BaseService() {
		try {
			Class<T> clz = GenericsUtils.getSuperClassGenricType(this.getClass());
			// System.out.println(clz.getSimpleName());
			model = clz.newInstance();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	/**
	 * 获取 mapperName
	 * 
	 * @param model
	 * @return
	 */
	public String getMapperName(T model) {
		String name = model.getClass().getSimpleName();
		String mapperName = name + "Mapper";
		return mapperName;
	}

	// ==============================以下service方法开始===================================

	/**
	 * 增
	 * 
	 * @param model
	 * @return
	 */
	public int insert(T entity) {
		String str = getMapperName(model) + ".insert";
		int flag = 0;
		try {
			flag = (int) dao.save(str, entity);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return flag;
	}

	/**
	 * 删除 by ids
	 * 
	 * @param fIds
	 * @return
	 */
	public int deleteByIds(PageData pd) {
		String str = getMapperName(model) + ".deleteByIds";
		int flag = 0;
		try {
			flag = (int) dao.delete(str, pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return flag;
	}

	/**
	 * 修改
	 * 
	 * @param entity
	 * @return
	 */
	public int update(T entity) {
		String str = getMapperName(model) + ".update";
		int flag = 0;
		try {
			flag = (int) dao.update(str, entity);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return flag;
	}

	/**
	 * 查找By id
	 */
	@SuppressWarnings("unchecked")
	public T selectById(Integer fId) {
		String str = getMapperName(model) + ".selectById";
		T entity = null;
		try {
			entity = (T) dao.findForObject(str, fId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return entity;

	}

	/**
	 * 列表查询 by model
	 * 
	 * @param entity
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByModel(T entity) {
		String str = getMapperName(model) + ".selectByModel";
		List mLlist = null;
		try {
			mLlist = (List) dao.findForList(str, entity);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return mLlist;
	}
	
	/**
	 * 列表查询 by PageData
	 * 
	 * @param entity
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByPageData(PageData pd) {
		String str = getMapperName(model) + ".selectByPageData";
		List pDList = null;
		try {
			pDList = (List) dao.findForList(str, pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return pDList;
	}

	/**
	 * 分页列表查询  by page
	 * 
	 * @param entity
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByPage(Page page) {
		String str = getMapperName(model) + ".selectByPage";
		List pLlist = null;
		try {
			pLlist = (List) dao.findForList(str, page);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return pLlist;
	}
}
