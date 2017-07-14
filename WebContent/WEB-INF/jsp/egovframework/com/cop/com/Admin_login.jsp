<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../cmm/directive.jsp" %><!-- common directive -->
    
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- jQuery -->
    <script src="/kywa_provoter/js/egovframework/com/cmm/jquery/jquery-1.11.3.min.js"></script>
    <!-- Bootstrap -->
    <link href="/kywa_provoter/js/egovframework/com/cmm/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
   
<title>로그인 페이지</title>
</head>
<body style="padding-left: 30px;">
            <form id="loginForm" name="loginForm" method="post" role="form">
                <h2 class="heading-title">
                    LOGIN
                </h2>
                <p class="form-row">
                    <input name="loginID" id="loginID" type="text" placeholder="Id">
                </p>
                <p class="form-row">
                    <input name="loginPW" id="loginPW" type="password" placeholder="Password">
                </p>
                <center>
                    <button onclick="adminLogin()" type="button" class="btn btn-success">LOGIN</button>  
                </center>   
            </form>
          <script>
          function adminLogin() {  
              // 파라미터 셋팅 
              var data = $("#loginForm").serialize();
          
              $.ajax({
                  type: 'post'
                  , url: 'login.do'
                  , dataType: 'json'
                  , data: data     
                  , success: function( rs ) {
                      if(rs.resultCode == "success") {
                          alert("로그인되었습니다.");
                          location.href = "/kywa_provoter/admin.do";
                      }
                      else if(rs.resultCode == "fail"){
                          alert("로그인 계정 정보가 다릅니다.");
                      }
                      else {
                    	  alert("로그인 요청을 실패 했습니다. 관리자에게 문의해주세요.");
                      }
                      
                  }
                  , error: function( response ) {
                      ajaxError( response );
                  }
              }); 
          }
          </script>
</body>

</html>