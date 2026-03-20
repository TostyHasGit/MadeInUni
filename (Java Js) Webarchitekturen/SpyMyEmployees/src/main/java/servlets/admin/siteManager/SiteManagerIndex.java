package servlets.admin.siteManager;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UserDao;
import dao.LocationDao;
import dao.SiteManagerLocationDao;
import dao.DaoFactory;

import model.User;
import model.Location;

public class SiteManagerIndex extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDao userDao = DaoFactory.getInstance().getUserDao();
    private final SiteManagerLocationDao siteManagerLocationDao = DaoFactory.getInstance().getSiteManagerLocationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // All SiteManager 
        List<User> siteManagers = userDao.listSiteManagers();
        
        // All Bosses
        List<User> bosses = userDao.listBosses();

        // Map SiteManager -> List<Location>
        Map<User, List<Location>> siteManagerLocations = new LinkedHashMap<>();

        for (User sm : siteManagers) {
            List<Location> locations = siteManagerLocationDao.listLocationsForSiteManager(sm.getId());
            siteManagerLocations.put(sm, locations);
        }

        request.setAttribute("siteManagerLocations", siteManagerLocations);
        request.setAttribute("currentUri", request.getServletPath());
        request.setAttribute("bosses", bosses);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin/siteManager/siteManagerIndex.jsp");
        dispatcher.forward(request, response);
    }
}
