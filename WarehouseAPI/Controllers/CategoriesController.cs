using Microsoft.AspNetCore.Mvc;
using Warehouse.BusinessLayer.Services;
using Warehouse.DataLayer.DTOs;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CategoriesController : ControllerBase
    {
        private readonly CategoryService _categoryService;

        public CategoriesController(CategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllCategories()
        {
            var categoriesWithProductCount = await _categoryService.GetAll();
            return Ok(categoriesWithProductCount);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCategoryById(int id)
        {
            var category = await _categoryService.GetById(id);

            if (category == null)
                return NotFound();

            return Ok(category);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCategory(int id, [FromBody] CategoryUpdateDto updatedCategoryDto)
        {
            var success = await _categoryService.UpdateCategory(id, updatedCategoryDto);

            if (!success)
                return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            throw new NotImplementedException();
        }
    }
}