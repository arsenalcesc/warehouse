using Warehouse.DataLayer.DTOs;
using Warehouse.DataLayer.Repositories;

namespace Warehouse.BusinessLayer.Services
{
    public class CategoryService
    {
        private readonly CategoryRepository _categoryRepository;

        public CategoryService(CategoryRepository categoryRepository)
        {
            _categoryRepository = categoryRepository;
        }

        public async Task<List<CategoryDto>> GetAll()
        {
            return await _categoryRepository.GetAll();
        }

        public async Task<CategoryDto> GetById(int categoryId)
        {
            return await _categoryRepository.GetById(categoryId);
        }

        public async Task<bool> UpdateCategory(int categoryId, CategoryUpdateDto updatedCategoryDto)
        {
            return await _categoryRepository.UpdateCategoryAsync(categoryId, updatedCategoryDto);
        }
    }
}
