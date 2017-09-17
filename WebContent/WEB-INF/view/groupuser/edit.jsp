<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - 병원 회원 관리" contents="${contentsCode }">
<script type="text/javascript">
$(document).ready(function(){
	$(".searchId").click(function(){
		var sIdUser = $("#id_user").val();
		var sIdGroup = $(".id_group").val();
		$.post("/groupuser/show?json=true",{"id_group":sIdGroup,"id_user":sIdUser},function(textData){
			var data = $.parseJSON( textData );
		//});
		//$.getJSON("/groupuser/show?json=true",{"id_group":sIdGroup,"id_user":sIdUser},function(data){
			  if(data.hasOwnProperty("id") === false ){
				  $.getJSON("/user/show?json=true",{"id":sIdUser},function(data){
			            if(data["id"] !== undefined){
			                for(var sKey in data){
			                    if(sKey === "phone_mobi"){
			                        var saPhoneMobi = data[sKey].split("-");
			                        $("span.selectbox_phone").text(saPhoneMobi[0]);
			                        for(var i = 0; i < saPhoneMobi.length; i++){
			                            $("*[name='phone_mobi']").eq(i).val(saPhoneMobi[i]);
			                        }
			                    }else{
			                        $("li ."+sKey+"").val(data[sKey]);  
			                    }
			                }   
			            }
			            else{
			                alert("정보가 없습니다.");
			            }
			        });		  
			  }else{
				  alert("이미 등록된 수강생입니다.");
			  }	
		});
		
	});
});
</script>
<style>
ul li
{
    margin-left:-40px;
    list-style: none;
}
/* #phonebox_phone_mobi>div, */
#phonebox_phone_mobi input[type=text]
{
width:30%;
display: inline-table;
}
</style>
<div class="header">
	<h1>
		수강생
		<s:if test="showIsNull"> 등록</s:if>
		<s:else>수정</s:else>
	</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
	<div class="article">

		<form action="modify" method="post" enctype="multipart/form-data"
			class="validator">
			<fieldset>
				<ul class="board-edit">
						<li>
							<label for="autocomplete_id_user">아이디</label>
						</li>
						<li>
							<input type="text" id="id_user" name="id_user" value="${showData.id_user }" required="required" />
							<input type="button" class="searchId" value="검색"/>
						</li>
						<li>
							<label>이름</label>
						</li>
						<li>
							<input type="text" class="name" name="user_name" value="${showData.user_name }" readonly="readonly"/>
						</li>
						<li>
                            <label>학과</label>
                        </li>
                        <li>
                            <input type="text" class="introduce" name="group_name" value="${showData.group_name }" readonly="readonly"/>
                        </li>
                        <li>
                            <label>직급</label>
                        </li>
                        <li>
                            <s:select id="selectbox_auth_group_id" name="auth_group_id" value="showData.auth_group_id" headerKey="" headerValue="---선택하세요---" list="subData.userAuth" listKey="id" listValue="auth_user_kor" theme="simple" required="required" />
                        </li>
                        <li>
                            <label>핸드폰 번호</label>
                        </li>
                        <li>
                            <a:phone id="phonebox_phone_mobi" name="phone_mobi" value="${showData.user_phone_mobi }" type="phone_mobi" required="required"/>
                        </li>
                        <li>
                            <label>학년</label>
                        </li>
                        <li>
                            <input type="text" class="nick" name="nick" value="${showData.user_nick }" readonly="readonly"/>
                        </li>
                        <li>
                            <label>성별</label>
                        </li>
                        <li>
                            <input type="text" class="gender_kor" name="gender" value="${showData.user_gender_kor }" readonly="readonly"/>
                        </li>
				</ul>
				<s:if test="showIsNull == false">
					<input type="hidden" name="id" value="${showData.id }" />
					<input type="hidden" name="date_join"
						value="${showData.date_join }" />
				    <input type="hidden" name="opt" value="${showData.opt }"/>
				    <input type="hidden" name="comment" value="${showData.comment }"/>
				    <%-- <input type="hidden" name="auth_group_id" value="${showData.auth_group_id }"/> --%>
				    <input type="hidden" name="id_group" value="${showData.id_group }"/>
				</s:if>
				<s:else>
				    <%-- <input type="hidden" name="auth_group_id" value="${subData.userAuth[0].id }"/> --%>
				    <input type="hidden" class="id_group" name="id_group" value="${id_group }"/>
				</s:else>
			</fieldset>
			<div class="footer board">
				<div class="buttons">
					<button type="submit" class="artn-button board">
						<s:if test="showIsNull">작성</s:if>
						<s:else>수정</s:else>
						완료
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
</a:html>