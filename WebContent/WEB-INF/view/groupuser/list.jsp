<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html contents="${contentsCode }">
<script type="text/javascript">
$(document).ready(function(){
	$(".userDelete").click(function(){
		var iCnt = 0;
		$("input[type='checkbox']").each(function(){
			if($(this).attr("checked") == "checked"){
				iCnt++;
			}
		});
		if(iCnt > 0){
			var bMessage=confirm(iCnt+"명의 수강생을 삭제 하시겠습니까?");
			if (bMessage==true){
				var sParams = $("input[type='checkbox']").serialize();
				$.post("/groupuser/delete?ajax=true",sParams,function(data){
					if(data == "success"){
						alert("삭제되었습니다.");	
					}
					else if(data == "fail"){
						alert("삭제에 실패하였습니다.");
					}
					location.reload();
				});
			}
		}
	});
});
</script>
<style>
ul li input,
span.userEdit a
{
    display: inline-table;
}
.searchFrm div
{
    display: inline-table;
    width :50%;
}
.searchFrm div.ui-submit
{
    width: 20%;
}
</style>
<div class="header">
    <%-- <s:if test="contentsCode == 'sub100'"><h1>병원 회원 관리</h1></s:if>
    <s:else><h1>그룹 사용자 관리</h1></s:else> --%>
    <h1>수강생</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>    
            <ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
				data-filter-placeholder="Search Student... " data-filter-theme="c">
                <li data-theme="b" data-icon="plus">
                    <a href="write?id_group=${id_group }">추가</a>
				</li>
				<s:if test="listIsNull">
					<li>그룹사용자가 없습니다</li>
				</s:if>
				<s:else>
					<s:iterator value="listData">
						<li>
                            <a href="show?id=${id }">학번:${id_user }(이름:${user_name })</a><%-- <input type="checkbox" name="id" data-role="none" value="${id }"/> --%>
                            <a href="delete?id=${id }&id_group=${id_group }" data-icon="delete">삭제</a>
                        </li>
                    </s:iterator>
				</s:else>
            </ul>
</a:html>
