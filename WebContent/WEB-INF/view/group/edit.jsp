<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 관리" contents="${contentsCode }">
<script>
	function select( jqSelector, args ){		
		if( jqSelector.val() === "0" ){
			$("fieldset .practice").hide();
			$("fieldset .theory").show();
			
			$("fieldset .practice").find("select, input").removeAttr("required");
            $("fieldset .theory").find("select, input").attr("required","required");
			initInput(args);
		}
		else if( jqSelector.val() === '1' ){
			$("fieldset .practice").show();
			$("fieldset .theory").hide();
			
			$("fieldset .practice").find("select, input").attr("required","required");
            $("fieldset .theory").find("select, input").removeAttr("required");
			initInput(args);
		}
		else if( jqSelector.val() === '2' ){
			$("fieldset .practice").show();
			$("fieldset .theory").show();
			
			$("fieldset .practice").find("select, input").attr("required","required");
            $("fieldset .theory").find("select, input").attr("required","required");
			initInput(args);
		}
	}
	
	function initInput( args ){
		try{
			var iLen = args.length;
			
			for(var i = 0; i < iLen; i++){
				$("#" + args[i]).val("");
			}
		} catch(e){}				
	}
	
	$(document).ready(function(){
		/* console.log($("#selectbox_lecture_div").val());
		if( $("#selectbox_lecture_div").val() === "1" ){
			$("fieldset .practice").hide();
			$("fieldset .theory").show();
		}
		else if( $("#selectbox_lecture_div").val() === '2' ){
			$("fieldset .practice").show();
			$("fieldset .theory").hide();
		}
		else if( $("#selectbox_lecture_div").val() === '3' ){
			$("fieldset .practice").show();
			$("fieldset .theory").show();
		} */		
		select( $("#selectbox_lecture_div") );		
		$("#selectbox_lecture_div").change(function(){
			select( $(this), ["textbox_lect_start", "textbox_lect_end", "textbox_prtc_start", "textbox_prtc_end"] );
			/* if( $(this).val() === '1' ){
				$("fieldset .practice").hide();
				$("fieldset .theory").show();
				
				$("#textbox_lect_start").val("");
				$("#textbox_lect_end").val("");
				$("#textbox_prtc_start").val("");
				$("#textbox_prtc_end").val("");
			}
			else if( $(this).val() === '2' ){
				$("fieldset .practice").show();
				$("fieldset .theory").hide();
				
				$("#textbox_lect_start").val("");
				$("#textbox_lect_end").val("");
				$("#textbox_prtc_start").val("");
				$("#textbox_prtc_end").val("");
			}
			else if( $(this).val() === '3' ){
				$("fieldset .practice").show();
				$("fieldset .theory").show();
				
				$("#textbox_lect_start").val("");
				$("#textbox_lect_end").val("");
				$("#textbox_prtc_start").val("");
				$("#textbox_prtc_end").val("");
			} */
		});
	});
</script>
<div class="header">
    <h1>강의 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
	<s:select list="#{'0':'이론','1':'실습','2':'이론/실습'}" id="selectbox_lecture_div" name="theory_practice" required="required" value="showData.theory_practice"/>	
<div>
	<label for="textbox_name">강의명</label>
	<input type="text" id="textbox_name" maxlength="16" name="name" required="required" value="${showData.name }"/>
</div>

<div class="theory">
	<label for="textbox_group1">이론 강의실 위치</label>
	<input type="text" id="textbox_group1" maxlength="16" name="address_group1" required="required" value="${showData.address_group1 }"/>
</div>

<div class="practice">
	<label for="textbox_group2">실습 강의실 위치</label>
	<input type="text" id="textbox_group2" maxlength="16" name="address_group2" value="${showData.address_group2 }"/>
</div>

<div>
	<label for="lect_code">강의코드</label>
	<input type="text" id="lect_code" maxlength="16" name="lect_code" required="required" value="${showData.lect_code }"/>
</div>

<div class="theory">
	<label for="lect_seq">이론 강의 순서(교시)</label>
	<s:select list="{'1','2','3','4','5','6','7','8','9'}" name="lect_seq" required="required" value="showData.lect_seq"/>
</div>
<%-- <input type="text" id="lect_seq" maxlength="16" name="lect_seq" data-role="num" required="required" value="${showData.lect_seq }"/> --%>

<div class="practice">
	<label for="prtc_seq">실습 강의 순서(교시)</label>
	<s:select list="{'1','2','3','4','5','6','7','8','9'}" name="prtc_seq" headerKey="0" headerValue="선택" value="showData.prtc_seq"/>
	<%-- <input type="text" id="prtc_seq" maxlength="16" name="prtc_seq" data-role="num" value="${showData.prtc_seq }"/> --%>
</div>
<div>
    <label for="nick">학년</label>
    <s:select list="{'1','2','3','4'}" id="nick" name="nick" value="showData.nick" theme="simple"></s:select>
</div>
<div>
	<label for="lect_score">학점</label>
	<s:select list="{'1','2','3'}" id="lect_score" name="lect_score" value="showData.lect_score" theme="simple"></s:select>
</div>
<div class="theory">
	<label for="weekly_lect">이론 강의 요일</label>
	<s:select list="{'월','화','수','목','금','토','일'}" id="weekly_lect" name="weekly_lect" value="showData.weekly_lect" theme="simple"></s:select>
</div>

<div class="practice">
	<label for="weekly_prtc">실습 강의 요일</label>
	<s:select list="{'월','화','수','목','금','토','일'}" headerKey="" headerValue="선택"  id="weekly_prtc" name="weekly_prtc" value="showData.weekly_prtc" theme="simple"></s:select>
</div>

<div>
	<label for="date_start">강의시작/종료날짜</label>
	<div class="ui-grid-a">
		<div class="ui-block-a">		
			<s:if test="#session.environment.osPlatform == 'Mobile'">
				<input type="date" id="datepicker_date_start" name="date_start" required="required" value="${showData.date_start }"/>
			</s:if>
			<s:else>
				<input type="text" data-role="date" id="datepicker_date_start" name="date_start" required="required" value="${showData.date_start }" data-year="2013" data-max-year="10">
			</s:else>			
		</div>
		<div class="ui-block-b">
			<s:if test="#session.environment.osPlatform == 'Mobile'">
				<input type="date" id="datepicker_date_end" name="date_end" required="required" value="${showData.date_end }"/>
			</s:if>
			<s:else>
				<input type="text" data-role="date" id="datepicker_date_end" name="date_end" required="required" value="${showData.date_end }" data-year="2013" data-max-year="10">
			</s:else>			
		</div>
	</div>
</div>

<div class="theory">
	<label for="time_lect_start">이론 강의 시작/종료시간</label>
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<input type="time" id="textbox_lect_start" maxlength="16" name="time_lect_start" data-role="num" value="${showData.time_lect_start }"/>
		</div>
		<div class="ui-block-b">
			<input type="time" id="textbox_lect_end" maxlength="16" name="time_lect_end" data-role="num" value="${showData.time_lect_end }"/>
		</div>
	</div>
</div>

<div class="practice">
	<label for="time_prtc_start">실습 강의 시작/종료시간</label>
	<div class="ui-grid-a">
		<div class="ui-block-a">
			<input type="time" id="textbox_prtc_start" maxlength="16" name="time_prtc_start" data-role="num" value="${showData.time_prtc_start }"/>
		</div>
		<div class="ui-block-b">
			<input type="time" id="textbox_prtc_end" maxlength="16" name="time_prtc_end" data-role="num" value="${showData.time_prtc_end }"/>
		</div>
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