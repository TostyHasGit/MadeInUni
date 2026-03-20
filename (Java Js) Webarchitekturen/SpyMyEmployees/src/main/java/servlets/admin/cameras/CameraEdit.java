package servlets.admin.cameras;

import dao.CameraDao;
import dao.DaoFactory;
import dao.ErrorLogDao;
import dao.SiteManagerLocationDao;
import dao.UserDao;
import dao.LocationDao;
import dao.ImageDao;
import model.Camera;
import model.ErrorLog;
import model.SiteManagerLocation;
import model.User;
import model.Location;
import exception.DaoException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CameraEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final CameraDao cameraDao = DaoFactory.getInstance().getCameraDao();
	private final UserDao userDao = DaoFactory.getInstance().getUserDao();
	private final SiteManagerLocationDao smlDao = DaoFactory.getInstance().getSiteManagerLocationDao();
	private final LocationDao locationDao = DaoFactory.getInstance().getLocationDao();
	private final ImageDao imageDao = DaoFactory.getInstance().getImageDao();
	private final ErrorLogDao errorLogDao = DaoFactory.getInstance().getErrorLogDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idParam = request.getParameter("id");

		if (idParam == null || idParam.trim().isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/admin/cameras");
			return;
		}

		try {
			Long cameraId = Long.parseLong(idParam);
			Camera camera = cameraDao.get(cameraId);

			Long locationId = camera.getLocationId();
			List<User> assignedManagers = smlDao.listSiteManagersForLocation(locationId);
			List<User> availableManagers = userDao.listSiteManagers();
			List<Location> allLocations = locationDao.list();

			availableManagers.removeIf(u -> assignedManagers.stream().anyMatch(a -> a.getId().equals(u.getId())));

			// Get newest picture
			String imagePath = imageDao.getLastImagePathForCamera(cameraId);
			String latestImagePath = imagePath == "" ? "images/placeholder.jpg" : imagePath;
			request.setAttribute("latestImagePath", latestImagePath);

			request.setAttribute("camera", camera);
			request.setAttribute("assignedManagers", assignedManagers);
			request.setAttribute("availableManagers", availableManagers);
			request.setAttribute("allLocations", allLocations);
			
			// Get Error Log
			List<ErrorLog> errorLogs = errorLogDao.getLogsByCamera(cameraId, true);
			List<ErrorLog> uncheckedLogs = errorLogDao.getLogsByCamera(cameraId, false);

			request.setAttribute("errorLogs", errorLogs);
			request.setAttribute("uncheckedLogs", uncheckedLogs);
			
			

			request.getRequestDispatcher("/jsp/admin/cameras/cameraEdit.jsp").forward(request, response);

		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/admin/cameras");
		} catch (Exception e) {
			request.setAttribute("error", "Fehler beim Laden der Kamera: " + e.getMessage());
			request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
	        String idParam = request.getParameter("id");
	        if (idParam == null || idParam.trim().isEmpty()) {
	            throw new IllegalArgumentException("Kamera-ID fehlt.");
	        }

	        Long cameraId = Long.parseLong(idParam);

	        // Error Log check
	        String markErrorsChecked = request.getParameter("markErrorsChecked");
	        if ("true".equalsIgnoreCase(markErrorsChecked)) {
	            errorLogDao.markAllAsChecked(cameraId);
	            response.sendRedirect(request.getContextPath() + "/admin/camera/edit?id=" + cameraId);
	            return;
	        }

	        Camera camera = cameraDao.get(cameraId);
	        if (camera == null) {
	            throw new IllegalArgumentException("Kamera mit ID " + cameraId + " nicht gefunden.");
	        }

			String name = request.getParameter("name");
			String description = request.getParameter("description");
			String url = request.getParameter("url");
			String status = request.getParameter("status");
			String locationIdParam = request.getParameter("locationId");

			if (name != null)
				camera.setName(name.trim());
			if (description != null)
				camera.setDescription(description.trim());
			if (url != null)
				camera.setUrl(url.trim());

			if ("true".equalsIgnoreCase(status)) {
				camera.setStatus("Active");
			} else if ("false".equalsIgnoreCase(status)) {
				camera.setStatus("Inactive");
			} else {
				throw new IllegalArgumentException("Ungültiger Statuswert: " + status);
			}

			if (locationIdParam != null)
				camera.setLocationId(Long.parseLong(locationIdParam));

			cameraDao.save(camera);

			// SiteManager add
			String addManagerId = request.getParameter("addManagerId");
			if (addManagerId != null) {
				SiteManagerLocation sml = new SiteManagerLocation();
				sml.setLocationId(camera.getLocationId());
				sml.setUserId(Long.parseLong(addManagerId));
				smlDao.save(sml);
			}

			// SiteManager delete
			String removeManagerId = request.getParameter("removeManagerId");
			if (removeManagerId != null) {
				smlDao.deleteByUserAndLocation(Long.parseLong(removeManagerId), camera.getLocationId());
			}

			response.sendRedirect(request.getContextPath() + "/admin/camera/edit?id=" + cameraId);

		} catch (NumberFormatException e) {
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
