using System;
using System.Collections.Generic;
using System.Linq;
using Lab2.Models;
using Lab2.Storage;

namespace Lab2.Services
{
    public class ShopProductsServices
    {
        private readonly Storage.Storage _storage;

        public ShopProductsServices(Storage.Storage storage)
        {
            _storage = storage;
        }

        public IEnumerable<ShopProduct> AddProductsToShop(int shopId, List<PricedAmountedProduct> consigment)
        {
            var startIndex = _storage.ShopProducts.Count;
            foreach (var pricedAmountedProduct in consigment)
            {
                _storage.CreateShopProduct(shopId, pricedAmountedProduct.Product.Id, pricedAmountedProduct.Price,
                    pricedAmountedProduct.Amount);
            }

            return _storage.ShopProducts.GetRange(startIndex, consigment.Count);
        }

        public Shop FindCheapestShopByProduct(int productId)
        {
            var product = _storage.Products[productId];
            ShopProduct cheapestShopProduct = new ShopProduct() {Price = Double.MaxValue};
            foreach (var shopProduct in _storage.ShopProducts)
            {
                if (shopProduct.Product == product && shopProduct.Price < cheapestShopProduct.Price)
                {
                    cheapestShopProduct = shopProduct;
                }
            }

            if (cheapestShopProduct.Price == Double.MaxValue)
            {
                return null;
            }

            return cheapestShopProduct.Shop;
        }

        public List<AmountedProduct> BuyInShopByPrice(int shopId, double totalMaxPrice)
        {
            var res = new List<AmountedProduct>();
            foreach (var shopProduct in _storage.ShopProducts)
            {
                var shop = _storage.Shops[shopId];
                if (shopProduct.Shop == shop && shopProduct.Price < totalMaxPrice)
                {
                    res.Add(new AmountedProduct()
                    {
                        Product = shopProduct.Product,
                        Amount = Convert.ToInt32(Math.Round(totalMaxPrice / shopProduct.Price))
                    });
                }
            }

            return res;
        }

        public double? BuyConsignment(int shopId, List<AmountedProduct> consigment, bool commitBuy = false)
        {
            if (CheckConsignmentInShop(0, consigment))
            {
                var totalSum = 0.0;
                foreach (var amountedProduct in consigment)
                {
                    var price = 0.0;
                    if (commitBuy)
                    {
                        price = BuyProductInShop(0, amountedProduct.Product.Id, amountedProduct.Amount);
                    }
                    else
                    {
                        try
                        {
                            price = _storage.GetShopProduct(shopId, amountedProduct.Product.Id).Price *
                                    amountedProduct.Amount;
                        }
                        catch
                        {
                            return null;
                        }
                       
                    }

                    totalSum += price;
                }

                return totalSum;
            }
            else
            {
                return -1;
            }
        }


        public bool CheckConsignmentInShop(int shopId, List<AmountedProduct> consignment)
        {
            foreach (var amountedProduct in consignment)
            {
                try
                {
                    var shopAmount = _storage.GetShopProduct(shopId, amountedProduct.Product.Id).Amount;
                    if (shopAmount < amountedProduct.Amount)
                    {
                        return false;
                    }
                }
                catch
                {
                    return false;
                }
                
            }
            return true;
        }

        public double BuyProductInShop(int shopId, int productId, int amount = 1)
        {
            foreach (var shopProduct in _storage.ShopProducts)
            {
                if (shopProduct.Shop.Id == shopId && shopProduct.Product.Id == productId)
                {
                    if (shopProduct.Amount > 1)
                    {
                        shopProduct.Amount = shopProduct.Amount - amount;
                    }
                    else if (shopProduct.Amount == 1)
                    {
                        _storage.ShopProducts.Remove(shopProduct);
                    }

                    return shopProduct.Price * amount;
                }
            }

            return 0;
        }

        public (Shop, double) WhereIsCheapestConsigment(List<AmountedProduct> consigment)
        {
            // LINQ
            var result = _storage.Shops.Select(shop => {
                return new {
                    Shop = shop,
                    Total = BuyConsignment(shop.Id, consigment)
                };
            }).Where(x => x.Total.HasValue).Min();
            return (result.Shop, result.Total.Value);

        }
    }
}