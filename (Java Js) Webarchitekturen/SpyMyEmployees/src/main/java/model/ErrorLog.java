package model;

import java.time.LocalDateTime;

public class ErrorLog {
	private Long id;
	private Long camer_id;
	private LocalDateTime capture_time;
	private boolean checked;
	private String description;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getCamer_id() {
		return camer_id;
	}

	public void setCamer_id(Long camer_id) {
		this.camer_id = camer_id;
	}

	public LocalDateTime getCapture_time() {
		return capture_time;
	}

	public void setCapture_time(LocalDateTime localDateTime) {
		this.capture_time = localDateTime;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean status) {
		this.checked = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String text) {
		this.description = text;
	}

}
