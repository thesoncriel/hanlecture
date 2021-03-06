package artn.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Random;

import artn.common.FileNameChangeMode;
import artn.common.Util;
import artn.common.manager.LoginManager;
import artn.common.model.User;
import artn.common.model.Visitor;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class UserAction extends AbsUploadActionController {
	/**
	 * 
	 */
	private static final long serialVersionUID = -886343068109405829L;
	private int userEdit = -1;
	private boolean newUser = false;
	private LoginManager loginManager;
	
	@Override
	public String list() throws Exception{
		if (getParams().containsKey("user_name") == true){
			getParams().put("name", getParams().get("user_name"));
		}
		doList("user-all");
		return this.successOrJsonList("id","name","email","date_birth","gender_kor","age","phone_mobi","phone_home","zipcode_home","address_home1","address_home2");
	}
	
	@Override
	public String show() throws Exception {
//		if(getParams().containsKey("phone_mobi") == true){
//			valid.toPhone(getParams(), getArrayParams(), "phone_mobi");
//		}
		doShow("user-single");			
		if(getParams().containsKey("json") == false){
			session().put("password", getShowData().get("pw"));
			
			if (getAuth().getIsAdmin() == false){
				getShowData().remove("pw");
			}	
		}
		userEdit = user().getRestrictUserEdit();
		return this.successOrJsonShow();
	}
	
	@Override
	public String edit() throws Exception {
		try{
			String sId = getParams().get("id").toString();
			
			dbm().open();
			
			getParams().put("id", user().getId());
			
			doShow("user-single", false);
			
			if (getShowData().get("pw").equals(getParams().get("pw")) == false){
				this.addActionError("패스워드가 틀렸습니다.");
				dbm().close();
				return "password";
			}
			
			getParams().put("id", sId);
			doShow("user-single", false);
			getParams().put("id_group", 0);
			doShowSub("auth_list", "user-auth-all", false);
			valid.replaceBRTagsToCRLF(getShowData(), "introduce");
			userEdit = user().getRestrictUserEdit();
			
			dbm().close();
			return SUCCESS;
		}
		catch(NullPointerException ex){
			System.out.println(ex.getMessage());
		}
		
		return LOGIN;
	}

	@Override
	public String modify() throws Exception {
		Map<String, Object> mParam = getParams();
		Map<String, String[]> msaParam = getArrayParams();
		//valid.toPhone(mParam, msaParam, "phone_mobi");
		Map<String, Object> mUser = dbm().selectOne("user-single", mParam);
		boolean isNew = (mUser == null);
		if (isNew == false){
			if ((getAuth().getIsAdmin() == false)){
				if (user().getId().equals(mParam.get("id")) == false) return ERROR_AUTH;
			}
			if(mParam.get("pw").equals("") || mParam.get("pw").toString() == null){
				mParam.put("pw", mUser.get("pw").toString());
			}
		}
		valid.checkEmptyValue(mParam, "", "zipcode_home", "address_home_new", "address_home1", "address_home2", "nick", "introduce");
		valid.checkEmptyValue(mParam, 4, "auth_user_id");
		valid.checkEmptyValue(mParam, 2, "login_limit","status_user");
		valid.checkEmptyValue(mParam, "m", "gender");
		valid.checkEmptyValue(mParam, util.getNow(), "date_join");
		valid.checkEmptyValue(mParam, "1992-01-01", "date_birth");
		valid.replaceCRLFToBRTags(mParam, "introduce");
		valid.mergeIntValuesToMap(mParam, msaParam, "opt");
		valid.mergeIntValuesToMap(mParam, msaParam, "status_user");
		valid.toPhone(mParam, msaParam, "phone_mobi");
		valid.toPhone(mParam, msaParam, "phone_home");
		valid.toEmail(mParam, msaParam, "email");
		
		if (mParam.get("introduce").toString().length() > 255){
			getError().put("introduce", "자기 소개 내용이 너무 많습니다. 간단히 적어 주세요.");
			valid.replaceBRTagsToCRLF(mParam, "introduce");
			getShowData().putAll(mParam);
			mParam.put("id_group", 0);
			doShowSub("auth_list", "user-auth-all");
			userEdit = user().getRestrictUserEdit();
			return ERROR;
		}

		if (hasFileParams() == true){
			try {
				saveFileToAuto(getDownloadPath() + "/upload/user/", FileNameChangeMode.nowdatetime);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else{
			valid.checkFileExists(mParam, "file_img");
		}
		doEdit("user-modify");
		if( (mParam.containsKey("comboGroup") == true) && (prop.getBoolean("artn.user.join.autoGroupJoin") == true) ){
			session().put("newUserId", mParam.get("id"));
			session().put("newUserName", mParam.get("name"));
			return "groupList";
		}
		return SUCCESS;
	}
	
	@Override
	public String write() throws Exception {
		getShowData().put("gender", 'm');
		getShowData().put("date_birth", "1992-01-01");
		
		getParams().put("id_group", 0);
		doShowSub("auth_list", "user-auth-all");
		this.newUser = true;
		
		return SUCCESS;
	}
	
	@Override
	public String delete() throws Exception {
		valid.checkEmptyValue(getParams(), "", "delete_comment_sub");
		doEdit("user-delete");
		doEdit("user-delete-bak");	
	
		if(getParams().get("id").equals(user().getId())){
			return logout();	
		}
		
		return SUCCESS;
	}
	
	public String login() throws Exception {
		session().remove("pay_user_name");
		session().remove("pay_phone");
		if(getParams().containsKey("id") == true) {
			loginManager = LoginManager.getInstance();
			
			String sError = "";
			String sResult = MENU;
			boolean hasLoginSurvey = prop.getBoolean("artn.user.loginSurvey"); // 로그인 시 설문조사 기능 추가 - 2014.02.04 by jhson
			
			try{
				sError = loginManager.login(getParams(), session());
				if(sError.equals("") == false){
					getError().put("login", sError);
					return LOGIN;
				}
			}
			catch(NullPointerException ex){
				return LOGIN;
			}
			
			sResult = prop.get("artn.user.onLogin");
			dbm().open();
			getParams().put("rowlimit", 100);
			if(getAuth().getIsAdmin() == false){
				getParams().put("id_user", getParams().get("id"));
				getParams().remove("id");
				session().put("userGroup", dbm().select("group-user-all", getParams()));
			}else{
				session().put("userGroup", dbm().select("group-all", getParams()));
			}
			session().put("idGroup", "");
			session().put("groupName", "");
			dbm().close();
			
			// 로그인 시 설문조사 기능 추가 - 2014.02.04 by jhson [시작]
			if (hasLoginSurvey){
				if(getAuth().getIsSiteUser() == true){
					List<Map<String,Object>> list;
					dbm().open();
					getParams().put("work_type", "loginSurv");
					list = dbm().select("survey-answer-single", getParams());
					dbm().close();
						if(list.size() == 0){
							return "loginSurvey";
						}else{	
							for(int i=0 ; i < list.size() ; i++){
								if(list.get(i).get("date_upload_fmt").toString().equals(util.today())){
									return "loginSurvey";
								}
								if(list.get(i).get("answer_int").toString().equals("1")){
									return "loginSurvey";
								}
							}
						}
				}
				return MENU;
				
			}
			else{
				if (sResult == null){
					return MENU;
				}
				else{
					return sResult;
				}
			}
			// 로그인 시 설문조사 기능 추가 - 2014.02.04 by jhson [종료]
			
		}
		return LOGIN;
	}
	public boolean getHasLoginError(){
		return getError().containsKey("login");
	}
	public String loginBySession() throws Exception {
		try{
			User user = User.getInstanceFromSession(session());
			String sUrl = getParams().get("redirect").toString();
			session().put( "user", user.setIp( ((Visitor)session().get("visitor")).getIp() ) );
			return (sUrl.isEmpty() == false)? sUrl : MAIN;
		}
		catch(Exception ex){
			return LOGIN;
		}
	}
	public String logout() throws Exception {
		LoginManager.getInstance().logout(session());		
		
		return LOGIN;
	}
	public User getUser(){
		return this.user();
	}
	public String myPage() throws Exception {
		if (getParams().containsKey("mini") == true){
			return "mini";
		}
		
		userEdit = user().getRestrictUserEdit();
		
		return SUCCESS; 
	}
	public String menu() throws Exception {
		return SUCCESS;
	}
	
	public String join() throws Exception {
		String sStep = "";
		
		if (userEdit < 0){
			userEdit = prop.getIntegerHex("artn.user.join.guest");
		}

		if (getParams().containsKey("step") == false){
			return "step1";
		}
		else{
			sStep = getParams().get("step").toString();
			
			if (sStep.equals("modify") == true){
				valid.checkEmptyValue(getParams(), 2, "status_user");
				modify();
				if ((user() == null) && 
					(prop.getBoolean("artn.user.join.autoLogin") && (getUser() == null))){
					login();
				}
				return "finish";
			}
			else{
				return "step" + sStep;
			}
		}
	}
	
	public String checkId() throws Exception {
		getParams().put("keys", "id,name");
		doShow("user-single");
		
		return JSONSHOW;
	}
	
	public String getLoginId(){
		try{
			return getParams().get("id").toString();
		}
		catch(NullPointerException ex){
			return "";
		}
	}
	
	public boolean userEdit(int place){
		return ((userEdit >> (place - 1)) & 1) > 0;
	}
	
	public boolean getNewUser(){
		return this.newUser || getParams().containsKey("newUser");
	}
	
	public LoginManager getLoginManager(){
		if (loginManager == null){
			loginManager = LoginManager.getInstance();
		}
		return loginManager;
	}
	
	public String menuAdmin() throws Exception{
		return SUCCESS;
	}
	
	public String memberConfirm() throws Exception{
		if(getParams().containsKey("confirmTimeOut") == true){
			session().remove("memberConfirm");
			setResponse("0|번호가 일치하지 않습니다\n 인증번호를 다시 받으시길바랍니다.");
		    return TEXT_RESPONSE;
		}
		if(getParams().containsKey("memberConfirm") == true){
			if(session().containsKey("memberConfirm") == true){
				if(session().get("memberConfirm").toString() == getParams().get("memberConfirm").toString()
						|| session().get("memberConfirm").toString().equals(getParams().get("memberConfirm").toString())){
							setResponse("2|성공");
							session().remove("memberConfirm");
							return TEXT_RESPONSE;
						}else{
							setResponse("0|번호가 일치하지 않습니다.\n 인증번호를 다시 받으시길바랍니다");
							session().remove("memberConfirm");
							return TEXT_RESPONSE;
						}
			}
			setResponse("0|번호가 초기화 되었습니다.\n재발송을 하십시오");
		    return TEXT_RESPONSE;
		}else{
			randomNum();		    
		    //sms 보내는 곳 작성		    
		    setResponse("");
		    return TEXT_RESPONSE;
		}
	    //sms 보내기 작성
	}
	
	public String sendEmail() throws Exception {
		EmailAction ea = new EmailAction();
		Map<String, Object> mParams = getParams();		
		
		getParams().put("category", "POBMALL");
		getParams().put("contentName", "요청하신 비밀번호 입니다.");
		getParams().put("userName", mParams.get("name").toString());
		getParams().put("name", "관리자");		
		
		ea.email(getParams(), getArrayParams(), getFileParams());		
		
		return SUCCESS;
	}
	
	public String randomNum() throws Exception{
		Random oRandom = new Random();
	    StringBuilder confirm = new StringBuilder();
	    
	    // 1~9까지의 정수를 랜덤하게 출력
	    for(int i = 0; i < 6 ; i++){
	    	confirm.append(oRandom.nextInt(9) + 1);

	    	//float f = oRandom.nextFloat();
	    }
	    session().put("memberConfirm", confirm);
		return "";
	}
	
	public String find() throws Exception{
		return "find";
	}
	
	public String passwdUpdate() throws Exception{
		doEdit("user-passwd-update");
		return SUCCESS;
	}
	
	public String leave() throws Exception{
		return SUCCESS;
	}
	public String findId() throws Exception {
		doShowSub("userFind", "user-single");
		if( (getSubData().get("userFind").size() > 0) && (getSubData().get("userFind").get(0).containsKey("id") == true) ){
			StringBuilder sb = new StringBuilder();				
			for(int i = 0; i < getSubData().get("userFind").size(); i++){
				sb.append("<tr><td>" + getSubData().get("userFind").get(i).get("id").toString() + "</td></tr>");					
			}
			
			setResponse("{ \"code\" : 0, \"message\" : \"찾으시는 아이디는 <table width='100%'>"+ sb +"<table> 입니다.\"}");
		} else{			
			setResponse("{ \"code\" : 1, \"message\" : \"회원 정보가 존재하지 않습니다. 입력하신 정보를 다시 확인 해주세요.\"}");
		}
		return TEXT_RESPONSE;
		
	}
	
	public String findPassword() throws Exception {
		String sEmailTo = "";		
		String[] saEmailTo;
		String sEmail = "";		
		String[] saEmail;
		
		if( (getParams().containsKey("find") == false) && (user() == null) ){
			return LOGIN;
		}
		if(getParams().containsKey("find") == true){			
			doShowSub("userFind", "user-single");
			
			if( (getSubData().get("userFind").size() > 0) && (getSubData().get("userFind").get(0).containsKey("id") == true) ){				
				
				if( (getSubData().get("userFind").get(0).get("email") != null) && (getSubData().get("userFind").get(0).get("email").equals("") == false) ){
					sEmailTo = getSubData().get("userFind").get(0).get("email").toString();					
					saEmailTo = sEmailTo.split("@");
					
					sEmail = getParams().get("email").toString();
					saEmail = sEmail.split("@");
					
					getParams().put("email_to", saEmailTo[0] + "@" + saEmailTo[1]);
					getParams().put("content", "<div style='text-align: center;'>" + getSubData().get("userFind").get(0).get("name").toString() + "님의 비밀번호는 <b style='color:red'>" + getSubData().get("userFind").get(0).get("pw").toString() + "</b> 입니다.</div>");
					getArrayParams().put("email", saEmail);					
					
					setResponse("{ \"code\" : 0}");
					sendEmail();					
				}else{
					setResponse("{ \"code\" : 1, \"message\" : \"이메일이 등록되지 않았습니다. 고객센터(031-905-1659)로 문의해 주세요.\"}");
				}				
			}else{				
				setResponse("{ \"code\" : 1, \"message\" : \"회원 정보가 존재하지 않습니다. 입력하신 정보를 다시 확인 해주세요.\"}");
			}			
		}
		
		return TEXT_RESPONSE;
	}
	
	public String userEdit() throws Exception {
		return SUCCESS;
	}
	public String userInsert() throws Exception {
		valid.checkEmptyValue(getParams(), "", "zipcode_home", "address_home_new", "address_home1", "address_home2", "nick", "introduce");
		valid.checkEmptyValue(getParams(), 4, "auth_user_id");
		valid.checkEmptyValue(getParams(), 2, "login_limit","status_user");
		valid.checkEmptyValue(getParams(), "m", "gender");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_join");
		valid.checkEmptyValue(getParams(), "1992-01-01", "date_birth");
		valid.replaceCRLFToBRTags(getParams(), "introduce");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "opt");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "status_user");
		valid.toPhone(getParams(), getArrayParams(), "phone_mobi");
		valid.toPhone(getParams(), getArrayParams(), "phone_home");
		valid.toEmail(getParams(), getArrayParams(), "email");
		
		HSSFWorkbook work = null;
	    HSSFSheet sheet = null;
	    HSSFRow row = null;
	    HSSFCell cell = null;
//	    String szFileName = getDownloadPath() + "/upload/user/xls/" + getParams().get("file_xls").toString();
	    dbm().open();
	    
		try{
			work = new HSSFWorkbook( new FileInputStream(getFileParams().get("file_xls")[0]));
			//XSSFWorkbook work = new XSSFWorkbook(new FileInputStream(new File(szFileName)));
            sheet = work.getSheetAt(0);
            int nRowStartIndex = 1;
            int nRowEndIndex = sheet.getLastRowNum();
            String cellStr = "";
//            DecimalFormat df = new DecimalFormat();
            String[] saColumn = {"id","pw","name","introduce","nick","gender","email","phone_home","phone_mobi","date_birth"};
            
            for ( int i=nRowStartIndex; i<=nRowEndIndex; i++ ) {
                row = sheet.getRow(i);
                for ( int j=0; j< row.getLastCellNum(); j++ ) {
                    cell = row.getCell(j);
                    
                    if ( cell == null ) continue;
                    if ( cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC ){
                    	if (HSSFDateUtil.isCellDateFormatted(cell)){
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
//							cellStr = formatter.format(cell.getDateCellValue());
							getParams().put(saColumn[j], formatter.format(cell.getDateCellValue()));
						}else{
//							double ddata = cell.getNumericCellValue();   
//							cellStr = df.format(ddata);
							getParams().put(saColumn[j], (int)cell.getNumericCellValue());
//							cellStr = String.valueOf((int)cell.getNumericCellValue());
						}
                    }
                    else{
                    	cellStr = cell.getStringCellValue();
                    	if(saColumn[j].equals("gender")){
                    		if(cellStr.equals("남")){
                    			cellStr = "m";
                    		}else{
                    			cellStr = "w";
                    		}
                    	}
                    	getParams().put(saColumn[j], cellStr);
                    }
                }
                dbm().updateNonCommit("user-modify", getParams());
            }
		}catch(Exception ex){
			ex.printStackTrace();
		}
		dbm().commit();
		dbm().close();
		return SUCCESS;
	}
}	
