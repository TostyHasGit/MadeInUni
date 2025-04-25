package de.hsma.soe.praktikum4;

public class Vogel extends Tier{

	String ruf = "Beep!";
	
	public Vogel(String name) {
		super(name);
	}
	
	public void sagHallo() {
		System.out.println(this.getName() + " sagt " + ruf);
	}
}
