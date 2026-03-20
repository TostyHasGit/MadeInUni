package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.User;
import exception.*;
import jndi.JndiFactory;



public class UserDaoImpl implements UserDao {

    private final JndiFactory jndi = JndiFactory.getInstance();
    private static final String DATASOURCE = "jdbc/libraryDB1";
    
    

    @Override
    public User get(Long id) {
        if (id == null)
            throw new IllegalArgumentException("id cannot be null");

        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, name, email, hashed_password, role FROM users WHERE id = ?");
            pstmt.setLong(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setHashedPassword(rs.getString("hashed_password"));
                user.setRole(rs.getString("role"));
                return user;
            } else {
            	throw new DaoNotFoundException("User", id);
            }
        } catch (Exception e) {
        	throw new DaoNotFoundException("User", id);
        } finally {
            closeConnection(connection);
        }
    }

    
    @Override
    public void save(User user) {
        if (user == null)
            throw new IllegalArgumentException("user cannot be null");

        Connection connection = null;
        try {
        	connection = jndi.getConnection(DATASOURCE);
            if (user.getId() == null) {
                // Insert
                PreparedStatement pstmt = connection.prepareStatement(
                    "INSERT INTO users (name, email, hashed_password, role) VALUES (?, ?, ?, ?)",
                		PreparedStatement.RETURN_GENERATED_KEYS);
                
                pstmt.setString(1, user.getName());
                pstmt.setString(2, user.getEmail());
                pstmt.setString(3, user.getHashedPassword());
                pstmt.setString(4, user.getRole());
                pstmt.executeUpdate();
                
                // Return generated ID in user Obj
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getLong(1)); 
                }
            } else {
                // Update
                PreparedStatement pstmt = connection.prepareStatement(
                    "UPDATE users SET name = ?, email = ?, hashed_password = ?, role = ? WHERE id = ?");
                pstmt.setString(1, user.getName());
                pstmt.setString(2, user.getEmail());
                pstmt.setString(3, user.getHashedPassword());
                pstmt.setString(4, user.getRole());
                pstmt.setLong(5, user.getId());
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            throw new DaoNotSavedException("User");
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
            PreparedStatement pstmt = connection.prepareStatement("DELETE FROM users WHERE id = ?");
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            throw new DaoNotDeletedException("User", id);
        } finally {
            closeConnection(connection);
        }
    }

    @Override
    public List<User> list() {
        List<User> users = new ArrayList<>();
        Connection connection = null;
        try {
        	connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, name, email, hashed_password, role FROM users");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setHashedPassword(rs.getString("hashed_password"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
            return users;
        } catch (Exception e) {
        	throw new DaoException("Error while listing users", e);
        } finally {
            closeConnection(connection);
        }
    }
    
    @Override
    public List<User> listSiteManagers() {
        List<User> users = new ArrayList<>();
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, name, email, hashed_password, role FROM users WHERE role = 'SiteManager' ORDER BY name ASC");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setHashedPassword(rs.getString("hashed_password"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
            return users;
        } catch (Exception e) {
            throw new DaoException("Error while listing site managers", e);
        } finally {
            closeConnection(connection);
        }
    }
    
    @Override
    public List<User> listBosses() {
        List<User> users = new ArrayList<>();
        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, name, email, hashed_password, role FROM users WHERE role = 'Boss'");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setHashedPassword(rs.getString("hashed_password"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
            return users;
        } catch (Exception e) {
            throw new DaoException("Error while listing Bosses", e);
        } finally {
            closeConnection(connection);
        }
    }
    
    @Override
    public User findByEmail(String email) {
        if (email == null || email.trim().isEmpty())
            throw new IllegalArgumentException("E-Mail darf nicht null oder leer sein.");

        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, name, email, hashed_password, role FROM users WHERE email = ?");
            pstmt.setString(1, email.trim());
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setHashedPassword(rs.getString("hashed_password"));
                user.setRole(rs.getString("role"));
                return user;
            }

            return null; // kein Treffer → gültig für Prüfung auf "E-Mail schon vorhanden?"
        } catch (Exception e) {
            throw new DaoException("Fehler beim Suchen eines Benutzers nach E-Mail", e);
        } finally {
            closeConnection(connection);
        }
    }

    @Override
    public User findByEmailAndPassword(String email, String password) throws DaoException {
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty())
            throw new IllegalArgumentException("E-Mail und Passwort dürfen nicht leer sein.");

        Connection connection = null;
        try {
            connection = jndi.getConnection(DATASOURCE);
            PreparedStatement pstmt = connection.prepareStatement(
                "SELECT id, name, email, hashed_password, role FROM users WHERE email = ? AND hashed_password = ?");
            pstmt.setString(1, email.trim());
            pstmt.setString(2, password.trim()); // Hinweis: Klartext – in echt gehasht vergleichen!
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setHashedPassword(rs.getString("hashed_password"));
                user.setRole(rs.getString("role"));
                return user;
            }

            return null; // kein Treffer
        } catch (Exception e) {
            throw new DaoException("Fehler beim Login (Email + Passwort prüfen)", e);
        } finally {
            closeConnection(connection);
        }
    }



    private void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                // log or ignore
                e.printStackTrace();
            }
        }
    }
 
}
