create or alter procedure dbo.usp_MakeFamilyPurchase(
	@FamilySurName varchar(255)
)
as
set nocount on
begin
	declare @ErrorMessage nvarchar(268)

	if not exists (
		select *
		from dbo.Family as f
		where f.SurName = @FamilySurName
	)
	begin
		set @ErrorMessage = N'Семьи "' + @FamilySurName + N'" нет!'

		raiserror(@ErrorMessage, 1, 1)

		return
	end
	;with cte_SumBudgetValue as (
		select
			b.ID_Family as ID_Family
			,sum(b.Value) as SumBudgetValue
		from dbo.Basket as b
		group by b.ID_Family
	)
	update f
	set BudgetValue = f.BudgetValue - sbv.SumBudgetValue
	from dbo.Family as f
	inner join cte_SumBudgetValue as sbv on sbv.ID_Family = f.ID
	where f.SurName = @FamilySurName

	return
end