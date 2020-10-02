namespace Lab1.Exception {
    public class InvalidValueTypeException: ParserException  {
        public InvalidValueTypeException(string typeName) : base($"Invalid value cast to {typeName} type") { }
    }
}