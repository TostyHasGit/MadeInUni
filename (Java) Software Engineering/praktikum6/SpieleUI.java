package de.hma.soe.praktikum6;

import java.util.Scanner;
import java.util.ArrayList;

public class SpieleUI {

	public void menu(Wettbewerb w) {
		Scanner scanner = new Scanner(System.in);
		ArrayList<String> wahl = new ArrayList<>();
		do {
			wahl.clear();
			System.out.println("Team Heim:");
			wahl.add(scanner.nextLine());
			System.out.println("Team Gast:");
			wahl.add(scanner.nextLine());
			System.out.println("Tore Heim:");
			wahl.add(scanner.nextLine());
			System.out.println("Tore Gast:");
			wahl.add(scanner.nextLine());
			System.out.println("Weiteres Spiel anlegen?");
			wahl.add(scanner.nextLine());

			Spiel s = new Spiel(w.searchTeam(wahl.get(0)), w.searchTeam(wahl.get(1)), Integer.parseInt(wahl.get(2)),
					Integer.parseInt(wahl.get(3)));
			w.addSpiel(s);
		} while (wahl.get(4).equals("ja"));
	}
}
