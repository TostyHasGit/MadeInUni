package utils;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppStartupListener implements ServletContextListener {
    private ImageDownloadService service;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        service = new ImageDownloadService();
        service.start();
        System.out.println("[INFO] ImageDownloadService gestartet.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (service != null) {
            service.stop();
            System.out.println("[INFO] ImageDownloadService gestoppt.");
        }
    }
}
