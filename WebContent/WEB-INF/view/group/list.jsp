<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 목록" contents="${contentsCode }">
<div class="header">
	<s:if test="lect">
	    <h1>강의 시작</h1>
	</s:if>
	<s:else>
		<h1>강의 목록</h1>
	</s:else>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div> 
	<ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
	data-filter-placeholder="Search Lecture... " data-filter-theme="c">
				<li>
					※강의를 선택해 주세요
				</li>
		<s:if test="lect">
			<s:iterator value="listData">
				<li data-theme="e" >
					<a href="/lecture/list?id=${id_group }">${group_name }</a>
				</li>
			</s:iterator>
		</s:if>
		<s:elseif test="attendance">
		    <s:iterator value="listData">
                <li data-theme="e" >
                    <a href="/lecture/list?id=${id_group }">${group_name }</a>
                </li>
            </s:iterator>
		</s:elseif>
		<s:elseif test="survey">
            <s:iterator value="listData">
                <li data-theme="e" >
                    <a href="/lecture/list?id=${id_group }">${group_name }</a>
                </li>
            </s:iterator>
        </s:elseif>
		<s:else>
			<s:iterator value="listData">
				<li data-theme="e">
					<a href="show?id=${id_group }">${group_name }</a>
				</li>
			</s:iterator>
		</s:else>
		<s:if test='%{auth.isAdmin}'>
			<li data-theme="b" data-icon="star"><a href="write">강의 추가</a></li>
		</s:if>
			<%-- <li><a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" /></li> --%>
	</ul>
<%-- <div data-role="ui-block">
	<s:include value="/WEB-INF/include/search/group.jsp"></s:include>
</div> --%>

</a:html>