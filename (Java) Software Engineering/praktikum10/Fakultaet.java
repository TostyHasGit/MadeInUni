package de.hma.soe.praktikum10;

import java.util.ArrayList;

public class Fakultaet {
	private String name;
	private ArrayList<Dozent> dozenten = new ArrayList<>();

	public Fakultaet(String name) {
		setName(name);
	}

	public float swsForSem(Semester sem) {
		float ges = 0;
		for (Dozent itVar : dozenten) {
			for (Vorlesung jtVar : itVar.getVorlesungen()) {
				if (jtVar.getSem() == sem) {
					ges += jtVar.getSws();
				}
			}
		}
		return ges;
	}
	
	public float ectsForSem(Semester sem) {
		float ges = 0;
		for (Dozent itVar : dozenten) {
			for (Vorlesung jtVar : itVar.getVorlesungen()) {
				if (jtVar.getSem() == sem) {
					ges += jtVar.getEcts();
				}
			}
		}
		return ges;
	}

	public float avarageSws() {
		float ges = 0;
		for (Dozent itVar : dozenten) {
			ges += itVar.SwsGesamt();
		}
		return ges / dozenten.size();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ArrayList<Dozent> getDozenten() {
		return dozenten;
	}

	public void addDozenten(Dozent d) {
		dozenten.add(d);
	}

}
