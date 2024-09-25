create or alter view dbo.vw_SKUPrice
as
select
	sku.ID as ID
	,sku.Code as Code
	,sku.Name as Name
	,dbo.udf_GetSKUPrice(sku.ID) as SKUPrice
from dbo.SKU as sku