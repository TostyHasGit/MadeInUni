package servlets.controlStation.cameraStation;

import dao.CameraDao;
import dao.DaoFactory;
import dao.LocationDao;
import dao.SiteManagerLocationDao;
import model.Camera;
import model.Location;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class CameraIndexStation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	private final CameraDao cameraDao = DaoFactory.getInstance().getCameraDao();
	private final SiteManagerLocationDao siteManagerLocationDao = DaoFactory.getInstance().getSiteManagerLocationDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        List<Location> locations;
        if ("Boss".equals(user.getRole())) {
            locations = siteManagerLocationDao.listLocationsForBoss();
        } else {
            locations = siteManagerLocationDao.listLocationsForSiteManager(user.getId());
        }
        
		Map<Long, List<Camera>> camerasByLocation = new HashMap<>();
		for (Location location : locations) {
			List<Camera> cameras = cameraDao.getCamerasByLocation(location.getId(), false, false);
			camerasByLocation.put(location.getId(), cameras);
		}

		request.setAttribute("locations", locations);
		request.setAttribute("camerasByLocation", camerasByLocation);
		request.setAttribute("currentUri", request.getServletPath());

		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/jsp/controlStation/cameraStation/cameraIndexStation.jsp");
		dispatcher.forward(request, response);
	}
}
