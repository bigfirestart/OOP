using System;
using System.Collections.Generic;
using System.Text.Json;
using Lab2.Services;
using Lab2.Storage;

namespace Lab2
{
    static class Program
    {
        static void PrintJson(Object obj)
        {
            Console.WriteLine(JsonSerializer.Serialize(obj, new JsonSerializerOptions() { WriteIndented = true }));
        }
        static void Main(string[] args)
        {
            var storage = new Storage.Storage();
            var services = new ShopProductsServices(storage);
            
            //1
            storage.CreateShop("Lenta");
            storage.CreateShop("Magnit");
            
            //2
            var pr1 = storage.CreateProduct("Milk");
            var pr2 = storage.CreateProduct("Milk1");
            var pr3 = storage.CreateProduct("Milk2");

            storage.CreateProduct("Milk3");
            storage.CreateProduct("Milk4");
            
            //3
            var consigment = new List<PricedAmountedProduct>();
            consigment.Add(new PricedAmountedProduct() {Product = pr1, Price = 100.20, Amount = 20});
            consigment.Add(new PricedAmountedProduct() {Product = pr2, Price = 3.20, Amount = 100});
            consigment.Add(new PricedAmountedProduct() {Product = pr3, Price = 30.20, Amount = 2200});
            services.AddProductsToShop(0, consigment);
            
            //4
            PrintJson(services.FindCheapestShopByProduct(1).Name);
            
            //5
            PrintJson(services.BuyInShopByPrice(0, 1000.0));
            
            //6
            var buyConsigment = new List<AmountedProduct>();
            buyConsigment.Add(new AmountedProduct() {Product = pr1, Amount = 11});
            buyConsigment.Add(new AmountedProduct() {Product = pr2, Amount = 90});
            buyConsigment.Add(new AmountedProduct() {Product = pr3, Amount = 100});
            var result = services.BuyConsignment(0, buyConsigment, true);
            if (result.HasValue) {
                // ... PrintJson();
            } else {
                
            }

            //7
            var cheapestConsigment = new List<AmountedProduct>();
            cheapestConsigment.Add(new AmountedProduct() {Product = pr1, Amount = 2});
            cheapestConsigment.Add(new AmountedProduct() {Product = pr2, Amount = 3});

            Console.WriteLine(services.WhereIsCheapestConsigment(cheapestConsigment));

        }
    }
}