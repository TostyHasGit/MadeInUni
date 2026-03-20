<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${param.logout == 'true'}">
    <div class="alert alert-success mt-3">Sie wurden erfolgreich ausgeloggt.</div>
</c:if>


<!DOCTYPE html>
<html>
<head>
    <title>Login | SpyMyEmployees</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-md-6">
            <div class="card p-4 shadow-sm">
                <h2 class="text-center">Login</h2>

                <form method="post" action="${pageContext.request.contextPath}/login">

                    <div class="mb-3">
                        <label for="email" class="form-label">E-Mail</label>
                        <input type="email" name="email" id="email"
                               class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Passwort</label>
                        <input type="password" name="password" id="password"
                               class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Einloggen</button>
                </form>

                <c:if test="${not empty errorMessage}">
				    <div class="alert alert-danger mt-3">${errorMessage}</div>
				</c:if>

            </div>
        </div>
    </div>
</div>

</body>
</html>
