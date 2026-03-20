package servlets.admin.location;

import dao.DaoFactory;
import dao.LocationDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class LocationDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final LocationDao locationDao = DaoFactory.getInstance().getLocationDao();

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
            locationDao.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Fehler beim Löschen des Standorts.");
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/locations");
    }
}
