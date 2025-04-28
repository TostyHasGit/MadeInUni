package de.hma.soe.praktikum7;

public class AdvancedPatientDashboard implements IBeobachter {

	public void aktualisieren(IBeobachtbar o) {
		Patient p = (Patient) o;
		System.out.println("Name: " + p.getName());
		System.out.println("Hearrate: " + p.getHeartrate());
		System.out.println("SpOtwo: " + p.getSpOtwo());
		System.out.println("Temp: " + p.getTemp());
		System.out.println("HeartrateThreshold: " + p.getHeartrateThreshold());
		System.out.println("SpOtwoThreshold: " + p.getSpOtwoThreshold());
		System.out.println("TempThreshold: "+ p.getTempThreshold());
	}
}
