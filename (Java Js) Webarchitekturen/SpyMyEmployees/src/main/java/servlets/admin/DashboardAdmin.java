	package servlets.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;


public class DashboardAdmin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/admin/dashboardAdmin.jsp").forward(request, response);
    }
}
