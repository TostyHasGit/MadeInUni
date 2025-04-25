package de.hma.soe.praktikum4A3;

import java.util.ArrayList;
import java.util.Collections;

public class Tabelle {
    protected Wettbewerb w;
    protected ArrayList<Team> teamsSortiert = new ArrayList<>();

    public Tabelle() {
    }

    public Tabelle(Wettbewerb w) {
        this.w = w;
        this.teamsSortiert.addAll(w.getTeams());
        calculatePoints();
        sortiereTeams();
    }

    public void createTabelle(Wettbewerb w) {
        this.w = w;
        this.teamsSortiert.addAll(w.getTeams());
        calculatePoints();
        sortiereTeams();
    }

    public void sortiereTeams() {
        Collections.sort(teamsSortiert);
    }

    public void calculatePoints() {
        for (Spiel s : w.getSpiele()) {
            if (s.heimTore > s.gastTore) {
                s.heim.punkte += 3;
                s.heim.siege++;
                s.gast.niederlagen++;
            } else if (s.heimTore < s.gastTore) {
                s.gast.punkte += 3;
                s.gast.siege++;
                s.heim.niederlagen++;
            } else {
                s.heim.punkte += 1;
                s.gast.punkte += 1;
                s.heim.unentschieden++;
                s.gast.unentschieden++;
            }
            s.heim.tore += s.heimTore;
            s.heim.gegentore += s.gastTore;
            s.gast.tore += s.gastTore;
            s.gast.gegentore += s.heimTore;
        }
    }

    public void printTabelle() {
        System.out.println("Platz  Team        Punkte  S  U  N  Tore   Diff");
        System.out.println("------------------------------------------------");

        int platz = 1;
        for (Team team : teamsSortiert) {
            String teamName = team.getName();
            int punkte = team.punkte;
            int siege = team.siege;
            int unentschieden = team.unentschieden;
            int niederlagen = team.niederlagen;
            String tore = team.tore + ":" + team.gegentore;
            int diff = team.tore - team.gegentore;

            System.out.printf("%-5d %-10s %-7d %-2d %-2d %-2d %-6s %d%n",
                    platz, teamName, punkte, siege, unentschieden, niederlagen, tore, diff);

            platz++;
        }
        System.out.println();
    }
}
