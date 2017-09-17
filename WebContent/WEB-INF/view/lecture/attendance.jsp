<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 출석 현황" contents="${contentsCode }">
<div class="header">
	<h3>출석 현황</h3>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div> 
		<%-- <ul data-role="listview" data-split-icon="check" data-split-theme="d">
			<s:iterator value="listData">
                <li data-theme="e">
                    <a href="/user/show?id=${id_student }">
                    	<h2>${id_student }(${student_name })&nbsp;&nbsp;&nbsp;수업시간:${date_lect }</h2>
                    	<h3>출석시간:${date_upload_fmt }</h3>
                    </a>
                </li>
            </s:iterator>
		</ul> --%>
	<%-- <ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
	data-filter-placeholder="Search Attendance... " data-filter-theme="c">
		<s:iterator value="subData.attendanceprof" var="data" status="s">
			<li data-role="list-divider">수업시간:${data.date_lect }&nbsp;&nbsp;일자:${data.date_upload_fmt }&nbsp;${s.index +1}번째출석</li>
			<s:iterator value="subData.attendancestudent" var="field" status="i">
			<s:if test="#data.id == #field.id_sum_prof">
			<li data-theme="e">
				<a href="/user/show?id=${id_student }">		
				<h2>${field.id_student }(${field.student_name })&nbsp;&nbsp;출석시간:${field.date_upload_fmt }</h2>
			</li>
			</s:if>
			</s:iterator>
		</s:iterator>
	</ul> --%>
<form action="attendance" method="get">
	<div class="ui-field-contain">
		<label for="date_upload">날짜 검색</label>
		<s:if test="#session.environment.osPlatform == 'Mobile'">
			<input type="date" id="date_upload" name="date_upload"/>
		</s:if>
		<s:else>
			<input type="text" data-role="date" id="date_upload" name="date_upload"/>
		</s:else>
		<input type="hidden" name="id_lect" value="${id_lect }"/>
		<s:if test="auth.isSiteUser">
		    <input type="hidden" name="id_student" value="${param.id_student }"/>
		</s:if>
		<s:else>
            <input type="hidden" name="id_prof" value="${param.id_prof }"/>          
        </s:else>
	</div>
	<input type="submit" value="Search..">
</form>

<div data-role="collapsible-set" data-theme="a" data-inset="false">	
	<s:iterator value="subData.attendanceprof" var="data" status="s">
		<div data-role="collapsible">
		<h2>수업시간:${data.date_lect }&nbsp;&nbsp;일자:${data.date_upload_fmt }&nbsp;${s.index +1}번째출석</h2>
			<ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
			data-filter-placeholder="Search Attendance... " data-filter-theme="c">
			    <s:if test="auth.isSiteUser == false">
                    <s:subset source="subData.attendancestudent" >
                        <li>
	                       <s:set var="count" value="0"/>
	                       <s:iterator var="studentCnt" status="i">
	                           <s:if test="#data.id == #studentCnt.id_sum_prof">
	                               <s:set var="count" value="#count+1"/>
	                           </s:if>
	                       </s:iterator>
                        ${count }명 / ${totCnt }명
                        </li>
                    </s:subset>
                </s:if>
	                <%-- <li data-role="list-divider">수업시간:${data.date_lect }&nbsp;&nbsp;일자:${data.date_upload_fmt }&nbsp;${s.index +1}번째출석</li> --%>
                <s:iterator value="subData.attendancestudent" var="field" status="i">
                <s:if test="#data.id == #field.id_sum_prof">
                <li data-theme="e">
                <%-- <a href="/user/show?id=${id_student }"> --%>       
                <h2>${field.id_student }(${field.student_name })&nbsp;&nbsp;출석시간:${field.date_upload_fmt }</h2>
                </li>
                </s:if>
                </s:iterator>			    
			    
			</ul>
		</div>
	</s:iterator>
</div>
</a:html>