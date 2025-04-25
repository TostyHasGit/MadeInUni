package de.hma.soe.praktikum7;

import java.util.Random;
import java.util.random.RandomGenerator;

public class VitalDataSimulator implements IVitaldataController{

	private static Random rg = new Random();
	SimProperties sP;
	Patient p;
	
	public void readValues() {
		while(true) {
			p.setTemp(generateRandom(36, 40));
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.print("\033[2J");	// clear Display
			System.out.print("\033[1;1H");	// clear Display
		}
	}
	
	public VitalDataSimulator (Patient p) {
		this.p = p;
	}

	private double generateRandom(int low, int high) {
		return low + rg.nextDouble()*(high-low);
	}
	
	public void setSimProperties(SimProperties sP) {
		this.sP = sP;
	}
}
