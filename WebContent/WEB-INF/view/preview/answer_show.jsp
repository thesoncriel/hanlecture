<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 평가 현황" contents="${contentsCode }">
<script>
	$(document).ready(function(){
		$(".answer").each(function(){
			answer = $(this).children("h3").children("span").text();
			$($(this).nextAll("div")).each(function(){
				answerT = $(this).children("h2").text();
				answerT = answerT.charAt(answer);		
				if(answer === answerT){
					$(this).children("h2").children("a").css("color","red");
				}
			});
		});
	});
</script>
<div class="header">
    <h1>평가 현황</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>

<div data-role="collapsible-set" data-theme="a" data-inset="false">	
	<s:iterator value="listData">
			<div class="answer">
				<h3>총 인원 : ${listData[0].attend_count} 명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;정답: <span style="color: red;">${question_cont }</span></h3>
			</div>
			<div data-role="collapsible">
				<h2 style="color:red;">가 ${a }</h2>				
				<ul data-role="listview">
					<li data-role="list-divider">						
						<s:if test="name1==null">
							없음
						</s:if>
						<s:else>
							${name1 }
						</s:else>
					</li>
				</ul>
			</div>	
			<div data-role="collapsible">
				<h2>나 ${b }</h2>				
				<ul data-role="listview">
					<li data-role="list-divider">
						<s:if test="name2==null">
							없음
						</s:if>
						<s:else>
							${name2 }
						</s:else>
					</li>
				</ul>
			</div>
			<div data-role="collapsible">
				<h2>다 ${c }</h2>				
				<ul data-role="listview">
					<li data-role="list-divider">
						<s:if test="name3==null">
							없음
						</s:if>
						<s:else>
							${name3 }
						</s:else>
					</li>
				</ul>
			</div>
			<div data-role="collapsible">
				<h2>라 ${d }</h2>				
				<ul data-role="listview">
					<li data-role="list-divider">
						<s:if test="name4==null">
							없음
						</s:if>
						<s:else>
							${name4 }
						</s:else>
					</li>
				</ul>
			</div>
			<div data-role="collapsible">
				<h2>마 ${e }</h2>				
				<ul data-role="listview">
					<li data-role="list-divider">
						<s:if test="name5==null">
							없음
						</s:if>
						<s:else>
							${name5 }
						</s:else>
					</li>
				</ul>
			</div>
			<div>
				<h5>무응답 ${noanswer }</h5>
			</div>			
	</s:iterator>
</div>
<ul data-role="listview">
	<s:if test="listIsNull"></s:if>
	<s:else>
		<li><a href="excel?id_survey=${param.id_survey }&id_group=${param.id_group }&id_prof=${id_prof }&date_upload=${date_upload }" data-ajax="false">결과표 다운로드</a></li>
	</s:else>
		<li><a href="answerlist?contents=${contentsCode }&id_group=${param.id_group }">목록</a></li>
</ul>   
     
</a:html>