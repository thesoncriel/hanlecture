<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 강의 목록" contents="${contentsCode }">

<div class="header">
	<h3>평가 문제 목록</h3>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
	
	<ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
				data-filter-placeholder="Search Evaluation..." data-filter-theme="c">
		<s:iterator value="listData" >
			<li><a href="/preview/edit?id=${id }&id_group=${id_group }">
				${writer_name }&nbsp;${date_upload_fmt }</a>
			</li>
		</s:iterator>
	</ul>
</a:html>