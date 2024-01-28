using Microsoft.AspNetCore.Mvc;
using Warehouse.BusinessLayer.Services;
using Warehouse.DataLayer.DTOs;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SalesController : ControllerBase
    {
        private readonly SaleService _saleService;
        private readonly ProductService _productService;

        public SalesController(SaleService saleService, ProductService productService)
        {
            _saleService = saleService;
            _productService = productService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllSales()
        {
            var sales = await _saleService.GetAll();

            return Ok(sales);
        }

        [HttpPost]
        public async Task<IActionResult> CreateSale([FromBody] NewSaleDto saleDto)
        {
            var result = await _saleService.CreateSale(saleDto);

            if (!result.Success)
                return BadRequest(result.Message);

            var products = await _productService.GetAll();

            return Ok(new { products, result.Message });
        }
    }
}