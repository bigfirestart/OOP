using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Lab2.Models;

namespace Lab2.Storage
{
    public class Storage
    {
        public List<Shop> Shops = new List<Shop>();
        public List<Product> Products = new List<Product>();
        public List<ShopProduct> ShopProducts = new List<ShopProduct>();

        public Shop CreateShop(string shopName)
        {
            Shops.Add(new Shop() {Id = Shops.Count, Name = shopName});
            return Shops[^1];
        }

        public Product CreateProduct(string productName)
        {
            Products.Add(new Product() {Id = Products.Count, Name = productName});
            return Products[^1];
        }

        public ShopProduct CreateShopProduct(int shopId, int productId, double price, int amount)
        {
            var shop = Shops[shopId];
            var product = Products[productId];
            ShopProducts.Add(new ShopProduct()
            {
                Id = ShopProducts.Count,
                Shop = shop,
                Product = product,
                Price = price,
                Amount = amount
            });
            return ShopProducts[^1];
        }

        public ShopProduct CreateShopProduct(string shopName, string productName, double price, int amount)
        {
            var shopId = CreateShop(shopName).Id;
            var productId = CreateProduct(productName).Id;
            return CreateShopProduct(shopId, productId, price, amount);
        }

        public ShopProduct GetShopProduct(int shopId, int productId)
        {
            var res = ShopProducts.Find(sp => sp.Shop.Id == shopId && sp.Product.Id == productId);
            if (res == null)
            {
                throw new Exception("No such Product in Shop");
            };
            return res;
        }
    }
}