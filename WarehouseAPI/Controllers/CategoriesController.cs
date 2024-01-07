using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WarehouseAPI.Database;

namespace WarehouseAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CategoriesController : ControllerBase
    {
        private readonly WarehouseDbContext _context;

        public CategoriesController(WarehouseDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllCategories()
        {
            var categoriesWithProductCount = await _context.Categories
                .Select(category => new
                {
                    CategoryId = category.CategoryId,
                    Name = category.Name,
                    Description = category.Description,
                    ProductCount = category.Products.Count // Assuming you have a navigation property 'Products' in your Category class
                })
                .ToListAsync();

            return Ok(categoriesWithProductCount);
        }


        //Create endpoint for getting a single category by id
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCategoryById(int id)
        {
            var category = await _context.Categories.FindAsync(id);

            if (category == null)
                return NotFound();

            return Ok(category);
        }

        [HttpPost]
        public async Task<IActionResult> CreateCategory([FromBody] Category category)
        {
            if (category == null)
                return BadRequest();

            _context.Categories.Add(category);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCategoryById), new { id = category.CategoryId }, category);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            var category = await _context.Categories.FindAsync(id);

            if (category == null)
                return NotFound();

            _context.Categories.Remove(category);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCategory(int id, [FromBody] CategoryUpdateDto updatedCategory)
        {
            var category = await _context.Categories.FirstOrDefaultAsync(c => c.CategoryId == id);

            if (category == null)
                return NotFound();

            category.Name = updatedCategory.Name;
            category.Description = updatedCategory.Description;

            await _context.SaveChangesAsync();

            return NoContent();
        }

        public class CategoryUpdateDto
        {
            public string Name { get; set; }
            public string Description { get; set; }
        }

    }
}