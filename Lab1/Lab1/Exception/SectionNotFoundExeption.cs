namespace Lab1.Exception {
    public class SectionNotFoundException: ParserException {
        public SectionNotFoundException(string sectionName)
            : base($"Section with name {sectionName} not found") {}
    }
}