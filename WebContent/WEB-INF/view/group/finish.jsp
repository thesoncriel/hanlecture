<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Create" contents="${contentsCode }">

<div class="article">
<h1>강의 개설 완료</h1>
<div class="ui-block">
    <div class="ui-bar ui-bar-c">${params.name }</div>
</div>
<div class="ui-block">
    <div class="ui-bar ui-bar-a"><a href="list?contents=${contentsCode }" class="artn-button board">목록</a></div>
</div> 
</div>
</a:html>