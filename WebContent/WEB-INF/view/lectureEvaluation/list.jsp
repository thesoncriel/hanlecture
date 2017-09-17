<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 강의 목록" contents="${contentsCode }">

<div class="header">
	<h3>강의 평가 목록</h3>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
	
	<ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
				data-filter-placeholder="Search Evaluation..." data-filter-theme="c">
		<s:iterator value="listData" >
			<li><a href="/lectureEvaluation/edit?is_practice=${is_practice }&id_lect=${id_lect }&id_sum_prof=${id }&id_prof=${id_prof }&prof_name=${prof_name }">
			${lect_name }&nbsp;${date_upload_fmt }&nbsp;${date_lect }
			<s:if test="is_practice == 1">
				[이론]
			</s:if><s:else>
				[실습]
			</s:else>
			<br/>- ${prof_name }
			</a></li>
		</s:iterator>
	</ul>
</a:html>