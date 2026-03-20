<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Location" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Standorte</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Wichtig für Mobile -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        .card {
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
        }
        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="/jsp/admin/_header.jsp" />

<div style="height: 70px;"></div>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-12 col-md-10 ">
            <div class="card p-4 bg-white">
			    <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-3 gap-2">
			        <h2 class="mb-4 fw-bold">Standort Übersicht</h2>
			        <a href="${pageContext.request.contextPath}/admin/location/create" class="btn btn-primary">Neuen Standort anlegen</a>
			    </div>
			    
			    <c:if test="${not empty locations}">
			        <div class="mb-5 card p-3 p-md-4">
			            <c:forEach var="location" items="${locations}">
			                <div class="card mb-3">
			                    <div class="card-header bg-dark text-white d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center">
			                        <div class="mb-2 mb-sm-0">
			                            <a href="${pageContext.request.contextPath}/admin/location/edit?id=${location.id}" 
			                               class="text-white fw-bold text-decoration-none">
			                                ${location.locationName}
			                            </a>
			                        </div>
			                        <div>
			                            <a href="${pageContext.request.contextPath}/admin/location/edit?id=${location.id}" 
			                               class="btn btn-sm btn-outline-light">Verwalten</a>
			                        </div>
			                    </div>
			                </div>
			            </c:forEach>
			        </div>
			    </c:if>
			
			    <c:if test="${empty locations}">
			        <div class="alert alert-warning">Es sind noch keine Standorte vorhanden.</div>
			    </c:if>
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
