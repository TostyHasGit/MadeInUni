package servlets.controlStation.cameraStation;

import dao.CameraDao;
import dao.DaoFactory;
import dao.LocationDao;
import dao.SiteManagerLocationDao;
import dao.ImageDao;
import model.Camera;
import model.ImageEntry;
import model.Location;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

public class ShowCam extends HttpServlet {
	private final CameraDao cameraDao = DaoFactory.getInstance().getCameraDao();
	private final LocationDao locationDao = DaoFactory.getInstance().getLocationDao();
	private final ImageDao imageDao = DaoFactory.getInstance().getImageDao();
	private final SiteManagerLocationDao smlDao = DaoFactory.getInstance().getSiteManagerLocationDao();

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");

            Long cameraId = Long.parseLong(request.getParameter("cameraId"));
            Camera camera = cameraDao.get(cameraId);

            // Auth
            if (!user.getRole().equals("Boss")) {
                List<Location> allowedLocations = smlDao.listLocationsForSiteManager(user.getId());
                boolean hasAccess = allowedLocations.stream().anyMatch(loc -> loc.getId().equals(camera.getLocationId()));
                if (!hasAccess) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Zugriff verweigert.");
                    return;
                }
            }

            Location location = locationDao.get(camera.getLocationId());

        
            Integer selectedYear = getIntParam(request, "year");
            Integer selectedMonth = getIntParam(request, "month");
            Integer selectedDay = getIntParam(request, "day");
            Integer selectedHour = getIntParam(request, "hour");

  
            Set<Integer> years = imageDao.getAvailableYears(cameraId);
            if (selectedYear == null && years.size() == 1) {
                selectedYear = years.iterator().next();
            }

            Set<Integer> months = (selectedYear != null) ? imageDao.getAvailableMonths(cameraId, selectedYear) : Collections.emptySet();
            if (selectedMonth == null && months.size() == 1) {
                selectedMonth = months.iterator().next();
            }

            Set<Integer> days = (selectedYear != null && selectedMonth != null) ?
                    imageDao.getAvailableDays(cameraId, selectedYear, selectedMonth) : Collections.emptySet();
            if (selectedDay == null && days.size() == 1) {
                selectedDay = days.iterator().next();
            }

            Set<Integer> hours = (selectedYear != null && selectedMonth != null && selectedDay != null) ?
                    imageDao.getAvailableHours(cameraId, selectedYear, selectedMonth, selectedDay) : Collections.emptySet();
            if (selectedHour == null && hours.size() == 1) {
                selectedHour = hours.iterator().next();
            }

            // autofill if only one option
            boolean shouldRedirect =
                    (request.getParameter("year") == null && years.size() == 1) ||
                    (request.getParameter("month") == null && months.size() == 1) ||
                    (request.getParameter("day") == null && days.size() == 1) ||
                    (request.getParameter("hour") == null && hours.size() == 1);

            if (shouldRedirect) {
                StringBuilder url = new StringBuilder(request.getContextPath() + "/showCam?cameraId=" + cameraId);
                if (selectedYear != null) url.append("&year=").append(selectedYear);
                if (selectedMonth != null) url.append("&month=").append(selectedMonth);
                if (selectedDay != null) url.append("&day=").append(selectedDay);
                if (selectedHour != null) url.append("&hour=").append(selectedHour);
                response.sendRedirect(url.toString());
                return;
            }

			List<ImageEntry> imageList = new ArrayList<>();
			String currentImage = null;

			if (selectedYear != null && selectedMonth != null && selectedDay != null && selectedHour != null) {
			    imageList = imageDao.getImageEntriesForHour(cameraId, selectedYear, selectedMonth, selectedDay, selectedHour);
			    if (!imageList.isEmpty()) {
			        currentImage = imageList.get(imageList.size() - 1).getFilePath();
			    }
			}

			request.setAttribute("imageList", imageList);
			request.setAttribute("currentImagePath", currentImage);
			request.setAttribute("camera", camera);
			request.setAttribute("location", location);
			request.setAttribute("years", years);
			request.setAttribute("months", months);
			request.setAttribute("days", days);
			request.setAttribute("hours", hours);
			request.setAttribute("selectedYear", selectedYear);
			request.setAttribute("selectedMonth", selectedMonth);
			request.setAttribute("selectedDay", selectedDay);
			request.setAttribute("selectedHour", selectedHour);
			request.setAttribute("currentImagePath", currentImage);
			
			request.getRequestDispatcher("/jsp/controlStation/cameraStation/showCam.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
	}

	private Integer getIntParam(HttpServletRequest request, String name) {
		String val = request.getParameter(name);
		try {
			return (val != null && !val.isEmpty()) ? Integer.parseInt(val) : null;
		} catch (NumberFormatException e) {
			return null;
		}
	}
}
