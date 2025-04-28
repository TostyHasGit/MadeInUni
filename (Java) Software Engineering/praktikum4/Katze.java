package de.hsma.soe.praktikum4;

public class Katze extends Tier{

	String ruf = "Miauuuu";
	
	public Katze(String name) {
		super(name);
	}
	
	public void sagHallo() {
		System.out.println(this.getName() + " sagt " + ruf);
	}
}
