#include "alltest.h"

#include <cstdlib>
#include <string>

#include "Sequence.h"

using IntVector = Sequence<int>;
using string = std::string;

void fill(IntVector& vec, size_t how_many, int val = 0) {
    vec.clear();
    vec.trim();
    for (size_t i = 0; i < how_many; ++i) {
        vec.push_back(val * val);
        val += 1;
    }
}

TEST_F(AllTest, einfach_size) {
    const size_t size = 10;
    IntVector vec;
    fill(vec, size);
    {
        SuspendMemCheck smc;
        EXPECT_EQ(size, vec.size());
    }
}

TEST_F(AllTest, at) {
    const size_t size = 42;
    IntVector vec;
    fill(vec, size, 17);
    for (size_t idx = 0; idx < vec.size(); idx += 1) {
        {
            SuspendMemCheck smc;
            EXPECT_EQ((17 + idx) * (17 + idx), vec[idx]);
        }
    }
}

void check_fail(IntVector& vec, size_t idx) {
    try {
        vec[10]; // out of range
        {
            SuspendMemCheck smc;
            FAIL() << "Zugriff vec[" << idx << "] sollte Fehler werfen";
        }
    } catch (const std::runtime_error& e) {
        // erwarteter Fehler
        {
            SuspendMemCheck smc;
            EXPECT_STREQ(e.what(), "Sequence::operator[]: pos out of bounds");
        }
    } catch (...) {
        {
            SuspendMemCheck smc;
            FAIL() << "Zugriff vec[" << idx
                   << "] sollte std::runtime_error werfen";
        }
    }
}
TEST_F(AllTest, at_fail) {
    const size_t size = 10;
    IntVector vec;
    fill(vec, 10);
    check_fail(vec, size);
    check_fail(vec, -1);
    check_fail(vec, size + 1000000);
}

TEST_F(AllTest, Kopierkonstruktor) {
    const size_t size = 20;
    IntVector v1(size);
    fill(v1, 20, 0);
    IntVector v2{v1};
    {
        SuspendMemCheck smc;
        EXPECT_EQ(v1.size(), v2.size());
    }
    for (size_t i = 0; i < v1.size(); ++i) {
        {
            SuspendMemCheck smc;
            EXPECT_EQ(v1[i], v2[i]);
        }
    }
}

TEST_F(AllTest, Zuweisungsoperator) {
    const size_t size = 20;
    IntVector v1;
    fill(v1, size, 2);
    IntVector v2;
    fill(v2, size / 2);
    v2 = v1;
    {
        SuspendMemCheck smc;
        EXPECT_EQ(v1.size(), v2.size());
    }
    for (size_t i = 0; i < v1.size(); ++i) {
        {
            SuspendMemCheck smc;
            EXPECT_EQ(v1[i], v2[i]);
        }
    }
    IntVector v3;
    fill(v2, 30);
    IntVector v4;
    fill(v4, 20, 3);
    v3 = v4;
    {
        SuspendMemCheck smc;
        EXPECT_EQ(v3.size(), v4.size());
        EXPECT_EQ(20, v3.size());
    }
    for (size_t i = 0; i < v3.size(); ++i) {
        {
            SuspendMemCheck smc;
            EXPECT_EQ(v3[i], v4[i]);
        }
    }
    v1 = v2 = v3 = v4;
}

const char alph[] = "abcdefghijklmnopqrstuvwxyz";
const size_t alphlen = sizeof(alph) / sizeof(alph[0]);
string create_random_string(size_t size = 42) {
    string ret;
    for (size_t i = 0; i < size; ++i) {
        ret += alph[rand() % alphlen];
    }
    return ret;
}

TEST_F(AllTest, withstring) {
    Sequence<string> ss;
    for (int i = 0; i < 1000; ++i) {
        ss.push_back(create_random_string());
        if ((rand() % 66) == 17) {
            auto old = ss;
            // std::cout << "trim" << std::endl;
            ss.trim();
            // std::cout << "done trim" << std::endl;
            {
                SuspendMemCheck smc;
                EXPECT_EQ(old, ss);
            }
        }
    }
}
