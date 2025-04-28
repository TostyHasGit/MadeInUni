package de.hma.soe.praktikum7;

import java.util.ArrayList;

public class SimplePatientDashboard implements IBeobachter{

	public void aktualisieren(IBeobachtbar o) {
		Patient p = (Patient) o;
		System.out.println("Name: " + p.getName());
		System.out.println("Hearrate: " + p.getHeartrate());
		System.out.println("SpOtwo: " + p.getSpOtwo());
		System.out.println("Temp: " + p.getTemp());
	}
}
