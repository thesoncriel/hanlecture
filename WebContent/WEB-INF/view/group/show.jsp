<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 정보" contents="${contentsCode }">
<script>
$(document).ready(function(){	
	if( $("#theory_practice").val() === "0" ){
		$("#show_theory").show();
		$("#show_practice").hide();		
	} else if( $("#theory_practice").val() === "1" ){
		$("#show_theory").hide();
		$("#show_practice").show();
	} else{
		$("#show_theory").show();
		$("#show_practice").show();
	}
});
</script>

<input type="hidden" id="theory_practice" value="${showData.theory_practice }"/>
<div class="header">
    <h1>강의 정보</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="ui-block">
    <s:if test='%{auth.isAdmin}'><div class="ui-bar ui-bar-a"><a href="/groupuser/list?id_group=${showData.id}&contents=${contentsCode }" class="artn-button board" data-theme="b">수강생 등록</a></div></s:if>
</div>  
<div class="ui-block">
	<div class="ui-bar ui-bar-a">
		<s:if test="showData.theory_practice == 0">
			이론
		</s:if>
		<s:elseif test="showData.theory_practice == 1">
			실습
		</s:elseif>
		<s:else>
			이론/실습
		</s:else>
	</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">강의명</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-e">${showData.name}</div>
</div>

<div class="ui-block">
	<div class="ui-bar ui-bar-a">강의코드</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.lect_code }</div>
</div>
<div class="ui-block">
    <div class="ui-bar ui-bar-a">학년</div>
</div>
<div class="ui-block">
    <div class="ui-bar ui-bar-c">${showData.nick } 학년</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-a">학점</div>
</div>
<div class="ui-block">
	<div class="ui-bar ui-bar-c">${showData.lect_score } 학점</div>
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


	<div id="show_theory">
		<div class="ui-grid-a">
			<div class="ui-block-a">
				<div class="ui-bar ui-bar-a">이론강의 순서</div>
			</div>
			<div class="ui-block-b">
				<div class="ui-bar ui-bar-a">이론강의실 위치</div>		
			</div>
		</div>
		<div class="ui-grid-a">
			<div class="ui-block-a">
				<div class="ui-bar ui-bar-c">${showData.lect_seq } 교시</div>
			</div>
			<div class="ui-block-b">
				<div class="ui-bar ui-bar-c">${showData.address_group1 }</div>
			</div>
		</div>
		
		<div class="ui-grid-a">
			<div class="ui-block-a">
				<div class="ui-bar ui-bar-a">이론강의 시작시간</div>
			</div>
			<div class="ui-block-b">
				<div class="ui-bar ui-bar-a">이론강의 종료시간</div>
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
		
		<div class="ui-block">
			<div class="ui-bar ui-bar-a">이론강의 요일</div>
		</div>
		<div class="ui-block">
			<div class="ui-bar ui-bar-c">${showData.weekly_lect }요일</div>
		</div>
	</div>
	
	
	<div id="show_practice">
		<div class="ui-grid-a">
			<div class="ui-block-a">
				<div class="ui-bar ui-bar-a">실습강의 순서</div>
			</div>
			<div class="ui-block-b">
				<div class="ui-bar ui-bar-a">실습강의실 위치</div>		
			</div>
		</div>
		<div class="ui-grid-a">
			<div class="ui-block-a">
				<div class="ui-bar ui-bar-c">${showData.prtc_seq } 교시</div>
			</div>
			<div class="ui-block-b">
				<div class="ui-bar ui-bar-c">${showData.address_group2 }</div>
			</div>
		</div>		
		
		<div class="ui-grid-a">
			<div class="ui-block-a">
				<div class="ui-bar ui-bar-a">실습강의 시작시간</div>
			</div>
			<div class="ui-block-b">
				<div class="ui-bar ui-bar-a">실습강의 종료시간</div>
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
		
		<div class="ui-block">
			<div class="ui-bar ui-bar-a">실습강의 요일</div>
		</div>
		<div class="ui-block">
			<div class="ui-bar ui-bar-c">${showData.weekly_prtc }요일</div>
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