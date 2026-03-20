package servlets.admin.siteManager;

import dao.DaoFactory;
import dao.SiteManagerLocationDao;
import dao.UserDao;
import exception.DaoException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Location;
import model.SiteManagerLocation;
import model.User;
import utils.PasswordUtil;

import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class SiteManagerEdit extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDao userDao = DaoFactory.getInstance().getUserDao();
    private final SiteManagerLocationDao smlDao = DaoFactory.getInstance().getSiteManagerLocationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID fehlt");
            return;
        }

        try {
            Long userId = Long.parseLong(idStr);
            User user = userDao.get(userId);

            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Benutzer nicht gefunden");
                return;
            }

            List<Location> allLocations = DaoFactory.getInstance().getLocationDao().list();
            List<Location> assignedLocations = smlDao.listLocationsForSiteManager(userId);

            Set<Long> assignedIds = assignedLocations.stream()
                    .map(Location::getId)
                    .collect(Collectors.toSet());

            List<Location> unassignedLocations = allLocations.stream()
                    .filter(loc -> !assignedIds.contains(loc.getId()))
                    .collect(Collectors.toList());

            request.setAttribute("user", user);
            request.setAttribute("unassignedLocations", unassignedLocations);
            request.setAttribute("assignedLocations", assignedLocations);

            request.getRequestDispatcher("/jsp/admin/siteManager/siteManagerEdit.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ungültige ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long userId = Long.parseLong(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            if (name == null || name.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || role == null || role.trim().isEmpty()) {

                request.setAttribute("error", "Alle Pflichtfelder müssen ausgefüllt sein.");
                doGet(request, response); 
                return;
            }

            User user = userDao.get(userId);
            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Benutzer nicht gefunden");
                return;
            }

            user.setName(name);
            user.setEmail(email);
            user.setRole(role);

            if (password != null && !password.trim().isEmpty()) {
                user.setHashedPassword(PasswordUtil.hashPassword(password));
            }

            userDao.save(user);

            if (role.equals("SiteManager")) {
                String removeLocationId = request.getParameter("removeLocationId");
                String[] addLocationIds = request.getParameterValues("addLocationIds");

                if (removeLocationId != null && !removeLocationId.trim().isEmpty()) {
                    smlDao.deleteByUserAndLocation(userId, Long.parseLong(removeLocationId));
                }

                if (addLocationIds != null) {
                    for (String locIdStr : addLocationIds) {
                        Long locId = Long.parseLong(locIdStr);
                        SiteManagerLocation sml = new SiteManagerLocation();
                        sml.setUserId(userId);
                        sml.setLocationId(locId);
                        smlDao.save(sml);
                    }
                }
            }

            request.setAttribute("user", user);
            request.setAttribute("assignedLocations", smlDao.listLocationsForSiteManager(userId));
            request.setAttribute("unassignedLocations", DaoFactory.getInstance().getLocationDao().list().stream()
                    .filter(loc -> smlDao.listLocationsForSiteManager(userId).stream().noneMatch(assigned -> assigned.getId().equals(loc.getId())))
                    .collect(Collectors.toList()));
            request.setAttribute("success", "Änderungen wurden erfolgreich gespeichert.");
            request.getRequestDispatcher("/jsp/admin/siteManager/siteManagerEdit.jsp").forward(request, response);


        } catch (DaoException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Fehler beim Aktualisieren: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}
