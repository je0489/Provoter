<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>▒ 청소년활동 안전 확인 홍보대사 투표 ▒</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="/kywa_provoter/js/egovframework/com/cmm/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/kywa_provoter/css/egovframework/com/common.css">

</head>
<body ondragstart="return false" onselectstart="return false">
    <img class="background" src="/kywa_provoter/images/egovframework/com/cop/com/main/top.png" usemap="#link" >
    <div class="app-contents">
        <div class="linkURL">
            <a href="" onclick="copy_linkURL(this.href); return false;">
                <button class="link-btn">
                    <img src="/kywa_provoter/images/egovframework/com/cop/com/main/linkButton.png" class="linkbut">
                </button>
            </a>
        </div>
    <div class = "top5Contents topPadding">
        <img class="top5Sign" src="/kywa_provoter/images/egovframework/com/cop/com/main/TOP5.png" >
        <div class="stats-vote-pan">
           <F1>TODAY - </F1>
           <F1 class="today"> ${today} </F1>    
           <F1> 명 | TOTAL -  ${total} 명</F1>    
        </div>
     </div>
    <div class = "top5Contents topPadding">
        <div class = "imageSize TOP1">
            <img class="top-crown" src="/kywa_provoter/images/egovframework/com/cop/com/main/TOP1.png">
        </div>
    </div>
    
     <div class = "top5Contents bottomPadding">
        <c:choose>
            <c:when test="${empty top5List}">
                <c:forEach var="top5" begin="1" end="5" varStatus="status">
                    <div class = "imageSize TOP5">
                        <img src="/kywa_provoter/images/egovframework/com/cop/com/main/NO${status.count}.png" class="radius top5Border" alt="${top5}위는 결정되지 않았습니다."/> 
                    </div> 
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:forEach var="top5"  items="${top5List}" varStatus="status">
                    <div class = "imageSize TOP5">
                            <img src="/kywa_provoter/imgView.do?filename=${top5.PHOTO_PATH}" class="radius top5Border"  title="${status.count}위는 ${top5.NAME}입니다" alt=" ${status.count}위는 ${top5.NAME}입니다" onerror="this.src='/kywa_provoter/images/egovframework/com/cop/com/main/NO4.png'" /> 
                    </div>
                    <c:if test="${status.last}">
                        <c:forEach var="top5" begin="${status.count+1}" end="5" varStatus="status1">
                            <div class = "imageSize TOP5">
                            <img src="/kywa_provoter/images/egovframework/com/cop/com/main/NO${status1.count}.png" alt="${top5}위는 결정되지 않았습니다." class="radius top5Border"/>   
                            </div> 
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    
    <div class = "applicantContents applicantTopPadding">
        <Img class="applicantSign" src="/kywa_provoter/images/egovframework/com/cop/com/main/applicant.png" >
    </div>
        <div class = "applicantContents topPadding">
            <input type="hidden"  id="applicantNO"  value="" />    <!-- 이미지를 누르면 여기에 값이 셋팅됨. -->
            <c:forEach items="${applicantList}" var="applicant" varStatus="status">
                <div class="imageSize ">
                    <a href="javascript:setApplicant('${applicant.APPLICANT_ID}');">
                       <img src="/kywa_provoter/imgView.do?filename=${applicant.PHOTO_PATH }" alt="후보 ${applicant.NAME}입니다." onerror="this.src='/kywa_provoter/images/egovframework/com/cop/com/main/NO0.png'" id="${applicant.APPLICANT_ID}" class="applicant radius listBorder" ></a>
                    <div class="applicantTopPadding applicantBottomPadding"><F1>${applicant.NAME}</F1></div>
                </div>
                <c:if test="${status.last && status.count%5 != 0}">
                    <c:forEach begin="${status.count%5}" end="5">
                        <div class="imageSize "></div>
                    </c:forEach>
                </c:if>
            </c:forEach>
            <div class="fixed-menu">
                <button onclick="vote()" class="voteBtn" >
                    <img src="/kywa_provoter/images/egovframework/com/cop/com/main/voteButton.png" class="linkbut">
                </button>
            </div>
        </div>
        <img class="background footer-pan" src= "/kywa_provoter/images/egovframework/com/cop/com/main/bottom.png" usemap="#link" >
    </div>
  <!-- Modal -->
<div class="modal fade" id="resultModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">투표 결과</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button id="modal-ok" type="button" class="btn btn-default" data-dismiss="modal">확인
           </button>
        </div>
      </div>
    </div>
  </div>

<script src="/kywa_provoter/js/egovframework/com/cmm/jquery/jquery-1.11.3.min.js"></script>
<script src="/kywa_provoter/js/egovframework/com/cmm/bootstrap/js/bootstrap.min.js"></script>
<script LANGUAGE = "JavaScript">
$(function() {
	
    var width= $(".ImageSize" ).width();
    $(".ImageSize").outerHeight(width);
    
    $("#modal-ok").bind("click", function () {
    	window.location.reload();
    });
});

$(window).resize(function(){
    var width= $(".ImageSize").width();
    $(".ImageSize").outerHeight(width);
    
}).resize();

function setApplicant(selectedApplicant) { 
    $(".applicant").css("border","4px solid");
    $(".applicant").css("border-color","#ededed");
    $("#"+selectedApplicant).css("border","4px solid");
    $("#"+selectedApplicant).css("border-color","#facb03");
    
    var no = document.getElementById("applicantNO").value = selectedApplicant;
}

function vote () {  
    var selectedApplicant = document.getElementById("applicantNO").value ;
    
    if(selectedApplicant == "" || selectedApplicant == null) {
        $(".modal-body").html("<p>투표할 후보를 선택해주세요!</p>");                  
        $("#resultModal").modal();
        return false;
    }
    
      $.ajax({
         type: 'post'
         , url: '/kywa_provoter/vote.do'
         , dataType: 'json'
         , data: 'applicant='+selectedApplicant
         ,success: function( rs ) {
             if(rs.resultCode == "fail") {
                 console.log("Fail");
                 $(".modal-body").html("<p>투표는 하루에 한 번 가능합니다!</p>");                  
                 $("#resultModal").modal();
             }
             else if (rs.resultCode == "success") {
                 console.log("Success");
                 $(".modal-body").html("<p>투표 성공! 감사합니다.</p>");                  
                 $("#resultModal").modal();
             }
             else {
                 console.log("Request Fail!!");
                 $(".modal-body").html("<p>요청 도중 에러가 발생했습니다. 관리자에게 문의하세요.</p>");                  
                 $("#resultModal").modal();
             }
         }
         , error: function( response ) {
             console.log(response);
         }
     });
}

function copy_linkURL(trb) {
    var IE=(document.all)?true:false;
    if (IE) {
        if(confirm("해당 페이지의 주소를 클립보드에 복사하시겠습니까?"))
            window.clipboardData.setData("Text", trb);
          } else {
                temp = prompt("해당 페이지 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", trb);
          }
    }

</script>

</body>
</html>