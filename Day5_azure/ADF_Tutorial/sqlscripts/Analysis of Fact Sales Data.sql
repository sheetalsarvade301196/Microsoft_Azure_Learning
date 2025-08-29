USE [WineStoreDW]
GO

   SELECT	[StoreId], [TerritoryId], [ProductId], [DateId], [CurrencyId], 
            [SalesQty], [SalesAmount], [CostAmount], [MarginAmount], [InsertDate], [BatchId]
   FROM	   [dbo].[factSales]


  --Total Sales
   SELECT	SUM([SalesQty]) AS TotalSales,
            SUM([SalesAmount]) AS TotalAmount,
            SUM([CostAmount]) AS TotalCost,
            SUM([MarginAmount]) AS Profit
   FROM		[dbo].[factSales]

  --Total Sales by SalesMonth
   SELECT		DD.[YearMonth],
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimDate] DD
   ON			   FS.DateId = DD.DateId
   GROUP BY		DD.[YearMonth]
   ORDER BY		DD.[YearMonth]

  --Total Sales by SalesTerritory
   SELECT		DT.TerritoryCode,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimTerritory] DT
   ON			   FS.TerritoryId = DT.TerritoryId
   GROUP BY		DT.TerritoryCode
   ORDER BY		DT.TerritoryCode

   --Total Sales by Variety
   SELECT		DP.Type,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimProduct] DP
   ON			   FS.ProductId = DP.ProductId
   GROUP BY		DP.Type
   ORDER BY		DP.Type

     --Total Sales by Variety and Wine ordered by most sold in descending
   SELECT		DP.Type,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimProduct] DP
   ON			   FS.ProductId = DP.ProductId
   GROUP BY		DP.Type
   ORDER BY		TotalSales DESC

  --Total Sales by Variety and Wine order by highest to lowest gross sales
   SELECT		DP.Type,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimProduct] DP
   ON			   FS.ProductId = DP.ProductId
   GROUP BY		DP.Type
   ORDER BY		TotalAmount DESC

   --Total Sales by Store order by highest to lowest gross sales
   SELECT		DS.StoreName,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimStore] DS
   ON			   FS.StoreId = DS.StoreId
   GROUP BY		DS.StoreName
   ORDER BY		TotalAmount DESC

    --Total Sales by Store order by highest to lowest gross sales and % gross margin
    SELECT		DS.StoreName,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit,
			   Round(Convert(Float, SUM(FS.[MarginAmount]))/Convert(Float, SUM(FS.[SalesAmount]))* 100, 2) AS Pct_GrossMargin
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimStore] DS
   ON			   FS.StoreId = DS.StoreId
   GROUP BY		DS.StoreName
   ORDER BY		TotalAmount DESC

      --Total Sales by Store each month
    SELECT		DS.StoreName,
				DT.YearMonth,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit,
			   Round(Convert(Float, SUM(FS.[MarginAmount]))/Convert(Float, SUM(FS.[SalesAmount]))* 100, 2) AS Pct_GrossMargin
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimStore] DS
   ON			   FS.StoreId = DS.StoreId
   INNER JOIN	[dbo].[dimDate] DT
   ON			FS.DateId = DT.DateId
   GROUP BY		DS.StoreName, DT.YearMonth
   ORDER BY		DS.StoreName, DT.YearMonth ASC

  --Total Sales by Province order by highest to lowest gross sales
   SELECT		DP.Province,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimProduct] DP
   ON			   FS.ProductId = DP.ProductId
   GROUP BY		DP.Province
   ORDER BY		TotalAmount DESC

    --Total Sales by Province, Region order by highest to lowest gross sales
   SELECT		DP.Province,
				   DP.Region,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimProduct] DP
   ON			   FS.ProductId = DP.ProductId
   GROUP BY		DP.Province,
				   DP.Region
   ORDER BY		TotalAmount DESC

  --Total Sales by Province, Region, Type order by highest to lowest gross sales
   SELECT		DP.Province,
               DP.Region,
               DP.Type,
               SUM(FS.[SalesQty]) AS TotalSales,
               SUM(FS.[SalesAmount]) AS TotalAmount,
               SUM(FS.[CostAmount]) AS TotalCost,
               SUM(FS.[MarginAmount]) AS Profit
   FROM			[dbo].[factSales] FS
   INNER JOIN	[dbo].[dimProduct] DP
   ON			   FS.ProductId = DP.ProductId
   GROUP BY		DP.Province,
				   DP.Region,
				   DP.Type
   ORDER BY		TotalAmount DESC
