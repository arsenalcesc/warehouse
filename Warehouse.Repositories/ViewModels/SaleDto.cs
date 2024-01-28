namespace Warehouse.DataLayer.DTOs
{
    //TODO: Move these DTOs to a separate file
    //TODO: Give correct names to DTOs/ViewModels
    public class SaleDto
    {
        public int SaleId { get; set; }
        public string CustomerBusinessName { get; set; }
        public DateTime SaleDate { get; set; }
        public int ProductsCount { get; set; }
        public int StockItemsCount { get; set; }
        public decimal Amount { get; set; }
    }
    public class NewSaleDto
    {
        public List<NewSaleItemDto> SaleItems { get; set; }
    }

    public class NewSaleItemDto
    {
        public int ProductId { get; set; }
        public int QuantitySold { get; set; }
    }

    public class NewSaleResultDto
    {
        public NewSaleResultDto(bool success, string message)
        {
            Success = success;
            Message = message;
        }

        public bool Success { get; set; }
        public string Message { get; set; }
    }
}
