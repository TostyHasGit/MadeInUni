<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Benutzer Übersicht</title>
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
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-12 col-md-10 ">
            <div class="card p-4 bg-white">
			    <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4 gap-3">
			        <h2 class="mb-0">Benutzer Übersicht</h2>
			        <a href="${pageContext.request.contextPath}/admin/siteManager/create" class="btn btn-primary">Neuen Benutzer erstellen</a>
			    </div>
			
			    <!-- Bosses -->
			    <div class="mb-5 p-4 card">
			        <h3 class="mb-4">Geschäftsführer</h3>
			        <c:forEach var="boss" items="${bosses}">
			            <div class="card mb-3">
			                <div class="card-header bg-dark text-white d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
			                    <div>
			                        <a href="${pageContext.request.contextPath}/admin/siteManager/edit?id=${boss.id}" 
			                           class="text-white fw-bold text-decoration-none">
			                            ${boss.name}
			                        </a> – ${boss.email}
			                    </div>
			                    <a href="${pageContext.request.contextPath}/admin/siteManager/edit?id=${boss.id}" 
			                       class="btn btn-sm btn-outline-light mt-2 mt-md-0">Bearbeiten</a>
			                </div>
			            </div>
			        </c:forEach>
			        <c:if test="${empty bosses}">
			            <div class="alert alert-warning">Es wurden noch keine Geschäftsführer erstellt.</div>
			        </c:if>
			    </div>
			
			    <!-- SiteManager -->
			    <div class="mb-5 p-4 card">
			        <h3 class="mb-4">Standortleiter</h3>
			        <c:forEach var="entry" items="${siteManagerLocations}">
					    <div class="card mb-3">
					        <div class="card-header bg-dark text-white d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
					            <div>
					                <a href="${pageContext.request.contextPath}/admin/siteManager/edit?id=${entry.key.id}" 
					                   class="text-white fw-bold text-decoration-none">
					                    ${entry.key.name}
					                </a> – ${entry.key.email}
					            </div>
					            <div class="d-flex flex-column flex-md-row gap-2 mt-2 mt-md-0">
					                <a href="${pageContext.request.contextPath}/admin/siteManager/edit?id=${entry.key.id}" 
					                   class="btn btn-sm btn-outline-light">Bearbeiten</a>
					                <button class="btn btn-sm btn-light" type="button"
					                        data-bs-toggle="collapse"
					                        data-bs-target="#collapseLocations_${entry.key.id}"
					                        aria-expanded="false"
					                        aria-controls="collapseLocations_${entry.key.id}">
					                    Standorte anzeigen
					                </button>
					            </div>
					        </div>
					
					        <!-- Collapse-Ziel -->
					        <div class="collapse" id="collapseLocations_${entry.key.id}">
					            <div class="card-body">
					                <h6 class="card-subtitle mb-2 text-muted">Zugewiesene Standorte:</h6>
					                <ul class="list-group">
					                    <c:forEach var="location" items="${entry.value}">
					                        <li class="list-group-item">
					                            <a href="${pageContext.request.contextPath}/admin/location/edit?id=${location.id}" class="text-decoration-none">
					                                ${location.locationName}
					                            </a>
					                        </li>
					                    </c:forEach>
					                    <c:if test="${empty entry.value}">
					                        <li class="list-group-item text-muted fst-italic">Keine Standorte zugewiesen</li>
					                    </c:if>
					                </ul>
					            </div>
					        </div>
					    </div>
					</c:forEach>
			
			        <c:if test="${empty siteManagerLocations}">
			            <div class="alert alert-warning">Es wurden noch keine Standortleiter erstellt.</div>
			        </c:if>
				</div>
			</div>
		</div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
