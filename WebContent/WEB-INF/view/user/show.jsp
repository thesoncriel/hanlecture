<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - 사용자 정보" contents="${contentsCode }">
<div class="header">
	<h1>사용자 정보</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>


<s:if test="userEdit(1)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">사진</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">
			<a:img src="/upload/user/img/${showData.file_img }" alt="회원 사진"
				srcNone="/img/none.png" altNone="회원 사진 없음 - 회원 등록 후 적용 됩니다."
				width="100" height="100" />
		</div>
	</div>
</s:if>

<s:if test="userEdit(2)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">아이디</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.id }</div>
	</div>
</s:if>

<s:if test="userEdit(3)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">이름</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.name }</div>
	</div>
</s:if>

<s:if test="userEdit(16)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">학과정보</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.introduce }</div>
	</div>
</s:if>

<s:if test="userEdit(5)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">학년</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.nick }</div>
	</div>
</s:if>

<s:if test="userEdit(8)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">휴대폰번호</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.phone_mobi }</div>
	</div>
</s:if>

<s:if test="userEdit(9)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">생년월일</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.date_birth }</div>
	</div>
</s:if>

<s:if test="userEdit(10)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">성별</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.gender_kor }</div>
	</div>
</s:if>

<s:if test="userEdit(11)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">사용자권한</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.auth_user_kor }</div>
	</div>
</s:if>

<s:if test="userEdit(12)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">우편번호</div>
	</div>
	<div class="ui-block">
		<div class="ui-bar ui-bar-c">${showData.zipcode_home }</div>
	</div>
</s:if>

<s:if test="userEdit(13)">
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">주소</div>
	</div>
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<div class="ui-bar ui-bar-a">지번주소</div>
		</div>
		<div class="ui-block-b">
			<div class="ui-bar ui-bar-c">${showData.address_home1 }</div>
		</div>

		<div class="ui-block-a">
			<div class="ui-bar ui-bar-a">새주소</div>
		</div>
		<div class="ui-block-b">
			<div class="ui-bar ui-bar-c">${showData.address_home_new }</div>
		</div>

		<div class="ui-block-a">
			<div class="ui-bar ui-bar-a">상세주소</div>
		</div>
		<div class="ui-block-b">
			<div class="ui-bar ui-bar-c">${showData.address_home2 }</div>
		</div>
	</div>
</s:if>

<!-- <div class="ui-grid-a"> -->
	<%-- <div class="ui-block-a">
		<div class="ui-bar ui-bar-b">
			<a href="leave?id=${showData.id }" class="artn-button board">회원탈퇴</a>
		</div>
	</div> --%>
	<div class="ui-block">
		<div class="ui-bar ui-bar-a">
			<a href="edit.action?id=${showData.id }&contents=${contentsCode }"
				class="artn-button board">회원정보 수정</a>
		</div>
	</div>
<!-- </div> -->
<div class="ui-block">
	<div class="ui-bar ui-bar-a">
		<s:if test='%{(#parameters.from == null) && (auth.isAdmin) }'>
			<a href="list.action" class="artn-button board">목록</a>
		</s:if>
		<s:else>
			<a href="/user/menu" class="artn-button board">확인</a>
		</s:else>
	</div>
</div>

</a:html>