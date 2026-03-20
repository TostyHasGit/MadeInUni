package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jndi.JndiFactory;
import model.Camera;
import model.ErrorLog;
import exception.*;

public class ErrorLogDaoImpl implements ErrorLogDao {

	private static final String DATASOURCE = "jdbc/libraryDB1";
	final JndiFactory jndi = JndiFactory.getInstance();

	@Override
	public ErrorLog get(Long id) {
		if (id == null)
			throw new IllegalArgumentException("id cannot be null");
		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			PreparedStatement pstmt = connection.prepareStatement(
					"SELECT ID, Camera_ID, Capture_Time, Checked, Description FROM ImageErrorLog WHERE id = ?");
			pstmt.setLong(1, id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				ErrorLog log = new ErrorLog();
				log.setId(rs.getLong("ID"));
				log.setCamer_id(rs.getLong("Camera_ID"));
				log.setCapture_time(rs.getTimestamp("Capture_Time").toLocalDateTime());
				log.setChecked(rs.getBoolean("Checked"));
				log.setDescription(rs.getString("Description"));
				return log;
			} else {
				throw new DaoNotFoundException("ErrorLog", id);
			}
		} catch (Exception e) {
			throw new DaoNotFoundException("ErrorLog", id);
		} finally {
			closeConnection(connection);
		}
	}

	@Override
	public void save(ErrorLog log) {
		if (log == null)
			throw new IllegalArgumentException("ErrorLog cannot be null");

		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			if (log.getId() == null) {
				PreparedStatement pstmt = connection.prepareStatement(
						"INSERT INTO ImageErrorLog (Camera_ID, Capture_Time, Checked, description) VALUES (?, ?, ?, ?)");
				pstmt.setLong(1, log.getCamer_id());
				pstmt.setTimestamp(2, java.sql.Timestamp.valueOf(log.getCapture_time()));
				pstmt.setBoolean(3, log.isChecked());
				pstmt.setString(4, log.getDescription());
				pstmt.executeUpdate();
			} else {
				PreparedStatement pstmt = connection.prepareStatement(
						"UPDATE ImageErrorLog SET Camera_ID = ?, Capture_Time = ?, Checked = ?, Description = ? WHERE id = ?");
				pstmt.setLong(1, log.getCamer_id());
				pstmt.setTimestamp(2, java.sql.Timestamp.valueOf(log.getCapture_time()));
				pstmt.setBoolean(3, log.isChecked());
				pstmt.setString(4, log.getDescription());
				pstmt.setLong(5, log.getId());
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new DaoNotSavedException("ErrorLog");
		} finally {
			closeConnection(connection);
		}
	}

	@Override
	public void delete(Long id) {
		if (id == null)
			throw new IllegalArgumentException("id cannot be null");
		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			PreparedStatement pstmt = connection.prepareStatement("DELETE FROM ImageErrorLog WHERE id = ?");
			pstmt.setLong(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			throw new DaoNotDeletedException("ErrorLog", id);
		} finally {
			closeConnection(connection);
		}
	}

	@Override
	public List<ErrorLog> list() {
		List<ErrorLog> logs = new ArrayList<>();
		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			PreparedStatement pstmt = connection
					.prepareStatement("SELECT ID, Camera_ID, Capture_Time, Checked, Description FROM ImageErrorLog ORDER BY ID ASC");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ErrorLog log = new ErrorLog();
				log.setId(rs.getLong("ID"));
				log.setCamer_id(rs.getLong("Camera_ID"));
				log.setCapture_time(rs.getTimestamp("Capture_Time").toLocalDateTime());
				log.setChecked(rs.getBoolean("Checked"));
				log.setDescription(rs.getString("Description"));
				System.out.println("Log: " + log.getDescription() + " @ " + log.getCapture_time()); // DEBUG
				logs.add(log);
			}
			return logs;
		} catch (Exception e) {
			throw new DaoException("Error while listing ErrorLogs", e);
		} finally {
			closeConnection(connection);
		}
	}

	@Override
	public List<ErrorLog> getLogsByCamera(Long cameraId, boolean all) {
		if (cameraId == null)
			throw new IllegalArgumentException("cameraId cannot be null");

		List<ErrorLog> logs = new ArrayList<>();
		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			PreparedStatement pstmt;
			if (all) {
				pstmt = connection
						.prepareStatement("SELECT id, Camera_ID, Capture_Time, Checked, Description FROM ImageErrorLog WHERE Camera_ID = ? ORDER BY Capture_Time DESC");
			}
			else {
				pstmt = connection
						.prepareStatement("SELECT id, Camera_ID, Capture_Time, Checked, Description FROM ImageErrorLog WHERE Camera_ID = ? AND Checked = False ORDER BY Capture_Time DESC");
			
			}
			pstmt.setLong(1, cameraId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ErrorLog log = new ErrorLog();
				log.setId(rs.getLong("ID"));
				log.setCamer_id(rs.getLong("Camera_ID"));
				log.setCapture_time(rs.getTimestamp("Capture_Time").toLocalDateTime());
				log.setChecked(rs.getBoolean("Checked"));
				log.setDescription(rs.getString("Description"));
				logs.add(log);
			}
			return logs;
		} catch (Exception e) {
			throw new DaoException("Fehler beim Laden der ErrorLogs für Kamera " + cameraId, e);
		} finally {
			closeConnection(connection);
		}
	}
	
	@Override
	public void markAllAsChecked(Long cameraId) {
		if (cameraId == null)
			throw new IllegalArgumentException("cameraId cannot be null");

		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			PreparedStatement pstmt = connection.prepareStatement(
				"UPDATE ImageErrorLog SET Checked = TRUE WHERE Camera_ID = ? AND Checked = FALSE");
			pstmt.setLong(1, cameraId);
			int updated = pstmt.executeUpdate();
			System.out.println("Fehlerprotokolle als geprüft markiert: " + updated); // optionales Logging
		} catch (Exception e) {
			throw new DaoException("Fehler beim Markieren der ErrorLogs als geprüft für Kamera-ID " + cameraId, e);
		} finally {
			closeConnection(connection);
		}
	}


	private void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
