package de.hma.soe.praktikum6;

import java.io.Serializable;
import java.util.ArrayList;

public class Team extends Platzierung implements Serializable{
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
