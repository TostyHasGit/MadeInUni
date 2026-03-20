package servlets.admin.siteManager;

import dao.DaoFactory;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class SiteManagerDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final UserDao userDao = DaoFactory.getInstance().getUserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
        	String idParam = request.getParameter("id");
            if (idParam == null || idParam.isBlank()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Fehlende ID.");
                return;
            }
            
            Long id = Long.parseLong(idParam);
            userDao.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Fehler beim Löschen des Standortleiters.");
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/siteManagers");
    }
}
