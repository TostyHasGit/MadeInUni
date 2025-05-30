#include "tausche.h"
#include "alltest.h"

TEST(tausche, tausche) {
    int a = 1;
    int b = 2;
    int* p = &a;
    int* q = &b;
    tausche(p, q);
    EXPECT_EQ(p, &b);
    EXPECT_EQ(q, &a);
}
