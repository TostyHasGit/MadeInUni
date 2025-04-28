#include "alltest.h"
#include "intvec.h"

using namespace std;

TEST(initclear, a) {
    intvec ivec;
    ivec_init(&ivec, 10);
    EXPECT_EQ(ivec.size, 0);
    EXPECT_EQ(ivec.capacity, 10);
    EXPECT_NE(ivec.arr, nullptr);
    ivec_clear(&ivec);
    EXPECT_EQ(ivec.size, 0);
    EXPECT_EQ(ivec.capacity, 0);
    EXPECT_EQ(ivec.arr, nullptr);
}

TEST(initclear, b) {
    intvec ivec;
    for (size_t i{0}; i < 100; ++i) {
        ivec_init(&ivec, i + 10);
        EXPECT_EQ(ivec.capacity, i + 10);
        ivec_clear(&ivec);
        EXPECT_EQ(ivec.capacity, 0);
        EXPECT_EQ(ivec.arr, nullptr);
    }
}

TEST(fill, a) {
    intvec ivec;
    ivec_init(&ivec, 10);
    // Das ist boese, vermeide reinzugreifen
    for (size_t i{0}; i < 5; ++i) {
        ivec.arr[i] = i;
    }
    ivec.size = 5;
    // End of boese
    // Zum testen darf man reingreifen...
    EXPECT_EQ(ivec.arr[0], 0);
    EXPECT_EQ(ivec.arr[1], 1);
    EXPECT_EQ(ivec.arr[2], 2);
    EXPECT_EQ(ivec.arr[3], 3);
    EXPECT_EQ(ivec.arr[4], 4);
    EXPECT_EQ(ivec.size, 5);
    EXPECT_EQ(ivec.capacity, 10);
    ivec_clear(&ivec);
}

TEST(fill, b) {
    intvec ivec;
    ivec_init(&ivec, 10);
    // Das ist gut
    for (int i{0}; i < 5; ++i) {
        ivec_push_back(&ivec, i);
    }
    // End of gut
    EXPECT_EQ(ivec.arr[0], 0);
    EXPECT_EQ(ivec.arr[1], 1);
    EXPECT_EQ(ivec.arr[2], 2);
    EXPECT_EQ(ivec.arr[3], 3);
    EXPECT_EQ(ivec.arr[4], 4);
    EXPECT_EQ(ivec.size, 5);
    EXPECT_EQ(ivec.capacity, 10);
    ivec_clear(&ivec);
}

static void ivec_fill(intvec* ivec, int fro, int to) {
    for (int val{fro}; val <= to; ++val) {
        ivec_push_back(ivec, val);
    }
}

TEST(fill, c) {
    intvec ivec;
    ivec_init(&ivec, 10);
    ivec_fill(&ivec, 0, 4);
    for (int idx{0}; idx < 5; ++idx) {
        EXPECT_EQ(ivec_at(&ivec, idx), idx);
    }
    EXPECT_EQ(ivec.size, 5);
    EXPECT_EQ(ivec.capacity, 10);
    ivec_fill(&ivec, 0, 4);
    for (int idx{5}; idx < 9; ++idx) {
        EXPECT_EQ(ivec_at(&ivec, idx), idx - 5);
    }
    EXPECT_EQ(ivec.size, 10);
    EXPECT_EQ(ivec.capacity, 10);
    ivec_push_back(&ivec, 17);
    EXPECT_EQ(ivec.size, 11);
    EXPECT_EQ(ivec.capacity, 20);
    ivec_clear(&ivec);
}

TEST(fill, d) {
    intvec ivec;
    ivec_init(&ivec, 2);
    ivec_fill(&ivec, 42, 42 + 1024);
    for (size_t idx{0}; idx < ivec.size; ++idx) {
        EXPECT_EQ(ivec_at(&ivec, idx), 42 + idx);
    }
    EXPECT_EQ(ivec.size, 1025);
    EXPECT_EQ(ivec.capacity, 2048);
    ivec_clear(&ivec);
}

TEST(sum, a) {
    intvec ivec;
    ivec_init(&ivec, 10);
    ivec_fill(&ivec, 1, 10);
    EXPECT_EQ(ivec_sum(&ivec), 55);
    ivec_fill(&ivec, 11, 20);
    EXPECT_EQ(ivec_sum(&ivec), 210);
    ivec_fill(&ivec, 21, 100);
    EXPECT_EQ(ivec_sum(&ivec), 5050);
    ivec_fill(&ivec, 101, 1000);
    EXPECT_EQ(ivec_sum(&ivec), 500500);
    ivec_clear(&ivec);
}
