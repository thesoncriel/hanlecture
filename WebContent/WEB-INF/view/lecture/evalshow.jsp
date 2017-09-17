<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 강의 평가 정보" contents="${contentsCode }">
<div class="header">
    <h1>강의 정보</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>

<ul data-role="listview">
	<li>출석한 총 인원 : ${listData[0].attend_count} 명</li>
	<s:iterator value="listData">
		<li data-role="list-divider">${question_cont }</li>
		<li>
			<div class="ui-grid-a">
				<div class="ui-block-a">가.매우 그렇다</div>
				<div class="ui-block-b">${a }</div>
			</div>
			<div class="ui-grid-a">
				<div class="ui-block-a">나.대체로 그렇다</div>
				<div class="ui-block-b">${b }</div>
			</div>      
			<div class="ui-grid-a">
				<div class="ui-block-a">다.보통이다</div>
				<div class="ui-block-b">${c }</div>
			</div>  
			<div class="ui-grid-a">
				<div class="ui-block-a">라.그렇지 않다</div>
				<div class="ui-block-b">${d }</div>
			</div>  
			<div class="ui-grid-a">
				<div class="ui-block-a">마.전혀 그렇지 않다</div>
				<div class="ui-block-b">${e }</div>
			</div>
			<div class="ui-grid-a">
				<div class="ui-block-a">-무응답-</div>
				<div class="ui-block-b">${noanswer }</div>
			</div>    
			<div class="ui-grid-a">
				<div class="ui-block-a"><b>평점</b></div>
				<div class="ui-block-b"><b>(5점 만점) ${rating_avg }</b></div>
			</div>   
		</li>
	</s:iterator>
		<li data-role="list-divider">${subData.commentList[0].quest_say }</li>
		<s:iterator value="subData.commentList">
			<li>&nbsp;${quest_answer }</li>
		</s:iterator>
	<s:if test="listIsNull"></s:if>
	<s:else>
		<li><a href="excel?id_sum_prof=${param.id_sum_prof }&id_lect=${param.id_lect }" data-ajax="false">결과표 다운로드</a></li>
	</s:else>
		<li><a href="answer_list?contents=${contentsCode }&id_lect=${param.id_lect }">목록</a></li>
</ul>      
            
</a:html>