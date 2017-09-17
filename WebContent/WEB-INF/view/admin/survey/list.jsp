<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html contents="${contentsCode }">

<div class="header">
    <h1>문제지 관리</h1>
</div>    
    <div class="section">
        <div class="article">
            <ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
                data-filter-placeholder="Search Student... " data-filter-theme="c">
                <li data-theme="b" data-icon="plus">
                    <a href="write?id_group=${param.id_group }">추가</a>
                </li>
                <s:if test="listIsNull">
                        <li>설문이 없습니다</li>
                </s:if>
                <s:else>
                <s:iterator value="listData">
                    <li>
                        <a href="show?id=${id }">${subject }(${date_upload_fmt })</a>
                        <a href="delete?id=${id }" data-icon="delete">삭제</a>
                    </li>
                </s:iterator>
                </s:else>
            </ul>

            <%-- <div class="footer board">
                <a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
            </div> --%>
        </div>
    </div>
</a:html>
