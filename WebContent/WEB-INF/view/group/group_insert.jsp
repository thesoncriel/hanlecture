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
				<h2>과목 등록</h2>
				<form action="groupInsert" method="post" enctype="multipart/form-data" class="validator">	
					<label for="file">엑셀 파일 선택</label>
					<a:file id="file_xls" name="file_xls" value=""/>
					<button type="submit" class="artn-button board">완료</button>
				</form>
		</div>
	</div>
</div>
</a:html>