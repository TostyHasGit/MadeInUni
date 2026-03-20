package model;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class ImageEntry {
    private final String iconPath;
    private final String filePath;
    private final LocalDateTime captureTime;

    public ImageEntry(String iconPath, String filePath, LocalDateTime captureTime) {
        this.iconPath = iconPath;
        this.filePath = filePath;
        this.captureTime = captureTime;
    }

    public String getIconPath() {
        return iconPath;
    }

    public String getFilePath() {
        return filePath;
    }

	public LocalDateTime getCaptureTime() {
		return captureTime;
	}
	

	public Date getCaptureTimeAsDate() {
	    return Date.from(captureTime.atZone(ZoneId.systemDefault()).toInstant());
	}
}

