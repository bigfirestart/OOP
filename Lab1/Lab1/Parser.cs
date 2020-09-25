using System;
using System.Collections.Generic;
using System.IO;

namespace Lab1 {
    internal static class IniParser {
        public static ParsedIniFile Parse(string filePath) {
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

        private static string[] CleanFile(string[] lines) {
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
    }

    internal class IniFileBuilder {
        private Dictionary<string, Dictionary<string, string>> data;

        public IniFileBuilder() {
            this.data = new Dictionary<string, Dictionary<string, string>>();
        }

        public void AddSection(string sectionName, Dictionary<string, string> section) {
            data.Add(sectionName, section);
        }

        public ParsedIniFile Build() {
            return new ParsedIniFile(this.data);
        }
    }

    class ParsedIniFile {
        private Dictionary<string, Dictionary<string, string>> data;

        public void Show() {
            foreach (var section in this.data) {
                Console.WriteLine($"Section [{section.Key}]");
                foreach (var line in section.Value) {
                    Console.WriteLine($"_{line.Key}:{line.Value}_");
                }
            }
        }

        public ParsedIniFile(Dictionary<string, Dictionary<string, string>> data) {
            this.data = data;
        }

        public string GetString(string sectionName, string key) {
            if (!this.data.ContainsKey(sectionName)) {
                throw new Exception("No such section");
            }

            var section = this.data[sectionName];
            if (!section.ContainsKey(key)) {
                throw new Exception($"No such key in section {sectionName}");
            }

            return section[key];
        }

        public int GetInt(string sectionName, string key) {
            var value = this.GetString(sectionName, key).Replace(".", ",");
            if (!int.TryParse(value, out var castedValue)) {
                throw new InvalidCastException();
            }

            return castedValue;
        }

        public float GetFloat(string sectionName, string key) {
            var value = this.GetString(sectionName, key).Replace(".", ",");
            if (!float.TryParse(value, out var castedValue)) {
                throw new InvalidCastException();
            }

            return castedValue;
        }
    }
}