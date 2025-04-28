package de.hma.soe.praktikum2;
import java.util.Vector;

public class Person {
	private String name;
	private String nname;
	private int alter;
	private String anrede;
	private Kompetenz kompetenz;
	private Vector<Vorlesung> vorlesung = new Vector<>();
	private boolean hasVL = false;
	private int groese;
	private int gewicht;
	
	public Person(String s) {
		name = s;
	}
	
	public void setSurname(String s) {
		nname = s;
	}
	
	public void setAge(int z) {
		alter = z;
		anrede = "dir";
		if (alter > 18) {
			anrede = "Ihnen";
		}
	}
	
	public void setKompetenz(Kompetenz k) {
		kompetenz = k;
	}
	
	public void setVorlesung(Vorlesung v) {
		if (v.getKompetenz().equals(kompetenz) && !v.getHasP()){
			vorlesung.add(v);
			hasVL = true;
			v.setHasP(true);
		}
		else {
			System.out.println("Benötigte Kompetenz passt nicht mit Kernkompetenz überein oder die Person hat schon eine VL");
		}
	}
	
	public void setGroese (int g) {
		this.groese = g;
	}
	
	public void setGewicht (int g) {
		this.gewicht = g;
	}
	
	public int getGroese () {
		return this.groese;
	}
	
	public int getGewicht () {
		return this.gewicht;
	}
	
	public void printVL() {
		System.out.println("Herr " + this.nname + "hat folgende VL besucht: \n");
		for (int i = 0; i != this.vorlesung.size(); ++i) {
			System.out.print(this.vorlesung.get(i));
			if (i != this.vorlesung.size()-1) {
				System.out.print(", ");
			}
		}
		System.out.println();
	}
	
	public void Gruesst(Person s) {
		System.out.println(name + " grüßt ganz herzlich " + s.name + " " + s.nname + ". Wie geht es " + s.anrede + "?");
	}
}
