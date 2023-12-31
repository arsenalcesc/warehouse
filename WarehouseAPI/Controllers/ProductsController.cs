using Microsoft.AspNetCore.Mvc;
using System.Xml.Linq;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductsController : ControllerBase
    {
        private static List<Product> _products = new List<Product>
        {
            new Product
            {
                Id = 1, Name = "Apple iPhone", QuantityPerCarton = 10,
                PricePerItem = 4.12M, CBM = 0.5M,
                Description = "Latest model smartphone.",
                PictureUrl = "https://i.ebayimg.com/images/g/oHsAAOSwM2lkCM1G/s-l1200.webp",
                Stock = 400
            },
            new Product
            {
                Id = 2, Name = "Samsung TV", QuantityPerCarton = 5,
                PricePerItem = 0.92M, CBM = 1.2M,
                Description = "55 inch 4K TV.",
                PictureUrl = "https://media.4rgos.it/s/Argos/2074539_R_SET?$Main768$&w=620&h=620",
                Stock = 300
            },
            new Product
            {
                Id = 3, Name = "Bose Headphones", QuantityPerCarton = 20,
                PricePerItem = 0.08M, CBM = 0.3M,
                Description = "Noise Cancelling Headphones 700.",
                PictureUrl = "https://via.placeholder.com/150",
                Stock = 126
            },
            new Product
            {
                Id = 4, Name = "Sony PlayStation 5", QuantityPerCarton = 5,
                PricePerItem = 1.49M, CBM = 2.0M,
                Description = "Next-gen gaming console.",
                PictureUrl = "https://via.placeholder.com/150",
                Stock = 900
            },
            new Product
            {
                Id = 5, Name = "Microsoft Xbox Series X", QuantityPerCarton = 4,
                PricePerItem = 1.25M, CBM = 1.8M,
                Description = "Advanced gaming console.",
                PictureUrl = "https://via.placeholder.com/150",
                Stock = 200
            },
            new Product
            {
                Id = 6, Name = "Apple MacBook Pro", QuantityPerCarton = 6,
                PricePerItem = 2.30M, CBM = 0.7M,
                Description = "High-performance laptop with M1 chip.",
                PictureUrl = "https://via.placeholder.com/150",
                Stock = 150
            },
            new Product
            {
                Id = 7, Name = "GoPro HERO9 Black", QuantityPerCarton = 10,
                PricePerItem = 0.55M, CBM = 0.2M,
                Description = "Waterproof action camera with 5K video.",
                PictureUrl = "https://via.placeholder.com/150",
                Stock = 75
            },
            // Add more products as needed
        };

        [HttpGet]
        public ActionResult<IEnumerable<Product>> Get()
        {
            return Ok(_products);
        }

        [HttpPost("SellProducts")]
        public ActionResult<List<Product>> SellProducts(List<Sale> sales)
        {
            List<Product> updatedProducts = new List<Product>();
            foreach (var sale in sales)
            {
                var product = _products.FirstOrDefault(p => p.Id == sale.ProductId);
                if (product == null) continue;
                if (product.Stock < sale.QuantitySold) continue;

                product.Stock -= sale.QuantitySold;
                updatedProducts.Add(product);
            }
            return Ok(updatedProducts);
        }

    }
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int QuantityPerCarton { get; set; }
        public decimal PricePerItem { get; set; }
        public decimal CBM { get; set; }
        public string Description { get; set; }
        public string PictureUrl { get; set; }
        public int Stock { get; set; }
    }
    public class Sale
    {
        public int ProductId { get; set; }
        public int QuantitySold { get; set; }
    }
}