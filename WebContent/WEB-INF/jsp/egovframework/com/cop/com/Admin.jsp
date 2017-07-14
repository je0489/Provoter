<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../cmm/directive.jsp" %><!-- common directive -->
<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>PROVOTER Admin Page</title>
    <!-- jQuery -->
    <script src="/kywa_provoter/js/egovframework/com/cmm/jquery/jquery-1.11.3.min.js"></script>
    <!-- Bootstrap -->
    <link href="/kywa_provoter/js/egovframework/com/cmm/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Drop Zone -->
    <script src="/kywa_provoter/js/egovframework/com/cmm/dropzone/dropzone.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/kywa_provoter/js/egovframework/com/cmm/dropzone/dropzone.css">
    <!-- Datatable -->
    <link href="/kywa_provoter/js/egovframework/com/cmm/datatables/dataTables.min.css" rel="stylesheet"/>
    <link href="/kywa_provoter/js/egovframework/com/cmm/datatables/dataTables.bootstrap.min.css" rel="stylesheet"/>
    <link href="/kywa_provoter/css/egovframework/com/admin.css" rel="stylesheet"/>
    
    <script src="/kywa_provoter/js/egovframework/com/admin.js" type="text/javascript"></script>
</head>

<body>
    <h2>PRODUCE 50 후보 관리 페이지 ᕙ(•̀‸•́‶)ᕗ
        <a href="admin/logout.do" class = "btn btn-default">로그아웃</a>
    </h2>
        <h4>by PROVOTER.</h4>
     
    <div class="app-contents">
        <div style="float:right">
            <button type="button", class="btn btn-warning" , onclick="openRegisterModal()">
                <span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>후보 추가
            </button> 
        </div>
        
        <br>
        <br>
        
        <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
            <colgroup>
                <col width="5%"/>
                <col width="20%"/>
                <col width="20%"/>
                <col width="5%"/>
                <col width="20%"/>
                <col width="20%"/>
                <col width="20%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>No.</th>
                    <th class="hide-cols"></th>
                    <th>후보 이름</th>
                    <th>사진 경로</th>
                    <th>Image</th>
                    <th>득표수</th>
                    <th>메뉴</th>
                </tr>
            </thead>
            <tfoot></tfoot>
            <tbody>
                <c:forEach items="${list }" var="row" varStatus="status">
                    <c:if test="${row.APPLICANT_ID == null || row.APPLICANT_ID == '' }">
                        <tr style="background:#ffc107;font-weight:bold;">
                                <td class="align-center">합 계</td>
                                <td class="hide-cols"></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="align-right"><fmt:formatNumber value="${row.VOTE_COUNT}" pattern="#,##0"/></td>
                                <td></td>
                            </tr>
                    </c:if>
                </c:forEach>
                <c:forEach items="${list}" var="row" varStatus="status">
                    <c:if test="${!status.last}">
                        <tr>
                            <td class="align-center">${status.count}</td>
                            <td class="hide-cols">${row.APPLICANT_ID }</td>
                            <td>${row.NAME }</td>
                            <td>${row.FILENAME }</td>
                            <td>
                                <img src="/kywa_provoter/imgView.do?filename=${row.PHOTO_PATH}" onclick="window.open(src,'_blank', 'height=500,width=500');" width="50" height="50">
                            </td>
                            <td class="align-right"><fmt:formatNumber value="${row.VOTE_COUNT}" pattern="#,##0"/></td>
                            <td>
                                <button id="update-${row.APPLICANT_ID}" name="${row.NAME}" photo_path="${row.PHOTO_PATH }" onclick="openUpdateModal(${row.APPLICANT_ID})" class="btn btn-primary btn-update">
                                <span class="glyphicon glyphicon-pencil"></span> 수정</button>
                                
                                <button id="del-${row.APPLICANT_ID}" photo_path="${row.PHOTO_PATH }" onclick="openDeleteModal(${row.APPLICANT_ID})" class="btn btn-danger">
                                <span class="glyphicon glyphicon-trash"></span> 삭제</button>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div>
    

 <!-- 후보 추가 &수정 Modal -->
    <div class="modal fade" id="modifyModal" role="dialog" >
        <div class="modal-dialog">
          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" onclick="location.reload()">&times;</button>
              <h4 id="modal-title" class="modal-title">후보 추가</h4>
            </div>
            
            <div class="modal-body modal-body-pad">
              
                <div class="form-group">
                    <label for="applicantName" class="control-label">이름</label>
                    <input id="name" type="text" class="form-control" value="" />
                </div>
                <br>
                <div id="myDrop" class="app-drop-zone">
                <label>이미지</label>
                    <div  class="del-btn-pan">
                        <div>
                           <br>
                           <button id="btnAllClear" class="btn btn-menu1 btn-sm">사진 삭제</button>
                        </div>
                    </div>
                    <form action="" class="dropzone" id="my-dropzone" enctype="multipart/form-data">
                        <input type="hidden" id="applicantName" name="applicantName" value="" />
                    </form>
                </div>
                
                <br>
               <div class="app-image">    
                    <img src="" width="100" height="100">
               </div>
            
            </div>
            <div class="modal-footer">
              <button id="register" class="btn btn-success" onclick="">추가하기</button>
              <button class="btn btn-default" data-dismiss="modal" onclick="location.reload()">닫기</button>
            </div>
          </div>
        </div>
    </div>
  
<!-- 후보 삭제 Modal -->
    <div class="modal fade" id="deleteModal" role="dialog">
        <div class="modal-dialog">
          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" onclick="location.reload()">&times;</button>
              <h4 class="modal-title"></h4>
            </div>
            
            <div class="delete-modal-body modal-body-pad">
            <form:form id="deleteForm" name="deleteForm" method="post">
                <div class="form-group">
                    <input id="deleteNo" name="deleteNo" type="hidden" size="0" class="form-control" value="" />
                    <input id="deletePhoto_path" name="deletePhoto_path" type="hidden" size="0" class="form-control" value="" />
                              <br><br>
                                <span>정말로 삭제하시겠습니까?</span>
                   <br>
                   <br>          
                </div>
            </form:form>
                
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-success" data-dismiss="modal" onclick="applicantDelete()">삭제하기</button>
              <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.reload()">닫기</button>
            </div>
          </div>
        </div>
    </div>
    
    <!-- Bootstrap -->
    <script src="/kywa_provoter/js/egovframework/com/cmm/bootstrap/js/bootstrap.min.js"></script>
    <!-- Datatables  -->
    <script src="/kywa_provoter/js/egovframework/com/cmm/datatables/dataTables.min.js" type="text/javascript"></script>
    <script src="/kywa_provoter/js/egovframework/com/cmm/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
 
    <script>
/* Data Table(합계, 득표수 정렬, 검색) */
    var table;
    $(document).ready(function() {
        table= $('#example').DataTable({
             "columns": [
                             { "orderable": true },
                             { "orderable": true },
                             { "orderable": true },
                             { "orderable": true },
                             { "orderable": false },
                             { "orderable": true },
                             { "orderable": false }
                         ],
             "deferRender" : true,
             "aaSorting": []    // datatable 첫 로우에 대한 자동 sorting 금지
             
         });
    });
    </script>
    
    <script>    

    
/* 후보 등록 */    
    function openRegisterModal() {
    	
    	$("#register").html("등록하기");
    	$("#modal-title").text("후보등록");
    	myDropzone.options.url = "admin/register.do";
		
    	$(".app-image").hide();
    	
    	$("#modifyModal").modal();
    }
    
/* 후보 수정  */
    function openUpdateModal(id) {
    	
    	//id name
    	var applicantName = $("#update-"+id).attr("name");
    	var applicantPhoto = $("#update-"+id).attr("photo_path");
    	$("#name").val(applicantName);
    	
    	$(".app-image").show();

        $(".app-image").find('img').attr("src","/kywa_provoter/imgView.do?filename="+applicantPhoto);
    	
    	
    	
    	$("#register").html("수정하기");
    	$("#modal-title").text("후보수정");
    	myDropzone.options.url = "admin/update.do?id="+id+"&photo_path="+applicantPhoto;
        
        $("#modifyModal").modal();
    }
    
    function applicantUpdate() {
        // 파라미터 셋팅 
        var data = $("#updateForm").serialize();
    
        $.ajax({
            type: 'post'
            , url: 'admin/update.do'
            , dataType: 'json'
            , data: data     
            , success: function( rs ) {
                if(rs.resultCode == "success") {
                    console.log(data+ " update success");
                    alert("후보가 수정되었습니다.");
                    setTimeout(function(){}, 3000);
                    // 알림을 띄워준 후에
                    window.location.replace('/admin.do');
                }
                else {
                    console.log("request fail");
                    alert("수정 실패!");
                }
                
            }
            , error: function( response ) {
                ajaxError( response );
            }
        }); 
    }
/*
 *   후보 관리 기능 : 3. 후보 삭제
 *      
 */ 
    function openDeleteModal(id) {
    	$("#deleteNo").val(id);
    	var applicantPhoto = $("#del-"+id).attr("photo_path");
    	
    	$("#deletePhoto_path").val(applicantPhoto);
        $("#deleteModal").modal();
    }
    
    function applicantDelete() {   //삭제
         // 파라미터 셋팅 
         
         var data = $("#deleteForm").serialize();
     
         $.ajax({
             type: 'post'
             , url: 'admin/delete.do'
             , dataType: 'json'
             , data: data     
             , success: function( rs ) {
                 if(rs.resultCode == "success") {
                     alert("후보가 삭제되었습니다.");
                 }
                 else {
                     alert("삭제 실패!");
                     console.log("삭제 실패");
                 }
                 
                 // 알림을 띄워준 후에
                 
                 location.reload();
                 console.log("refresh");
             }
             , error: function( response ) {
                 ajaxError( response );
             }
         }); 
     }

</script>
    
    
</body>
</html>