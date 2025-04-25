package de.hma.soe.praktikum5;

public class HandballTabelle extends Tabelle {

    public HandballTabelle() {
        super();
    }

    public HandballTabelle(Wettbewerb w) {
        super(w);
    }

    @Override
    public void calculatePoints() {
        for (Spiel s : w.getSpiele()) {
            if (s.heimTore > s.gastTore) {
                s.heim.punkte += 2;
                s.heim.siege++;
                s.gast.niederlagen++;
            } else if (s.heimTore < s.gastTore) {
                s.gast.punkte += 2;
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
}
