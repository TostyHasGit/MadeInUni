<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Kamera Übersicht</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap & Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
.location-card {
	background-color: #212529;
	color: white;
	border-radius: 0.5rem;
	padding: 1rem;
	margin-bottom: 1rem;
}

.location-name {
	font-weight: 600;
	font-size: 1.2rem;
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
<body class="bg-light">

	<jsp:include page="/jsp/controlStation/_headerControlStation.jsp" />

	<div style="height: 70px;"></div>
	<div class="container py-4">
		<h2 class="mb-4 fw-bold">Kamera Übersicht</h2>

		<c:choose>
			<c:when test="${empty locations}">
				<div class="alert alert-info" role="alert">Es sind keine Orte
					vorhanden.</div>
			</c:when>
			<c:otherwise>
				<div class="p-3 bg-white rounded shadow-sm">
					<c:forEach var="location" items="${locations}">
						<div
							class="location-card d-flex justify-content-between align-items-center">
							<div class="location-name">${location.locationName}</div>
							<div class="d-flex gap-2">
								<a class="btn btn-outline-light btn-sm"
									data-bs-toggle="collapse" href="#collapse-${location.id}">
									Kameras anzeigen </a>
							</div>
						</div>

						<div class="collapse mb-3" id="collapse-${location.id}">
							<div class="ps-3 pe-3">
								<c:choose>
									<c:when test="${empty camerasByLocation[location.id]}">
										<div class="text-muted fst-italic mt-2">Keine Kameras
											vorhanden.</div>
									</c:when>
									<c:otherwise>
										<div
											class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-6 row-cols-xl-9 g-3">
											<c:forEach var="camera"
												items="${camerasByLocation[location.id]}">
												<div class="col">
													<a
														href="${pageContext.request.contextPath}/showCam?cameraId=${camera.id}"
														class="camera-link">
														<div
															class="camera-card text-center 
                                                        ${camera.status != null and camera.status.trim().toLowerCase() eq 'active'
                                                            ? 'bg-success text-white' : 'bg-danger text-white'}">
															<i class="bi bi-camera-video camera-icon toggle-icon"></i>
															<div class="camera-name">${camera.name}</div>
														</div>
													</a>
												</div>
											</c:forEach>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
