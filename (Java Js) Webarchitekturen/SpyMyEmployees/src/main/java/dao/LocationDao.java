package dao;

import java.util.List;

import model.Camera;
import model.Location;

public interface LocationDao {
    Location get(Long id);
    void save(Location location);
    void delete(Long id);
    List<Location> list();
	List<Location> getLocationsByUser(Long userId);
}
