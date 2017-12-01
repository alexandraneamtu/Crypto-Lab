using BigMath;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using System.IO;

namespace Lab2Crypto
{
    class Program
    {
        static void Main(string[] args)
        {

            string[] values = File.ReadAllLines(@"/Users/alexandraneamtu/Documents/An3-sem1/crypto/Lab2/Lab2Crypto/test.txt");
            string[] results = new string[100];
            foreach (var line in values)
            {
                string[] s = line.Split(',');

                /*
                long a, b;

                bool aResult = Int64.TryParse(s[0], out a);
                bool bResult = Int64.TryParse(s[1], out b);

                if (aResult && bResult)
                {

                    Console.WriteLine("a: " + a + " b: " + b);
                    var time1 = Stopwatch.StartNew();
                    var result1 = GCDAlgorithms.Alg1(a, b);
                    time1.Stop();
                    Console.WriteLine("Alg1 Result: " + result1);
                    Console.WriteLine(time1.Elapsed.TotalMilliseconds * 1000000 + " nanoseconds\n");


                    Console.WriteLine("a: " + a + " b: " + b);
                    var time2 = Stopwatch.StartNew();
                    var result2 = GCDAlgorithms.Alg2(a, b);
                    time2.Stop();
                    Console.WriteLine("Alg2 Result: " + result2);
                    Console.WriteLine(time2.Elapsed.TotalMilliseconds * 1000000 + " nanoseconds\n");
                }
    */

                Int256 aBig, bBig;
                bool aBigResult = Int256.TryParse(s[0], out aBig);
                bool bBigResult = Int256.TryParse(s[1], out bBig);
                if (aBigResult && bBigResult)
                {
                    Console.WriteLine("a: " + aBig + " b: " + bBig);
                    var time3 = Stopwatch.StartNew();
                    var result3 = GCDAlgorithms.Alg3(aBig, bBig);
                    time3.Stop();
                    Console.WriteLine("Alg3 Result: " + result3);
                    Console.WriteLine(time3.Elapsed.TotalMilliseconds * 1000000
                                      + " nanoseconds\n");

                }

         
                    
                }
            Console.ReadLine();
        }
    }
}
