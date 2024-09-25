create or alter trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert
as
begin
	with cte_DiscontAvailable as (
		select
			case
				when count(i.ID) >= 2
					then 1
				else 0
			end as FlagAvailable
			,i.ID_SKU as ID_SKU
		from inserted as i
		group by i.ID_SKU
	)
	update b
	set DiscountValue = i.Value * 0.05 * da.FlagAvailable
	from dbo.Basket as b
	inner join inserted as i on i.ID = b.ID
	inner join cte_DiscontAvailable as da on da.ID_SKU = b.ID_SKU
end