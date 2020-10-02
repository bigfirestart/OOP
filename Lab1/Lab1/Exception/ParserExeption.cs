namespace Lab1.Exception {
    public class ParserException : System.Exception {
        public ParserException() {
        }
        public ParserException(string message)
            : base(message) {
        }
    }
}