<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<title>Kamera bearbeiten</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.card {
	border-radius: 1rem;
	box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
	overflow: hidden;
}

.form-label {
	font-weight: 500;
}

.camera-placeholder-img {
	width: 100%;
	height: 250px;
	object-fit: cover;
	object-position: center;
}
</style>
</head>
<body>

	<jsp:include page="/jsp/admin/_header.jsp" />

	<div style="height: 70px;"></div>
	<div class="container py-4">
		<div class="row justify-content-center">
			<div class="col-12 col-md-10 col-lg-8 col-xl-8">
				<div class="card bg-white">

					<img src="${pageContext.request.contextPath}/${latestImagePath}"
						alt="Neueste Kameraaufnahme" class="camera-placeholder-img" />

					<div class="p-4">
						<div
							class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4 gap-2">
							<h2 class="mb-0">Kamera bearbeiten</h2>
							<form method="post"
								action="${pageContext.request.contextPath}/admin/camera/delete"
								onsubmit="return confirm('Diese Kamera wirklich löschen?');">
								<input type="hidden" name="id" value="${camera.id}" />
								<button type="submit" class="btn btn-danger">Kamera
									entfernen</button>
							</form>
						</div>

						<form method="post"
							action="${pageContext.request.contextPath}/admin/camera/edit">
							<input type="hidden" name="id" value="${camera.id}" />

							<div class="mb-3">
								<label class="form-label">Name</label> <input type="text"
									name="name" value="${camera.name}" class="form-control"
									required>
							</div>

							<div class="mb-3">
								<label class="form-label">Beschreibung</label>
								<textarea name="description" class="form-control" rows="3">${camera.description}</textarea>
							</div>

							<div class="mb-3">
								<label class="form-label">URL</label> <input type="text"
									name="url" value="${camera.url}" class="form-control">
							</div>

							<div class="mb-3">
								<label class="form-label">Status</label><br>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="status"
										value="true" ${camera.status == 'Active' ? 'checked' : ''}>
									<label class="form-check-label">Aktiv</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="status"
										value="false" ${camera.status != 'Active' ? 'checked' : ''}>
									<label class="form-check-label">Inaktiv</label>
								</div>
							</div>

							<div class="mb-4">
								<label class="form-label">Ort</label> <select name="locationId"
									class="form-select" required>
									<c:forEach var="loc" items="${allLocations}">
										<option value="${loc.id}"
											${camera.locationId == loc.id ? 'selected' : ''}>
											${loc.locationName}</option>
									</c:forEach>
								</select>
							</div>

							<div class="d-flex justify-content-between">
								<a href="${pageContext.request.contextPath}/admin/cameras"
									class="btn btn-secondary">Abbrechen</a>
								<button type="submit" class="btn btn-success">Speichern</button>
							</div>
						</form>
					</div>

				</div>
				
				<c:if test="${not empty errorLogs}">
				    <div class="card bg-white mt-4">
				        <div class="p-4">
				            <h5 class="mb-3">Fehlerprotokoll</h5>
				            <button class="btn btn-outline-danger mb-3" type="button"
				                    data-bs-toggle="collapse" data-bs-target="#errorLogCollapse"
				                    aria-expanded="false">
				                Fehlerprotokoll anzeigen (${errorLogs.size()} Einträge
				                <c:choose>
				                    <c:when test="${not empty uncheckedLogs}">
				                        , ${uncheckedLogs.size()} neu
				                    </c:when>
				                    <c:otherwise>
				                        – keine neuen Fehler
				                    </c:otherwise>
				                </c:choose>)
				                
				            </button>
								
				            <div class="collapse" id="errorLogCollapse">
				                <div class="card card-body">
				                    <c:if test="${not empty uncheckedLogs}">
									    <form method="post" action="${pageContext.request.contextPath}/admin/camera/edit">
									        <input type="hidden" name="id" value="${camera.id}" />
									        <input type="hidden" name="markErrorsChecked" value="true" />
									        <button type="submit" class="btn btn-sm btn-success mb-3">
									            Alle als geprüft markieren
									        </button>
									    </form>
									</c:if>
				
				                    <table class="table table-sm table-bordered">
				                        <thead class="table-light">
				                            <tr>
				                                <th>Zeitpunkt</th>
				                                <th>Beschreibung</th>
				                                <th>Status</th>
				                            </tr>
				                        </thead>
				                        <tbody>
				                            <c:forEach var="log" items="${errorLogs}">
				                                <tr>
				                                    <td>${log.capture_time}</td>
				                                    <td>Connection timed out</td>
				                                    <td>
				                                        <c:choose>
				                                            <c:when test="${log.checked}">
				                                                <span class="badge bg-success">Gesehen</span>
				                                            </c:when>
				                                            <c:otherwise>
				                                                <span class="badge bg-danger">Neu</span>
				                                            </c:otherwise>
				                                        </c:choose>
				                                    </td>
				                                </tr>
				                            </c:forEach>
				                        </tbody>
				                    </table>
				                </div>
				            </div>
				        </div>
				    </div>
				</c:if>

			</div>
		</div>
	</div>
	
	
	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
