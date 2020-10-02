using System.Collections.Generic;
using System.IO;
using Lab1.Exception;

namespace Lab1.Parser {
    internal static class IniParser {
        public static ParsedIniFile Parse(string filePath) {
            try {
                var builder = new IniFileBuilder();
                var lines = CleanFile(File.ReadAllLines(filePath));
                string curSectionName = null;
                var curSection = new Dictionary<string, string>();
                foreach (var line in lines) {
                    if (line[0] == '[') {
                        if (curSectionName != null) {
                            builder.AddSection(curSectionName, new Dictionary<string, string>(curSection));
                            curSection.Clear();
                        }

                        curSectionName = line.Substring(1, line.Length - 2);
                    }
                    else {
                        var key = line.Split('=')[0];
                        var val = line.Split('=')[1];
                        curSection.Add(key, val);
                    }
                }

                return builder.Build();
            }
            catch (System.Exception e) {
                throw new FileParsingException();
            }
        }

        private static string[] CleanFile(string[] lines) {
            try {
                var cleanedLines = new List<string>();
                for (var i = 0; i < lines.Length; i++) {
                    var line = lines[i];
                    line = line.Trim();
                    line = line.Replace(" ", string.Empty);
                    if (lines[i].Length > 0) {
                        var semicolonPos = line.IndexOf(';');
                        if (semicolonPos >= 0) {
                            lines[i] = line.Substring(0, semicolonPos);
                            i--;
                        }
                        else {
                            cleanedLines.Add(line);
                        }
                    }
                }

                return cleanedLines.ToArray();
            }
            catch (System.Exception e) {
                throw new FileCleaningException();
            }
            
        }
    }
}
