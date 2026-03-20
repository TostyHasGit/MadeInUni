<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Benutzer bearbeiten</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <div class="col-12 col-md-10 col-lg-8 col-xl-8">
        	<div class="card p-4 bg-white">
	            <div class="d-flex justify-content-between align-items-center mb-3 flex-column flex-md-row gap-3">
	                <h2 class="mb-0">Benutzer bearbeiten</h2>
	                <form method="post" action="${pageContext.request.contextPath}/admin/siteManager/delete"
	                      onsubmit="return confirm('Möchtest du diesen Standortleiter wirklich löschen?');">
	                    <input type="hidden" name="id" value="${user.id}" />
	                    <input type="hidden" name="action" value="delete" />
	                    <button type="submit" class="btn btn-danger">Benutzer entfernen</button>
	                </form>
	            </div>
	
	            <c:if test="${not empty error}">
	                <div class="alert alert-danger">${error}</div>
	            </c:if>
	            <c:if test="${not empty success}">
	                <div class="alert alert-success">${success}</div>
	            </c:if>
	
	            <form method="post" class="mt-4">
	                <input type="hidden" name="id" value="${user.id}" />
	
	                <div class="mb-3">
	                    <label class="form-label">Name</label>
	                    <input type="text" name="name" class="form-control" value="${user.name}" required>
	                </div>
	
	                <div class="mb-3">
	                    <label class="form-label">E-Mail</label>
	                    <input type="email" name="email" class="form-control" value="${user.email}" required>
	                </div>
	
	                <div class="mb-3">
	                    <label class="form-label">Passwort (leer lassen für keine Änderung)</label>
	                    <input type="password" name="password" class="form-control">
	                </div>
	
	                <div class="mb-3">
	                    <label class="form-label">Rolle:</label><br>
	                    <div class="form-check form-check-inline">
	                        <input class="form-check-input" type="radio" name="role" id="roleSiteManager" value="SiteManager"
	                            ${user.role == 'SiteManager' || inputRole == null ? 'checked' : ''}>
	                        <label class="form-check-label" for="roleSiteManager">Standortleiter</label>
	                    </div>
	                    <div class="form-check form-check-inline">
	                        <input class="form-check-input" type="radio" name="role" id="roleBoss" value="Boss"
	                            ${user.role == 'Boss' ? 'checked' : ''}>
	                        <label class="form-check-label" for="roleBoss">Geschäftsführer</label>
	                    </div>
	                </div>
	
	                <div id="locationSection">
	                    <div class="mb-4">
	                        <label class="form-label">Zugewiesene Standorte</label>
	                        <ul class="list-group">
	                            <c:forEach var="loc" items="${assignedLocations}">
	                                <li class="list-group-item d-flex justify-content-between align-items-center">
	                                    ${loc.locationName}
	                                    <button type="submit" name="removeLocationId" value="${loc.id}" class="btn btn-danger btn-sm">
	                                        Entfernen
	                                    </button>
	                                </li>
	                            </c:forEach>
	                        </ul>
	                    </div>
	
	                    <div class="mb-4">
	                        <label class="form-label">Weitere Standorte zuweisen</label>
	                        <div class="row">
	                            <c:forEach var="loc" items="${unassignedLocations}">
	                                <div class="col-12 col-sm-6">
	                                    <div class="form-check">
	                                        <input class="form-check-input" type="checkbox" name="addLocationIds" value="${loc.id}" id="loc${loc.id}">
	                                        <label class="form-check-label" for="loc${loc.id}">${loc.locationName}</label>
	                                    </div>
	                                </div>
	                            </c:forEach>
	                        </div>
	                    </div>
	                </div>
	
	                <div class="d-flex flex-column flex-sm-row gap-2">
	                    <button type="submit" class="btn btn-primary">Speichern</button>
	                    <a href="${pageContext.request.contextPath}/admin/siteManagers" class="btn btn-secondary">Zurück</a>
	                </div>
	            </form>
			</div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleLocationSection() {
        const role = document.querySelector('input[name="role"]:checked').value;
        const locationSection = document.getElementById('locationSection');
        locationSection.style.display = (role === 'SiteManager') ? 'block' : 'none';
    }

    document.querySelectorAll('input[name="role"]').forEach(el => {
        el.addEventListener('change', toggleLocationSection);
    });

    window.addEventListener('DOMContentLoaded', toggleLocationSection);

    // Success fadeout
    setTimeout(() => {
        const alert = document.querySelector('.alert-success');
        if (alert) {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }
    }, 3000);
</script>

</body>
</html>
