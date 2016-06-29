package core.controller.system.dept;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.system.SysDept;
import core.util.PageData;

@Service
public class SysDeptService extends BaseService<SysDept>{

	/**
	 * 查找 树数据
	 * @return
	 */
	public List<PageData> selectTreeData() {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("SysDeptMapper.selectTreeData", null);
	}

	/**
	 * 部门关联删除
	 * @param pd
	 * @return
	 */
	public int relateDelte(PageData pd) {
		// TODO Auto-generated method stub
		int flag=0;
		flag+=(int)dao.delete("SysDeptMapper.deleteByIds", pd);
		flag+=(int)dao.delete("SysDeptMapper.deleteSubByIds", pd);
		
//		//关联删除 部门邮箱
//		String fIds=pd.getString("fIds");
//		String[] fId=fIds.split(",");
//		for(int i=0;i<fId.length;i++){
//			PageData mPd=new PageData();
//			mPd.put("tableName", "deptmail_"+fId[i]);
//			flag+=(int)dao.update("TsDeptMailMapper.dropTsDeptMail", mPd);//删除部门邮箱，若存在
//		}
		
		return flag;
	}

	/**
	 * 关联查找对象
	 * @param pd
	 * @return
	 */
	public PageData relateSelectById(PageData pd) {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("SysDeptMapper.relateSelectById",pd);
	}

	/**
	 * 新增部门 关联，创建部门时，也创建部门邮箱
	 * @param dept
	 * @return
	 */
	public int relateInsert(SysDept dept) {
		// TODO Auto-generated method stub
		int flag=0;
		flag+=(int) dao.save("SysDeptMapper.insert", dept);
		
//		PageData pd=new PageData();
//		pd.put("tableName", "deptmail_"+dept.getfId());
//		flag+=(int)dao.update("TsDeptMailMapper.dropTsDeptMail", pd);//删除部门邮箱，若存在
//		flag+=(int)dao.update("TsDeptMailMapper.createTsDeptMail", pd);//新建部门邮箱
		
		return flag;
	}

	/**
	 * 根据 部门名称 查找部门list
	 * @param pd
	 * @return
	 */
	public List<SysDept> selectByDeptName(PageData pd) {
		// TODO Auto-generated method stub
		return (List<SysDept>) dao.findForList("SysDeptMapper.selectByDeptName", pd);
	}

	/**
	 * 查询出 需要考核的部门
	 * @return
	 */
	public List<SysDept> selectExamDept() {
		// TODO Auto-generated method stub
		return (List<SysDept>) dao.findForList("SysDeptMapper.selectExamDept", null);
	}

	/**
	 * 查询出 父对象的层级
	 * @param getfPid
	 * @return
	 */
	public Integer findParentLevel(Integer fPid) {
		// TODO Auto-generated method stub
		return (Integer) dao.findForObject("SysDeptMapper.findParentLevel", fPid);
	}

	/**
	 * 查询出需要签收 通知 通报的部门
	 * @return
	 */
	public List<SysDept> selectMsgRecDept() {
		// TODO Auto-generated method stub
		return (List<SysDept>) dao.findForList("SysDeptMapper.selectMsgRecDept", null);
	}

	/**
	 * 查询出 需要提交任务上报的部门
	 * @return
	 */
	public List<SysDept> selectTaskDept() {
		// TODO Auto-generated method stub
		return (List<SysDept>) dao.findForList("SysDeptMapper.selectTaskDept", null);
	}

	/**
	 * 查询部门责任人
	 * @param fDept
	 * @return
	 */
	public String findDutyPersonByDept(String fDept) {
		// TODO Auto-generated method stub
		return (String) dao.findForObject("SysDeptMapper.findDutyPersonByDept", fDept);
	}

}
