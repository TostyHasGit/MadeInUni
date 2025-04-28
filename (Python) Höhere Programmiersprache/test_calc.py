#!/usr/bin/python3
""" Test the module calc and in there the function compute"""

import unittest
import calc


class CalcTest(unittest.TestCase):
    "test class for calc.calc"

    def setUp(self):
        "before each test, here nothing to do"

    def test_calc(self):
        "function compute exists"
        self.assertTrue("compute" in dir(calc))

    def test_calc_add(self):
        "addition"
        # self.assertEqual(3.0, calc.compute("1", "+", "2"))
        # for float numbers exact comparison is dangerous and should not be used
        self.assertAlmostEqual(3.0, calc.compute("1", "+", "2"))

    def test_calc_sub(self):
        "subtraction"
        self.assertAlmostEqual(2.0, calc.compute("3", "-", "1"))

    def test_calc_mul(self):
        "multiplication"
        self.assertAlmostEqual(6.0, calc.compute("2", "x", "3"))

    def test_calc_div(self):
        "division"
        self.assertAlmostEqual(2.0, calc.compute("6", "/", "3"))

    def test_calc_add_multi(self):
        "add many different combinations"
        for x_val in range(1, 10):
            for y_val in range(1, 10):
                erg = calc.compute(str(x_val), "+", str(y_val))
                self.assertAlmostEqual(float(x_val+y_val), erg)

    def test_calc_number_fail(self):
        "conversion error on numbers"
        try:
            erg = calc.compute("bla", "+", "schlonz")
            if isinstance(erg, (int, float)):
                self.fail("must not succeed")
        except Exception:
            # throwing an exception is fine on error
            pass

    def test_calc_op_fail(self):
        "no result on unknown op"
        try:
            erg = calc.compute("1", "?", "2")
            if isinstance(erg, (int, float)):
                self.fail("must not succeed")
        except Exception:
            pass

    def test_expect_throw(self):
        "just to demonstrate how to expect an exception"
        with self.assertRaises(Exception):
            # in this block an exception must be thrown
            17 + "42" # that will raise a TypeError, which is an Exception


if __name__ == '__main__':
    unittest.main()
