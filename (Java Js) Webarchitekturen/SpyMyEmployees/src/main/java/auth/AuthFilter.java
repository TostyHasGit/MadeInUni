package auth;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Set;

@WebFilter("/*") // Filtert alle Anfragen
public class AuthFilter implements Filter {

    private static final Set<String> PUBLIC_PATHS = Set.of(
        "/login",                    // Servlet-Pfad zum Einloggen
        "/logout",                   // optional, falls Logout nicht geschützt sein soll
        "/jsp/auth/login.jsp",       // Login-Seite
        "/jsp/auth/",                // gesamtes Login-Verzeichnis (failsafe)
        "/css/", "/js/", "/images/", "/resources/" // statische Pfade
    );

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI().substring(request.getContextPath().length());
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute("userRole") != null;
        boolean isPublic = PUBLIC_PATHS.stream().anyMatch(path::startsWith);

        System.out.println("[AuthFilter] Pfad: " + path);
        System.out.println("Eingeloggt: " + isLoggedIn + " | Öffentlich erlaubt: " + isPublic);

        if (!isLoggedIn && !isPublic) {
            System.out.println("Zugriff verweigert → Weiterleitung per Dispatcher zu /login");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            chain.doFilter(req, res);
        }
    }
}
