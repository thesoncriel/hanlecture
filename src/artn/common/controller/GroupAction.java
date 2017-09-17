package artn.common.controller;

import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import artn.common.Const;
import artn.common.FileNameChangeMode;

public class GroupAction extends AbsUploadActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1568950975487808157L;
	//private boolean hasAuthGroup = false;
	
	public String extractSrcFromDaumMap(String htmlContent, String width, String height) {
		String sTag = htmlContent;
		int iUrlStart = sTag.indexOf("\"");
		int iUrlEnd = sTag.indexOf("\"", iUrlStart + 1);
		int iWidthStart = sTag.indexOf("width=");
		int iWidthEnd = sTag.indexOf("&height");
		int iHeightStart = sTag.indexOf("height=");
		int iHeightEnd = sTag.indexOf("&", iWidthEnd + 1);
			
		String sWidth = sTag.substring(iWidthStart + 6, iWidthEnd);
		String sHeight = sTag.substring(iHeightStart+7, iHeightEnd);
		
		String sTagChange = sTag.replace("width=" + sWidth+"&height=" + sHeight, "width=" + width + "&height=" + height);
		String sUrl = sTagChange.substring(iUrlStart+1, iUrlEnd);
		
		return sUrl;
	}
	
	
	@Override
	public String list() throws Exception {
		
		
		if (getParams().containsKey("groupType") == true){
			getParams().put("group_type", getGroupTypeCode( getParams().get("groupType") ));
		}

		if( ( (getAuth().getIsAdmin() == true || getAuth().getIsSuperAdmin() == true) &&
			(getContentsCode().equals(Const.CONTENTS_NORMAL) == true) )){
			doList("group-all");
			return "admin";
		}else{
			getParams().put("date", getUtil().getToday());
			getParams().put("id_user", user().getId());
			doList("group-user-single");
			return SUCCESS;	
		}
		
	}
	
	protected int getGroupTypeCode(Object groupType){
		if (groupType.equals("service") == true) return 0x1;
		if (groupType.equals("seller") == true) return 0x2;
		if (groupType.equals("medical") == true) return 0x4;
		if (groupType.equals("pension") == true) return 0x8;
		if (groupType.equals("cafe") == true) return 0x10;
		
		return 0;
	}

	@Override
	public String show() throws Exception {
		// TODO: 그룹 공개 여부에 따라 권한 오류로 내보내는 기능 필요함 (먼 훗날...) - 2013.08.05 by jhson
		if (user() != null){
			user().setIdGroup( getParams().get("id").toString() );
		}
		
		doShow("group-single");
		
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		if (user() == null) return LOGIN;
		Map<String, Object> mParam = getParams();
		Map<String, String[]> msaParam = getArrayParams();
		
		try{
			valid.checkEmptyValue(mParam, "", "homepage", "zipcode_group", "address_group_new", "address_group1", "address_group2", "date_estab","introduce","nick");
			valid.mergeIntValuesToMap(mParam, msaParam, "group_type");
			valid.checkEmptyValue(mParam, util.getNow(), "date_create");
			valid.appendAndPutToMap(mParam, msaParam, "phone_group", "-");
			valid.appendAndPutToMap(mParam, msaParam, "phone_fax", "-");
			valid.checkFileExists(mParam, "file_img", "file_banner");
			makeDaumMapUrl(mParam, "map_coord", "map_url", "name");
			
			if (hasFileParams() == true){
				saveFileToAuto(getDownloadPath() + "/upload/group/", "", FileNameChangeMode.parentheses);
			}
			doEdit("group-modify");
			if (mParam.containsKey("id") == false){
				mParam.put( "id_group", dbm().selectOne("common-inserted-id", mParam).get("id") );
				mParam.put("insertValue", prop.get("artn.group.authMaking"));
				return "modifyForNew";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			return ERROR_AUTH;
		}
		
		return SUCCESS;
	}
	
	protected void makeDaumMapUrl(Map<String, Object> destData, String keyMapCoord, String keyMapUrl, String keyLocationName){
		try{
			String sCoord = destData.get( keyMapCoord ).toString();
			String[] saCoord = sCoord.split(",");
			StringBuilder sbMapUrl = new StringBuilder("http://dna.daum.net/examples/maps/MissA/map_view.php?width=660&height=400&latitude=");
	
			sbMapUrl.append(saCoord[0].trim())
			.append("&longitude=").append(saCoord[1].trim())
			.append("&contents=").append(destData.get( keyLocationName ).toString())
			.append("&zoom=4");
	
			getParams().put( keyMapUrl, sbMapUrl.toString() );
		}
		catch(Exception ex){
			destData.put( keyMapCoord, /*"37.66175495311978,126.76981768345294"*/"");
			destData.put( keyMapUrl, "");
		}
	}
	
	public String companyList() throws Exception{
		doList("group-company-list");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("id", 0);
		map.put("name", "미등록 기업");
		
		getListData().add(map);
		
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		if (user() == null) return LOGIN;
		user().setIdGroup( getParams().get("id").toString() );
		show();
		return successOrAuth("GroupAdmin");
	}
	@Override
	public String write() throws Exception {
		if (user() == null) return LOGIN;
		return successOrAuth("GroupAdmin");
	}
	@Override
	public String delete() throws Exception {
		if (user() == null) return LOGIN;
		String sRet = successOrAuth("GroupAdmin");
		
		if (sRet.equals(SUCCESS) == true){
			doEdit("group-delete");
		}
		
		return sRet;
	}
	
	public boolean getIsGroupAdmin(){
		return getAuth().getIsGroupAdmin();
	}
	public String groupEdit() throws Exception {
		return SUCCESS;
	}
	public String groupInsert() throws Exception {
		Map<String, Object> mParam = getParams();
		valid.checkEmptyValue(mParam, "", "homepage", "zipcode_group", "address_group_new", "address_group1", "address_group2", "date_estab","introduce","nick");
		valid.mergeIntValuesToMap(mParam, getArrayParams(), "group_type");
		valid.checkEmptyValue(mParam, util.getNow(), "date_create");
		valid.appendAndPutToMap(mParam, getArrayParams(), "phone_group", "-");
		valid.appendAndPutToMap(mParam, getArrayParams(), "phone_fax", "-");
		valid.checkFileExists(mParam, "file_img", "file_banner");
		makeDaumMapUrl(mParam, "map_coord", "map_url", "name");
		
		HSSFWorkbook work = null;
	    HSSFSheet sheet = null;
	    HSSFRow row = null;
	    HSSFCell cell = null;
	    dbm().open();
	    
	    try{
			work = new HSSFWorkbook( new FileInputStream(getFileParams().get("file_xls")[0]));
            sheet = work.getSheetAt(0);
            int nRowStartIndex = 1;
            int nRowEndIndex = sheet.getLastRowNum();
            String cellStr = "";
            String[] saColumn = {"id","name","lect_code","nick","theory_practice"
            					,"date_start","date_end","lect_score","address_group1","lect_seq"
            					,"weekly_lect","time_lect_start","time_lect_end","address_group2","prtc_seq"
            					,"weekly_prtc","time_prtc_start","time_prtc_end"};
            for ( int i=nRowStartIndex; i<=nRowEndIndex; i++ ) {
                row = sheet.getRow(i);
                for ( int j=0; j< row.getLastCellNum(); j++ ) {
                    cell = row.getCell(j);
                    
                    if ( cell == null ) continue;
                    if ( cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC ){
                    	if (HSSFDateUtil.isCellDateFormatted(cell)){
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
							mParam.put(saColumn[j], formatter.format(cell.getDateCellValue()));
						}else{
							mParam.put(saColumn[j], (int)cell.getNumericCellValue());
						}
                    }
                    else{
                    	cellStr = cell.getStringCellValue();
                    	mParam.put(saColumn[j], cellStr);
                    }
                }
                int iGroupSize = 0;
                iGroupSize = dbm().selectNonOpen("group-all", mParam).size();
                dbm().updateNonCommit("group-modify", mParam);
                if(iGroupSize == 0){
                	mParam.put( "id_group", mParam.get("id"));
    				mParam.put("insertValue", prop.get("artn.group.authMaking"));
    				mParam.remove("id");
    				insertByValue(mParam.get("insertValue").toString());
    				
    				getParams().put("auth_user", "262144");
    				getParams().put("auth_group_id", dbm().selectOneNonOpen("user-auth-single", getParams()).get("id"));
    				mParam.remove("id");
    				mParam.remove("name");
    				mParam.put("auth_user", "131080");
    				List<Map<String, Object>> lmUser = dbm().selectNonOpen("user-all", mParam);
    				for(int j = 0; j < lmUser.size(); j++){
    					mParam.put("id_user", lmUser.get(j).get("id"));
    					mParam.put("date_join", getUtil().getNow());
    					mParam.put("opt", lmUser.get(j).get("opt"));
    					mParam.put("comment", "");
    					dbm().updateNonCommit("group-user-modify", mParam);
    				}	
                }
            }
		}catch(Exception ex){
			ex.printStackTrace();
		}
		dbm().commit();
		dbm().close();
		return SUCCESS;
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
}