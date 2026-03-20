<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Kamera erstellen</title>
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
                <h2 class="mb-4">Kamera erstellen</h2>

                <c:if test="${not empty location}">
                    <h4 class="mb-4 text-primary">Standort: <strong>${location.locationName}</strong></h4>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/admin/camera/create">
                    <input type="hidden" name="locationId" value="${location.id}" />

                    <div class="mb-3">
                        <label for="cameraName" class="form-label">Kameraname</label>
                        <input type="text" class="form-control" name="name" id="cameraName" required>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Beschreibung</label>
                        <textarea class="form-control" name="description" id="description" rows="3"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="cameraUrl" class="form-label">Kamera-URL</label>
                        <input type="url" class="form-control" name="url" id="cameraUrl"
                               placeholder="https://example.com/stream" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Status</label><br/>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="statusAktiv" value="true" checked>
                            <label class="form-check-label" for="statusAktiv">Aktiv</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="statusInaktiv" value="false">
                            <label class="form-check-label" for="statusInaktiv">Inaktiv</label>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary">Speichern</button>
                        <a href="${pageContext.request.contextPath}/admin/cameras" class="btn btn-secondary">Abbrechen</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
