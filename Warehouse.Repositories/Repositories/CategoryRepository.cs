using Microsoft.EntityFrameworkCore;
using Warehouse.DataLayer.DTOs;

namespace Warehouse.DataLayer.Repositories
{
    public class CategoryRepository
    {
        private readonly WarehouseDbContext _context;

        public CategoryRepository(WarehouseDbContext context)
        {
            _context = context;
        }

        public async Task<List<CategoryDto>> GetAll()
        {
            var categories = await _context.Categories
                .Select(category => new CategoryDto
                {
                    CategoryId = category.CategoryId,
                    Name = category.Name,
                    Description = category.Description,
                    ProductCount = category.Products.Count
                })
                .ToListAsync();


            return categories;
        }

        public async Task<CategoryDto> GetById(int categoryId)
        {
            var category = await _context.Categories
                .Select(category => new CategoryDto
                {
                    CategoryId = category.CategoryId,
                    Name = category.Name,
                    Description = category.Description,
                    ProductCount = category.Products.Count
                })
                .FirstOrDefaultAsync(category => category.CategoryId == categoryId);

            return category;
        }

        public async Task<bool> UpdateCategoryAsync(int categoryId, CategoryUpdateDto updatedCategoryData)
        {
            var category = await _context.Categories.FirstOrDefaultAsync(c => c.CategoryId == categoryId);

            if (category == null)
                return false;

            category.Name = updatedCategoryData.Name;
            category.Description = updatedCategoryData.Description;
            category.UpdatedOnUtc = DateTime.UtcNow;
            category.UpdatedByUserId = 1;

            await _context.SaveChangesAsync();
            return true;
        }
    }
}
