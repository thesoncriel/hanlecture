package artn.common.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class SurveyAction extends AbsSubDataActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5557192118546936311L;

	@Override
	public String list() throws Exception {
		getParams().put("id_writer", user().getId());
		doList("survey-all");
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		doList("survey-single");
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
//		doList("survey-single");
		show();
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		valid.checkEmptyValue(getParams(), 60, "setTime");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();			
		
		cal.add(cal.MINUTE, Integer.parseInt(getParams().get("setTime").toString()));
		
		valid.checkEmptyValue(getParams(), 0, "id_group","question_count");
		valid.checkEmptyValue(getParams(), 1, "opt");
		valid.checkEmptyValue(getParams(), "loginSurv", "work_type");
		valid.checkEmptyValue(getParams(), user().getId(), "id_writer");
		valid.checkEmptyValue(getParams(), user().getName(), "writer_name");
		valid.checkEmptyValue(getParams(), "지식평가", "subject");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_start");
		valid.checkEmptyValue(getParams(), dateFormat.format(cal.getTime()), "date_end");		
		
		if(getArrayParams().containsKey("question_cont")){
			getParams().put("question_count", getArrayParams().get("question_cont").length); 
		} else {
			getParams().put("question_count", 1);
		}
		dbm().open();
		dbm().updateNonCommit("survey-modify", getParams());
//		doEdit("survey-modify");
		if(getParams().containsKey("id") == false){
			int iId = 0;
			iId = Integer.parseInt(dbm().selectOneNonOpen("survey-max-id", getParams()).get("id").toString());
//			doShow("survey-max-id");
//			getParams().put("id_survey", getShowData().get("id").toString());
			getParams().put("id_survey", iId);
		}else{
			getParams().put("id_survey", getParams().get("id"));
			getParams().remove("id");
		}
//		doEdit("survey-question-delete");
		dbm().updateNonCommit("survey-question-delete", getParams());
//		doEdit("survey-answer-delete");
		dbm().updateNonCommit("survey-answer-delete", getParams());
		doEditSub("survey-question-modify","","seq", false);
		dbm().commit();
		dbm().close();
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
//		doEdit("survey-delete");
		dbm().open();
		dbm().updateNonCommit("survey-delete", getParams());
		getParams().put("id_survey", getParams().get("id"));
		dbm().updateNonCommit("survey-question-delete", getParams());
		dbm().updateNonCommit("survey-answer-delete", getParams());
		dbm().commit();
		dbm().close();
		return SUCCESS;
	}
	
	public String answer_open() throws Exception {
		doList("survey-single");
		return SUCCESS;
	}
	
	public String answer_complete() throws Exception {
		
		boolean survey = false;
		if(getArrayParams().containsKey("seq")){
			String[] answer_int = new String[getArrayParams().get("seq").length];
			for(int i = 0 ; i < getArrayParams().get("seq").length ;i ++ ){
				answer_int[i] = getParams().get("answer_int"+(i+1)).toString();
				if( getArrayParams().get("question_type")[i].equals("0") && answer_int[i].equals("1")){
					survey = true;
				}
			}
			getArrayParams().put("answer_int",answer_int);
			doEditSub("survey-answer-modify","","seq");
			
		}else{
			
			if(getParams().get("question_type").equals("0") && getParams().get("answer_int1").equals("1")){
				survey = true;
			}
			getParams().put("answer_int", getParams().get("answer_int1"));
			doEdit("survey-answer-modify");
		}
		
		/**/
		if(survey){
			return "login_survey";
		}
		return SUCCESS;
	}

	public String surveyMenu() throws Exception{
		return SUCCESS;
	}

}
