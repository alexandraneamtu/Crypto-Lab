using System;
using static System.Math;
using BigMath;

namespace CryptoLab3MillerRabin
{
    class MainClass
    {
        
        public static void Main(string[] args)
        {
            
            long n = 104543;
            int k = 10;
            bool isPrime = IsPrime(n,k);
            if (isPrime == true)
                Console.WriteLine("According to the Miller-Rabin Algorithm, n={0} is PROBABLE PRIME.\nThe probability" +
                                  " of error is less than 1/4^{1}", n, k);
            else
                Console.WriteLine("According to the Miller-Rabin Algorithm, n={0} is surely COMPOSITE",n);
            


        }


        private static bool IsPrime(long n, int k)
        {
            Console.WriteLine("n="+n);
            if ((n < 2) || (n % 2 == 0))
                return (n == 2);

            long t = n - 1;
            int s = 0;
            while (t % 2 == 0)
            {
                s++;
                t = t / 2;
            }
        

            bool isPrime = false;


            //Console.WriteLine(n + " - 1 = 2^" + s + " * " + n1);
            //Console.WriteLine("s:" + s);
            //Console.WriteLine("t:" + n1);

            Random r = new Random();
            for (int i = 0; i < k; i++)
            {
                //Console.WriteLine("----------");
                long[] seq = new long[s + 1];
                int a = r.Next(2, (int)(n - 1));
                long x = a;
                for (int j = 0; j < t - 1; j++)
                {
                    x = x * a;
                    x = x % n;
                }
                seq[0] = x;
                //Console.WriteLine("x:" + x);
                if (x != 1)
                {
                    int l;
                    for (l = 1; l <= s; l++)
                    {
                        x = x * x;
                        x = x % n;
                        seq[l] = x;
                        //Console.WriteLine("x:" + x);
                    }

                    for (int j = 0; j < s; j++)
                    {
                        if (seq[j] == n - 1 && seq[j + 1] == 1) { 
                        isPrime = true;
                    }

                    }

                    if (isPrime == false)
                        return isPrime;
                }
                else
                    isPrime = true;
            }
            return isPrime;
        }
   
    }
}
