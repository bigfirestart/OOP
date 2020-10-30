namespace Lab2.Models
{
    public class Product
    {
        public int Id { get; }
        public string Name { get; }

        public Product(int id, string name) {
            Id = id;
            Name = name;
        }
    }
}