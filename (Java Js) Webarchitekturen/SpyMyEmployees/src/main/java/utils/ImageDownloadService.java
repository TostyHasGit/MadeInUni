package utils;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.*;
import java.nio.file.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.*;
import javax.imageio.ImageIO;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import jndi.JndiFactory;

public class ImageDownloadService {
	private static final String DATASOURCE = "jdbc/libraryDB1";
	final JndiFactory jndi = JndiFactory.getInstance();

    private ScheduledExecutorService scheduler;

    public void start() {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(this::downloadImages, 0, 5, TimeUnit.MINUTES);
    }

    public void stop() {
        if (scheduler != null) scheduler.shutdownNow();
    }

    private void downloadImages() {
        String baseDir;
        try {
            Context initContext = new InitialContext();
            baseDir = (String) initContext.lookup("java:comp/env/project.root");
        } catch (NamingException e) {
            System.err.println("Projektpfad konnte nicht aus context.xml geladen werden, benutze aktuelles Verzeichnis.");
            baseDir = ".";
        }

        Path outputDir = Paths.get(baseDir, "bilder");
        Path iconDir = outputDir.resolve("icons");

        try (Connection conn = jndi.getConnection(DATASOURCE);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, url FROM cameras WHERE status = 'Active'")) {

            Files.createDirectories(outputDir);
            Files.createDirectories(iconDir);

            while (rs.next()) {
                int cameraId = rs.getInt("id");
                String imageUrl = rs.getString("url");

                if (imageUrl == null || imageUrl.isBlank()) continue;

                try {
                    String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd_HH-mm"));
                    String filename = "camera_" + cameraId + "_" + timestamp + ".jpg";
                    Path imagePath = outputDir.resolve(filename);
                    Path iconPath = iconDir.resolve("icon_" + filename);

                    URL url = new URL(imageUrl);
                    URLConnection connUrl = url.openConnection();
                    connUrl.setConnectTimeout(10000);
                    connUrl.setReadTimeout(10000);
                    connUrl.setRequestProperty("User-Agent", "Mozilla/5.0");

                    try (InputStream in = connUrl.getInputStream()) {
                        BufferedImage original = ImageIO.read(in);
                        if (original != null) {
                            ImageIO.write(original, "jpg", imagePath.toFile());
                            BufferedImage icon = resizeImage(original, 150, 84);
                            ImageIO.write(icon, "jpg", iconPath.toFile());

                            try (PreparedStatement insert = conn.prepareStatement(
                                    "INSERT INTO images (file_path, icon_path, camera_id, capture_time) VALUES (?, ?, ?, ?)")) {
                            	insert.setString(1, "bilder/" + filename);
                            	insert.setString(2, "bilder/icons/icon_" + filename);
                                insert.setInt(3, cameraId);
                                insert.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
                                insert.executeUpdate();
                            }

                            System.out.println("Bild gespeichert: " + filename);
                        } else {
                            System.err.println("Kein Bild empfangen von Kamera " + cameraId);
                        }
                    }

                } catch (Exception e) {
                    System.err.println("✘ Fehler bei Kamera " + cameraId + ": " + e.getMessage());
                    try (PreparedStatement logStmt = conn.prepareStatement(
                            "INSERT INTO imageerrorlog (camera_id, capture_time, description) VALUES (?, ?, ?)")) {
                        logStmt.setInt(1, cameraId);
                        logStmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                        logStmt.setString(3, e.getMessage());
                        logStmt.executeUpdate();
                    } catch (SQLException ex) {
                        System.err.println("Fehler beim Schreiben in imageerrorlog: " + ex.getMessage());
                    }
                }
            }

        } catch (Exception e) {
            System.err.println("Allgemeiner Fehler beim Bild-Download: " + e.getMessage());
        }
    }

    private BufferedImage resizeImage(BufferedImage original, int width, int height) {
        Image scaled = original.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        BufferedImage icon = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = icon.createGraphics();
        g2d.drawImage(scaled, 0, 0, null);
        g2d.dispose();
        return icon;
    }
}
