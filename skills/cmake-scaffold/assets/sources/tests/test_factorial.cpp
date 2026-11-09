#include <gtest/gtest.h>

extern "C" {
#include "<project_name>/<project_name>.h"
}

TEST(FactorialTest, Zero) {
    EXPECT_EQ(factorial(0), 1u);
}

TEST(FactorialTest, Ten) {
    EXPECT_EQ(factorial(10), 3628800u);
}
