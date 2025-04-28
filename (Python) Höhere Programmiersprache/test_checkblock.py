#!/usr/bin/python3
"""check the checkblock method of checkblocks"""

import unittest
from checkblock import checkblock


class CheckblockTest(unittest.TestCase):
    "test class for checkblock.checkblock"

    def setUp(self):
        self.CORRECT = [
            "", "()", "{}",
            "(){}", "(())", "({})", "{()}",
            "()()()()()()()",
            "()()({(){{}}})"
        ]

    def test_ok(self):
        "test ok"
        for parenstr in self.CORRECT:
            self.assertIsNone(checkblock(parenstr))

    def test_notmatching(self):
        "test not matching parenthesis"
        line, col, _ = checkblock("(}")
        self.assertEqual((1, 1), (line, col))
        line, col, _ = checkblock("{)")
        self.assertEqual((1, 1), (line, col))
        line, col, _ = checkblock("(({()})}")
        self.assertEqual((1, 7), (line, col))

    def test_pendingopen(self):
        "test too many open"
        line, col, _ = checkblock("(")
        self.assertEqual((2, 0), (line, col))
        line, col, _ = checkblock("{")
        self.assertEqual((2, 0), (line, col))
        line, col, _ = checkblock("(({()})){")
        self.assertEqual((2, 0), (line, col))

    def test_closenotopen(self):
        "test closed but not open"
        line, col, _ = checkblock(")")
        self.assertEqual((1, 0), (line, col))
        line, col, _ = checkblock("}")
        self.assertEqual((1, 0), (line, col))
        line, col, _ = checkblock("(({()}))}")
        self.assertEqual((1, 8), (line, col))

    def test_cross(self):
        "test wrong order"
        line, col, _ = checkblock("({)}")
        self.assertEqual((1, 2), (line, col))
        line, col, _ = checkblock("({({}))}")
        self.assertEqual((1, 6), (line, col))

    def test_multilines(self):
        "test with multiple lines"
        line, col, _ = checkblock("\n\n\n)")
        self.assertEqual((4, 0), (line, col))
        line, col, _ = checkblock("()\n{\n}\n(")
        self.assertEqual((5, 0), (line, col))
        line, col, _ = checkblock("\n".join("(({()}))") + " }")
        self.assertEqual((8, 2), (line, col))


if __name__ == '__main__':
    unittest.main()
