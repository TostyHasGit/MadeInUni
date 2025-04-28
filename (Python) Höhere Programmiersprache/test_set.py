#!/usr/bin/python3
"""Test der Mengenimplementierung"""

import unittest

from menge import Set  # die eigene zu testende Klasse


class TestSet(unittest.TestCase):
    "Testen der Mengenimplementierung"

    def setUp(self):
        "vor jedem Test, Beispielmengen instanziieren"
        self.pys = set([1, 5, 3])
        self.mys = Set([1, 5, 3])
        self.myt = Set([1, 3, 5])

    def same_set(self):
        "Hilfsroutine, prüft ob zwei Mengen gleich sind"
        if len(self.pys) != len(self.mys):
            return False
        for ele in self.pys:
            if ele not in self.mys:
                return False
        return True

    def test_initialize(self):
        "Initialisieren"
        self.assertTrue(self.same_set())

    def test_add_existing(self):
        "Vorhandenes Element dazu, gleiche Liste"
        self.mys.add(3)
        self.mys.add(5)
        self.assertTrue(self.same_set())

    def test_equals(self):
        "equals, =="
        self.assertEqual(self.mys, self.myt)
        self.mys.remove(3)
        self.assertNotEqual(self.mys, self.myt)
        self.assertNotEqual(self.myt, self.mys)

    def test_remove1(self):
        "Einzelne Elemente loeschen"
        self.mys.remove(1)
        self.mys.remove(2)
        self.myt.remove(5)
        self.myt.remove(4)
        self.assertEqual(len(self.mys), len(self.myt))

    def test_remove2(self):
        "In zwei Mengen die gleichen Elemente loeschen"
        remove = [3, 4, 5]
        for ele in remove:
            self.mys.remove(ele)
        for ele in reversed(remove):
            self.myt.remove(ele)
        self.assertEqual(self.mys, self.myt)

    def test_union_update(self):
        "Elemente mit Vereinigung aufnehmen"
        self.mys.remove(1)
        self.mys.remove(2)
        self.myt.remove(5)
        self.myt.remove(4)
        self.mys.union_update(self.myt)
        self.myt.union_update(self.mys)
        self.assertEqual(self.mys, self.myt)

    def test_difference_update(self):
        "Mengendifferenz, Menge aendern"
        self.mys.difference_update(Set([1, 5]))
        self.myt.remove(5)
        self.myt.remove(1)
        self.assertEqual(self.mys, self.myt)

    def test_difference(self):
        "Mengendifferenz, neu berechnen"
        self.myt.remove(5)
        self.myt.remove(1)
        self.assertEqual(self.mys.difference([1, 5]), self.myt)

    def test_plus_op(self):
        "Der '+'-Operator"
        self.assertEqual(self.myt + self.mys, self.mys)
        self.assertEqual(self.myt + [1, 3], self.mys)
        self.assertEqual(self.myt + [1, 3, 7, 9], [7, 9] + self.mys)

    def test_in(self):
        "Der in-Test"
        for ele in self.mys:
            self.assertTrue(ele in self.myt)
        for ele in self.myt:
            self.assertTrue(ele in self.mys)

    def test_clear(self):
        "Alle Elemente entfernen"
        self.myt.clear()
        self.assertEqual(self.myt.size(), 0)


if __name__ == '__main__':
    suite = unittest.TestSuite()
    suite.addTest(unittest.makeSuite(TestSet))
    unittest.TextTestRunner(verbosity=2).run(suite)
