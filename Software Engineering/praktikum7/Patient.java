package de.hma.soe.praktikum7;

import java.util.ArrayList;

public class Patient implements IBeobachtbar {
	private String name;
	private double temp;
	private double spOtwo;
	private int heartrate;
	private double tempThreshold = 39.0;
	private double spOtwoThreshold = 93.0;
	private int heartrateThreshold = 130;
	public PatientState state;

	private ArrayList<IBeobachter> beobachter = new ArrayList();

	public Patient(String name) {
		this(name, PatientState.NORMAL);
	}
	
	public Patient(String name, PatientState state) {
		this.setName(name);
		this.state = state;
	}
	
	public Patient(String name, double temp, double spOtwo, int heartrate) {
		this.setName(name);
		this.setTemp(temp);
		this.setSpOtwo(spOtwo);
		this.setHeartrate(heartrate);
	}

	private void aktualisieren() {
		for (IBeobachter o : beobachter) {
			o.aktualisieren(this);
		}
	}

	public void anmelden(IBeobachter o) {
		beobachter.add(o);
	}

	public void abmelden(IBeobachter i) {

	}

	public int getHeartrate() {
		return heartrate;
	}

	public void setHeartrate(int heartrate) {
		this.heartrate = heartrate;
		aktualisieren();
	}

	public double getSpOtwo() {
		return spOtwo;
	}

	public void setSpOtwo(double spOtwo) {
		this.spOtwo = spOtwo;
		aktualisieren();
	}

	public double getTemp() {
		return temp;
	}

	public void setTemp(double temp) {
		this.temp = temp;
		aktualisieren();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
		aktualisieren();
	}

	public double getTempThreshold() {
		return tempThreshold;
	}

	public void setTempThreshold(double tempThreshold) {
		this.tempThreshold = tempThreshold;
	}

	public double getSpOtwoThreshold() {
		return spOtwoThreshold;
	}

	public void setSpOtwoThreshold(double spOtwoThreshold) {
		this.spOtwoThreshold = spOtwoThreshold;
	}

	public int getHeartrateThreshold() {
		return heartrateThreshold;
	}

	public void setHeartrateThreshold(int heartrateThreshold) {
		this.heartrateThreshold = heartrateThreshold;
	}
}
