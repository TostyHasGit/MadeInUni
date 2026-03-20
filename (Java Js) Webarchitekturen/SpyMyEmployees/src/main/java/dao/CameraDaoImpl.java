package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jndi.JndiFactory;
import model.Camera;
import exception.*;

public class CameraDaoImpl implements CameraDao {

	private static final String DATASOURCE = "jdbc/libraryDB1";
	final JndiFactory jndi = JndiFactory.getInstance();

	@Override
	public Camera get(Long id) {
		if (id == null)
			throw new IllegalArgumentException("id cannot be null");

		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			PreparedStatement pstmt = connection.prepareStatement(
					"SELECT id, name, url, description, status, location_id FROM cameras WHERE id = ?");
			pstmt.setLong(1, id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				Camera camera = new Camera();
				camera.setId(rs.getLong("id"));
				camera.setName(rs.getString("name"));
				camera.setUrl(rs.getString("url"));
				camera.setDescription(rs.getString("description"));
				camera.setStatus(rs.getString("status"));
				camera.setLocationId(rs.getLong("location_id"));
				return camera;
			} else {
				throw new DaoNotFoundException("Camera", id);
			}
		} catch (Exception e) {
			throw new DaoNotFoundException("Camera", id);
		} finally {
			closeConnection(connection);
		}
	}

	@Override
	public void save(Camera camera) {
		if (camera == null)
			throw new IllegalArgumentException("Camera cannot be null");

		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			if (camera.getId() == null) {
				PreparedStatement pstmt = connection.prepareStatement(
						"INSERT INTO cameras (name, url, description, status, location_id) VALUES (?, ?, ?, ?, ?)");
				pstmt.setString(1, camera.getName());
				pstmt.setString(2, camera.getUrl());
				pstmt.setString(3, camera.getDescription());
				pstmt.setString(4, camera.getStatus());
				pstmt.setLong(5, camera.getLocationId());
				pstmt.executeUpdate();
			} else {
				PreparedStatement pstmt = connection.prepareStatement(
						"UPDATE cameras SET name = ?, url = ?, description = ?, status = ?, location_id = ? WHERE id = ?");
				pstmt.setString(1, camera.getName());
				pstmt.setString(2, camera.getUrl());
				pstmt.setString(3, camera.getDescription());
				pstmt.setString(4, camera.getStatus());
				pstmt.setLong(5, camera.getLocationId());
				pstmt.setLong(6, camera.getId());
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new DaoNotSavedException("Camera");
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
			PreparedStatement pstmt = connection.prepareStatement("DELETE FROM cameras WHERE id = ?");
			pstmt.setLong(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			throw new DaoNotDeletedException("Camera", id);
		} finally {
			closeConnection(connection);
		}
	}

	@Override
	public List<Camera> list() {
		List<Camera> cameras = new ArrayList<>();
		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			PreparedStatement pstmt = connection
					.prepareStatement("SELECT id, name, status FROM cameras ORDER BY name ASC");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Camera camera = new Camera();
				camera.setId(rs.getLong("id"));
				camera.setName(rs.getString("name"));
				camera.setStatus(rs.getString("status"));
				cameras.add(camera);
			}
			return cameras;
		} catch (Exception e) {
			throw new DaoException("Error while listing cameras", e);
		} finally {
			closeConnection(connection);
		}
	}

	@Override
	public List<Camera> getCamerasByLocation(Long locationId, boolean all, boolean isAdmin) {
		if (locationId == null)
			throw new IllegalArgumentException("locationId cannot be null");

		List<Camera> cameras = new ArrayList<>();
		Connection connection = null;
		try {
			connection = jndi.getConnection(DATASOURCE);
			PreparedStatement pstmt;

			StringBuilder baseQuery = new StringBuilder("""
			    SELECT id, name, location_id, status
			    FROM cameras c
			    WHERE location_id = ?
			""");

			// Nur Kameras mit Bildern anzeigen, wenn kein Admin
			if (!isAdmin) {
				baseQuery.append("""
				    AND EXISTS (
				        SELECT 1 FROM images i WHERE i.camera_id = c.id
				    )
				""");
			}

			// Nur aktive Kameras anzeigen, wenn all == false
			if (!all) {
				baseQuery.append(" AND status = 'Active'");
			}

			pstmt = connection.prepareStatement(baseQuery.toString());
			pstmt.setLong(1, locationId);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Camera camera = new Camera();
				camera.setId(rs.getLong("id"));
				camera.setName(rs.getString("name"));
				camera.setLocationId(rs.getLong("location_id"));
				camera.setStatus(rs.getString("status"));
				cameras.add(camera);
			}
			return cameras;
		} catch (Exception e) {
			throw new DaoException("Fehler beim Laden der Kameras für Standort " + locationId, e);
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
