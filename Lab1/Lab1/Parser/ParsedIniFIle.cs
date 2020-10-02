using System;
using System.Collections.Generic;
using Lab1.Exception;

namespace Lab1.Parser {
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
                throw new SectionNotFoundException(sectionName);
            }

            var section = this.data[sectionName];
            if (!section.ContainsKey(key)) {
                throw new PropertyNotFoundException(key);
            }

            return section[key];
        }

        public int GetInt(string sectionName, string key) {
            var value = this.GetString(sectionName, key).Replace(".", ",");
            if (!int.TryParse(value, out var castedValue)) {
                throw new InvalidValueTypeException("Int");
            }

            return castedValue;
        }

        public float GetFloat(string sectionName, string key) {
            var value = this.GetString(sectionName, key).Replace(".", ",");
            if (!float.TryParse(value, out var castedValue)) {
                throw new InvalidValueTypeException("Float");
            }

            return castedValue;
        }
    }
}