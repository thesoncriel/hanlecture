<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 강의평가현황" contents="${contentsCode }">
<div class="header">
	<h3></h3>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div> 
<input type="hidden" name="id_lect" value="${id_lect }"/>
	<ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
				data-filter-placeholder="Search Evaluation..." data-filter-theme="c">
		<s:iterator value="listData" >
			<li><a href="/lectureEvaluation/answer_show?id_sum_prof=${id }&id_lect=${id_lect }">
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