package servlets.controlStation.cameraStation;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import dao.CameraDao;
import dao.DaoFactory;
import dao.SiteManagerLocationDao;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Camera;
import model.User;

@WebServlet("/bilder/*")
public class AuthImageServlet extends HttpServlet {

    private static final String BASE_PATH = "D:/HSMA/6. Sem/WAI/wai06/SpyMyEmployees/bilder/";
    private final CameraDao cameraDao = DaoFactory.getInstance().getCameraDao();
    private final SiteManagerLocationDao smlDao = DaoFactory.getInstance().getSiteManagerLocationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        String requestedFile = request.getPathInfo(); 

        if (user == null || requestedFile == null || requestedFile.length() <= 1) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Long cameraId = extractCameraId(requestedFile);
        if (cameraId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ungültiger Dateiname.");
            return;
        }

        try {
            Camera camera = cameraDao.get(cameraId);

     
            if ("SiteManager".equals(user.getRole())) {
                List<Long> allowedLocationIds = smlDao.listLocationsForSiteManager(user.getId()).stream()
                        .map(loc -> loc.getId()).toList();
                if (!allowedLocationIds.contains(camera.getLocationId())) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Kein Zugriff auf dieses Bild.");
                    return;
                }
            }

            File file = new File(BASE_PATH, requestedFile);
            System.out.println("Gesuchter Pfad: " + file.getAbsolutePath());

            if (!file.exists() || file.isDirectory()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            response.setContentType(getServletContext().getMimeType(file.getName()));
            response.setContentLengthLong(file.length());

            try (FileInputStream fis = new FileInputStream(file);
                 ServletOutputStream out = response.getOutputStream()) {
                fis.transferTo(out);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Fehler beim Laden des Bildes.");
        }
    }

    private Long extractCameraId(String path) {
        try {
            String name = new File(path).getName();
            String[] parts = name.split("_");
           
            if (parts.length >= 3 && (parts[0].equals("camera") || parts[0].equals("icon") && parts[1].equals("camera"))) {
                return Long.parseLong(parts[parts[0].equals("icon") ? 2 : 1]);
            }
        } catch (Exception ignored) {}
        return null;
    }
}
