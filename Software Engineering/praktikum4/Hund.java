package de.hsma.soe.praktikum4;

public class Hund extends Tier {
	
	String ruf = "Wuff wuff!";
	
	public Hund(String name) {
		super(name);
	}
	
	public void sagHallo() {
		System.out.println(this.getName() + " sagt " + ruf);
	}
}
