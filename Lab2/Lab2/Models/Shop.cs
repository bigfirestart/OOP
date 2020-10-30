using System;
using System.Text.Json;

namespace Lab2.Models
{
    public class Shop
    {
        public int Id { get;}
        public string Name { get;}

        public Shop(int id, string name)
        {
            Id = id;
            Name = Name;
        }
    }
}