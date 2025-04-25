package de.hma.soe.praktikum3;

public class Spiel {
	private Team heimManschaft;
	private Team gastManschaft;
	private int heimPunkte;
	private int gastPunkte;

	public Spiel(Team heim, Team gast) {
		this.heimManschaft = heim;
		this.gastManschaft = gast;
	}

	public Spiel(Team heim, Team gast, int hPunkte, int gPunkte, Wettbewerb w) {
		this.heimManschaft = heim;
		this.gastManschaft = gast;
		Spielende(hPunkte, gPunkte, w);
	}

	public void Spielende(int hPunkte, int gPunkte, Wettbewerb w) {
		this.heimPunkte = hPunkte;
		this.gastPunkte = gPunkte;

		if (hPunkte > gPunkte) {
			this.heimManschaft.AddErgebniss(Ergebniss.Gewonnen);
			this.gastManschaft.AddErgebniss(Ergebniss.Verloren);
			this.heimManschaft.setPunkte(2);
			this.heimManschaft.setSiege();
			this.gastManschaft.setLoses();
		} else if (hPunkte < gPunkte) {
			this.heimManschaft.AddErgebniss(Ergebniss.Verloren);
			this.gastManschaft.AddErgebniss(Ergebniss.Gewonnen);
			this.gastManschaft.setPunkte(2);
			this.gastManschaft.setSiege();
			this.heimManschaft.setLoses();
		} else {
			this.heimManschaft.AddErgebniss(Ergebniss.Unentschieden);
			this.gastManschaft.AddErgebniss(Ergebniss.Unentschieden);
			this.heimManschaft.setPunkte(1);
			this.gastManschaft.setPunkte(1);
			this.heimManschaft.setdraw();
			this.gastManschaft.setdraw();
		}
		w.addSpiel(this);
	}
	
	public String getHeim() {
		return this.heimManschaft.getName();
	}
	
	public String getGast() {
		return this.gastManschaft.getName();
	}
	
	public int getHPunkte() {
		return heimPunkte;
	}
	
	public int getGPunkte() {
		return gastPunkte;
	}
}
