<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 출석 현황" contents="${contentsCode }">
<script type="text/javascript">
$(document).ready(function(){
	$("#confirmFrm").submit(function(){
	    $(".ui-checkbox-on").children(".student_name").attr("name","student_name");
	    $(".ui-checkbox-on").children(".student_dept").attr("name","student_dept");
	});
});
</script>
<div class="header">
	<h3>임의 출석</h3>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div> 
<form action="anyAttendConfirm" method="post" id="confirmFrm">
	<div data-role="content">  
	    <fieldset data-role="controlgroup" id="myGroup" data-filter="true" data-icon="false">
	        <s:iterator value="listData" status="list">
	            <input type="checkbox" name="id_student" id="id_user_${list.count }" value="${id_user }"/>
	            <label for="id_user_${list.count }">${user_name }(${id_user })
	               <input type="hidden" class="student_name" value="${user_name }"/>
	               <input type="hidden" class="student_dept" value="${user_introduce }"/>
	            </label>
	        </s:iterator>                
	    </fieldset>
	    <input type="hidden" name="id_lect" value="${subData.groupSingle[0].id }" />
		<input type="hidden" name="lect_code" value="${subData.groupSingle[0].lect_code }" />
		<input type="hidden" name="lect_name" value="${subData.groupSingle[0].name }" />
		<input type="hidden" name="lect_seq" value="${subData.groupSingle[0].lect_seq }" />
		<input type="hidden" name="date_lect" value="${subData.groupSingle[0].time_lect_start }" />
		<input type="hidden" name="id_sum_prof" value="${subData.maxLecture[0].id }" />
	</div>
	<div class="footer board">
	    <div class="buttons">
	            <button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	    </div>
    </div>
</form>
</a:html>