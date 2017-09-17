<%@tag import="artn.database.DBManager"%>
<%@tag import="artn.common.model.Environment"%>
<%@tag import="artn.common.model.Visitor"%>
<%@tag import="artn.common.manager.LoginManager"%>
<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="공통으로 쓰이는 html 바탕 구조" trimDirectiveWhitespaces="true" %>
<%@ attribute name="title" %>
<%@ attribute name="contents" %>
<%@ attribute name="innerClear" type="java.lang.Boolean" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%!
	public int getMenuNumber(String subValue){
	    try{
	    	String sValue = subValue.split("_")[0];
	        return Integer.parseInt( sValue.substring(3, sValue.length()) );
	    }
	    catch(Exception ex){
	        return 0;
	    }
	}
%>
<%
if ((contents != null) && (contents.equals("") == true)){
	//response.sendRedirect("/main");
	request.setAttribute("menu", 0);
}
else{
	request.setAttribute("menu", getMenuNumber(contents));
}

//사용자 접속정보 객체 등록부 [시작]
if(session.getAttribute("loginManager") == null){	
	request.getSession().setAttribute("loginManager", LoginManager.getInstance());
}
if(session.getAttribute("environment") == null){	
	Visitor visitor = new Visitor( request.getHeader("referer"), request.getRemoteAddr() );
	Environment environment = new Environment(request.getHeader("User-Agent"));
	DBManager dbm = null;
	
	visitor.readEnvironment(environment);
	
	if(session.getAttribute("id_user") == null){
		visitor.setIdUser("guest");
	}
	
	if(session.getAttribute("dbm") == null){
		dbm = new DBManager();
	}
	else{
		dbm = (DBManager)session.getAttribute("dbm");
	}
	
	session.setAttribute("visitor", visitor);
	session.setAttribute("environment", environment);
	session.setAttribute("dbm", dbm);
	visitor.doInsert( dbm );
}
//사용자 접속정보 객체 등록부 [종료]

response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, pre-check=0, post-check=0, max-age=0");
response.setHeader("Pragma", "no-cache, no-store");   
response.setDateHeader("Expires", 0);

if (request.getProtocol().equals("HTTP/1.1")){
	//response.setHeader("Cache-Control", "no-cache");
}

%>
<%--<s:bean name="artn.common.model.User" var="user"><s:property value="#session.user"/></s:bean> --%>
<s:set name="artn.common.model.User" var="user" value="#session.user"></s:set>
<!DOCTYPE html>
<html>
    <head> 
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta http-equiv="Expires" content="-1"> 
		<meta http-equiv="Pragma" content="no-cache"> 
		<meta http-equiv="Cache-Control" content="no-cache"> 
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <jsp:include page="/WEB-INF/include/title_css_script.htmlpart"/>
	</head>
    <body>
<%if((innerClear == null) || (innerClear == false)){ %>
        <input type="hidden" name="contents" value="${param.contents}"/>
        <input type="hidden" name="join" value="${param.join}"/>
        <input type="hidden" class="menu_selector" data-sub="${param.contents}"/>
        <div class="container">
            <div class="header">
				<div class="top-gnb" data-role="header" data-theme="b">
                    <jsp:include page="/WEB-INF/include/menu/gnb.jsp"/>
                </div>  
                <%-- <div class="nav top-menu">
                	<div data-role="navbar">
                		<ul>
	                        <s:if test ="#user.isAdmin == true">
	                        <li><a href="/admin">admin</a></li>
	                        </s:if>
	                        <s:if test="#user != null">                    
	                        	<li><a href="/user/show.action?id=${user.id }">My Page</a></li>
	                        </s:if>
	                        <s:if test='%{#user != null}'>
	                        	<li><a href="/logout">로그아웃</a></li>
	                        </s:if><s:else>
	                        	<li><a href="/login">로그인</a></li>
	                        </s:else>
                        </ul>
					</div>
                </div> --%>
            </div>
<div id="body">
<div class="contents-wrap" data-role="content">
<s:set var="menu">${menu }</s:set>
<s:if test="#menu > 0">	
	<div class="section contents">
		<jsp:doBody/>
	</div>	
</s:if>
<s:else>
	<div class="contents">
		<jsp:doBody/>
	</div>
</s:else>
</div>
</div>
<div id="footer" data-role="footer" data-position="fixed" class="footer-docs" data-theme="b">
   <jsp:include page="/WEB-INF/include/footer.jsp"/>
</div>
<div id="aside"><%--
<s:include value="/WEB-INF/include/browserClick.htmlpart"/>
<jsp:include page="/WEB-INF/include/browser.htmlpart" flush="true" /> --%>
</div>
</div>
<%} else { %><jsp:doBody/><%} %>
</body>
</html>