<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${contentsCode }">
<script type="text/javascript">
$(document).ready(function(){
	$("input[name='id']").focusout(function(){
		$.getJSON("/user/show?json=true",{"id":$(this).val()},function(data){
			if(data.id !== undefined){
				alert("  이미 등록된 사용자 입니다. \n 다시 확인 해주시기 바랍니다.");
				$("input[name='id']").val("");
			}
		});
	});
	$("#textbox_pwre").keyup(function(){
		var sPw = $("#textbox_pw").val();
		var sPwre = $(this).val();
		if(sPw === sPwre){
			$(".pw_success").text("ok");
			$(".pw_success").css("color","green");
		}else{
			$(".pw_success").text("");
		}
	});
	$("#textbox_pwre").focusout(function(){
        var sPw = $("#textbox_pw").val();
        var sPwre = $(this).val();
        if(sPw !== sPwre){
        	$(".pw_success").text("패스워드가 일치 하지 않습니다.");
        	$(".pw_success").css("color","red");
        }
    });
});
</script>
<div class="header">
	<h1>사용자 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
	</div>

<div class="section">
<div class="article">

<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>


<s:if test="userEdit(1)">
<label for="file_img">사진</label>
<a:img src="/upload/user/img/${showData.file_img }" alt="회원 사진" srcNone="/img/none.png" altNone="회원 사진 없음 - 회원 등록 후 적용 됩니다." width="100" height="100" /><br/>
<a:file id="file_img" name="file_img" value="${showData.file_img }"/></s:if>

<s:if test="userEdit(11)">
<label for="selectbox_auth_user_id">사용자권한</label>
<s:select id="selectbox_auth_user_id" name="auth_user_id" list="subData.auth_list" headerKey="" headerValue="---선택하세요---" listKey="id" listValue="auth_user_kor" value="showData.auth_user_id" theme="simple" required="required"/> </s:if>

<s:if test="userEdit(2)">
<label for="textbox_id">아이디</label>
<s:if test="newUser">
<input type="text" id="textbox_id" class="user-name" maxlength="16" name="id" required="required" value="" title="영문, 숫자로 16자 이내로 입력 하세요. (작성 후 포커스 이동 시 ID 사용 가능 여부 자동 확인함)" /></s:if>
<s:else>
<input type="text" id="textbox_id" class="user-name" value="${showData.id }" disabled="disabled"/><input type="hidden" name="id" value="${showData.id }" /></s:else>
</s:if>

<s:if test="userEdit(3)">
<label for="textbox_name">이름</label>
<s:if test="newUser">
    <input type="text" id="textbox_name" class="user-name" maxlength="16" data-minlen="2" required="required" value="${showData.name }" title="한글로 성함을 입력 하세요." data-rule="kor" name="name" value=""/>
</s:if>
<s:else>
    <input type="text" id="textbox_name" class="user-name" maxlength="16" disabled="disabled" data-minlen="2" value="${showData.name }" title="한글로 성함을 입력 하세요." data-rule="kor"/>
    <input type="hidden" name="name" value="${showData.name }"/>
</s:else>

</s:if>

<s:if test="newUser">
	<s:if test="userEdit(4)">
	<label for="textbox_pw">비밀번호</label>
	<input type="password" id="textbox_pw" maxlength="16" name="pw" data-minlen="6" required="required" title="비밀번호를 입력 하세요. (최소 6글자)" />
	<label for="textbox_pwre">비밀번호 확인<span class="pw_success"></span></label>
	<input type="password" id="textbox_pwre" maxlength="16" name="pwre" required="required" title="위의 내용과 똑같이 입력 하세요." />
	<input type="hidden" name="newUser" value="1"/></s:if>
</s:if>
<s:else>
	<%--<s:if test="userEdit(4)">
	<label for="textbox_pwold">현재 비밀번호</label>
	<input type="password" id="textbox_pwold" maxlength="16" name="pwold" data-minlen="6" title="현재 비밀번호를 입력 하세요. (최소 6글자)" />
		<span class="alert">${showData.err_pwold }</span>
		</s:if>
	 --%>
	<s:if test="userEdit(4)">
	<label for="textbox_pw">새 비밀번호</label>
	<input type="password" id="textbox_pw" maxlength="16" name="pw" data-minlen="6" title="새 비밀번호를 입력 하세요. (최소 6글자)" />
	<label for="textbox_pwre">비밀번호 확인</label>
	<input type="password" id="textbox_pwre" maxlength="16" name="pwre" title="위의 내용과 똑같이 입력 하세요." /></s:if>
</s:else>
<s:if test="userEdit(16)">
<label for="textbox_introduce">학과</label>
<input type="text" disabled="disabled" value="${showData.introduce }" required="required"/>
<input type="hidden" name="introduce" value="${showData.introduce }" required="required"/>
</s:if>
<s:if test="userEdit(5)">
<label for="textbox_nick">학년</label>
<input type="text" id="textbox_nick" class="user-name" maxlength="16" data-minlen="3" disabled="disabled" value="${showData.nick }" title="학년을 입력 하세요." />
<input type="hidden" class="user-name" maxlength="16" data-minlen="3" name="nick" value="${showData.nick }" title="학년을 입력 하세요." />
</s:if>


<s:if test="userEdit(6)">
<label for="email1">이메일</label>
<a:email id="emailbox_email" name="email" value="${showData.email }" required="required"/></s:if>

<s:if test="userEdit(7)">
<label for="phone_home1">전화번호</label>
<a:phone id="phonebox_phone_home" name="phone_home" value="${showData.phone_home }"/>
</s:if>

<s:if test="userEdit(8)">
<label for="phone_mobi1">휴대폰번호</label>
<a:phone id="phonebox_phone_mobi" name="phone_mobi" value="${showData.phone_mobi }" type="phone_mobi" required="required"/>
<%-- <input type="text" name="phone_mobi" value="${showData.phone_mobi }"/> --%>
</s:if>

<s:if test="userEdit(9)">
<label for="datepicker_date_birth">생년월일</label>
<input type="text" data-role="date" name="date_birth" required="required" value="${showData.date_birth }" data-year="1950" title="생년월일을 입력 하세요. (클릭)" /></s:if>

<s:if test="userEdit(10)">
<label for="gender">성별</label>
<s:radio id="gender" name="gender" list="#{'m':'남자','w':'여자'}" value="showData.gender" theme="simple" /></s:if>

<%-- 
<s:if test="userEdit(12)">
<label for="textbox_zipcode_home">우편번호</label>
<input type="text" id="textbox_zipcode_home" class="zipcode" name="zipcode_home" maxlength="7" data-rule="zipcode" data-to="#textbox_address_home1" data-tonew="#textbox_address_home_new" value="${showData.zipcode_home }" title="거주하는 곳의 우편번호를 선택하세요. (클릭)"/></s:if>

<s:if test="userEdit(13)">
<label for="textbox_address_home2" class="address">주소</label>
<label for="textbox_address_home1" class="address">지 번</label> <input type="text" id="textbox_address_home1" class="address" name="address_home1" value="${showData.address_home1 }" maxlength="100" title="우편번호 선택 시 자동으로 입력 됩니다. (클릭)"/><br/>
	<label for="textbox_address_home_new" class="address">도로명</label> <input type="text" id="textbox_address_home_new" class="address" name="address_home_new" value="${showData.address_home_new }" maxlength="100" title="새주소(도로명 주소)를 입력하세요. (클릭)"/><br/>
	<label for="textbox_address_home2">상 세</label>: <input type="text" id="textbox_address_home2" class="address" name="address_home2" value="${showData.address_home2 }" maxlength="100" title="상세 주소를 입력 하세요."/>
	</s:if>
	
<s:if test="userEdit(14)">
<label>추가 정보</label>
<a:checkboxlist name="opt" list="옵션1,옵션2,옵션3,옵션4,옵션5" value="${showData.opt }" /> </s:if>

<s:if test="userEdit(15)">
<label>회원 상태</label>
<a:checkboxlist name="status_user" list="신청중,가입됨,이름 비공개,자기소개 비공개" value="${showData.status_user }" /> ※ 아무것도 체크되어 있지 않다면 익명 사용자</s:if>

 --%>
<%--숨김 필드 모음--%>
<input type="hidden" name="status_user" value="2"/>
<s:if test="showIsNull == false">
<input type="hidden" name="date_join" value="${showData.date_join }"/>
</s:if>
<s:if test='%{(showIsNull) && auth.isGroupAdmin}'>
<input type="hidden" name="comboGroup" value="true"/>
</s:if>
</fieldset>
<div class="footer board">
	<div class="buttons">
		<button type="submit" class="artn-button board"><s:if test="newUser">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
</form>
</div>
</div>
</a:html>