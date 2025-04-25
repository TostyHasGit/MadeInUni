package de.hma.soe.praktikum2;

public class Vorlesung {
	
	private static int IDCounter = 1;
	private int ID;
	private String titel;
	private int SWS;
	private int ECTS;
	private Kompetenz benoetigteKompetenz;
	private boolean hasP = false;
	
	public Vorlesung (String titel, int SWS, int ECTS, Kompetenz benoetigteKompetenz) {
		this.ID = IDCounter++;
		this.titel = titel;
		this.SWS = SWS;
		this.ECTS = ECTS;
		this.benoetigteKompetenz = benoetigteKompetenz;
	}
	
	public Kompetenz getKompetenz() {
		return this.benoetigteKompetenz;
	}
	
	public void setHasP(boolean wert) {
		this.hasP = wert;
	}
	
	public boolean getHasP() {
		return this.hasP;
	}
	
	public int getID() {
		return this.ID;
	}
}
