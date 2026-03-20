package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import jndi.JndiFactory;
import model.Location;
import exception.*;

public class LocationDaoImpl implements LocationDao {

	private static final String DATASOURCE = "jdbc/libraryDB1";
    final JndiFactory jndi = JndiFactory.getInstance();

    @Override
    public Location get(Long id) {
        if (id == null)
            throw new IllegalArgumentException("id cannot be null");
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, location_name FROM locations WHERE id = ?");
            pstmt.setLong(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Location location = new Location();
                location.setId(rs.getLong("id"));
                location.setLocationName(rs.getString("location_name"));
                return location;
            } else {
            	throw new DaoNotFoundException("Location", id);
            }
        } catch (Exception e) {
        	throw new DaoNotFoundException("Location", id);
        } finally {
            closeConnection(connection);
        }
    }

    @Override
    public void save(Location location) {
        if (location == null)
            throw new IllegalArgumentException("location cannot be null");
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            if (location.getId() == null) {
                PreparedStatement pstmt = connection.prepareStatement(
                    "INSERT INTO locations (location_name) VALUES (?)");
                pstmt.setString(1, location.getLocationName());
                pstmt.executeUpdate();
            } else {
                PreparedStatement pstmt = connection.prepareStatement(
                    "UPDATE locations SET location_name = ? WHERE id = ?");
                pstmt.setString(1, location.getLocationName());
                pstmt.setLong(2, location.getId());
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            throw new DaoNotSavedException("Location");
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
            PreparedStatement pstmt = connection.prepareStatement(
                "DELETE FROM locations WHERE id = ?");
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            throw new DaoNotDeletedException("Location", id);
        } finally {
            closeConnection(connection);
        }
    }

    @Override
    public List<Location> list() {
        List<Location> locations = new ArrayList<>();
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, location_name FROM locations ORDER BY location_name ASC");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Location location = new Location();
                location.setId(rs.getLong("id"));
                location.setLocationName(rs.getString("location_name"));
                locations.add(location);
            }
            return locations;
        } catch (Exception e) {
        	throw new DaoException("Error while listing locations", e);
        } finally {
            closeConnection(connection);
        }
    }

    @Override
    public List<Location> getLocationsByUser(Long userId) {
        if (userId == null) return Collections.emptyList();

        List<Location> locations = new ArrayList<>();
        Connection connection = null;

        try {
            connection = jndi.getConnection(DATASOURCE);

            String sql = """
                SELECT l.id, l.location_name
                FROM locations l
                JOIN sitemanagerslocations sml ON l.id = sml.location_id
                WHERE sml.user_id = ?
                ORDER BY l.location_name ASC
            """;

            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setLong(1, userId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Location location = new Location();
                        location.setId(rs.getLong("id"));
                        location.setLocationName(rs.getString("location_name"));
                        locations.add(location);
                    }
                }
            }

            return locations;

        } catch (Exception e) {
            throw new DaoException("Fehler beim Laden der Locations für userId=" + userId, e);
        } finally {
            closeConnection(connection);
        }
    }


    private void closeConnection(Connection connection) {
        if (connection != null) {
            try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
