using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Xml.Linq;
using WarehouseAPI.Database;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly WarehouseDbContext _context;

        public ProductsController(WarehouseDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Product>> Get()
        {
            //return all products with their stock count
            var productsWithStockCount = _context.Products
                .Select(product => new
                {
                    ProductId = product.ProductId,
                    ImageUrl = product.ImageUrl,
                    Name = product.Name,
                    Price = product.Price,
                    QuantityPerBox = product.QuantityPerBox,
                    CBM = product.CBM,
                    Description = product.Description,
                    StockCount = product.Inventory != null ? product.Inventory.QuantityInStock : 0
                })
                .ToList();

            return Ok(productsWithStockCount);
        }

        [HttpPost("SellProducts")]
        public ActionResult<List<Product>> SellProducts(List<Sale> sales)
        {
            return Ok();
        }

    }

    public class Sale
    {
        public int ProductId { get; set; }
        public int QuantitySold { get; set; }
    }
}