package artn.lect.controller;

import java.io.InputStream;
import java.util.Map;

import artn.common.Util;
import artn.common.controller.AbsSubDataActionController;
import artn.common.model.User;

public class PreviewAction extends AbsSubDataActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 323575178394985623L;
	private InputStream inputStream;
	private String fileName;

	@Override
	public String list() throws Exception {
		getParams().put("work_type", "preview");
		getParams().put("now", true);
		if(getAuth().getIsSiteUser() == true){
			getParams().put("id_student", true);
			getParams().put("id_user", user().getId());
		}
		doList("survey-all");
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		doList("lecture-preview-list");
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		getParams().put("work_type", "preview");
		doList("survey-single");
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
		// TODO Auto-generated method stub
		return null;
	}
	
	public String excel() throws Exception{
		String[] saKorKeys = new String[]{
				"정답", 
				"답변한 학생 수",
				"강의 등록 학생 수",
				"가",
				"(가)답변학생ID",
				"나",
				"(나)답변학생ID",
				"다",
				"(다)답변학생ID",
				"라",
				"(라)답변학생ID",
				"마",
				"(마)답변학생ID",
				"무응답"
		};
		
		getParams().putAll(putLectEvalFields( saKorKeys ));
		doList("lecture-preview-excel");
		
		inputStream = makeExcel(getListData(), saKorKeys);
		fileName = getParams().get("date_upload") + "_" + getParams().get("id_survey") + "_" + ".xls";
		
		return SUCCESS;
	}
	
	protected Map<String, Object> putLectEvalFields(String... value){
		Map<String, Object> mFieldName = util.createMap();
		
		String[] saKeys = new String[]{
			"question_cont",
			"answer_total",
			"attend_cound",
			"a","name1", "b","name2", "c","name3", "d","name4", "e","name5",
			"noanswer"
		};
		
		for(int i = 0; i < saKeys.length; i++){
			mFieldName.put( saKeys[i], value[i] );
		}
		
		return mFieldName;
	}
	
	public InputStream getInputStream(){
		return inputStream;
	}
	
	public String getFileName(){
		return fileName;
	}

}
