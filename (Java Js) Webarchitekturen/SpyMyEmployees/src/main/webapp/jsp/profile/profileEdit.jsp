<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Profil bearbeiten</title>
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
        <div class="col-lg-8">
            <div class="card p-4 bg-white">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Profil</h3>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <div class="mb-3">
                    <span class="text-muted">Rolle:</span> <strong>${user.role}</strong>
                </div>

                <form method="post" novalidate>
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" name="name" class="form-control" value="${user.name}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">E-Mail</label>
                        <input type="email" name="email" class="form-control" value="${user.email}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Passwort <small class="text-muted">(leer lassen für keine Änderung)</small></label>
                        <input type="password" name="password" class="form-control">
                    </div>

                    <div class="text-end">
                        <button type="submit" class="btn btn-primary px-4">Änderungen speichern</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Fade-Out Success
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
