<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 사용자 목록" contents="${contentsCode }">
<style>
span {
	display: inline-block;
}
span.id {
	width: 200px;
}
</style>
	<div class="header">	
	    <h1>사용자 관리</h1>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>		
	</div>
	<div class="section">
		<div class="article">
			<%-- <ul data-role="listview" data-theme="c" data-dividertheme="c">
				<li data-role="list-divider"><span class="id">학번</span><span class="name">이름</span></li>
				<s:iterator value="listData">
				<li><a href="show?id=${id }&contents=${contentsCode }"><span class="id">${id }</span><span class="name">${name }</span></a></li>				
				</s:iterator>
				<li data-role="list-divider"><a data-role="button" data-theme="a" data-icon="check" href="write?contents=${contentsCode }" class="artn-button board">회원 추가</a></li>
			</ul> --%>
			
			<ul data-role="listview" data-split-icon="search" data-split-theme="d" data-filter="true" 
				data-filter-placeholder="Search User... " data-filter-theme="c">
				    <%-- <a href="#">등록</a> --%>
				<div class="ui-bar ui-bar-a"><a href="/user/write?contents=${contentsCode }" class="artn-button board" data-theme="b">수강생 등록</a></div>
				<li data-role="list-divider">
					<!-- <div class="ui-grid-a">
						<div class="ui-block-a">학번</div>
						<div class="ui-block-b">이름</div>												
					</div> -->
					<h2>학번</h2>
					<p>이름</p>
				</li>
				<s:iterator value="listData">
					<li data-theme="c" style="text-align: center; vertical-align: middle;">
						<%-- <a href="#"></a>
						<div class="ui-grid-a">					
							<div class="ui-block-a">${id }</div>
							<div class="ui-block-b">${name }</div>												
						</div>
						<a href="show?id=${id }&contents=${contentsCode }">정보보기</a> --%>
						<a href="show?id=${id }&contents=${contentsCode }">
							<h2>${id }</h2>
							<h2>${name }</h2>
						</a>
					</li>
				</s:iterator>
			</ul>
<%-- <table data-role="table" data-mode="reflow" style="width: 100%; text-align: center;">
<thead><tr>
<th class="row-num">번호</th>
<th>학번</th>
<th class="name">성명</th>
<th class="last">상세정보</th>
</tr></thead>

<tbody>
<s:if test="listIsNull">
<tr><td colspan="5">회원이 없습니다 ^^;</td></tr>
</s:if>
<s:else><s:iterator value="listData">
<tr>
<td><s:property value="row_number"/></td>
<td><s:property value="id"/></td>
<td><s:property value="name"/></td>
<td><a href="show?id=${id }&contents=${contentsCode }">정보 보기</a></td>
</tr>
</s:iterator></s:else>
</tbody>
</table> --%>
<%-- <div class="footer board" data-role="footer">
<div class="buttons">
	<a data-role="button" data-theme="a" data-icon="check" href="write?contents=${contentsCode }" class="artn-button board">회원 추가</a>
</div>
	<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
</div> --%>

<%-- <form action="list.action?contents=${param.contents }" method="post" class="board search">
	<!-- <label for="textbox_name">이름</label> -->		
       <input type="search" id="textbox_name" name="search_text" value="${param.search_text}"/>
       <!-- <input class="artn-button board" type="submit" value="검색" data-inline="true"/> -->
</form> --%>

</div>
</div>

</a:html>