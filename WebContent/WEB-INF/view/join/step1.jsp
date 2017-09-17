<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 회원 가입" contents="sub901_1">


	<div class="header">
		<h1>회원 가입 - 약관확인</h1>
	    <div id="breadcrumbs" data-sub="*회원가입,약관확인"></div>
	</div>
	

<div class="section">
<div class="article member-join step1">
<div class="hgroup artn-bg-64 step3">
    <h2 class="selected">1. 약관동의</h2>  
    <h2>2. 회원정보 입력</h2>
    <h2>3. 가입완료</h2>
</div>
<form action="join?step=2" method="post" class="validator">
<fieldset>
<input type="checkbox" id="toc1" name="term_of_condition" required="required" title="동의 하시면 체크 하십시요." /> <label for="toc1">이용약관에 동의합니다.(필수)</label>
<input type="checkbox" id="toc3" name="term_of_condition" required="required" title="동의 하시면 체크 하십시요." /> <label for="toc3">개인정보 수집 및 이용에 동의합니다.(필수)</label>
</fieldset>
	<div class="footer board">
		<div class="buttons">
			<button type="submit" data-rendering="anchor" class="artn-button board">다음</button>
		</div>
	</div>
</form>

</div>
</div>
</a:html>