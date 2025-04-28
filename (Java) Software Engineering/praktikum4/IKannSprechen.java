package de.hsma.soe.praktikum4;

public abstract class IKannSprechen {
    
    private String name;

    // Constructor that accepts a name
    public IKannSprechen(String name) {
        this.name = name;
    }

    // Default constructor sets name to "Irgendwas"
    public IKannSprechen() {
        this.name = "Irgendwas";
    }

    // Abstract method to be implemented by subclasses
    public abstract void sagHallo();

    // Getter method for `name` to allow access from subclasses
    public String getName() {
        return this.name;
    }
}
