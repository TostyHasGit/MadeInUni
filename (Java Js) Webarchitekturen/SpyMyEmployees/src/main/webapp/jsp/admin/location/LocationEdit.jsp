<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="model.Location, model.User" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>Standort anzeigen</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        .card {
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
        }
        .form-label {
            font-weight: 500;
        }
        
        .camera-card {
            border-radius: 0.5rem;
            padding: 1rem;
            text-align: center;
            box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.05);
            height: 100%;
            transition: transform 0.1s ease-in-out;
        }

        .camera-card:hover {
            transform: scale(1.02);
            cursor: pointer;
        }

        .camera-icon {
            font-size: 2rem;
        }

        .camera-name {
            margin-top: 0.5rem;
            font-weight: 500;
        }

        a.camera-link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>

<jsp:include page="/jsp/admin/_header.jsp" />

<div style="height: 70px;"></div>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-12 col-md-10 ">
        	<div class="card p-4 bg-white">
	            <div class="card p-4 bg-white mb-3">
	
	                <!-- Titel und Löschen -->
	                <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4 gap-2">
	                    <h2 class="mb-0">Standort bearbeiten</h2>
	                    <form method="post" action="${pageContext.request.contextPath}/admin/location/delete"
	                          onsubmit="return confirm('Diesen Standort wirklich löschen?');">
	                        <input type="hidden" name="id" value="${location.id}" />
	                        <button type="submit" class="btn btn-danger">Standort entfernen</button>
	                    </form>
	                </div>
	
	                <!-- update locationName -->
	                <form method="post" class="mb-4">
	                    <input type="hidden" name="id" value="${location.id}" />
	                    <div class="input-group">
	                        <input type="text" class="form-control" name="name" value="${location.locationName}" required />
	                        <button class="btn btn-primary" type="submit">Namen aktualisieren</button>
	                    </div>
	                </form>
				</div>
				
				<div class="card p-4 bg-white mb-3">
	                <!-- assigned siteManagers  -->
	                <h4 class="mb-2">Zugewiesene Standortleiter</h4>
	                <c:if test="${not empty assignedManagers}">
	                    <ul class="list-group mb-4">
	                        <c:forEach var="manager" items="${assignedManagers}">
	                            <li class="list-group-item d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center">
	                                <span>${manager.name} (${manager.email})</span>
	                                <form method="post" class="mt-2 mt-sm-0" style="margin:0;">
	                                    <input type="hidden" name="id" value="${location.id}" />
	                                    <input type="hidden" name="removeManagerId" value="${manager.id}" />
	                                    <button class="btn btn-sm btn-outline-danger">Entfernen</button>
	                                </form>
	                            </li>
	                        </c:forEach>
	                    </ul>
	                </c:if>
	                <c:if test="${empty assignedManagers}">
	                    <p class="text-muted mb-4">Keine Standortleiter zugewiesen.</p>
	                </c:if>
	
	                <!-- add SiteManager -->
	                <h4 class="mb-2">Standortleiter hinzufügen</h4>
	                <c:if test="${not empty availableManagers}">
	                    <form method="post" class="row g-2 align-items-center mb-3">
	                        <input type="hidden" name="id" value="${location.id}" />
	                        <div class="col-12 col-md-auto">
	                            <select name="addManagerId" class="form-select" required>
	                                <c:forEach var="manager" items="${availableManagers}">
	                                    <option value="${manager.id}">${manager.name} (${manager.email})</option>
	                                </c:forEach>
	                            </select>
	                        </div>
	                        <div class="col-12 col-md-auto">
	                            <button class="btn btn-primary w-100 w-md-auto">Hinzufügen</button>
	                        </div>
	                    </form>
	                </c:if>
	                <c:if test="${empty availableManagers}">
	                    <p class="text-muted">Alle Standortleiter wurden bereits hinzugefügt.</p>
	                </c:if>
	
	            </div>
	            
	            <!-- Linked Cameras -->
	            <div class="card p-4 bg-white">
					<h4 class="mb-4">Verknüpfte Kameras</h4>
					<c:if test="${not empty linkedCameras}">
					    <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-6 row-cols-xl-9 g-3">
		                    <c:forEach var="camera" items="${linkedCameras}">
		                        <div class="col">
		                            <a href="${pageContext.request.contextPath}/admin/camera/edit?id=${camera.id}" class="camera-link">
		                                <div class="camera-card text-center 
		                                    ${camera.status != null and camera.status.trim().toLowerCase() eq 'active'
		                                        ? 'bg-success text-white' : 'bg-danger text-white'}">
		                                    <i class="bi bi-camera-video camera-icon toggle-icon"></i>
		                                    <div class="camera-name">${camera.name}</div>
		                                </div>
		                            </a>
		                        </div>
		                    </c:forEach>
		                </div>
					</c:if>
					<c:if test="${empty linkedCameras}">
					    <p class="text-muted mb-4">Keine Kameras verknüpft.</p>
					</c:if>
					
					<div class="d-flex flex-column flex-sm-row gap-2 mt-4">
						<a href="${pageContext.request.contextPath}/admin/camera/create?locationId=${location.id}" class="btn btn-primary">
							<i class="bi bi-plus-lg"></i> Kamera hinzufügen
						</a>
					</div>
				</div>
	    	</div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
