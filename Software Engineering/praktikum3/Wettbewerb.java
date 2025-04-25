package de.hma.soe.praktikum3;

import java.util.Vector;

public class Wettbewerb {
	private String wettbewerb;
	private Vector<Spiel> spiele = new Vector<>();
	private Tabelle tabelle;

	public Wettbewerb(String name) {
		this.wettbewerb = name;
		this.tabelle = new Tabelle(this);
	}

	public void setTabelle(Tabelle tabelle) {
		this.tabelle = tabelle;
	}

	public void printTeams() {
		if (this.tabelle != null) {
			this.tabelle.printTeams();
		} else {
			System.out.println("No teams available. Tabelle is not initialized.");
		}
	}

	public Tabelle getTabelle() {
		return tabelle;
	}
	
	public void printSpiele() {
		int j = 1;
		for (Spiel i : spiele) {
			System.out.println("Spiel " + j++ + ":");
			System.out.println("Heim: " + i.getHeim() + "   " + i.getHPunkte());
			System.out.println("Gast: " + i.getGast() + "   " + i.getGPunkte());
			System.out.println();
		}
	}
	
	public void addSpiel(Spiel spiel) {
		spiele.add(spiel);
	}
}
