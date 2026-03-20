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

public class ImageDownloader {

    private static final String OUTPUT_DIR = "bilder";
    private static final String ICON_DIR = "bilder/icons";
    private static final String DB_URL = "jdbc:postgresql://db.inftech.hs-mannheim.de/n2112209_WAITDB";
    private static final String DB_USER = "n2112209";
    private static final String DB_PASSWORD = "123456qwertz";

    public static void main(String[] args) {
        ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();

        Runnable task = () -> {
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT id, url FROM cameras WHERE status = 'Active'")) {

                Files.createDirectories(Paths.get(OUTPUT_DIR));
                Files.createDirectories(Paths.get(ICON_DIR));

                while (rs.next()) {
                    int cameraId = rs.getInt("id");
                    String imageUrl = rs.getString("url");

                    if (imageUrl == null || imageUrl.trim().isEmpty()) continue;

                    try {
                        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd_HH-mm"));
                        String filename = "camera_" + cameraId + "_" + timestamp + ".jpg";
                        Path imagePath = Paths.get(OUTPUT_DIR, filename);
                        Path iconPath = Paths.get(ICON_DIR, "icon_" + filename);

                        URL url = new URL(imageUrl);
                        URLConnection connection = url.openConnection();
                        connection.setRequestProperty("User-Agent", "Mozilla/5.0");

                        try (InputStream in = connection.getInputStream()) {
                            BufferedImage original = ImageIO.read(in);
                            if (original != null) {
                                // Bild speichern
                                ImageIO.write(original, "jpg", imagePath.toFile());

                                // Icon erzeugen (150 x 84)
                                BufferedImage icon = resizeImage(original, 150, 84);
                                ImageIO.write(icon, "jpg", iconPath.toFile());

                                // In Datenbank speichern
                                try (PreparedStatement insert = conn.prepareStatement(
                                    "INSERT INTO images (file_path, icon_path, camera_id, capture_time) VALUES (?, ?, ?, ?)")) {
                                    insert.setString(1, imagePath.toString());
                                    insert.setString(2, iconPath.toString());
                                    insert.setInt(3, cameraId);
                                    insert.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
                                    insert.executeUpdate();
                                }
                                System.out.println("✔ Bild & Icon gespeichert für Kamera " + cameraId);
                                
                            } else {
                                System.err.println("✘ Kein Bild erhalten von Kamera ID " + cameraId);
                            }
                        }

                    } catch (Exception e) {
                        System.err.println(" Fehler bei Kamera ID " + cameraId + ": " + e.getMessage());

                        // Fehler auch in die Datenbank schreiben
                        try (PreparedStatement logStmt = conn.prepareStatement(
                                "INSERT INTO ImageErrorLog (Camera_ID, Capture_Time, Description) VALUES (?, ?, ?)")) {
                            logStmt.setInt(1, cameraId);
                            logStmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                            logStmt.setString(3, e.getMessage());
                            logStmt.executeUpdate();
                        } catch (SQLException logEx) {
                            System.err.println("✘ Fehler beim Schreiben in ImageErrorLog: " + logEx.getMessage());
                        }
                    }
                }

            } catch (SQLException | IOException e) {
                System.err.println("✘ DB/IO-Fehler: " + e.getMessage());
            }
        };

        scheduler.scheduleAtFixedRate(task, 0, 5, TimeUnit.MINUTES);
    }

    // Hilfsmethode zur Bildskalierung
    private static BufferedImage resizeImage(BufferedImage original, int width, int height) {
        Image scaled = original.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        BufferedImage icon = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = icon.createGraphics();
        g2d.drawImage(scaled, 0, 0, null);
        g2d.dispose();
        return icon;
    }
}