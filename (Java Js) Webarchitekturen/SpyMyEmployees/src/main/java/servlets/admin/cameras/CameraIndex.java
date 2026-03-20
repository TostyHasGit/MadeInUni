package servlets.admin.cameras;

import dao.CameraDao;
import dao.DaoFactory;
import dao.ErrorLogDao;
import dao.LocationDao;
import model.Camera;
import model.Location;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class CameraIndex extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final CameraDao cameraDao = DaoFactory.getInstance().getCameraDao();
	private final LocationDao locationDao = DaoFactory.getInstance().getLocationDao();
	private final ErrorLogDao errorLogDao = DaoFactory.getInstance().getErrorLogDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Location> locations = locationDao.list();

		Map<Long, List<Camera>> camerasByLocation = new HashMap<>();
		Map<Long, Boolean> cameraHasUncheckedErrors = new HashMap<>();
		
		for (Location location : locations) {
			List<Camera> cameras = cameraDao.getCamerasByLocation(location.getId(), true, true);
			camerasByLocation.put(location.getId(), cameras);
		}
		
		for (Location location : locations) {
			List<Camera> cameras = cameraDao.getCamerasByLocation(location.getId(), true, true);
			// check for new Errors
			for (Camera cam : cameras) {
				boolean hasUnchecked = !errorLogDao.getLogsByCamera(cam.getId(), false).isEmpty();
				cameraHasUncheckedErrors.put(cam.getId(), hasUnchecked);
			}
			
			camerasByLocation.put(location.getId(), cameras);
		}

		request.setAttribute("locations", locations);
		request.setAttribute("camerasByLocation", camerasByLocation);
		request.setAttribute("cameraHasUncheckedErrors", cameraHasUncheckedErrors);
		request.setAttribute("currentUri", request.getServletPath());

		RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin/cameras/cameraIndex.jsp");
		dispatcher.forward(request, response);
	}
}
