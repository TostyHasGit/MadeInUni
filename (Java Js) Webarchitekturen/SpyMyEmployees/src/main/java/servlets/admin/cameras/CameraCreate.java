package servlets.admin.cameras;

import dao.CameraDao;
import dao.DaoFactory;
import dao.LocationDao;
import exception.DaoException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Camera;
import model.Location;

import java.io.IOException;
import java.util.List;

public class CameraCreate extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CameraDao cameraDao = DaoFactory.getInstance().getCameraDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String locationIdStr = request.getParameter("locationId");
        if (locationIdStr != null) {
            try {
                Long locationId = Long.parseLong(locationIdStr);
                LocationDao locationDao = DaoFactory.getInstance().getLocationDao();
                Location location = locationDao.get(locationId);
                List<Camera> cameras = cameraDao.getCamerasByLocation(locationId, true, true);
                request.setAttribute("cameras", cameras);
                request.setAttribute("location", location);
            } catch (Exception e) {
                request.setAttribute("error", "Ungültiger Standort.");
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin/cameras/cameraCreate.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String url = request.getParameter("url");
        String description = request.getParameter("description");
        String statusStr = request.getParameter("status");
        String locationIdStr = request.getParameter("locationId");

        if (name == null || name.trim().isEmpty() || url == null || url.trim().isEmpty()) {
            request.setAttribute("error", "Name und URL dürfen nicht leer sein.");
            doGet(request, response); // Standortname erneut anzeigen
            return;
        }

        try {
            Camera camera = new Camera();
            camera.setName(name.trim());
            camera.setUrl(url.trim());
            camera.setDescription(description != null ? description.trim() : "");

            if ("true".equalsIgnoreCase(statusStr)) {
			    camera.setStatus("Active");
			} else if ("false".equalsIgnoreCase(statusStr)) {
			    camera.setStatus("Inactive");
			} else {
			    throw new IllegalArgumentException("Ungültiger Statuswert: " + statusStr);
			}
            if (locationIdStr != null) {
                camera.setLocationId(Long.parseLong(locationIdStr));
            }

            cameraDao.save(camera);
            response.sendRedirect(request.getContextPath() + "/admin/cameras");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Fehler beim Erstellen der Kamera.");
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}
