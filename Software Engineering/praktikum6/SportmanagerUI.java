package de.hma.soe.praktikum6;

import java.util.Scanner;

public class SportmanagerUI {

	private Wettbewerb w;
	private WettbewerbDAO wDAO;

	public SportmanagerUI(Wettbewerb w) {
		this.w = w;
	}
	
	public void setWettbewerbDAO(WettbewerbDAO wDAO) {
		this.wDAO = wDAO;
	}

	public void menu() {
		Scanner scanner = new Scanner(System.in);
		int wahl;
		TeamUI t = new TeamUI();
		SpieleUI s = new SpieleUI();
		Tabelle table = new Tabelle();
		do {
			System.out.println("---------------------------------------------\n");
			System.out.println("Willkommen beim Sportmanager");
			System.out.println("---------------------------------------------\n");
			System.out.println("Wie kann ich Ihnen helfen?");
			System.out.println("(1) Teams anlegen");
			System.out.println("(2) Spielergebnisse eintragen");
			System.out.println("(3) Tabelle ausgeben");
			System.out.println("(4) Wettbewerb speichern");
			System.out.println("(5) Wettbewerb laden");
			System.out.println("(0) Beenden");

			wahl = scanner.nextInt();
			switch (wahl) {
			case 1 -> t.menu(w);
			case 2 -> s.menu(w);
			case 3 -> {
				table.createTabelle(w);
				table.printTabelle();
			}
			case 4 -> {
				wDAO.speichern(w);
			}
			case 5 -> {
				wDAO.laden();
			}
			case 0 -> System.out.println("Bis zum nächsten Mal!");
			default -> System.out.println("Falsche Wahl. Bitte nochmal versuchen!");
			}
		} while (wahl != 0);

	}
}
