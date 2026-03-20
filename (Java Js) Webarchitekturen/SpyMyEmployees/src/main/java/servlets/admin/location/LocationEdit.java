package servlets.admin.location;

import dao.DaoFactory;
import dao.LocationDao;
import dao.CameraDao;
import dao.SiteManagerLocationDao;
import dao.UserDao;
import model.Camera;
import model.Location;
import model.SiteManagerLocation;
import model.User;
import exception.DaoException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class LocationEdit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final LocationDao locationDao = DaoFactory.getInstance().getLocationDao();
    private final UserDao userDao = DaoFactory.getInstance().getUserDao();
    private final SiteManagerLocationDao smlDao = DaoFactory.getInstance().getSiteManagerLocationDao();
    private final CameraDao cameraDao = DaoFactory.getInstance().getCameraDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/locations");
            return;
        }

        try {
            Long locationId = Long.parseLong(idParam);
            Location location = locationDao.get(locationId);

            List<User> assignedManagers = smlDao.listSiteManagersForLocation(locationId);
            List<User> availableManagers = userDao.listSiteManagers();
            
            List<Camera> linkedCameras = cameraDao.getCamerasByLocation(locationId, true, true);

            // remove already assigned 
            availableManagers.removeIf(u -> assignedManagers.stream().anyMatch(a -> a.getId().equals(u.getId())));

            request.setAttribute("location", location);
            request.setAttribute("assignedManagers", assignedManagers);
            request.setAttribute("availableManagers", availableManagers);
            request.setAttribute("linkedCameras", linkedCameras);

            request.getRequestDispatcher("/jsp/admin/location/LocationEdit.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/locations");
        } catch (Exception e) {
            request.setAttribute("error", "Fehler beim Laden des Standorts: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long locationId = Long.parseLong(request.getParameter("id"));

            // Name edit
            String name = request.getParameter("name");
            if (name != null && !name.trim().isEmpty()) {
                Location location = locationDao.get(locationId);
                location.setLocationName(name.trim());
                locationDao.save(location);
            }

            // add SiteManager
            String addManagerId = request.getParameter("addManagerId");
            if (addManagerId != null) {
                SiteManagerLocation sml = new SiteManagerLocation();
                sml.setLocationId(locationId);
                sml.setUserId(Long.parseLong(addManagerId));
                smlDao.save(sml);
            }

            // delete SiteManager
            String removeManagerId = request.getParameter("removeManagerId");
            if (removeManagerId != null) {
                smlDao.deleteByUserAndLocation(Long.parseLong(removeManagerId), locationId);
            }

            response.sendRedirect(request.getContextPath() + "/admin/location/edit?id=" + locationId);

        } catch (NumberFormatException e) {
            // invalid ID-Parameter
            request.setAttribute("error", "Ungültige ID übergeben.");
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);

        } catch (DaoException e) {
            request.setAttribute("error", "Datenbankfehler: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unerwarteter Fehler: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

}
