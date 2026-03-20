<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !"Admin".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/jsp/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Startseite – SpyMyEmployees</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="/jsp/admin/_header.jsp" />

<div style="height: 70px;"></div>
<div class="container py-4">
    <h1 class="mb-4">Willkommen im Adminbereich</h1>

    <hr>
    <h5>Erste Schritte:</h5>
    <ul>
    	<li>
    		Standorte ihres Unternehmens anlegen unter
    		<a href="${pageContext.request.contextPath}/admin/locations">Standorte</a>.
    	</li>
    	<li>
    		Kameras anlegen und ihnen einen Standort zuweisen unter
    		<a href="${pageContext.request.contextPath}/admin/Cameras">Kameras</a>.
    	</li>
        <li>
        	Legen sie Benutzer an unter 
        	<a href="${pageContext.request.contextPath}/admin/siteManagers">Benutzer</a>.
        	<br>Standortleiter haben nur Einsicht auf Kameras ihrer Standorte. <br> Geschäftsführer haben auf alle Kameras einsicht. </li>
    </ul>

    <p class="text-muted mt-5">© 2025 SpyMyEmployees – Admin Dashboard</p>
</div>
</body>
</html>
