package de.hma.soe.praktikum5;

import java.util.ArrayList;

public class Team extends Platzierung {
    private String name;
    private ArrayList<String> wettbewerb = new ArrayList<>();

    public Team(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return name;
    }
}
