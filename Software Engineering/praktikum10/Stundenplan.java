package de.hma.soe.praktikum10;

import java.util.ArrayList;

public class Stundenplan {

	private ArrayList<Vorlesung> vorlesungen = new ArrayList<>();

	public ArrayList<Vorlesung> getVorlesungen() {
		return vorlesungen;
	}
	
	public void addVorlesung(Vorlesung vl) {
		vorlesungen.add(vl);
	}

}
