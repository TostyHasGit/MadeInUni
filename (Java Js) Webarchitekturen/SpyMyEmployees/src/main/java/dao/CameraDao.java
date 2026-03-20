package dao;

import java.util.List;
import model.Camera;

public interface CameraDao {
	Camera get(Long id);
	void save(Camera camera);
	void delete (Long id);
	List<Camera> list();
	public List<Camera> getCamerasByLocation(Long locationId, boolean all, boolean isAdmin);
}