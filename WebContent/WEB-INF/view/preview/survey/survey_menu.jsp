<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - Main Menu" contents="${contentsCode }">
<div class="header">
	<h1>강의 평가</h1>
	<div id="breadcrumbs" data-sub="*메인메뉴"></div>
</div>
<div class="section">
	<div class="article">
		<div class="nav">
			<ul data-role="listview">
				<li><a href="/admin/Survey/list">문항 설정</a></li>
				<li><a href="/group/list?survey=true">다운로드</a></li>
			</ul>
		</div>
	</div>
</div>
</a:html>