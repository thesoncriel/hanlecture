package artn.lect.controller;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import artn.common.controller.AbsSubDataActionController;
import artn.common.controller.DefaultAction;
import artn.common.model.Environment;

public class AttendanceResultAction extends DefaultAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2225609207447676284L;
	
	private InputStream inputStream = null;

	private String fileName;

	/* 엑셀 출력부 기능 추가/변경 - 2014.02.20 by jhson [시작] */
	
	/**
	 * 외부에서 Struts2를 이용하여 수행되는 액션 메서드.
	 * 출결 현황 테이블을 만들어 이 곳에 집계 자료를 입력 한다.
	 * 수행 시 기존에 만들어져 있던 집계 테이블은 삭제 된다.
	 * @return text_response
	 * @throws Exception
	 */
	public String makeSheet() throws Exception {
		List<Map<String, Object>> lmDateShort = null;
		List<Map<String, Object>> lmResultData = null;
		Map<String, Object> mTemp = util.createMap();
		
		if ( "kor".equals( getParams().get("result_word") ) == true ){
			mTemp.put("status1", "출석");
			mTemp.put("status2", "결석");
			mTemp.put("status3", "지각");
			mTemp.put("status4", "조퇴");
			mTemp.put("status5", "불성실");
		}
		else{
			mTemp.put("status1", "O");
			mTemp.put("status2", "X");
			mTemp.put("status3", "△");
			mTemp.put("status4", "□");
			mTemp.put("status5", "■");
		}
		
		dbm().open();
		
		try{dbm().updateNonCommit("lecture-attendance-result-drop-table", getParams()); }catch(Exception ex){}		//필요항목: id_lect
		dbm().updateNonCommit("lecture-attendance-result-create-table", getParams()); 	//필요항목: id_lect
		
		lmDateShort = dbm().selectNonOpen("lecture-attendance-result-date-list", getParams());	//필요항목: id_lect
		
		for(Map<String, Object> mDateShort : lmDateShort){
			mDateShort.putAll(mTemp);
			dbm().updateNonCommit("lecture-attendance-result-add-column", mDateShort);		//필요항목: id_lect, date_lect_short
			lmResultData = dbm().selectNonOpen("lecture-attendance-result-data", mDateShort);			//필요항목: id_lect, date_lect
			
			for(Map<String, Object> mResultData : lmResultData){
				dbm().updateNonCommit("lecture-attendance-result-update-data", mResultData);		//필요항목: id_lect, date_lect_short, result, id_user
			}
		}
		
		dbm().commit();
		dbm().close();
		
		setResponse("0|출석 자료의 집계가 완료 되었습니다. 엑셀을 다운로드 받으십시요.");
		
		return TEXT_RESPONSE;
	}
	
	

		
	
	
	public String excel() throws Exception {
		try{
			List<Map<String, Object>> lmResult = null;
			List<String> lsKeys = new ArrayList<String>();
			ArrayList<String> lsDateKeys = new ArrayList<String>();
			Set<String> setKeys = null;
			
			doList("lecture-attendance-result-all");
			
			lmResult = getListData();
			setKeys = lmResult.get(0).keySet();
			
			this.fileName = lmResult.get(0).get("lect_name").toString().replaceAll(" ", "_") + "_" + getParams().get("id_lect") + "_" + util.getToday() + ".xls";
			this.fileName = encFileName(fileName);

			lsKeys.add("id_user");
			lsKeys.add("user_name");
			lsKeys.add("id_lect");
			lsKeys.add("lect_name");
			
			for(String sKey : setKeys){
				if ( lsKeys.contains( sKey ) == false ){
					lsDateKeys.add( sKey );
				}
			}
			
			Collections.sort( lsDateKeys );
			
			lsKeys.addAll( lsDateKeys );
			
			inputStream = makeExcel( lmResult, lsKeys );
		}catch(Exception ex){
			ex.printStackTrace();
			setResponse("0|오류");
			return TEXT_RESPONSE;
		}
		
		return SUCCESS;
	}
	
	public InputStream getInputStream(){
		return inputStream;
	}
	
	public String getFileName(){
		System.out.println(fileName);
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
	
	/* 엑셀 출력부 기능 추가/변경 - 2014.02.20 by jhson [종료] */
	
}
