<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - 설문지관리" contents="${contentsCode }">

<script>
$(document).ready(function(){
	$("#form_preview").submit(function(e){
		var jqItem = $(this).find(".item>ul");
		var iLen = jqItem.length;
		var bRet = false;
		
		var iLenChecked = jqItem.find("input:checked[type='radio']").length;
		
		bRet = iLen === iLenChecked;
		
		if (bRet === false){
			alert("모든 질문에 답하셔야 합니다.");
		}
		return bRet;
	});
});
</script>

<div class="header" align="center" style="font-family: '맑은고딕'" >
	<h1>평가 문제</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
	<div class="article" style="font-family: '나눔고딕'">
		<form id="form_preview" action="modify" method="post" enctype="multipart/form-data" class="validator">
		    <%--<ul data-role="listview" data-inset="true">
			    <li class="ui-field-contain">
			        <label>아이디/작성자</label>
			        ${listData[0].id_writer } / ${listData[0].writer_name }    
			    </li>
			    <li class="ui-field-contain">
			        <label>설문기간</label>
			        ${listData[0].date_start_fmt } ~ ${listData[0].date_end_fmt }    
			    </li>
			</ul> --%>
			<div class="item" style="font-family: '나눔고딕'">
				<s:iterator value="listData" status="s">
                    <ul data-role="listview" data-inset="true">
                        <li class="ui-field-contain">
                            <input type="hidden" value="${id_question }" name="id_question">
                            <input type="hidden" value="${question_type }" name="question_type">
                            <input type="hidden" value="${seq }" name="seq">
                            <label class="questionLabel">${seq }번 문항</label>                            
                        </li>
                        <li class="ui-field-contain">
                            <a:checkboxlist name="answer_int${seq }" list="${question_item }" type="radio" cssClass="survey_show" />
                        </li>
                    </ul>
                </s:iterator>
			</div>
			<input type="hidden" value="${listData[0].id_survey }" name="id_survey"> 
			<input type="hidden" value="${listData[0].id_group }" name="id_group"> 
			<input type="hidden" value="${listData[0].id_writer }" name="id_prof"> 
			<input type="hidden" value="${listData[0].writer_name }" name="prof_name">			
			<input type="hidden" value="${listData[0].subject }" name="subject">
			<input type="hidden" value="${listData[0].work_type }" name="work_type">
			
			<div class="footer board">
				<div class="buttons">
					<button class="artn-button board" type="submit">저장</button>
				</div>
			</div>
		</form>
	</div>
</div>

</a:html>