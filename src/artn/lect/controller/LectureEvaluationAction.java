package artn.lect.controller;

import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import artn.common.Util;
import artn.common.controller.AbsSubDataActionController;
import artn.common.model.Environment;
import artn.common.model.User;

public class LectureEvaluationAction extends AbsSubDataActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 323575178394985623L;
	private InputStream inputStream;
	private String fileName;

	@Override
	public String list() throws Exception {
		getParams().put("id_user", user().getId());
		doList("lecture-evaluation");
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		getParams().put("auth_group","33554432");
		doList("group-user-all");
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		
		getParams().put("work_type","lectSurv");
		doList("lecture-evaluation-propaser");
		
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		getParams().put("id_user",user().getId());
		getParams().put("user_name",user().getName());
		getParams().put("id_student", user().getId());
		getParams().put("id_lect",getParams().get("id_group"));
		int iAttendance = 0;
		dbm().open();
		iAttendance = dbm().selectNonOpen("lecture-attendance-student", getParams()).size();
		if(iAttendance == 0){
			getParams().put("attd_yes", 0);
		}else{
			getParams().put("attd_yes", 1);
		}
		dbm().close();
		boolean survey = false;
		if(getArrayParams().containsKey("seq")){
			String[] answer_int = new String[getArrayParams().get("seq").length];
				for(int i = 0 ; i < getArrayParams().get("seq").length ;i ++ ){
					answer_int[i] = getParams().get("answer_int"+(i+1)).toString();
				}
				getArrayParams().put("answer_int",answer_int);
			doEditSub("survey-answer-modify","","seq");
		}else{
			getParams().put("answer_int", getParams().get("answer_int1"));
			doEdit("survey-answer-modify");
		}
		
		/**/
		
		return SUCCESS;
		
	}

	@Override
	public String delete() throws Exception {
		
		return null;
	}
	
	public String answer_list() throws Exception {
		doList("lecture-evaluation");
		
		return SUCCESS;
	}
	
	public String answer_show() throws Exception {
		getParams().putAll(putLectEvalFields(
				"question_cont",
				"a", "b", "c", "d", "e",
				"noanswer",
				"rating_avg"
		));
		
		dbm().open();
		doList("lecture-evaluation-list");
		doShowSub("commentList","lecture-attendance-answer_text");
		dbm().close();
		
		return SUCCESS;
	}

	public String surveyMenu() throws Exception{
		return SUCCESS;
	}
	
	public String excel() throws Exception{
		String[] saKorKeys = new String[]{
				"평가 문항", 
				"매우 그렇다",
				"대체로 그렇다",
				"보통이다",
				"그렇지 않다",
				"전혀 그렇지 않다",
				"무응답",
				"평점 (5점만점)"
		};
		
		getParams().putAll(putLectEvalFields( saKorKeys ));
		dbm().open();
		doList("lecture-evaluation-list");
		appendTextAnswer("평가 문항", getListData());
		dbm().close();
		
		inputStream = makeExcel(getListData(), saKorKeys);
		fileName = getParams().get("id_sum_prof") + "_" + getParams().get("id_lect") + "_" + util.getIdByNowDateTime() + ".xls";
		
		return SUCCESS;
	}
	
	protected void appendTextAnswer(String saveKeyPos, List<Map<String, Object>> list){
		appendTextAnswer(saveKeyPos, "lecture-attendance-answer_text", list);
	}
	
	protected void appendTextAnswer(String saveKeyPos, String queryKey, List<Map<String, Object>> list){
		List<Map<String, Object>> listAnswer = dbm().selectNonOpen(queryKey, getParams());
		Map<String, Object> map = util.createMap();
		
		map.put(saveKeyPos, "::기타 답변::");
		list.add(map);
		
		if (listAnswer.size() > 0){
			for(Map<String, Object> mapAnswer : listAnswer){
				map = util.createMap();
				map.put(saveKeyPos, mapAnswer.get("quest_answer").toString());
				list.add(map);
			}
		}
		else{
			map.put(saveKeyPos, "답변이 존재하지 않음.");
			list.add(map);
		}
		
		
	}
	
	/*select 문의 필드명 템플릿인 `${a}`에 값을 넣기 위한 메서드.
	 * 이 메서드를 사용하는 액션 메서드 내 query는 모두 `${a}` 와 같은 필드명 템플릿이 존재 한다.
	 * Show View 와 Excel Export 에서 데이터는 같으나 사용하는 필드명만 다른 경우를 위해 사용 한다.
	*/
	protected Map<String, Object> putLectEvalFields(String... value){
		Map<String, Object> mFieldName = util.createMap();
		
		String[] saKeys = new String[]{
			"question_cont",
			"a", "b", "c", "d", "e",
			"noanswer",
			"rating_avg"
		};
		
		for(int i = 0; i < saKeys.length; i++){
			mFieldName.put( saKeys[i], value[i] );
		}
		
		return mFieldName;
	}
	
	protected String getProfAndLectName(Map<String, Object> mParam){
		if (mParam.containsKey("id_group") == false){
			mParam.put("id_group", mParam.get("id_lect").toString());
		}
		if (mParam.containsKey("id_user") == false){
			mParam.put("id_user", mParam.get("id_prof").toString());
		} 
		
		try{
			List<Map<String, Object>> lmResult = dbm().selectNonOpen("group-user-all", mParam);
			
			return lmResult.get(0).get("group_name") + "_" + lmResult.get(0).get("user_name");
		}
		catch(Exception ex){
			ex.printStackTrace();
			
			return mParam.get("id_group") + "_" + mParam.get("id_user");
		}
	}

	public InputStream getInputStream(){
		return inputStream;
	}
	
	public String getFileName(){
		return fileName;
	}
	
	protected String encFileName(String value) throws Exception{
		String sBrowser = Environment.getInstanceBySession(getSession()).getBrowserName();
		
		if (sBrowser.indexOf("IE") >= 0){
			return URLEncoder.encode(value, "UTF-8");
		}
		else{
			return new String(value.getBytes("UTF-8"), "ISO-8859-1");
		}
	}
	
	// 교수 평가 집계 현황 출력 기능추가 - 2014.03.07 by jhson [시작]
	public String profResultShow() throws Exception{
		getParams().putAll(putLectEvalFields(
				"question_cont",
				"a", "b", "c", "d", "e",
				"noanswer",
				"rating_avg"
		));
		
		dbm().open();
		doList("prof-evaluation-list");
		doShowSub("commentList","prof-evaluation-list-text");
		dbm().close();
		
		return SUCCESS;
	}
	
	public String profResultExcel() throws Exception{
		String[] saKorKeys = new String[]{
				"평가 문항", 
				"매우 그렇다",
				"대체로 그렇다",
				"보통이다",
				"그렇지 않다",
				"전혀 그렇지 않다",
				"무응답",
				"평점 (5점만점)"
		};
		
		getParams().putAll(putLectEvalFields( saKorKeys ));
		dbm().open();
		doList("prof-evaluation-list");
		appendTextAnswer("평가 문항", "prof-evaluation-list-text", getListData());
		fileName = encFileName( getProfAndLectName(getParams()) + "_" + util.getIdByNowDateTime() + ".xls" );
		dbm().close();
		
		inputStream = makeExcel(getListData(), saKorKeys);
		
		return SUCCESS;
	}
	// 교수 평가 집계 현황 출력 기능추가 - 2014.03.07 by jhson [종료]
}
