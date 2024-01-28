using Microsoft.EntityFrameworkCore;
using Warehouse.DataLayer.DTOs;
using Warehouse.DataLayer.Entities;

namespace Warehouse.DataLayer.Repositories
{
    public class SaleRepository
    {
        private readonly WarehouseDbContext _context;

        public SaleRepository(WarehouseDbContext context)
        {
            _context = context;
        }

        public async Task<List<SaleDto>> GetAll()
        {
            var sales = await _context.Sales
                .Select(sale => new
                {
                    sale.SaleId,
                    CustomerBusinessName = sale.Customer.BusinessName,
                    sale.SaleDate,
                    ProductsCount = sale.SaleItems.Count,
                    StockItemsCount = sale.SaleItems.Sum(x => x.Quantity),
                    Amount = sale.SaleItems.Sum(x => x.Price * x.Quantity)
                })
                .OrderByDescending(x => x.SaleDate)
                .ToListAsync();

            return sales.Select(s => new SaleDto
            {
                SaleId = s.SaleId,
                CustomerBusinessName = s.CustomerBusinessName,
                SaleDate = s.SaleDate,
                ProductsCount = s.ProductsCount,
                StockItemsCount = s.StockItemsCount,
                Amount = s.Amount
            }).ToList();
        }

        public async Task CreateSale(Sale sale)
        {
            _context.Sales.Add(sale);
            await _context.SaveChangesAsync();
        }
    }
}
