<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 현재 URL --%>
<c:set var="url" value="${ requestScope[ 'javax.servlet.forward.servlet_path' ] }"/>

<%-- 세션값 --%>
<c:set var="ID" value="${ sessionScope.ID }"/>

<c:choose>
	<c:when test="${ ID == null }"><c:set var="isSession" value="false"/></c:when>
	<c:otherwise><c:set var="isSession" value="true"/></c:otherwise>
</c:choose>

 
