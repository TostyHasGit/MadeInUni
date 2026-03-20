package servlets.profile;

import dao.DaoFactory;
import dao.UserDao;
import exception.DaoException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import utils.PasswordUtil;

import java.io.IOException;


public class ProfileEdit extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDao userDao = DaoFactory.getInstance().getUserDao();
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/jsp/profile/profileEdit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");


            if (name == null || name.trim().isEmpty()
                    || email == null || email.trim().isEmpty()) {

                request.setAttribute("error", "Alle Pflichtfelder müssen ausgefüllt sein.");
                doGet(request, response); 
                return;
            }

            // Authentication 
        	HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute ("user");
            if (user == null) {
            	response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            user.setName(name);
            user.setEmail(email);

            if (password != null && !password.trim().isEmpty()) {
                user.setHashedPassword(PasswordUtil.hashPassword(password));
            }

            userDao.save(user);
            
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("user", user);

            request.setAttribute("user", user);
            request.setAttribute("success", "Änderungen wurden erfolgreich gespeichert.");
            request.getRequestDispatcher("/jsp/profile/profileEdit.jsp").forward(request, response);


        } catch (DaoException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Fehler beim Aktualisieren: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}
