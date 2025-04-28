package de.hma.soe.praktikum3;

import java.util.Vector;

public class Tabelle {
	private Vector<Team> manschaften = new Vector<>(); // Use generics for better type safety
	private Wettbewerb wettbewerb;

	// Constructor to initialize Tabelle with the Wettbewerb
	public Tabelle(Wettbewerb wettbewerb) {
		this.wettbewerb = wettbewerb;
	}

	// Method to add a team to the Tabelle
	public void addTeam(Team team) {
		this.manschaften.add(team);
	}

	// Method to print all teams
	public void printTeams() {
		if (manschaften.isEmpty()) {
			System.out.println("No teams to display.");
		} else {
			for (Team team : manschaften) {
				System.out.print(team.getName() + ", ");
			}
			System.out.println();
		}
	}

	public void createTabelle(Wettbewerb w) {
		for (Team i : manschaften)
			// TODO: Fehlen noch paar Sachen beim Print
			System.out.println(i.getName() + "   " + i.getPunkte() + "   " + i.getSiege() + "   " + i.getDraw() + "   "
					+ i.getLoses() + "   ");
	}
}
