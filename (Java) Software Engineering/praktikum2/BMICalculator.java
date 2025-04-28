package de.hma.soe.praktikum2;

public class BMICalculator {
	public float GetScore(Person p) {
		return ((float) p.getGewicht() / (((float) p.getGroese() / 100) * ((float) p.getGroese() / 100)));
	}

	public String GetDiagnosis(Person p) {
		float BMI = GetScore(p);
		if (BMI < 18.5) {
			return "Untergewichtig";
		} else if (18.5 <= BMI && BMI < 25) {
			return "Normalgewicht";
		} else if (25 <= BMI && BMI < 30) {
			return "Übergewicht (Präadipositas)";
		} else if (30 <= BMI && BMI < 35) {
			return "Adipositas-Grad I";
		} else if (35 <= BMI && BMI < 40) {
			return "Adipositas-Grad II";
		} else if (40 <= BMI) {
			return "Adipositas-Grad III";
		}
		return "Etwas ist schief gelaufen";
	}
}
