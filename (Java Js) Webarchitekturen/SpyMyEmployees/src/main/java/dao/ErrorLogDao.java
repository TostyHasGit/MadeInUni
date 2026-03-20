package dao;

import java.util.List;
import model.ErrorLog;

public interface ErrorLogDao {
	ErrorLog get (Long id);
	void save(ErrorLog log);
	void delete (Long id);
	List<ErrorLog> list();
	List<ErrorLog> getLogsByCamera(Long locationId, boolean all);
	void markAllAsChecked(Long cameraId);
}