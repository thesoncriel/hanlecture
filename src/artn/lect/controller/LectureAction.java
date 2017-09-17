package artn.lect.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import artn.common.controller.AbsSubDataActionController;

public class LectureAction extends AbsSubDataActionController{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5279226545302543575L;
	private InputStream is;
	private int iTotCnt = 0;
	@Override
	public String list() throws Exception {
		doList("group-single");
		if(getAuth().getIsSiteUser()){
			doShowSub("lectureList", "lecture-list");
		}			
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String edit() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String modify() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public String start() throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> mParams = new HashMap<String, Object>();
		Map<String, Object> mResult = new HashMap<String, Object>();
		List<Map<String,Object>> lmList;
		mParams = getParams();
		int iStudentCnt = 0;

		try{
			dbm().open();
//			mParams.put("professor", user().getId());
			mParams.put("professor", "33554432");
			mResult = dbm().selectOneNonOpen("lecture-attendance-single", mParams);			
			
			if(mResult != null){
				setResponse("2|이미 " + mParams.get("lect_name") + " 과목의 출석이 시작되었습니다.");
				dbm().close();				
				return TEXT_RESPONSE;
			}
			getParams().put("id_group", getParams().get("id_lect"));
			lmList = dbm().select("group-user-all", mParams);
			iStudentCnt = lmList.size();
			mParams.put("student_count", iStudentCnt);
			if(lmList.get(0).get("time_lect_start").equals("")){
				mParams.put("date_lect", lmList.get(0).get("time_prtc_start"));
			}
			else
			{
				mParams.put("date_lect", lmList.get(0).get("time_lect_start"));
			}
			mParams.put("lect_code", lmList.get(0).get("lect_code"));
			mParams.put("attend_count", 0);
			mParams.put("date_upload", util.getNow());
			dbm().updateNonCommit("lecture-attendance-prof", mParams);
			dbm().updateNonCommit("lecture-modify", mParams);
			dbm().commit();
			dbm().close();
			setResponse("1|"+ mParams.get("lect_name") + " 과목의 출석이 시작되었습니다");
		}catch(Exception ex){
			ex.printStackTrace();
			setResponse("0|오류입니다");
		}
		return TEXT_RESPONSE;
	}
	
	public String end() throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> mParams = new HashMap<String, Object>();
		Map<String, Object> mResult = new HashMap<String, Object>();
		List<Map<String,Object>> lmList;
		mParams = getParams();
		int iStudentCnt = 0;
		try{
			dbm().open();
//			mParams.put("professor", user().getId());
			mResult = dbm().selectOneNonOpen("lecture-attendance-single", mParams);
			if(mResult == null){
				setResponse("2|이미"+ mParams.get("lect_name") + "과목의 출석이 종료되었습니다.");
				dbm().close();				
				return TEXT_RESPONSE;
			}
			mResult = dbm().selectOneNonOpen("lecture-attendance-max", mParams);
			mParams.put("id", mResult.get("id").toString());
			mParams.put("id_sum_prof", mResult.get("id").toString());
			lmList = dbm().select("lecture-attendance-student", mParams);
			iStudentCnt = lmList.size(); //학생 출석 수
			mParams.put("attend_count", iStudentCnt);
			mParams.put("date_upload", util.getNow());
			dbm().updateNonCommit("lecture-attendance-prof-update", mParams);
			dbm().updateNonCommit("lecture-delete", mParams);
			dbm().commit();
			dbm().close();
			setResponse("1|"+ mParams.get("lect_name") +"과목의 출석이 종료되었습니다");
		}catch(Exception ex){
			ex.printStackTrace();
			setResponse("0|오류입니다");
		}
		
		return TEXT_RESPONSE;
	}
	
	
	public String confirm() throws Exception {
		Map<String,Object> mPwSuccess;
		Map<String, Object> mAttendance;
		try{
			valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
			dbm().open();
			mPwSuccess = dbm().selectOneNonOpen("lecture-attendance-single", getParams());
			if(mPwSuccess == null){
				dbm().close();
				setResponse("3|출석할 강의가 없습니다");
				return TEXT_RESPONSE;
			}
			
			int iIdSumProf = Integer.parseInt(dbm().selectOneNonOpen("lecture-attendance-max", getParams()).get("id").toString());
			getParams().put("id_sum_prof", iIdSumProf);
			
			//출석 중복 여부
			mAttendance = dbm().selectOneNonOpen("lecture-attendance-student", getParams());
			if(mAttendance == null){
				//패스워드 일치 여부
				if(mPwSuccess.get("lect_pw").equals(getParams().get("lect_pw"))){
					
					dbm().updateNonCommit("lecture-attendance", getParams());
					setResponse("1|출석 완료");
				}else{
					setResponse("2|패스워드가 일치하지 않습니다.");
				}
			}else{
				setResponse("4|이미 출석하였습니다.");
			}
			
			dbm().commit();
			dbm().close();

		}catch(Exception ex){
			ex.printStackTrace();			
			setResponse("0|오류입니다");
		}
		return TEXT_RESPONSE;
	}
	
	public String attendance() throws Exception {
		// TODO Auto-generated method stub
		
		getParams().put("id_group", getParams().get("id_lect"));
		getParams().put("professor", "33554432");
		dbm().open();
		try{
			iTotCnt = dbm().selectNonOpen("group-user-all", getParams()).size();
			doShowSub("attendanceprof", "lecture-attendance-all","attendancestudent","lecture-attendance-student");
		}catch(Exception ex){
			setResponse("0|오류");
			dbm().close();
			return "";
		}
		dbm().close();
		return SUCCESS;
	}
	
	public String attendanceExcel() throws Exception {
		// TODO Auto-generated method stub
		List<Map<String,Object>> lmList;
		List<Map<String,Object>> lmResult = new ArrayList<Map<String,Object>>();
		
		Calendar cal = Calendar.getInstance();
	    int iDate = cal.getActualMaximum(Calendar.DATE);
	  
		try{
			doList("lecture-attendance-all");
			lmResult.add(util.createMap());
			lmList=getListData();
			lmResult.get(0).put("id_student", "");
			lmResult.get(0).put("student_name", "");
			for(int i=0; i < lmList.size(); i++){
				lmResult.get(0).put(lmList.get(i).get("sdate").toString()+"/"+i, "");
			
			}
			String[] aa = new String[]{"id_student","studetn_name"};

			is = makeExcel(lmResult);
		}catch(Exception ex){
			ex.printStackTrace();
			setResponse("0|오류");
			return "";
		}
		
		return SUCCESS;
	}
	
	public String anyAttend(){
		getParams().put("professor", "33554432");
		doList("group-user-all");
		getParams().put("id", getParams().get("id_group"));
		getParams().put("id_lect", getParams().get("id_group"));
		getParams().put("id_prof", user().getId());
		doShowSub("groupSingle","group-single","maxLecture","lecture-attendance-max");
		return SUCCESS;
	}
	
	public String anyAttendConfirm(){
		Map<String, Object> mAttendance;
		Map<String, Object> mParams = getParams();
		getParams().put("id_prof", user().getId());
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
		
		int iStudentCnt = 0;
		try{
			dbm().open();
			if(getArrayParams().containsKey("id_student")){
				for(int i = 0; i < getArrayParams().get("id_student").length; i++){
					mParams.put("id_student", getArrayParams().get("id_student")[i]);
					mParams.put("student_name", getArrayParams().get("student_name")[i]);
					mParams.put("student_dept", getArrayParams().get("student_dept")[i]);
					mAttendance = dbm().selectOneNonOpen("lecture-attendance-student", mParams);
					if(mAttendance == null){
						dbm().updateNonCommit("lecture-attendance", mParams);
						iStudentCnt++;
					}
				}
			}else{
				mAttendance = dbm().selectOneNonOpen("lecture-attendance-student", mParams);
				if(mAttendance == null){
					dbm().updateNonCommit("lecture-attendance", getParams());
					iStudentCnt++;
				}
			}
			//출석이 끝났는지 확인
			int iAttendAble = dbm().selectNonOpen("lecture-attendance-single", getParams()).size();
			if(iAttendAble == 0){
				getParams().put("id", getParams().get("id_sum_prof"));
				getParams().put("attend_count", iStudentCnt);
				getParams().put("date_upload", getUtil().getNow());
				dbm().updateNonCommit("lecture-attendance-prof-update", getParams());
			}
			dbm().commit();
			dbm().close();

		}catch(Exception ex){
			ex.printStackTrace();			
			setResponse("0|오류입니다");
		}
		return SUCCESS;
	}
	
	public InputStream getInputStream(){
		return is;
	}
	
	public int getTotCnt(){
		return iTotCnt;
	}
	
}
