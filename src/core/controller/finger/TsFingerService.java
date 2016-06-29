package core.controller.finger;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.springframework.stereotype.Service;

import core.controller.base.BaseService;
import core.entity.TsFinger;
import core.util.PageData;

@Service
public class TsFingerService extends BaseService<TsFinger> {

	/**
	 * 查找导出的数据
	 * 
	 * @param pd
	 * @return
	 */
	public List<PageData> selectExcelData(TsFinger finger) {
		// TODO Auto-generated method stub

		List<PageData> pdList = new ArrayList<PageData>();

		
		String fCode=finger.getfCode();//警号
		String fDate=finger.getfTime();//日期，格式为2015-03
		
		String fName=(String) dao.findForObject("SysUserMapper.findUserByfCode", fCode);//根据警号获取人员姓名
		
		int i;
		String day;
		List<TsFinger> finList;
		for(i=1;i<=31;i++){
			if(i<10){
				day="-0"+i;
			}else{
				day="-"+i;
			}
			String fNewTime=fDate+day;    //拼接出每月的 1-31号日期
			
			finger.setfTime(fNewTime);
			finList=(List<TsFinger>) dao.findForList("TsFingerMapper.selectExcelMonthExport",finger);
			
			PageData pd=new PageData();
			pd.put("F_DATE", fNewTime);   //日期
			pd.put("F_CODE", fCode);      //警号
			pd.put("F_NAME", fName);      //姓名
			
			for(int j=0;j<finList.size();j++){
				pd.put("F_D"+j, finList.get(j).getfTime().substring(10, finList.get(j).getfTime().length()));//赋值当天打卡时间
			}
			
			pdList.add(pd);
			
		}
		

		// ====================================打印显示=============================================
		
//		System.out.println("Length="+pdList.size());
//		
//		for (int m = 0; m < pdList.size(); m++) {
//
//			System.out.println(pdList.get(m).getString("F_DATE"));
//			System.out.println(pdList.get(m).getString("F_CODE"));
//			System.out.println(pdList.get(m).getString("F_NAME"));
//			System.out.println(pdList.get(m).getString("F_D0"));
//			System.out.println(pdList.get(m).getString("F_D1"));
//			System.out.println(pdList.get(m).getString("F_D2"));
//			System.out.println(pdList.get(m).getString("F_D3"));
//			System.out.println(pdList.get(m).getString("F_D4"));
//			System.out.println(pdList.get(m).getString("F_D5"));
//			System.out.println(pdList.get(m).getString("F_D6"));
//			System.out.println(pdList.get(m).getString("F_D7"));
//			System.out.println(pdList.get(m).getString("F_D8"));
//
//			System.out
//					.println("=================================================================");
//		}

		return pdList;
	}

	/**
	 * 根据月份查询出所有员工的考勤
	 * @param fTime
	 * @return
	 */
	public List<PageData> selectFingerByMonth(String fTime,Integer days) {//fTime的格式为 2015-03
		// TODO Auto-generated method stub
		
		List<PageData> pdList = new ArrayList<PageData>();
		
		//=========================查询出该月份打卡的所有民警===============================
		String fYear=fTime.substring(0, 4);
		String fMonth=fTime.substring(5, 7);
		PageData pdMonth=new PageData();
		pdMonth.put("fYear", fYear);
		pdMonth.put("fMonth", fMonth);
		
		List<PageData> code2nameList=(List<PageData>) dao.findForList("TsFingerMapper.selectDistinctCodeByMonth", pdMonth);
		
		
		for(int i=0;i<code2nameList.size();i++){			
			String code=code2nameList.get(i).getString("F_CODE");  //警号
			String name=code2nameList.get(i).getString("F_CNAME"); //姓名
			
			PageData pd=new PageData();
			pd.put("F_CODE", code);
			pd.put("F_NAME", name);
			
			//查询出考勤打卡时间
			List<TsFinger> finList;
			String day;
			for(int j=1;j<=days;j++){
				if(j<10){
					day="-0"+j;
				}else{
					day="-"+j;
				}
				String fNewTime=fTime+day;    //拼接出每月的 1-days号日期
				
				TsFinger finger=new TsFinger();
				finger.setfCode(code);
				finger.setfTime(fNewTime);
				finList=(List<TsFinger>) dao.findForList("TsFingerMapper.selectExcelMonthExport",finger);
				
				String dayTime="";
				for(TsFinger fg:finList){
					dayTime +=fg.getfTime().substring(10, fg.getfTime().length())+";";				
				}
				pd.put("F_D"+j, dayTime);   //循环出1 到31 天的打卡时间记录
			}
			
			pdList.add(pd);
		}
		
 //====================================打印显示=============================================
		
//		System.out.println("Length="+pdList.size());
//		
//		for (int m = 0; m < pdList.size(); m++) {
//
//			System.out.println(pdList.get(m).getString("F_CODE"));
//			System.out.println(pdList.get(m).getString("F_NAME"));
//			
//			for(int k=0;k<days;k++){		
//				System.out.println(pdList.get(m).getString("F_D"+k));
//			}
//			
//
//			System.out
//					.println("=================================================================");
//		}
		
		return pdList;
	}

}
