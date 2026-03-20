package dao;

public class DaoFactory {

    private static DaoFactory instance = new DaoFactory();

    private final LocationDao locationDao = new LocationDaoImpl();
    private final CameraDao cameraDao = new CameraDaoImpl();
    private final UserDao userDao = new UserDaoImpl();
    private final ImageDao imageDao = new ImageDaoImpl();
    private final SiteManagerLocationDaoImpl siteManagerLocationDao = new SiteManagerLocationDaoImpl();
    private final ErrorLogDao errorLogDao = new ErrorLogDaoImpl();

    private DaoFactory() {
        
    }

    public static DaoFactory getInstance() {
        return instance;
    }

    public LocationDao getLocationDao() {
        return locationDao;
    }
    
    public CameraDao getCameraDao() {
        return cameraDao;
    }

    public UserDao getUserDao() {
        return userDao;
    }
    
    public ImageDao getImageDao() {
        return imageDao;
    }

    public SiteManagerLocationDaoImpl getSiteManagerLocationDao() {
        return siteManagerLocationDao;
    }

	public ErrorLogDao getErrorLogDao() {
		return errorLogDao;
	}
}
