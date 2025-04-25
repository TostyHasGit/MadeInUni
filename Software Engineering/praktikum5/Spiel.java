package de.hma.soe.praktikum5;

public class Spiel {
    public int heimTore;
    public int gastTore;
    public Team heim;
    public Team gast;

    public Spiel(Team heim, Team gast, int hTore, int gTore) {
        this.heim = heim;
        this.gast = gast;
        this.heimTore = hTore;
        this.gastTore = gTore;
    }

    public void setErgebnis(int h, int g) {
        this.heimTore = h;
        this.gastTore = g;
    }

    @Override
    public String toString() {
        return heim.getName() + " : " + gast.getName() + " " + heimTore + ":" + gastTore;
    }
}
