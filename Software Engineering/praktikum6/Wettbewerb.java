package de.hma.soe.praktikum6;

import java.io.Serializable;
import java.util.ArrayList;

public class Wettbewerb implements Serializable{
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
    
    public Team searchTeam(String name) {
    	for (int i = 0; i < teams.size(); ++i) {
    		if (teams.get(i).getName().equals(name)) {
    			return teams.get(i);
    		}
    	}
		return null;
    }
}
