package de.hma.soe.praktikum7;

public class DashboardFactory {
	public IBeobachter createDashboard(Patient p) {
		if (p.state == PatientState.NORMAL) {
			return new SimplePatientDashboard();
		}
		
		return new AdvancedPatientDashboard();
	}
}
