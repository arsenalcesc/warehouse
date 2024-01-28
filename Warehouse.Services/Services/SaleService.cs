using Warehouse.DataLayer.DTOs;
using Warehouse.DataLayer.Entities;
using Warehouse.DataLayer.Repositories;

namespace Warehouse.BusinessLayer.Services
{
    public class SaleService
    {
        private readonly SaleRepository _saleRepository;
        private readonly ProductRepository _productRepository;

        public SaleService(SaleRepository saleRepository, ProductRepository productRepository)
        {
            _saleRepository = saleRepository;
            _productRepository = productRepository;
        }

        public async Task<List<SaleDto>> GetAll()
        {
            return await _saleRepository.GetAll();
        }
        
        //TODO:
        //Improve this method, validation, error handling, etc.
        //Should not be fectching all products from DB and updating their stock in this method directly
        public async Task<NewSaleResultDto> CreateSale(NewSaleDto saleDto)
        {
            if (saleDto?.SaleItems == null || !saleDto.SaleItems.Any())
                return new NewSaleResultDto(false, "Sale data is incomplete or missing.");

            var productIds = saleDto.SaleItems.Select(x => x.ProductId).ToList();
            var products = await _productRepository.GetProductsWithInventory(productIds);

            if (products.Count != productIds.Count)
                throw new Exception("One or more products not found in inventory");

            var firstItemNotEnoughStock = products.FirstOrDefault(x =>
                x.Inventory.QuantityInStock < saleDto.SaleItems.First(y => y.ProductId == x.ProductId).QuantitySold);

            if (firstItemNotEnoughStock != null)
                return new NewSaleResultDto(false, $"Not enough stock for Product ID: {firstItemNotEnoughStock.ProductId}");

            var sale = new Sale
            {
                CustomerId = 1,
                SaleDate = DateTime.UtcNow,
                SaleByUserId = 1,
                AddedOnUtc = DateTime.UtcNow,
                AddedByUserId = 1,
                SaleItems = new List<SaleItem>()
            };

            foreach (var saleItemDto in saleDto.SaleItems)
            {
                var product = products.First(p => p.ProductId == saleItemDto.ProductId);
                product.Inventory.QuantityInStock -= saleItemDto.QuantitySold;

                var saleItem = new SaleItem
                {
                    ProductId = saleItemDto.ProductId,
                    Quantity = saleItemDto.QuantitySold,
                    Price = product.Price
                };

                sale.SaleItems.Add(saleItem);
            }

            await _saleRepository.CreateSale(sale);
            return new NewSaleResultDto(true, "Sale created successfully");
        }
    }
}