<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 정보" contents="${contentsCode }">
<div class="header">
    <h1>강의 정보</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>

<div class="ui-block">
	<div class="ui-bar ui-bar-a">강의명</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-e">${showData.name}</div>
</div>

<div class="ui-block">
	<div class="ui-bar ui-bar-a">강의실 위치</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.address_group1 }</div>
</div>

<div class="ui-block">
	<div class="ui-bar ui-bar-a">실습실 위치</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.address_group2 }</div>
</div>

<div class="ui-block">
	<div class="ui-bar ui-bar-a">강의코드</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.lect_code }</div>
</div>

<div class="ui-block">
	<div class="ui-bar ui-bar-a">학점</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.lect_score }</div>
</div>

<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-a">강의순서</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-a">실습순서</div>
	</div>
</div>
<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-c">${showData.lect_seq }</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-c">${showData.prtc_seq }</div>
	</div>
</div>
<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-a">강의요일</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-a">실습요일</div>
	</div>
</div><div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-c">${showData.weekly_lect }</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-c">${showData.weekly_prtc }</div>
	</div>
</div>
<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-a">강의시작날짜</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-a">강의종료날짜</div>
	</div>
</div>
<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-c">${showData.date_start }</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-c">${showData.date_end }</div>
	</div>
</div>

<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-a">강의시작시간</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-a">강의종료시간</div>
	</div>
</div>
<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-c">${showData.time_lect_start }</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-c">${showData.time_lect_end }</div>
	</div>
</div>

<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-a">실습시작시간</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-a">실습종료시간</div>
	</div>
</div>
<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-c">${showData.time_prtc_start }</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-c">${showData.time_prtc_end }</div>
	</div>
</div>

<div class="ui-grid-a">
	<div class="ui-block-a">
		<div class="ui-bar ui-bar-b">
			<s:if test='%{auth.isGroupAdmin(id)}'><a href="edit?id=${showData.id }&contents=${contentsCode }" class="artn-button board">수정</a></s:if>
			<s:elseif test='%{(hasLogin == true) && (auth.isGroupUser(id) == false)}'><a href="/groupuser/write?id_group=${showData.id }" class="artn-button board">가입</a></s:elseif>
		</div>
	</div>
	<div class="ui-block-b">
		<div class="ui-bar ui-bar-b">
			<s:if test='%{auth.isAdmin}'><a href="delete?id=${showData.id }&contents=${contentsCode }" class="artn-button board">삭제</a></s:if>
		</div>
	</div>
</div>            
            
<div class="ui-block">
	<div class="ui-bar ui-bar-a"><a href="list?contents=${contentsCode }" class="artn-button board">목록</a></div>
</div>            
            
</a:html>