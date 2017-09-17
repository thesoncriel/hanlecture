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
            labelSurv();    
            deleteSurv();
            changeSelectBox();
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
	
	
	function changeSelectBox(){
		$(".question_type").change(function(){
			$(this).prev("span").text($(this).children("option:selected").text());	
		});
	}
	
</script>
<div class="header">
	<h1>설문지 관리</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
	<div class="article">
		<form id="form_survey" action="modify" method="post"
			enctype="multipart/form-data" class="validator">
			<input type="hidden" value="${user.id }" name="id_writer" /> <input
				type="hidden" value="${user.name }" name="writer_name" />
			<s:if test="listIsNull == false">
				<input type="hidden" name="id" value="${listData[0].id }" />
			</s:if>
			<fieldset>
				<label for="subject">설문제목</label>
				    <input type="text" name="subject" size="100" value="${listData[0].subject }" required="required" />
				<label for="work_type">업무형태</label>
					<s:select value="listData[0].work_type" name="question_opt" list="#{'lectSurv':'강의평가'}" theme="simple"></s:select> 
				    <%-- <input type="text" name="work_type" required="required" maxlength="10" value="${listData[0].work_type }" />  --%>
				<label for="question_opt">강의 형태</label>
					<s:select value="question_opt" name="question_opt" list="#{'0':'공통','1':'이론','2':'실습'}" theme="simple"></s:select>
				<label for="date_start">설문일시</label>
				    <s:if test="#session.environment.osPlatform == 'Mobile'">
                        <input type="date" name="date_start" value="${listData[0].date_start_fmt }" id="datepicker_date_start" required="required" /> ~ <input required="required" type="date" name="date_end" value="${listData[0].date_end_fmt }" id="datepicker_date_end" />
	                </s:if>
	                <s:else>
	                   <input type="text" data-role="date" name="date_start" value="${listData[0].date_start_fmt }" id="datepicker_date_start" required="required" /> ~ <input required="required" data-role="date" type="text" name="date_end" value="${listData[0].date_end_fmt }" id="datepicker_date_end" />
	                </s:else>			
				<div class="question">
				 <!-- 문항 추가를 위한 DIV -->
				    <div class="createQuestion" style="display: none">
				        <div class="deleteQuestion">
				            <div class="ui-corner-all custom-corners">
                                <div class="ui-bar ui-bar-a">
		                            <label class="questionLabel">문항</label><input type="hidden" name="seq"/>
		                        </div>
		                        <div class="ui-body ui-body-a">
		                        <label for="question_type">선택종류</label>
		                        	<select class="question_type" name="question_type">
		                        		<option value="0">라디오버튼</option>
		                        		<option value="3">텍스트박스</option>
		                        	</select>
								
				                    <textarea rows="5" cols="90" name="question_cont"></textarea>
				                    <label>답변체크(답변은 , 로 불리해서 입력하시면 됩니다.)</label>
				                    <input type="text" name="question_item" size="100"/>
				                    <button class="button_surveyDelete" type="button">삭제</button>
				                </div>
				            </div>		        
				        </div>
                    </div>
                 <!-- 수정 및 기본 표시되는 문항을 위한 DIV -->
                    <div class="deleteQuestion">
	                    <div class="ui-corner-all custom-corners">
						  <div class="ui-bar ui-bar-a">
						    <label class="questionLabel">1번 문항</label><input type="hidden" name="seq" required="required"/>
						  </div>
						  <div class="ui-body ui-body-a">
						  <label for="question_type">선택종류</label>
							<select class="question_type" name="question_type">
		                        <option value="0">라디오버튼</option>
		                        <option value="3">텍스트박스</option>
		                    </select>
						    <textarea rows="5" cols="90" name="question_cont"
                             required="required">${listData[0].question_cont }</textarea>
                         <label>답변체크(답변은 , 로 불리해서 입력하시면 됩니다.)</label>
                         <input type="text" name="question_item"
                             size="100" value="${listData[0].question_item }"/>
                         <button class="button_surveyDelete" type="button">삭제</button>
						  </div>
						</div>
						
                   
                    </div>
                    <!-- 수정 화면에서 보여주기 위한 DIV -->
                    <s:subset source="listData" start="1">
                    <s:iterator status="list">
                        <div class="deleteQuestion">
                            <div class="ui-corner-all custom-corners">
                                <div class="ui-bar ui-bar-a">
	                               <label class="questionLabel">${list.index + 2 }번 문항</label><input type="hidden" name="seq" required="required"/>
	                            </div>
	                            <div class="ui-body ui-body-a">
	                            	<label for="question_type">선택종류</label>
	                            	<s:if test="question_type == 0">
										<select name="question_type">
			                        		<option selected="selected" value="0">라디오버튼</option>
			                        		<option value="3">텍스트박스</option>
			                        	</select>
		                        	</s:if>
		                        	<s:if test="question_type == 3">
										<select name="question_type">
			                        		<option value="0">라디오버튼</option>
			                        		<option selected="selected" value="3">텍스트박스</option>
			                        	</select>
		                        	</s:if>
	                             <textarea rows="5" cols="90" name="question_cont" required="required">${question_cont }</textarea>
	                             <label>답변체크(답변은 , 로 불리해서 입력하시면 됩니다.)</label>
	                             <input type="text" name="question_item" size="100"  value="${question_item }"/>
	                             <button class="button_surveyDelete" type="button">삭제</button>                            
	                            </div>
	                        </div>
                        </div>
                     </s:iterator>
                    </s:subset>
				</div>
			</fieldset>
			<div class="footer board">
				<div class="buttons">
					<button id="button_surveyField" class="artn-button board"
						type="button">추가</button>
					<button id="button_submitSurveyField" type="submit"
						class="artn-button board">입력완료</button>
				</div>
			</div>
		</form>
	</div>
</div>

</a:html>