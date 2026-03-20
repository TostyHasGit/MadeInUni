package servlets.admin.location;

import dao.DaoFactory;
import dao.LocationDao;
import exception.DaoException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Location;

import java.io.IOException;

public class LocationCreate extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final LocationDao locationDao = DaoFactory.getInstance().getLocationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show form for creating a new location
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin/location/locationCreate.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String locationName = request.getParameter("locationName");
        

        // Validate inputs
        if (locationName == null || locationName.trim().isEmpty() ) {
            request.setAttribute("error", "Name darf nicht leer sein.");
            request.getRequestDispatcher("/jsp/admin/location/locationCreate.jsp").forward(request, response);
            return;
        }

        try {
            Location location = new Location();
            location.setLocationName(locationName.trim());
            

            locationDao.save(location);

            // Redirect to location list
            response.sendRedirect(request.getContextPath() + "/admin/locations");

        } catch (DaoException e) {
            e.printStackTrace();
            request.setAttribute("error", "Fehler beim Erstellen des Standorts: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}
