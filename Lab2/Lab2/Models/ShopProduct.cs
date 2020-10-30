namespace Lab2.Models
{
    public class ShopProduct 
    {
        
        public int Id { get;}
        public Shop Shop { get;}
        public Product Product { get;}
        public double Price { get; set; }
        public int Amount { get; set; }
        
        public ShopProduct(int id, Shop shop, Product product)
        {
            Id = id;
            Shop = shop;
            Product = product;
        }

        public ShopProduct() {}
    }
}