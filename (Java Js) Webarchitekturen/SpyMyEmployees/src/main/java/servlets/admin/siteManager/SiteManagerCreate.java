package servlets.admin.siteManager;

import dao.UserDao;
import dao.SiteManagerLocationDao;
import dao.DaoFactory;
import exception.DaoException;
import model.Location;
import model.SiteManagerLocation;
import model.User;
import utils.PasswordUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;




public class SiteManagerCreate extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDao userDao = DaoFactory.getInstance().getUserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	List<Location> allLocations = DaoFactory.getInstance().getLocationDao().list();
    	request.setAttribute("locations", allLocations);
    	
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/admin/siteManager/siteManagerCreate.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String[] selectedLocationIds = request.getParameterValues("locationIds");
        
        

        // Validation
        
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
        		|| role == null || role.trim().isEmpty()) {

        	request.setAttribute("error", "Alle Felder müssen ausgefüllt sein.");
            request.setAttribute("locations", DaoFactory.getInstance().getLocationDao().list());
            request.setAttribute("inputName", name);
            request.setAttribute("inputEmail", email);
            request.setAttribute("inputRole", role);
            
            request.getRequestDispatcher("/jsp/admin/siteManager/siteManagerCreate.jsp").forward(request, response);
            return;
        }
    	   
        
        try {
        	
        	// Unique Email
            User existingUser = userDao.findByEmail(email.trim());
            if (existingUser != null) {
                request.setAttribute("error", "Ein Benutzer mit dieser E-Mail-Adresse existiert bereits.");
                request.setAttribute("locations", DaoFactory.getInstance().getLocationDao().list());
                request.setAttribute("inputName", name);
                request.setAttribute("inputEmail", email);
                request.setAttribute("inputRole", role);
               
                request.getRequestDispatcher("/jsp/admin/siteManager/siteManagerCreate.jsp").forward(request, response);
                return;
            }
            
            
            String hashedPassword = PasswordUtil.hashPassword(password);

            User user = new User();
            user.setName(name.trim());
            user.setEmail(email.trim());
            user.setHashedPassword(hashedPassword);
            
            if (role.equals("Boss")) {
            	user.setRole("Boss");
            	userDao.save(user);
         
        	} else if (role.equals("SiteManager")) {
            	user.setRole("SiteManager");
            	userDao.save(user);
            	
            	if (selectedLocationIds != null) {
                    SiteManagerLocationDao smLocationDao = DaoFactory.getInstance().getSiteManagerLocationDao();
                    for (String idStr : selectedLocationIds) {
                    	SiteManagerLocation sml = new SiteManagerLocation();
                    	
                    	Long locationId = Long.parseLong(idStr);
                        sml.setLocationId(locationId);
                        sml.setUserId(user.getId());
                        smLocationDao.save(sml);
                    }
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/siteManagers");

        } catch (DaoException e) {
            e.printStackTrace();
            request.setAttribute("error", "Fehler beim Erstellen des SiteManagers: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}
