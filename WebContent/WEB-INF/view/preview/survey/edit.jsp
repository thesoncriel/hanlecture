<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - 설문지관리" contents="${contentsCode }">
<script>
	$(document).ready(function() {

		$("#button_surveyField").click(function() {
			var sQuestion = $(".createQuestion").html();
			$(".question").append(sQuestion);
			$("textarea[name='question_cont']").last().val("");
			$("input[name='question_item']").last().val("");
			$("textarea[name='question_cont']").last().attr("required","required");
            $("input[name='question_item']").last().attr("required","required");
            labelSurv();    
            deleteSurv();
		});
		
		$("#form_survey").submit(function(){
			$(".createQuestion").remove();
			$("input[name='seq']").each(function(index){
				$(this).val(index+1);
			});
		});
		
		function labelSurv(){
			$(".question>.deleteQuestion .questionLabel").each(function(index){
                $(this).text((index+1)+"번 문항");
            });
		};
		
		function deleteSurv(){
			$(".button_surveyDelete").click(function(){
	            $(this).parentsUntil(".deleteQuestion").parent().remove();
	            labelSurv();
	        });
		};
		
		deleteSurv();
	});
</script>
<div class="header">
	<h1>설문지 관리</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
	<div class="article">
		<form id="form_survey" action="modify" method="post"
			enctype="multipart/form-data" class="validator">
			<input type="hidden" value="${user.id }" name="id_writer" />
			<input type="hidden" value="${user.name }" name="writer_name" />
			<input type="hidden" value="${params.id_group }" name="id_group" />
			<s:if test="listIsNull == false">
				<input type="hidden" name="id" value="${listData[0].id }" />
			</s:if>
			<fieldset>
				<label for="question_opt">강의 형태</label>
				<s:select value="listData[0].question_opt" name="question_opt" list="#{'0':'공통','1':'이론','2':'실습'}" theme="simple"></s:select>				    
				<label for="work_type">업무형태</label> 
				    <input type="text" name="work_type" required="required" maxlength="10" value="preview" />
				<label for="work_type">평가 제한 시간(분단위 입력)</label>					    
					<input type="range" name="setTime" min="1" max="1000" value="60">				
				<div class="question">				
                    <!-- 수정 및 기본 표시되는 문항을 위한 DIV -->                    
	                    <div class="ui-corner-all custom-corners">
						  <div class="ui-bar ui-bar-a">
						    <label class="questionLabel">문제</label><input type="hidden" name="seq" required="required"/>
						  </div>
						  <div class="ui-body ui-body-a">
						  	<label for="question_cont">답</label>
						    <input type="text" id="question_cont" name="question_cont" required="required" value="${listData[0].question_cont }"/>						    
				            <input type="hidden" name="question_type" value="0"/>				                    
				            <input type="hidden" name="question_item" size="100" value="가,나,다,라,마"/>                         
						  </div>
						</div>                        
				</div>
			</fieldset>
			<div class="footer board">
				<div class="buttons">					
					<button id="button_submitSurveyField" type="submit"	class="artn-button board">입력완료</button>
				</div>
			</div>
		</form>
	</div>
</div>

</a:html>