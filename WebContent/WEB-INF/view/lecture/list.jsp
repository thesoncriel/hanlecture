<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 목록" contents="${contentsCode }">
<script>
	$(document).ready(function (){
		$(".attendence_start").click(function(){
			var sMsg = prompt("교수님께서 말씀하신 암호를 입력해 주세요");
			if(sMsg != null && sMsg != "" && sMsg.length > 0){
				$.ajax({
				    type : 'POST',
				    url : "/lecture/confirm",
				    data : {
				    		"id_lect" : $("input[name=\"id_lect\"]").val()
				    		,"lect_code" : $("input[name=\"lect_code\"]").val()
				    		,"lect_name" : $("input[name=\"lect_name\"]").val()
				    		,"lect_seq" : $("input[name=\"lect_seq\"]").val()
				    		,"date_lect" : $("input[name=\"date_lect\"]").val() 
				    		,"id_student" : $("input[name=\"id_student\"]").val() 
				    		,"student_name" : $("input[name=\"student_name\"]").val()
				    		,"student_dept" : $("input[name=\"student_dept\"]").val()
				    		,"lect_pw" : sMsg
				    		,"id_prof": $(this).next("input[type='hidden']").val()
				    		},
				    success : function (data) {
				    	if(data.split("|")[0] == "1"){
				    		alert(data.split("|")[1]);
				    	}else if(data.split("|")[0] == "2"){
				    		alert(data.split("|")[1]);
				    	}else if(data.split("|")[0] == "3"){
				    		alert(data.split("|")[1]);
				    	}else{
				    		alert(data.split("|")[1]);
				    	}
				    }
				});
			}else{
				alert("암호를 입력주세요");
			}
		});	
		$(".lect_start").click(function(){
			var iPractice = 1;
			if( $(this).data("practice") === true){
				iPractice = 2;
			}
			
			var sMsg = prompt("학생들에게 불러준 암호를 입력하세요");
				
			if(sMsg !== null && sMsg.length > 0){
				$.post("/lecture/start", { "id_lect":$("input[name=\"id_lect\"]").val()
											,"lect_name":$("input[name=\"lect_name\"]").val()
											,"lect_seq":$("input[name=\"lect_seq\"]").val()
											,"lect_pw":sMsg, "start_end":"start"
											,"is_practice":iPractice
											,"id_prof":$("input[name=\"id_student\"]").val()
											,"prof_name":$("input[name=\"student_name\"]").val()
											},
				function( data ){
					
					if(data.split("|")[0] == "1"){
						alert(data.split("|")[1]);
			    	}else if(data.split("|")[0] == "2"){
			    		alert(data.split("|")[1]);				    		
			    	}else{
			    		alert("오류가 발생하였습니다.");
			    	}
				});
			} else if(sMsg === null){
				alert("취소 되었습니다.");
			} else if(sMsg === ""){
				alert("비밀번호를 입력해 주세요");
			}
			return false;		
		});
		$("#lect_end").click(function(){					
				$.post("/lecture/end", { "id_lect":$("input[name=\"id_lect\"]").val()
										,"lect_name":$("input[name=\"lect_name\"]").val()
										,"lect_seq":$("input[name=\"lect_seq\"]").val()
										,"lect_code":$("input[name=\"lect_code\"]").val()
										,"start_end":"end"
										,"id_prof":$("input[name=\"id_student\"]").val()
										,"prof_name":$("input[name=\"student_name\"]").val()
										},
				function( data ){					
					if(data.split("|")[0] == "1"){							
						alert(data.split("|")[1]);
			    	}else if(data.split("|")[0] == "2"){
			    		alert(data.split("|")[1]);				    		
			    	}else{
			    		alert(data.split("|")[1]);
			    	}
				});
				return false;				 
		});
		// 엑셀 출력부 원터치로 변경 - 2014.02.24 by jhson [시작]
		$("#anchor_attdExcel").click(function(){
			var jqThis = $(this);

			$.mobile.loading("show", {
				text: "잠시만 기다려주세요",
				textVisible: true,
				theme: "z"
			});
			$.post( jqThis.data("before-action"), function(data){				
				if(data.split("|")[0] == "0"){							
					//alert(data.split("|")[1]);
					$.mobile.loading("hide");	
					location.href = ( jqThis.attr("href") );
		    	}				    		
		    	else{
		    		alert("오류가 발생하여 파일 다운로드가 불가 합니다.\r\n서버 상태를 확인하여 주십시요.");
		    	}				
			});			
			return false;
		});
		// 엑셀 출력부 원터치로 변경 - 2014.02.24 by jhson [종료]
<%--
/*		
		$("#anchor_attdMakeSheet").click(function(){
			$.mobile.loading("show", {
				text: "잠시만 기다려주세요",
				textVisible: true,
				theme: "z"
			});
			$.post($(this).attr("href"), function(data){				
				if(data.split("|")[0] == "0"){							
					alert(data.split("|")[1]);
					$.mobile.loading("hide");					
		    	}				    		
		    	else{
		    		alert("오류가 발생하였습니다.");
		    	}				
			});			
			return false;
		});
*/--%>
	});
	
</script>

<input type="hidden" name="id_lect" value="${listData[0].id }" />
<input type="hidden" name="lect_code" value="${listData[0].lect_code }" />
<input type="hidden" name="lect_name" value="${listData[0].name }" />
<input type="hidden" name="lect_seq" value="${listData[0].lect_seq }" />
<input type="hidden" name="date_lect" value="${listData[0].time_lect_start }" />
<input type="hidden" name="id_student" value="${user.id }" />
<input type="hidden" name="student_name" value="${user.name }" />
<input type="hidden" name="student_dept" value="${user.introduce }" />
<div class="header">
	<h3></h3>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div> 
	<s:if test="auth.menu(3)">
		<ul data-role="listview" data-split-icon="check" data-split-theme="d">
			<li data-role="list-divider">${listData[0].name }</li>
			<li>※ 출석 시작을 눌러주세요(학생들에게 불러줄 암호 입력)</li>
			<%-- <li><a href="#" class="lect_start">출석 시작[이론]</a></li>
			<li><a href="#" class="lect_start" data-practice="true">출석 시작[실습]</a></li> --%>
			<s:if test="listData[0].theory_practice == 0 || listData[0].theory_practice == 2">
				<li><a href="#" class="lect_start">출석 시작[이론]</a></li>
			</s:if>
			<s:if test="listData[0].theory_practice == 1 || listData[0].theory_practice == 2">
				<li><a href="#" class="lect_start" data-practice="true">출석 시작[실습]</a></li>
			</s:if>
			<li><a href="#" id="lect_end">출석 종료</a></li>
			<li><a href="anyAttend?id_group=${id }">임의 출석(스마트폰이 없는 학생)</a></li>
			<li><a href="attendance?id_lect=${id }&id_prof=${user.id }">출석 현황</a></li>
			<%--<li><a id="anchor_attdMakeSheet" href="/attdResult/makeSheet?id_lect=${id }&result_word=">출석 현황 집계(Excel)</a></li> --%>
			<li><a id="anchor_attdExcel" href="/attdResult/excel?id_lect=${id }" data-before-action="/attdResult/makeSheet?id_lect=${id }&result_word=" data-ajax="false">출석 현황 출력(Excel)</a></li>
			<li><a href="/lectureEvaluation/answer_list?id_lect=${id }">강의 평가 이력</a></li>
			<li data-role="list-divider">사전지식 평가</li>
			<li><a href="/preview/answerlist?id_group=${id }">지식평가 현황</a></li>
			<li><a href="/preview/survey/list?id_group=${id }">지식평가 문제 작성</a></li>			
		</ul>
	</s:if>
	<s:if test="auth.menu(4)">
		<ul data-role="listview" data-split-icon="check" data-split-theme="d">
			<li data-role="list-divider">${listData[0].name }</li>
			<li>※ 출석을 눌러주세요(교수님에게 받은 암호 입력)</li>
			<s:iterator value="subData.lectureList">
				<li>
					<a href="#" class="attendence_start">출석 (${prof_name } 교수님)</a>
					<input type="hidden" value="${id_prof }"/>
				</li>
			</s:iterator>
			<li><a href="attendance?id_lect=${id }&id_student=${user.id }">출석 현황</a></li>
			<li data-role="list-divider">평가</li>
			<li><a href="/lectureEvaluation/list?id_lect=${id }">강의 평가</a></li>
			<li><a href="/preview/list?id_group=${id }">문제 풀기</a></li>
		</ul>
	</s:if>	
</a:html>