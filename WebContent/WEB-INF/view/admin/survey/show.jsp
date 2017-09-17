<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 설문지관리" contents="${contentsCode }">
<style>
.survey_show label{

/* 	vertical-align: top; */
}

</style>
<div class="header">
    <h1>설문지 관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form id="form_mediCheckField" action="edit" method="get" enctype="multipart/form-data" class="validator">

<input type="hidden" name="id" value="${listData[0].id }" />
<ul data-role="listview" data-inset="true">
    <li class="ui-field-contain">
        <label>아이디/작성자</label>
        ${listData[0].id_writer } / ${listData[0].writer_name }    
    </li>
    <li class="ui-field-contain">
        <label>설문시작 일시</label>
        ${listData[0].date_start_fmt }    
    </li>
    <li class="ui-field-contain">
        <label>설문종료 일시</label>
        ${listData[0].date_end_fmt }    
    </li>
    <li class="ui-field-contain">
        <label>사용여부</label>
        <s:if test="listData[0].opt == 1">
        사용
        </s:if>
        <s:if test="listData[0].opt == 0">
        사용안함
        </s:if>    
    </li>
</ul>
<h1 style="text-align: center;">${listData[0].subject }</h1>
<div class="item">
    <s:iterator value="listData">
        <ul data-role="listview" data-inset="true">
            <li class="ui-field-contain">
               <label class="questionLabel">${seq }번 문항</label>
               <textarea rows="" cols="" readonly="readonly">${question_cont }</textarea>
            </li>
            <s:if test="question_type == 0">
             <li class="ui-field-contain">
                <a:checkboxlist name="answer_int${seq }" list="${question_item }" type="radio" cssClass="survey_show" />
            </li>
            </s:if>
            <s:if test="question_type == 3">
           	<li>
				<input type="text" readonly="readonly" name="answer_text" />
			</li>
			</s:if>
           
        </ul>
     </s:iterator>
</div>

<!-- <div class="footer board">
	<div class="buttons">
		<button class="artn-button board" type="submit">수정</button>
	</div>
</div> -->
</form>
</div>
</div>

</a:html>