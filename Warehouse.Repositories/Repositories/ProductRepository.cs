using Microsoft.EntityFrameworkCore;
using Warehouse.DataLayer.DTOs;
using Warehouse.DataLayer.Entities;

namespace Warehouse.DataLayer.Repositories
{
    public class ProductRepository
    {
        private readonly WarehouseDbContext _context;

        public ProductRepository(WarehouseDbContext context)
        {
            _context = context;
        }

        public async Task<List<ProductDto>> GetAll()
        {
            var productsWithStockCount = _context.Products
                .Select(product => new ProductDto
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

            return productsWithStockCount;
        }

        public async Task<List<Product>> GetProductsWithInventory(List<int> productIds)
        {
            return await _context.Products.Include(x => x.Inventory)
                                          .Where(x => productIds.Contains(x.ProductId))
                                          .ToListAsync();
        }
    }
}
