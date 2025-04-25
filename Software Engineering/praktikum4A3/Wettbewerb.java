package de.hma.soe.praktikum4A3;

import java.util.ArrayList;

public class Wettbewerb {
    private String name;
    private ArrayList<Team> teams = new ArrayList<>();
    private ArrayList<Spiel> spiele = new ArrayList<>();

    public Wettbewerb(String name) {
        this.name = name;
    }

    public void addTeam(Team t) {
        teams.add(t);
    }

    public void addSpiel(Spiel s) {
        spiele.add(s);
    }

    public ArrayList<Team> getTeams() {
        return teams;
    }

    public ArrayList<Spiel> getSpiele() {
        return spiele;
    }

    public void printTeams() {
        for (Team t : teams) {
            System.out.println(t.getName());
        }
    }

    public void printSpiele() {
        for (Spiel s : spiele) {
            System.out.println(s);
        }
    }
}
