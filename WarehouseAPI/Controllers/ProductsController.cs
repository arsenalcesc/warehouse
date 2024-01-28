using Microsoft.AspNetCore.Mvc;
using Warehouse.BusinessLayer.Services;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly ProductService _productService;

        public ProductsController(ProductService productService)
        {
            _productService = productService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllProducts()
        {
            var productsWithStockCount = await _productService.GetAll();

            return Ok(productsWithStockCount);
        }
    }
}