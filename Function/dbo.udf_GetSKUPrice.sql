create or alter function dbo.udf_GetSKUPrice(
	@ID_SKU int
)
returns decimal(18, 2)
as
begin
	declare @SKUPrice decimal(18, 2)

	select @SKUPrice = coalesce(sum(b.Value) / sum(b.Quantity), 0)
	from dbo.Basket as b
	where b.ID_SKU = @ID_SKU

	return @SKUPrice
end