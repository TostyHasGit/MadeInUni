package de.hsma.soe.praktikum4;

public class Pittbull extends Hund{

	String ruf = "Mister Worldwide!";
	
	public Pittbull(String name) {
		super(name);
	}
	
	public void sagHallo() {
		System.out.println(this.getName() + " sagt " + ruf);
	}
}
