package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.naming.NamingException;

import jndi.JndiFactory;
import model.ImageEntry;
import exception.*;

public class ImageDaoImpl implements ImageDao {
	private final JndiFactory jndi = JndiFactory.getInstance();
	private static final String DATASOURCE = "jdbc/libraryDB1";

	@Override
	public String getLastImagePathForCamera(Long cameraId) {
		String path = "";
		String sql;
		sql = "SELECT file_path FROM images WHERE camera_id = ? ORDER BY capture_time DESC LIMIT 1";

		try (Connection conn = jndi.getConnection(DATASOURCE); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, cameraId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				path = rs.getString("file_path");
			}
		} catch (SQLException | NamingException e) {
			throw new DaoException("Fehler beim Laden der Bildpfade", e);
		}
		return path;
	}

	public Set<Integer> getAvailableYears(Long cameraId) {
	    Set<Integer> years = new TreeSet<>();
	    String sql = "SELECT DISTINCT EXTRACT(YEAR FROM capture_time) AS year FROM images WHERE camera_id = ?";
	    try (Connection conn = jndi.getConnection(DATASOURCE);
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setLong(1, cameraId);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            years.add(rs.getInt("year"));
	        }
	    } catch (SQLException | NamingException e) {
	        throw new DaoException("Fehler beim Laden der Jahre", e);
	    }
	    return years;
	}

	public Set<Integer> getAvailableMonths(Long cameraId, int year) {
	    Set<Integer> months = new TreeSet<>();
	    String sql = "SELECT DISTINCT EXTRACT(MONTH FROM capture_time) AS month FROM images WHERE camera_id = ? AND EXTRACT(YEAR FROM capture_time) = ?";
	    try (Connection conn = jndi.getConnection(DATASOURCE);
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setLong(1, cameraId);
	        ps.setInt(2, year);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            months.add(rs.getInt("month"));
	        }
	    } catch (SQLException | NamingException e) {
	        throw new DaoException("Fehler beim Laden der Monate", e);
	    }
	    return months;
	}

	public Set<Integer> getAvailableDays(Long cameraId, int year, int month) {
	    Set<Integer> days = new TreeSet<>();
	    String sql = "SELECT DISTINCT EXTRACT(DAY FROM capture_time) AS day FROM images WHERE camera_id = ? AND EXTRACT(YEAR FROM capture_time) = ? AND EXTRACT(MONTH FROM capture_time) = ?";
	    try (Connection conn = jndi.getConnection(DATASOURCE);
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setLong(1, cameraId);
	        ps.setInt(2, year);
	        ps.setInt(3, month);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            days.add(rs.getInt("day"));
	        }
	    } catch (SQLException | NamingException e) {
	        throw new DaoException("Fehler beim Laden der Tage", e);
	    }
	    return days;
	}

	public Set<Integer> getAvailableHours(Long cameraId, int year, int month, int day) {
	    Set<Integer> hours = new TreeSet<>();
	    String sql = "SELECT DISTINCT EXTRACT(HOUR FROM capture_time) AS hour FROM images WHERE camera_id = ? AND EXTRACT(YEAR FROM capture_time) = ? AND EXTRACT(MONTH FROM capture_time) = ? AND EXTRACT(DAY FROM capture_time) = ?";
	    try (Connection conn = jndi.getConnection(DATASOURCE);
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setLong(1, cameraId);
	        ps.setInt(2, year);
	        ps.setInt(3, month);
	        ps.setInt(4, day);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            hours.add(rs.getInt("hour"));
	        }
	    } catch (SQLException | NamingException e) {
	        throw new DaoException("Fehler beim Laden der Stunden", e);
	    }
	    return hours;
	}

	public List<ImageEntry> getImageEntriesForHour(Long cameraId, int year, int month, int day, int hour) {
	    List<ImageEntry> list = new ArrayList<>();
	    String sql = """
	        SELECT icon_path, file_path, Capture_Time FROM images
	        WHERE camera_id = ?
	        AND EXTRACT(YEAR FROM capture_time) = ?
	        AND EXTRACT(MONTH FROM capture_time) = ?
	        AND EXTRACT(DAY FROM capture_time) = ?
	        AND EXTRACT(HOUR FROM capture_time) = ?
	        ORDER BY capture_time
	    """;
	    try (Connection conn = jndi.getConnection(DATASOURCE);
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setLong(1, cameraId);
	        ps.setInt(2, year);
	        ps.setInt(3, month);
	        ps.setInt(4, day);
	        ps.setInt(5, hour);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	        	String iconPath = rs.getString("icon_path");
	        	String filePath = rs.getString("file_path");
	        	Timestamp timestamp = rs.getTimestamp("capture_time");
	        	LocalDateTime captureTime = timestamp.toLocalDateTime();

	        	list.add(new ImageEntry(iconPath, filePath, captureTime));
	        }
	    } catch (SQLException | NamingException e) {
	        throw new DaoException("Fehler beim Laden der Bilder", e);
	    }
	    return list;
	}
}
