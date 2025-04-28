package de.hma.soe.praktikum6;

import java.io.ObjectOutputStream;
import java.io.*;

public class WettbewerbDAO {

	public void speichern(Wettbewerb w) {
		File f = new File("Wettbewerb.sm");

		try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(f))) {
			oos.writeObject(w);
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	public Wettbewerb laden() {
		File f = new File("Wettbewerb.sm");
		Wettbewerb w = null;

		try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(f))) {
			w = (Wettbewerb) ois.readObject();
		} catch (IOException | ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		return w;
	}
}
