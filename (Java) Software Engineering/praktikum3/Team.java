package de.hma.soe.praktikum3;

import java.util.Vector;

public class Team {
	private String name;
	private Vector<Ergebniss> ergebnisse = new Vector();
	private Tabelle tabelle;
	private int punkte;
	private int siege;
	private int loses;
	private int draw;

	public Team(String name) {
		this.name = name;
	}
	
	public Team(String name, Wettbewerb wettbewerb) {
		this.name = name;
		if (wettbewerb.getTabelle() == null) {
			tabelle = new Tabelle(wettbewerb);
			wettbewerb.setTabelle(tabelle);
		}
		else {
			 tabelle = wettbewerb.getTabelle();
		}
		tabelle.addTeam(this);
	}
	
	public void AddErgebniss(Ergebniss ergebniss) {
		ergebnisse.add(ergebniss);
	}
	
	public String getName() {
		return this.name;
	}
	
	public int getPunkte() {
		return punkte;
	}
	
	public void setPunkte(int x) {
		this.punkte += x;
	}
	
	public int getSiege() {
		return siege;
	}
	
	public void setSiege() {
		this.siege++;
	}
	
	public int getLoses() {
		return loses;
	}
	
	public void setLoses() {
		this.loses++;
	}
	
	public int getDraw() {
		return draw;
	}
	
	public void setdraw() {
		this.draw++;
	}
}
