using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FirstConsoleAppExample
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello WOrld!");

            string name = "Jelena";
            Console.WriteLine(name);

            //deklaracija
            int a, b, c, d;
            //inicijalizacija
            a = 1;
            b = 6;
            c = d = 7;

            Console.WriteLine($"a={a}\n b={b}\n c={c}\n d={d}\n"); //mora ići $ inače doslovno ispisuje a={a}

            bool isActive = false;

            if(isActive)
            {
                Console.WriteLine(name);
            }
            else
            {
                string secondName ="Ana";
                Console.WriteLine (secondName); //ovaj secondname varijabla postoji samo unutar ove else funkcije jer je tu definirana
            }

            Console.ReadLine();
        }
    }
}
