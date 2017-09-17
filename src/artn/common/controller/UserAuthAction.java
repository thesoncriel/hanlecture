package artn.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.Const;

public class UserAuthAction extends AbsUtilitySupportActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9088045920424942005L;

	@Override
	public String list() throws Exception {
		getParams().put(Const.KEY_ROW_NUMBER_ASCENDING, true);
		
		if (getParams().containsKey("json") == true) {
			getParams().put("rowlimit", 100);
			doList("user-auth-all");
			return "jsonlist";
		}
		
		doList("user-auth-all");
		
		return "success";
	}

	@Override
	public String show() throws Exception {
		doShow("user-auth-single");
		return "success";
	}

	@Override
	public String write() throws Exception {
		return "success";
	}

	@Override
	public String modify() throws Exception {
		if (getParams().containsKey("insertValue") == true){
			insertByValue(getParams().get("insertValue").toString());
			try{
				dbm().open();
				getParams().put("auth_user", "262144");
				getParams().put("auth_group_id", dbm().selectOneNonOpen("user-auth-single", getParams()).get("id"));
				Map<String, Object> mParams = getParams();
				mParams.remove("name");
				mParams.put("auth_user", "131080");
				List<Map<String, Object>> lmUser = dbm().selectNonOpen("user-all", mParams);
				for(int i = 0; i < lmUser.size(); i++){
					mParams.put("id_user", lmUser.get(i).get("id"));
					mParams.put("date_join", getUtil().getNow());
					mParams.put("opt", lmUser.get(i).get("opt"));
					mParams.put("comment", "");
					dbm().updateNonCommit("group-user-modify", mParams);
				}
				dbm().commit();
				dbm().close();
			}catch(Exception e){
				dbm().commit();
				dbm().close();
				e.printStackTrace();
			}
		}
		else{
			valid.checkEmptyValue(getParams(), 0, "id_group");
			valid.mergeIntValuesToMap(getParams(), getArrayParams(), "auth_user");
			valid.mergeIntValuesToMap(getParams(), getArrayParams(), "restrict_menu");
			valid.mergeIntValuesToMap(getParams(), getArrayParams(), "restrict_user_edit");
			doEdit("user-auth-modify");
		}
		
		return "success";
	}
	protected void insertByValue(String value){
		String[] saAuthGroupSource = value.split(";");
		String[] saAuthGroup;
		Map<String, Object> mParam = getParams();
		boolean isFirst = true;
		
		dbm().open();
		for(String sAuthGroup : saAuthGroupSource){
			saAuthGroup = sAuthGroup.split(":");
			mParam.put("auth_user", Integer.decode(saAuthGroup[1]));
			mParam.put("auth_user_kor", saAuthGroup[0]);
			
			if (saAuthGroup.length > 2){
				mParam.put("restrict_menu", Integer.decode(saAuthGroup[2]));
				if (saAuthGroup.length == 4){
					mParam.put("restrict_user_edit", Integer.decode(saAuthGroup[3]));
				}
				else{
					mParam.put("restrict_user_edit", 0);
				}
			}
			else{
				mParam.put("restrict_menu", 0);
				mParam.put("restrict_user_edit", 0);
			}
			
			dbm().insertNonCommit("user-auth-modify", mParam);
			
			if (isFirst){
				String sId = dbm().selectOneNonOpen("common-inserted-id", getParams()).get("id").toString();
				getParams().put("auth_group_id", sId);
				isFirst = false;
			}
		}
		dbm().commit();
		dbm().close();
	}

	@Override
	public String delete() throws Exception {
		doEdit("user-auth-delete");
		return "success";
	}

	@Override
	public String edit() throws Exception {
		return show();
	}
}
