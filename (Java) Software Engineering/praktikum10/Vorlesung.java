package de.hma.soe.praktikum10;

import java.util.ArrayList;

public class Vorlesung {
	private int sws;
	private int ects;
	private String name;
	private ArrayList<TimeSlot> slot = new ArrayList<>();
	private Semester sem;

	public Vorlesung(int sws, int ects, String name, Tag tag, Block block, Semester sem) {
		setSws(sws);
		setEcts(ects);
		setName(name);
		addSlot(tag, block);
		setSem(sem);
	}

	public int getSws() {
		return sws;
	}

	public void setSws(int sws) {
		this.sws = sws;
	}

	public int getEcts() {
		return ects;
	}

	public void setEcts(int ects) {
		this.ects = ects;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Semester getSem() {
		return sem;
	}

	public void setSem(Semester sem) {
		this.sem = sem;
	}

	public ArrayList<TimeSlot> getSlot() {
		return slot;
	}

	public void addSlot(Tag tag, Block block) {
		this.slot.add(new TimeSlot(tag, block));
	}
}
