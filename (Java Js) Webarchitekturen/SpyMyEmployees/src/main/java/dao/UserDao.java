package dao;

import java.util.List;
import model.User;
import exception.DaoException;


public interface UserDao {
    User get(Long id);
    void save(User user);
    void delete(Long id);
    List<User> list();
    List<User> listSiteManagers();
    List<User> listBosses();
    User findByEmail(String email);
    User findByEmailAndPassword(String email, String password) throws DaoException;

    
}
