<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 관리" contents="${contentsCode }">
<div class="header">
    <h1>강의 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>

<label for="textbox_name">강의명</label>
<input type="text" id="textbox_name" maxlength="16" name="name" required="required" value="${showData.name }"/>

<label for="textbox_group1">강의실 위치</label>
<input type="text" id="textbox_group1" maxlength="16" name="address_group1" required="required" value="${showData.address_group1 }"/>

<label for="textbox_group2">실습실 위치</label>
<input type="text" id="textbox_group2" maxlength="16" name="address_group2" required="required" value="${showData.address_group2 }"/>

<label for="lect_code">강의코드</label>
<input type="text" id="lect_code" maxlength="16" name="lect_code" required="required" value="${showData.lect_code }"/>

<label for="lect_seq">강의순서</label>
<input type="text" id="lect_seq" maxlength="16" name="lect_seq" data-role="num" required="required" value="${showData.lect_seq }"/>

<label for="prtc_seq">실습순서</label>
<input type="text" id="prtc_seq" maxlength="16" name="prtc_seq" data-role="num" required="required" value="${showData.prtc_seq }"/>

<label for="lect_score">학점</label>
<s:select list="{'1','2','3'}" id="lect_score" name="lect_score" value="showData.lect_score" theme="simple"></s:select>

<label for="weekly_lect">강의요일</label>
<s:select list="{'월','화','수','목','금','토','일'}" id="weekly_lect" name="weekly_lect" value="showData.weekly_lect" theme="simple"></s:select>

<label for="weekly_prtc">실습요일</label>
<s:select list="{'월','화','수','목','금','토','일'}" id="weekly_prtc" name="weekly_prtc" value="showData.weekly_prtc" theme="simple"></s:select>

<label for="date_start">강의시작/종료날짜</label>
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<input type="text" id="datepicker_date_start" name="date_start" required="required" value="${showData.date_start }" data-year="2013" data-max-year="10" class="hasDatepicker">
		</div>
		<div class="ui-block-b">
			<input type="text" id="datepicker_date_start" name="date_end" required="required" value="${showData.date_end }" data-year="2013" data-max-year="10" class="hasDatepicker">
		</div>
	</div>

<label for="time_lect_start">강의시작/종료시간</label>
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<input type="time" id="textbox_name" maxlength="16" name="time_lect_start" data-role="num" required="required" value="${showData.time_lect_start }"/>
		</div>
		<div class="ui-block-b">
			<input type="time" id="textbox_name" maxlength="16" name="time_lect_end" data-role="num" required="required" value="${showData.time_lect_end }"/>
		</div>
	</div>

<label for="time_prtc_start">실습시작/종료시간</label>
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<input type="time" id="textbox_name" maxlength="16" name="time_prtc_start" data-role="num" required="required" value="${showData.time_prtc_start }"/>
		</div>
		<div class="ui-block-b">
			<input type="time" id="textbox_name" maxlength="16" name="time_prtc_end" data-role="num" required="required" value="${showData.time_prtc_end }"/>
		</div>
	</div>

<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id" value="${showData.id }"/>
<input type="hidden" name="group_type" value="32"/>
</s:if>

</fieldset>

<div class="footer board">
	<div class="buttons">
			<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
<input type="hidden" name="contents" value="${contentsCode}"/>
</form>
</div>
</div>

</a:html>