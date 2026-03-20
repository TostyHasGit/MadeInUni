package servlets.admin.location;

import dao.DaoFactory;
import dao.LocationDao;
import model.Location;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class LocationIndex extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final LocationDao locationDao = DaoFactory.getInstance().getLocationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Location> locations = locationDao.list();
        request.setAttribute("locations", locations);
        request.setAttribute("currentUri", request.getServletPath());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin/location/locationIndex.jsp");
        dispatcher.forward(request, response);
    }
}
