package de.hma.soe.praktikum4A3;

public class Platzierung implements Comparable<Platzierung> {
    protected int tore = 0;
    protected int gegentore = 0;
    protected int punkte = 0;
    protected int siege = 0;
    protected int unentschieden = 0;
    protected int niederlagen = 0;

    @Override
    public int compareTo(Platzierung p) {
        if (this.punkte != p.punkte) {
            return Integer.compare(p.punkte, this.punkte);
        }
        int tordifferenzThis = this.tore - this.gegentore;
        int tordifferenzOther = p.tore - p.gegentore;
        if (tordifferenzThis != tordifferenzOther) {
            return Integer.compare(tordifferenzOther, tordifferenzThis);
        }
        return Integer.compare(p.tore, this.tore);
    }
}
