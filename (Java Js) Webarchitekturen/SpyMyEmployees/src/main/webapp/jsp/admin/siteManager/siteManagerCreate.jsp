<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Standortleiter erstellen</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-8 col-xl-8">
            <div class="card p-4 bg-white">
                <h2 class="mb-4">Benutzer erstellen</h2>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form method="post" action="">
                    <div class="mb-3">
                        <label for="name" class="form-label">Name:</label>
                        <input type="text" name="name" class="form-control" id="name" required 
                               value="${inputName != null ? inputName : ''}" autocomplete="name">
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">E-Mail:</label>
                        <input type="email" name="email" class="form-control" id="email" required 
                               value="${inputEmail != null ? inputEmail : ''}" autocomplete="email">
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Passwort:</label>
                        <input type="password" name="password" class="form-control" id="password" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Rolle:</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="role" id="roleSiteManager" value="SiteManager"
                                ${inputRole == 'SiteManager' || inputRole == null ? 'checked' : ''}>
                            <label class="form-check-label" for="roleSiteManager">Standortleiter</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="role" id="roleBoss" value="Boss"
                                ${inputRole == 'Boss' ? 'checked' : ''}>
                            <label class="form-check-label" for="roleBoss">Geschäftsführer</label>
                        </div>
                    </div>

                    <div class="mb-5" id="locationSection">
                        <label class="form-label">Standorte zuweisen:</label>
                        <div class="row">
                            <c:forEach var="location" items="${locations}">
                                <div class="col-12 col-sm-6 col-md-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="locationIds" 
                                               value="${location.id}" id="loc${location.id}"
                                               <c:if test="${fn:contains(selectedLocationIds, location.id.toString())}">checked</c:if>>
                                        <label class="form-check-label" for="loc${location.id}">
                                            ${location.locationName}
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="d-flex flex-column flex-sm-row gap-2">
                        <button type="submit" class="btn btn-primary">Erstellen</button>
                        <a href="${pageContext.request.contextPath}/admin/siteManagers" class="btn btn-secondary">Abbrechen</a>
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
</script>

</body>
</html>
