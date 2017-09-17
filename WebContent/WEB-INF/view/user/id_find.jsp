<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 사용자 목록" contents="sub900_2">
<script type="text/javascript">
$(document).ready(function(){
    $("#passwd_find").click(function(){
        var jqTag = $(".right_frm");
        var sPhone = jqTag.find("span.selectbox_phone").text()+"-"+jqTag.find("#phone_mobi1").val()+"-"+jqTag.find("#phone_mobi2").val();
        var sParams = {
                "json" : true,
                "id" : jqTag.find(".id").val(),
                "name" : jqTag.find(".name").val(),
                "phone_mobi" : sPhone,
                "email" : "master@artn.kr",
                "find" : true
        };
        $.getJSON("/user/findpassword",sParams,function(data){
        	if(data.code == "0"){
            	if($(this).attr("id") != "reconfirm"){
            		alert("가입 시 입력한 메일로 \n 암호가 전송되었습니다.");
            		location.replace("/user/login");
            	}
            }else if(data.code == "1"){
                alert(data.message);
                location.replace("/user/find");
            }
        });
    });
});

</script>
<div class="header">
    <h1>비밀번호 찾기</h1>
    <div id="breadcrumbs" data-sub="sub900_2"></div>
</div>
<div class="article">
   	   <div class="right_frm">
	   	   <div>
		       <label for="textbox_name">아이디</label>
		       <input type="text" class="id" name="id" required="required"/>
		   </div>
		   <div>
	           <label for="textbox_name">이름</label>
	           <input type="text" class="name" name="name" required="required"/>
	       </div>
	       <div>
	           <label for="phonebox_phone_mobi">핸드폰</label>
	           <a:phone id="phonebox_phone_mobi" name="phone_mobi" value="" type="phone_mobi" required="required"/>
	       </div>
	       <div class="footer board">
			    <div class="buttons">
			            <button type="submit" id="passwd_find" class="artn-button board">메일로 비밀번호 전송</button>
			    </div>
			</div>
       </div>
</div>

</a:html>