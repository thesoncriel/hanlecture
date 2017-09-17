package artn.common.controller;

import java.util.List;
import java.util.Map;

public class GroupUserAction extends AbsUploadActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3882586504659407537L;
	//private boolean hasAuthGroup = false;
	private String groupUserAuthId;
	private Integer modifiedId;

	public Integer getModifiedId(){
		return modifiedId;
	}
	
	@Override
	public String list() throws Exception {
		if (user() == null) return LOGIN;
		
		doList("group-user-all");
		return successOrJsonList();
	}

	@Override
	public String show() throws Exception {
		if (user() == null) return LOGIN;
		doShow("group-user-single");
		return successOrJsonShow();
	}

	@Override
	public String edit() throws Exception {
		if (user() == null) return LOGIN;
		show();
		doShowSub("userAuth","user-auth-all");
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		
//		getParams().put("auth_user", 262144);
		doShowSub("userAuth","user-auth-all");
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		if (user() == null) return LOGIN;
		//FIXME: 그룹 관리자가 아니면 이용 못하게 해야함. - 2013.08.06 by jhson
		//FIXME: 관리자가 회원 가입시킬 때 중복확인해야함. - 2013.08.08 by shkang
		if(getParams().containsKey("id_user") == false){
			valid.checkEmptyValue(getParams(), user().getId(), "id_user");	
		}
		valid.checkEmptyValue(getParams(), 0, "id_group", "auth_group_id");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_join");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "opt");
		valid.replaceCRLFToBRTags(getParams(), "comment");
		dbm().open();
			doEdit("group-user-modify");	
		session().remove("newUserName");
		session().remove("newUserId");
		
		
		List<Map<String, Object>> lmAuthGroup;
		
		lmAuthGroup = dbm().selectNonOpen("group-user-all", getParams());
		if(getParams().get("id") == null || getParams().get("id") == ""){
			modifiedId = dbm().selectOneInteger("common-inserted-id-int", getParams());
		}else{
			modifiedId = Integer.parseInt(getParams().get("id").toString());
		}
		session().put("idGroup", getParams().get("id_group"));
		if(getAuth().getIsAdmin() == false){
			getParams().put("id_user", user().getId());
			getParams().remove("id");
			session().put("userGroup", dbm().selectNonOpen("group-user-all", getParams()));
		}else{
			session().put("userGroup", dbm().selectNonOpen("group-all", getParams()));
		}
		
		
		getParams().put("modifiedId", modifiedId);
		//System.out.println(modifiedId + "그룹가입 아이디");
		dbm().close();
		if(getAuth().getIsSiteStaff() == false){
			user().putAuthGroup( lmAuthGroup );	
		}
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		
		if(getParams().containsKey("ajax")){
			try{
				dbm().open();
				if(getArrayParams().containsKey("id")){
					for(int i = 0; i < getArrayParams().get("id").length ; i++){
						getParams().put("id", getArrayParams().get("id")[i]);
						dbm().updateNonCommit("group-user-delete", getParams());	
					}	
				}else{
					dbm().updateNonCommit("group-user-delete", getParams());
				}
				
				dbm().commit();
				dbm().close();
				setResponse("success");
			}catch(Exception e){
				setResponse("fail");
			}
			return TEXT_RESPONSE;
		}else{
			doEdit("group-user-delete");
			return SUCCESS;
		}
		
	}
	
	public String getGroupUserAuthId(){
		return groupUserAuthId;
	}
}