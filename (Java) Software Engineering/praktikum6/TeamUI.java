package de.hma.soe.praktikum6;

import java.util.Scanner;

public class TeamUI {

	public void menu(Wettbewerb w) {
		Scanner scanner = new Scanner(System.in);
		String wahl;
		do {
			System.out.println("Bitte Teamname eingeben. Beenden mit q");
			wahl = scanner.nextLine();
			if (!wahl.equals("q")) {
				Team t = new Team(wahl);
				w.addTeam(t);
			}
		} while (!wahl.equals("q"));
		
	}
}
