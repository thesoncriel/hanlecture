<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<s:if test="hasLogin">
	<%response.sendRedirect("/user/menu"); %>
</s:if>
<a:html title=" - 로그인" contents="sub900_1">
<script type="text/javascript">
$(document).ready(function(){
	$(".login").click(function(){
        var today = new Date();
        if($("#id_save").is(":checked") == true){
            today.setDate(today.getDate() + 365);
            document.cookie = "id_save="+$("#textbox_id").val()+"; path=/; expires="
                    + today.toGMTString() + ";";
        }else{
            today.setDate(today.getDate() + (-1));
            document.cookie = "id_save="+$("#textbox_id").val()+"; path=/; expires="
                    + today.toGMTString() + ";";
        }
    });
    
     function getId() {
            // userid 쿠키에서 id 값을 가져온다.
       var cook = document.cookie + ";";
       var idx = cook.indexOf("id_save", 0);
       var val = "";
       if (idx != -1) {
           cook = cook.substring(idx, cook.length);
           begin = cook.indexOf("=", 0) + 1;
           end = cook.indexOf(";", begin);
           val = unescape(cook.substring(begin, end));
       }

       // 가져온 쿠키값이 있으면
       if (val != "") {
           $("#textbox_id").val(val);
           $(".id_save_check").removeClass("ui-checkbox-off");
           $(".id_save_check").addClass("ui-checkbox-on");
           $("#id_save").attr("checked",true);
       }            
     }
     getId();
});
</script>
<div class="header">
	<br/><br/>
    <div id="breadcrumbs" data-sub="sub900_1"></div>
</div>
<div class="contents">
	<form action="/user/login" method="post">
		<div class="body">
			<div class="inner">
				<ul>
				    <li><input type="text" name="id" data-rule="id" maxlength="16" id="textbox_id" placeholder="아이디를 입력하세요" value="${loginId }" /></li>
				    <li><input type="password" name="pw" maxlength="16" id="textbox_pw" placeholder="비밀번호를 입력하세요"/></li>
				</ul>
				<div class="ui-grid-a">
					<div class="ui-block-a">
						<button type="submit" class="artn-button login" data-ajax="false">로그인</button>
					</div>
			     	<div class="ui-block-b">
						<div class="footer">				
							<div class="inner">
								<div class="options">
									<span><input type="checkbox" id="id_save" data-inline="none"><label class="id_save_check" for="id_save">아이디 저장</label></span>  
								</div>
							<s:if test="hasLoginError"><div class="error"><span class="artn-icon-32 alert"></span>${error.login }</div></s:if>
							</div>                         
						</div>
					</div>
				</div>
				<div class="ui-block">
				    <div class="ui-bar ui-bar-a"><a href="/user/find" class="artn-button board">패스워드 찾기</a></div>
				</div> 
				<%-- <div>
					browserName === <s:property value="#session.environment.browserName"/><br/>
					browserVersion === <s:property value="#session.environment.browserVersion"/><br/>
					osName === <s:property value="#session.environment.osName"/><br/>
					osVersion === <s:property value="#session.environment.osVersion"/><br/>
					osPlatform === <s:property value="#session.environment.osPlatform"/><br/>
					device === <s:property value="#session.environment.device"/><br/>
				</div>
				<s:property value="#session.environment.osPlatform"/>
				<s:if test="#session.environment.osPlatform == 'Mobile'">
					<input type="date"/>
				</s:if>
				<s:else>
					<input type="text" data-role="date"/>
				</s:else> --%>
					<%-- <a href="/user/join" class="artn-button board" data-role="button" data-theme="b">회원 가입하기</a> --%>				
			</div>
		</div>
	</form>
</div>

</a:html>