package auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import dao.UserDao;
import dao.UserDaoImpl;
import model.User;
import utils.PasswordUtil;

@WebServlet("/login")  
public class LoginServlet extends HttpServlet {

    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
        	
            dataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/libraryDB1");
        } catch (Exception e) {
            throw new ServletException("Datenquelle nicht gefunden", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/jsp/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    
    
            throws ServletException, IOException {
    	System.out.println(">> LoginServlet wurde aufgerufen!");


        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String hashedPassword = PasswordUtil.hashPassword(password);
        UserDao userDao = new UserDaoImpl();
        User user = userDao.findByEmailAndPassword(email, hashedPassword);
        System.out.println("Loginversuch: " + email + " mit Hash: " + hashedPassword);


        try {


            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userName", user.getName());
                session.setAttribute("userRole", user.getRole());

                switch (user.getRole()) {
                case "Admin":
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    break;
                case "SiteManager":
                    response.sendRedirect(request.getContextPath() + "/cameras");
                    break;
                case "Boss":
                    response.sendRedirect(request.getContextPath() + "/cameras");
                    break;
                default:
                	response.sendRedirect(request.getContextPath() + "/login");
            }


            } else {
            	request.setAttribute("errorMessage", "E-Mail oder Passwort ist falsch.");
                request.getRequestDispatcher("/jsp/auth/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException("Login fehlgeschlagen", e);
        }
    }
}
