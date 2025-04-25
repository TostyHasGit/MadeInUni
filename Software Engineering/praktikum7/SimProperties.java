package de.hma.soe.praktikum7;

public class SimProperties {
	private static SimProperties instance = new SimProperties();
	public double temperaturLow;
	public double temperaturHigh;
	public double SpO2Low;
	public double SpO2High;
	public int heartrateLow;
	public int heartrateHigh;
	public int updateIntervall;
	
	private SimProperties() {
		
	}
	
	public SimProperties getInstance() {
		return instance;
	}
}
