package servlets.controlStation.cameraStation;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.format.DateTimeFormatter;
import java.util.List;

import dao.DaoFactory;
import dao.ErrorLogDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ErrorLog;

@WebServlet("/getErrorLogs")
public class ErrorLogsServlet extends HttpServlet {
    private final ErrorLogDao errorLogDao = DaoFactory.getInstance().getErrorLogDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");

        List<ErrorLog> logs = errorLogDao.list();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        PrintWriter out = response.getWriter();
        out.print("[");
        for (int i = 0; i < logs.size(); i++) {
            ErrorLog log = logs.get(i);
            String timestamp = log.getCapture_time().format(formatter);
            String text = log.getDescription().replace("\"", "\\\"");

            out.print("{\"timestamp\":\"" + timestamp + "\","
                    + "\"text\":\"" + text + "\"}");

            if (i < logs.size() - 1) out.print(",");
        }
        out.print("]");
    }
}
