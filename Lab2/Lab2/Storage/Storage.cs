using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Lab2.Models;
using Lab2.Services;

namespace Lab2.Storage
{
    public class Storage: ShopProduct
    {
        private List<Shop> Shops = new List<Shop>();
        private List<Product> Products = new List<Product>();
        private List<ShopProduct> ShopProducts = new List<ShopProduct>();
        
        List<T> Clone<T>(IEnumerable<T> oldList)
        {
            return new List<T>(oldList);
        }

        public Shop CreateShop(string shopName)
        {
            Shops.Add(new Shop(Shops.Count, shopName));
            return Shops.Last();
        }

        public List<Shop> GetShops()
        {
            return Clone(this.Shops);
        }

        public List<Product> GetProducts()
        {
            return Clone(this.Products);
        }

        public List<ShopProduct> GetShopProducts()
        {
            return Clone(this.ShopProducts);
        }
        public Product CreateProduct(string productName) {
            Products.Add(new Product(Products.Count, productName));
            return Products.Last();
        }

        public ShopProduct CreateShopProduct(int shopId, int productId, double price, int amount)
        {
            var shop = Shops[shopId];
            var product = Products[productId];
            ShopProducts.Add(new ShopProduct(ShopProducts.Count, shop, product)
            {
                Price = price,
                Amount = amount
            });
            return ShopProducts.Last();
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

        public double BuyProductInShop(int shopId, int productId, int amount = 1)
        {
            foreach (var shopProduct in ShopProducts)
            {
                if (shopProduct.Shop.Id == shopId && shopProduct.Product.Id == productId)
                {
                    if (shopProduct.Amount > 1)
                    {
                        shopProduct.Amount = shopProduct.Amount - amount;
                    }
                    else if (shopProduct.Amount == 1)
                    {
                        ShopProducts.Remove(shopProduct);
                    }

                    return shopProduct.Price * amount;
                }
            }

            return 0;
        }
    }
}