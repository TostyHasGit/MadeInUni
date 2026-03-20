package auth;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
import java.util.Set;

@WebFilter("/admin/*") // Filtert alle Anfragen
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI().substring(request.getContextPath().length());
        HttpSession session = request.getSession(false);
        boolean isAdmin = false;
        if (session != null) {
        	User user = (User) session.getAttribute("user");
        	isAdmin = user.getRole().equals("Admin");
        }
        
        if (!isAdmin) {
            System.out.println("Zugriff verweigert → Weiterleitung zu /login");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Berechtigt → weiter im Filter/Servlet-Chain
            chain.doFilter(req, res);
        }
    }
}
