using BigMath;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab2Crypto
{
    class GCDAlgorithms
    {
        /*
        Stein’s Algorithm

        Algorithm to find GCD using Stein’s algorithm gcd(a, b)

        1.If both and b are 0, gcd is zero gcd(0, 0) = 0.
        2.gcd(a, 0) = a and gcd(0, b) = b because everything divides 0.
        3.If a and b are both even, gcd(a, b) = 2* gcd(a/2, b/2) because 2 is a common divisor.Multiplication with 2 can be done with bitwise shift operator.
        4.If a is even and b is odd, gcd(a, b) = gcd(a / 2, b).Similarly, if a is odd and b is even, then
        gcd(a, b) = gcd(a, b / 2).It is because 2 is not a common divisor.
        5.If both a and b are odd, then gcd(a, b) = gcd(| a - b |/ 2, b).Note that difference of two odd numbers is even
        6.Repeat steps 3–5 until a = b, or until a = 0. In either case, the GCD is power(2, k) * b, where power(2, k) is 2 raise to the power of k and k is the number of common factors of 2 found in step 2.

        */
        public static long Alg1(long b, long a)
        {
            if (a == 0)
                return b;
            if (b == 0)
                return a;

            /*Finding K, where K is the greatest power of 2
              that divides both a and b. */
            int k;
            for (k = 0; ((a | b) & 1) == 0; ++k)
            {
                a >>= 1;
                b >>= 1;
            }

            /* Dividing a by 2 until a becomes odd */
            while ((a & 1) == 0)
                a >>= 1;

            /* From here on, 'a' is always odd. */
            do
            {
                /* If b is even, remove all factor of 2 in b */
                while ((b & 1) == 0)
                    b >>= 1;

                /* Now a and b are both odd. Swap if necessary
                   so a <= b, then set b = b - a (which is even).*/
                if (a > b)
                {
                    long swap = a;
                    a = b;
                    b = swap;
                }// Swap a and b.

                b = (b - a);
            } while (b != 0);

            /* restore common factors of 2 */
            return a << k;
        }

        //repeated substractions
        public static long Alg2(long a, long b)
        {
            if (a * b == 0)
            {
                return a + b;
            }
            while (a != b)
            {
                if (a > b)
                {
                    a = a - b;
                }
                else
                {
                    b = b - a;
                }
            }
            return a;
        }



        //Euclid's Algorithm
        public static Int256 Alg3(Int256 a, Int256 b)
        {
            if (a == 0)
                return b;
            if (b == 0)
                return a;

            if (a > b)
                return Alg3(a % b, b);
            else
                return Alg3(a, b % a);
        }


    }
}