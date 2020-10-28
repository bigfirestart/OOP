using Lab2.Models;

namespace Lab2.Services
{
    public class PricedAmountedProduct
    {
        public Product Product { get; set; }
        public int Amount { get; set; }
        public double Price { get; set; }
    }
}