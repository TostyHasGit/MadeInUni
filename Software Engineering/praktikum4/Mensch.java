package de.hsma.soe.praktikum4;

public class Mensch extends IKannSprechen{

	public Mensch(String name) {
		super(name);
	}

	@Override
	public void sagHallo() {
		System.out.println("I bims");
	}
}
