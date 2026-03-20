package dao;

import java.util.List;
import model.*;

public interface SiteManagerLocationDao {


	SiteManagerLocation get(Long id);
    void save(SiteManagerLocation location);
    void delete(Long id);
    public void deleteByUserAndLocation(Long userId, Long locationId);
    List<SiteManagerLocation> list();
    List<Location> listLocationsForSiteManager(Long id);
    public List<User> listSiteManagersForLocation(Long id);
    public List<Location> listLocationsForBoss();

}
