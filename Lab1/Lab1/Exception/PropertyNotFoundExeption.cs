namespace Lab1.Exception {
    public class PropertyNotFoundException: ParserException {
        public PropertyNotFoundException(string key)
            : base($"Property with key {key} not found") {}
    }
}