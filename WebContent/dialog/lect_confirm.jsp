<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>팝업</title>
<!-- <script>
	$(document).ready(function(){
		$("#start").click(function(){			
			console.log("id_lect=" + $("input[name=\"id_lect\"]").val());
			console.log("lect_name=" + $("input[name=\"lect_name\"]").val());
			console.log("lect_seq=" + $("input[name=\"lect_seq\"]").val());
			$.post("/lecture/start", { "id_lect":$("input[name=\"id_lect\"]").val(), "lect_name":$("input[name=\"lect_name\"]").val(), "lect_seq":$("input[name=\"lect_seq\"]").val() }, function( data ){
				console.log("data=" + data);
			});
		});
	});
</script>-->
</head>
<body>
<div data-role="popup">
<form action="/lecture/start" method="post">
	<input type="text" name="id_lect" value="${param.id_lect }"/>
	<input type="text" name="lect_name" value="${param.lect_name }"/>
	<input type="text" name="lect_seq" value="${param.lect_seq }"/>
	<input type="text" name="start_end" value="start"/>
	<input type="text" name="lect_pw"/>
	<button id="start">확인</button>
</form>
	<a href="#" data-rel="back" data-btn="right" data-role="button" data-icon="delete" data-iconpos="notext">Close</a>
</div>
</body>
</html>