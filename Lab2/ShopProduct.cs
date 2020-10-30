namespace Lab2.Models
{
    public class ShopProduct 
    { 
        public int Id { get; set; }
        public Shop Shop { get; set; }
        public Product Product { get; set; }
        public double Price { get; set; }
        public int Amount { get; set; }

    }
}