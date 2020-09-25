using System;
using System.Linq;


namespace Lab1 {
    internal static class Program {
        private enum AllowedTypes {
            String,
            Int,
            Float
        }
        public static void Main(string[] args) {
            if (args.Length < 1) {
                Console.WriteLine("Invalid program args");
                return;
            }

            ParsedIniFile parser = null;
            try {
                parser = IniParser.Parse(args[0]);
            }
            catch (Exception e) {
                Console.WriteLine(e.Message);
            }
            
            //reading data 
            Console.WriteLine("Section: ");
            var section = Console.ReadLine();
            
            Console.WriteLine("key: ");
            var key = Console.ReadLine();
            
            Console.WriteLine("Type: ");
            var type = Console.ReadLine();
            
            //trying extract
            if (!Enum.GetNames(typeof(AllowedTypes)).Contains(type)) return;
            if (parser == null) return;
            try {
                switch (type) {
                    case "Int":
                        Console.WriteLine(parser.GetInt(section, key));
                        break;
                    case "Float":
                        Console.WriteLine(parser.GetFloat(section, key));
                        break;
                    default:
                        Console.WriteLine(parser.GetString(section, key));
                        break;
                }
                
            }
            catch (Exception e) {
                Console.WriteLine(e.Message);
            }
        }
    }
}