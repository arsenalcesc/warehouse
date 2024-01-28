using Warehouse.DataLayer.DTOs;
using Warehouse.DataLayer.Repositories;

namespace Warehouse.BusinessLayer.Services
{
    public class ProductService
    {
        private readonly ProductRepository _productsRepository;

        public ProductService(ProductRepository productsRepository)
        {
            _productsRepository = productsRepository;
        }

        public async Task<List<ProductDto>> GetAll()
        {
            return await _productsRepository.GetAll();
        }
    }
}
