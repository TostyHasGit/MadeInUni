package dao;

import java.util.List;
import java.util.Set;

import model.ImageEntry;

public interface ImageDao {
	String getLastImagePathForCamera(Long cameraId);

	Set<Integer> getAvailableYears(Long cameraId);

	Set<Integer> getAvailableMonths(Long cameraId, int selectedYear);
	
	Set<Integer> getAvailableDays(Long cameraId, int year, int month);

	Set<Integer> getAvailableHours(Long cameraId, int selectedYear, int selectedMonth, int selectedDay);

	List<ImageEntry> getImageEntriesForHour(Long cameraId, int year, int month, int day, int hour);
}
