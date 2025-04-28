package de.hsma.soe.praktikum4;

public class Rind extends Tier{
	
	String ruf = "Muuuuuuuh";
	
	public Rind(String name) {
		super(name);
	}
	
	public void sagHallo() {
		System.out.println(this.getName() + " sagt " + ruf);
		
	}
}
