<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 목록" contents="${contentsCode }">

<div class="header">
	<h3>교수님을 선택해주세요</h3>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>

	<ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
				data-filter-placeholder="Search Prof... " data-filter-theme="c">
		<s:iterator value="listData" >
			<li><a href="/lectureEvaluation/profResultShow?id_lect=${id_group }&id_prof=${id_user }&prof_name=${user_name }" >${user_name } 교수님</a></li>
		</s:iterator>
	</ul>
	
</a:html>