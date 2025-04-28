package de.hma.soe.praktikum10;

import java.util.ArrayList;

public class Dozent {
	private String name;
	private String kuerzel;
	private ArrayList<Vorlesung> vorlesungen = new ArrayList<>();

	public Dozent(String name, String kuerzel) {
		setName(name);
		setKuerzel(kuerzel);
	}

	public int SwsGesamt() {
		int ges = 0;
		for (Vorlesung itVar : vorlesungen) {
			ges += itVar.getSws();
		}
		return ges;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKuerzel() {
		return kuerzel;
	}

	public void setKuerzel(String kuerzel) {
		this.kuerzel = kuerzel;
	}

	public ArrayList<Vorlesung> getVorlesungen() {
		return vorlesungen;
	}

	public void addVorlseung(Vorlesung vl) {
		vorlesungen.add(vl);
	}

}
