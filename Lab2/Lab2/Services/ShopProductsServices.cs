using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
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

        public string AddProductsToShop(int shopId, List<PricedAmountedProduct> consigment)
        {
            var startIndex = _storage.GetShopProducts().Count;
            foreach (var pricedAmountedProduct in consigment)
            {
                _storage.CreateShopProduct(shopId, pricedAmountedProduct.Product.Id, pricedAmountedProduct.Price,
                    pricedAmountedProduct.Amount);
            }

            return JsonSerializer.Serialize(_storage.GetShopProducts().GetRange(startIndex, consigment.Count));
        }

        public string FindCheapestShopByProduct(int productId)
        {
            var product = _storage.GetProducts()[productId];
            ShopProduct cheapestShopProduct = new ShopProduct() {Price = Double.MaxValue};
            foreach (var shopProduct in _storage.GetShopProducts())
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

            return JsonSerializer.Serialize(cheapestShopProduct.Shop);
        }

        public List<AmountedProduct> BuyInShopByPrice(int shopId, double totalMaxPrice)
        {
            var res = new List<AmountedProduct>();
            foreach (var shopProduct in _storage.GetShopProducts())
            {
                var shop = _storage.GetShops()[shopId];
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
                        price = _storage.BuyProductInShop(0, amountedProduct.Product.Id, amountedProduct.Amount);
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

        public (string, double) WhereIsCheapestConsigment(List<AmountedProduct> consigment)
        {
            // LINQ
            var result = _storage.GetShops().Select(shop => {
                return new {
                    Shop = shop,
                    Total = BuyConsignment(shop.Id, consigment)
                };
            }).Where(x => x.Total.HasValue).Min();
            return (JsonSerializer.Serialize(result.Shop), result.Total.Value);

        }
    }
}