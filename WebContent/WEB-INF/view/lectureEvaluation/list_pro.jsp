<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 목록" contents="${contentsCode }">

<div class="header">
	<h3>평가할 교수님을 선택하시오.</h3>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>

	<ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
				data-filter-placeholder="Search Student... " data-filter-theme="c">
		<s:iterator value="listData" >
			<li><a href="/lectureEvaluation/edit?id_sum_prof=${param.id_sum_prof }&id_group=${id_group }&is_practice=${param.is_practice }&id_prof=${id_user }&prof_name=${user_name }" >${user_name }</a></li>
		</s:iterator>
	</ul>
	
</a:html>