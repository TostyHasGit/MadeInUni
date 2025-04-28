package de.hsma.soe.praktikum4;

public class Tier extends IKannSprechen {

    // Constructor that accepts a name and passes it to the superclass
    public Tier(String name) {
        super(name);
    }

    // Default constructor that uses the superclass default name
    public Tier() {
        super();
    }

    // Implementation of the abstract `sagHallo` method
    @Override
    public void sagHallo() {
        System.out.println("Ich kann nichts sagen");
    }

    // No need for a `name` field here; we can use `getName()` from `IKannSprechen`
}
