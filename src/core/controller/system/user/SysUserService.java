package core.controller.system.user;

import java.util.List;

import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.system.SysUser;
import core.util.PageData;

@Service
public class SysUserService extends BaseService<SysUser>{
	
	/**
	 * 测试事物注解
	 */
	public void relateInsert(){
		SysUser u1=new SysUser();
		u1.setfUname("王武1");
		dao.save("SysUserMapper.insert", u1);
		int i=1/0;
		SysUser u2=new SysUser();
		u2.setfUname("王武2");
		dao.save("SysUserMapper.insert", u2);
	}

	/**
	 * 关联新增用户,建用户时动态建表
	 * @param user
	 * @return
	 */
	public int relateInsert(SysUser user) {
		
		int flag=0;
		flag+=(int) dao.save("SysUserMapper.insert", user);
		
		PageData pd=new PageData();
		pd.put("tableName", "personmail_"+user.getfId());
		flag+=(int)dao.update("TsMailMapper.dropTsMail", pd);//删除用户邮箱，若存在
		flag+=(int)dao.update("TsMailMapper.createTsMail", pd);//新建邮箱
		return flag;
	}

	/**
	 * 删除用户是，关联删除表
	 * @param pd
	 * @return
	 */
	public int relateDelete(PageData pd) {
		// TODO Auto-generated method stub
		int flag=0;
		flag+=(int)dao.delete("SysUserMapper.deleteByIds", pd);
		
		String fIds=pd.getString("fIds");
		String[] fId=fIds.split(",");
		for(int i=0;i<fId.length;i++){
			PageData mPd=new PageData();
			mPd.put("tableName", "personmail_"+fId[i]);
			flag+=(int)dao.update("TsMailMapper.dropTsMail", mPd);//删除用户邮箱，若存在
		}
		return flag;
	}

	/**
	 * 查询用的的信息by ids
	 * @param pd
	 * @return
	 */
	public List<SysUser> findUserByIds(PageData pd) {
		// TODO Auto-generated method stub
		return (List<SysUser>) dao.findForList("SysUserMapper.findUserByIds", pd);
	}

	/**
	 * 取phone by name
	 * @param fLeader
	 * @return
	 */
	public String findPhoneByName(String fCname) {
		// TODO Auto-generated method stub
		Object obj=dao.findForObject("SysUserMapper.findUserPhone", fCname);
		
		System.out.println(obj);
		
		if(obj==null){
			return "";
		}
		return (String) obj;
	}

	/**
	 * 批量重置密码
	 * @param pd
	 * @return
	 */
	public int resetPassword(PageData pd) {
		// TODO Auto-generated method stub
		return (int) dao.update("SysUserMapper.resetPassword", pd);
	}

}
