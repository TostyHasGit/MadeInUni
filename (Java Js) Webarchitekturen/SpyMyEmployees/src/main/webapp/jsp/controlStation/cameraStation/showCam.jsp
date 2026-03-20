<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Kamera anzeigen</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
.camera-image {
	width: 100%;
	max-height: 400px;
	object-fit: cover;
	object-position: center;
}

.image-grid {
	display: grid;
	grid-template-columns: repeat(6, 1fr);
	gap: 0.75rem;
}

.image-grid img {
	width: 100%;
	height: 150px;
	object-fit: cover;
	border-radius: 0.5rem;
}
</style>
</head>
<body class="bg-light">

	<jsp:include page="/jsp/controlStation/_headerControlStation.jsp" />

	<div class="container py-4">
		<h2 class="mb-4 fw-bold text-center">Kameraansicht</h2>

		<!-- Kamera-Infos -->
		<div class="text-center mb-4">
			<h4>${camera.name}</h4>
			<p class="text-muted">${location.locationName}</p>
		</div>

		<!-- Filterauswahl -->
		<form method="get" action="${pageContext.request.contextPath}/showCam"
			class="row g-2 justify-content-center mb-4">
			<input type="hidden" name="cameraId" value="${camera.id}" />

			<div class="col-md-2">
				<select name="year" class="form-select"
					onchange="this.form.submit()">
					<option disabled ${selectedYear==null?'selected' : ''}>Bitte
						Jahr wählen</option>
					<c:forEach var="y" items="${years}">
						<option value="${y}" ${y == selectedYear ? "selected" : ""}>${y}</option>
					</c:forEach>
				</select>
			</div>

			<c:if test="${not empty months}">
				<div class="col-md-2">
					<select name="month" class="form-select"
						onchange="this.form.submit()">
						<option disabled ${selectedMonth==null?'selected' : ''}>Bitte
							Monat wählen</option>
						<c:forEach var="m" items="${months}">
							<option value="${m}" ${m == selectedMonth ? "selected" : ""}>${m}</option>
						</c:forEach>
					</select>
				</div>
			</c:if>

			<c:if test="${not empty days}">
				<div class="col-md-2">
					<select name="day" class="form-select"
						onchange="this.form.submit()">
						<option disabled ${selectedDay==null?'selected' : ''}>Bitte
							Tag wählen</option>
						<c:forEach var="d" items="${days}">
							<option value="${d}" ${d == selectedDay ? "selected" : ""}>${d}</option>
						</c:forEach>
					</select>
				</div>
			</c:if>

			<c:if test="${not empty hours}">
				<div class="col-md-2">
					<select name="hour" class="form-select"
						onchange="this.form.submit()">
						<option disabled ${selectedHour==null?'selected' : ''}>Bitte
							Stunde wählen</option>
						<c:forEach var="h" items="${hours}">
							<option value="${h}" ${h == selectedHour ? "selected" : ""}>${h}:00</option>
						</c:forEach>
					</select>
				</div>
			</c:if>
		</form>


		<div class="image-grid">
			<c:forEach var="entry" items="${imageList}">
				<div class="text-center">
					<a href="${pageContext.request.contextPath}/${entry.filePath}"
						target="_blank"> <img
						src="${pageContext.request.contextPath}/${entry.iconPath}"
						alt="Bild" />
					</a> <small class="text-muted d-block mt-1"> <fmt:formatDate
							value="${entry.captureTimeAsDate}" pattern="HH:mm:ss" />
					</small>
				</div>
			</c:forEach>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
