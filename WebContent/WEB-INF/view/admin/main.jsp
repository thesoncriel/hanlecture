<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="sub1000">
	<div class="header">
		<h1>관리자</h1>		
	</div>
	<div class="section">
		<div class="article">			
			<ul data-role="listview">
				<li data-role="list-divider">현재 접속자</li>
				<li>${loginManager.userCount }</li>
				<li data-role="list-divider">관리자메뉴</li>
				<li><a href="/user/list">사용자 관리</a></li>
				<li><a href="/group/list">그룹 관리</a></li>
				<li><a href="/groupuser/list">그룹 관리</a></li>
			</ul>
		</div>
	</div>
</a:html>