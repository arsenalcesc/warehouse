namespace Warehouse.DataLayer.DTOs
{
    public class ProductDto
    {
        public int ProductId { get; set; }
        public string ImageUrl { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int QuantityPerBox { get; set; }
        public decimal CBM { get; set; }
        public string Description { get; set; }
        public int StockCount { get; set; }
    }
}
