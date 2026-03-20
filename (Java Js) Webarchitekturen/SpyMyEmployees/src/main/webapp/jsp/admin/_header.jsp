<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- ToDo: uncomment this when we have login 
<c:if test="${not empty sessionScope.user and sessionScope.user.role == 'Admin'}">
--%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand me-3" href="${pageContext.request.contextPath}/admin/dashboard">SpyMyEmployees Admin Bereich</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Navigation umschalten">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link ${fn:contains(currentUri, '/admin/locations') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/locations">Standorte</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${fn:contains(currentUri, '/admin/cameras') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/cameras">Kameras</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${fn:contains(currentUri, '/admin/siteManagers') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/siteManagers">Benutzer</a>
                    </li>
                </ul>

                <span class="navbar-text text-white me-3">
                    Eingeloggt als:
                    <a href="${pageContext.request.contextPath}/profile" class="text-white fw-bold text-decoration-underline">
                        ${sessionScope.userName}
                    </a>
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>
<%--  
</c:if>
--%>


