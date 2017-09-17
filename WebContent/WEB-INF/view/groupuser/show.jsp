<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - 사용자 정보" contents="${contentsCode }">
<div class="header">
	<h1>사용자 정보</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">아이디</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.id_user }</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">이름</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.user_name }</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">학과</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.group_name }</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">직급</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.auth_group_kor }</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">핸드폰 번호</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.user_phone_mobi }</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">학년</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.user_nick }</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">성별</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.user_gender_kor }</div>
</div>
<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-b">
			<a
				href="edit?id_user=${showData.id_user }&contents=${contents}&id_group=${showData.id_group }"
				class="artn-button board">수정</a>
		</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-b">
			<a href="/groupuser/delete?id_user=${showData.id_user }&contents=${contents}&id_group=${showData.id_group }"
				class="artn-button board">그룹 탈퇴</a>
		</div>
	</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">
		<a href="list?id_group=${showData.id_group }&contents=${contents}"
			class="artn-button board">목록</a>
	</div>
</div>
</a:html>