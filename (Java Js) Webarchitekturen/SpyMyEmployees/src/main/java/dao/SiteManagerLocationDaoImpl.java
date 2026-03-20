package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jndi.JndiFactory;
import model.*;
import exception.*;

public class SiteManagerLocationDaoImpl implements SiteManagerLocationDao {

    final JndiFactory jndi = JndiFactory.getInstance();
    private static final String DATASOURCE = "jdbc/libraryDB1";
    
    @Override
    public void delete(Long id) {
        if (id == null)
            throw new IllegalArgumentException("id can not be null");

        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement("DELETE FROM SiteManagersLocations WHERE id = ?");
            pstmt.setLong(1, id);
            int affected = pstmt.executeUpdate();
            if (affected == 0) {
                throw new DaoNotDeletedException("SiteManagerLocation", id);
            }
        } catch (Exception e) {
            throw new DaoNotDeletedException("SiteManagerLocation", id);
        } finally {
            closeConnection(connection);
        }
    }
    
    @Override
    public void deleteByUserAndLocation(Long userId, Long locationId) {
        if (userId == null || locationId == null) {
            throw new IllegalArgumentException("userId and locationId must not be null");
        }

        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            String sql = "DELETE FROM SiteManagersLocations WHERE user_id = ? AND location_id = ?";
            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setLong(1, userId);
            pstmt.setLong(2, locationId);
            int affected = pstmt.executeUpdate();
            if (affected == 0) {
                throw new DaoException("Error deleting SiteManagerLocation by userId and locationId");
            }
        } catch (Exception e) {
            throw new DaoException("Error deleting SiteManagerLocation by userId and locationId", e);
        } finally {
            closeConnection(connection);
        }
    }
    
    @Override
    public SiteManagerLocation get(Long id) {
        if (id == null)
            throw new IllegalArgumentException("id can not be null");

        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, user_id, location_id FROM SiteManagersLocations WHERE id = ?");
            pstmt.setLong(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                SiteManagerLocation sml = new SiteManagerLocation();
                sml.setId(rs.getLong("id"));
                sml.setUserId(rs.getLong("user_id"));
                sml.setLocationId(rs.getLong("location_id"));
                return sml;
            } else {
                throw new DaoNotFoundException("SiteManagerLocation", id);
            }
        } catch (Exception e) {
            throw new DaoNotFoundException("SiteManagerLocation", id);
        } finally {
            closeConnection(connection);
        }
    }

    @Override
    public void save(SiteManagerLocation sml) {
        if (sml == null)
            throw new IllegalArgumentException("SiteManagerLocation can not be null");

        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            if (sml.getId() == null) {
                PreparedStatement pstmt = connection.prepareStatement(
                    "INSERT INTO SiteManagersLocations (user_id, location_id) VALUES (?, ?)");
                pstmt.setLong(1, sml.getUserId());
                pstmt.setLong(2, sml.getLocationId());
                pstmt.executeUpdate();
            } else {
                PreparedStatement pstmt = connection.prepareStatement(
                    "UPDATE SiteManagersLocations SET user_id = ?, location_id = ? WHERE id = ?");
                pstmt.setLong(1, sml.getUserId());
                pstmt.setLong(2, sml.getLocationId());
                pstmt.setLong(3, sml.getId());
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            throw new DaoNotSavedException("SiteManagerLocation");
        } finally {
            closeConnection(connection);
        }
    }

    @Override
    public List<SiteManagerLocation> list() {
        List<SiteManagerLocation> list = new ArrayList<>();
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, user_id, location_id FROM SiteManagersLocations");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                SiteManagerLocation sml = new SiteManagerLocation();
                sml.setId(rs.getLong("id"));
                sml.setUserId(rs.getLong("user_id"));
                sml.setLocationId(rs.getLong("location_id"));
                list.add(sml);
            }
            return list;
        } catch (Exception e) {
            throw new DaoException("Error while listing SiteManagerLocations");
        } finally {
            closeConnection(connection);
        }
    }
    
    @Override
    public List<Location> listLocationsForSiteManager(Long id) {
        List<Location> locations = new ArrayList<>();
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT l.id, l.location_name " +
                "FROM locations l " +
                "JOIN SiteManagersLocations sml ON l.id = sml.location_id " +
                "WHERE sml.user_id = ? " +
                "ORDER BY location_name ASC");
            pstmt.setLong(1, id);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Location location = new Location();
                location.setId(rs.getLong("id"));
                location.setLocationName(rs.getString("location_name"));
                locations.add(location);
            }
            return locations;
        } catch (Exception e) {
            throw new DaoException("Error while listing locations for site manager with id " + id, e);
        } finally {
            closeConnection(connection);
        }
    }
    
    @Override
    public List<User> listSiteManagersForLocation(Long id) {
        List<User> siteManagers = new ArrayList<>();
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT u.id, u.name, u.email " +
                "FROM users u " +
                "JOIN SiteManagersLocations sml ON u.id = sml.user_id " +
                "WHERE sml.location_id = ? " +
                "ORDER BY name ASC");
            pstmt.setLong(1, id);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User sm = new User();
                sm.setId(rs.getLong("id"));
                sm.setName(rs.getString("name"));
                sm.setEmail(rs.getString("email"));
                siteManagers.add(sm);
            }
            return siteManagers;
        } catch (Exception e) {
            throw new DaoException("Error while listing siteManagers for location with id " + id, e);
        } finally {
            closeConnection(connection);
        }
    }
    
    @Override
    public List<Location> listLocationsForBoss() {
        List<Location> locations = new ArrayList<>();
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement("SELECT id, location_name FROM locations ORDER BY location_name ASC");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Location location = new Location();
                location.setId(rs.getLong("id"));
                location.setLocationName(rs.getString("location_name"));
                locations.add(location);
            }
            return locations;
        } catch (Exception e) {
            throw new DaoException("Error while listing locations for Boss", e);
        } finally {
            closeConnection(connection);
        }
    }


    private void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
