<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - Main Menu" contents="${contentsCode }">
<div class="header">
	<h1>메인 메뉴</h1>
	<div id="breadcrumbs" data-sub="*메인메뉴"></div>
</div>
<div class="section">
	<div class="article">
		<div class="nav">
			<!-- 관리자 메뉴 -->
			<%-- <s:if test="auth.menu(1)">
				<ul data-role="listview">
					<li><a href="/user/list">사용자 관리</a></li>
					<li><a href="/group/list">그룹 관리</a></li>
					<li><a href="/groupuser/list">그룹 관리</a></li>
				</ul>
			</s:if> --%>
			<!-- 대학관계자 메뉴 -->
			<s:if test="auth.menu(2)">
				<ul data-role="listview">
					<li><a href="/group/list">강의 목록</a></li>
					<li><a href="/user/list">학생 목록</a></li>
					<li><a href="/user/userEdit">학생 등록(xls)</a></li>
					<li><a href="/group/groupEdit">과목 등록(xls)</a></li>
					<%-- <li data-theme="a"><a href="/group/list?attendance=true">출결 관리</a></li> --%>
					<li data-theme="a"><a href="/admin/Survey/surveyMenu">문항관리(강의평가..등)</a></li>
					<li data-theme="a"><a href="/group/proflist">강의 평가 이력</a></li>
				</ul>
			</s:if>
			<!-- 교수 메뉴 -->
			<s:if test="auth.menu(3)">
				<ul data-role="listview">
					<li>※강의시작을 눌러주세요</li>
					<li><a href="/group/list?lect=true">강의 시작</a></li>
					<li><a href="/group/list">강의 목록</a></li>
					<%-- <li data-theme="a"><a href="#">현재 강의 찾기</a></li> --%>
				</ul>
			</s:if>
			<!-- 학생 메뉴 -->
			<s:if test="auth.menu(4)">
				<ul data-role="listview">
					<li><a href="/group/list?lect=true">수강 목록</a></li>
				</ul>
			</s:if>
		</div>
	</div>
</div>
</a:html>