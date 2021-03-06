USE [Eyeglasses]
GO
/****** Object:  StoredProcedure [dbo].[GuiGetBrandProductsEG]    Script Date: 28-Dec-18 3:08:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
* Modified by: Bhavesh Jadav
* Modified on: 26-nov-18
* Description: Get top 1 productid as per MPN_bit and lowest price
*/

-- EXEC GuiGetBrandProductsEG 2,3280,0,0,10000

 ALTER procedure [dbo].[GuiGetBrandProductsEG]  
 (
	@StoreID int=0,      
	@ManufactureId int=0,      
	@Gender int =0,
	@RowIdStart int=0,
	@RowIdEnd int=10000
 )
 AS
BEGIN
	BEGIN TRY

		-- Get MPN and more color count of product as per ManufactureID
		SELECT MPN, count(PRODUCTID) AS MoreColorCount
		INTO #tmp_mpn_count
		FROM tb_Product 
		WHERE ManufactureID = @ManufactureId and storeid = @StoreID
		GROUP BY MPN

		-- Select productId though MPN from products colors
		SELECT #tmp_mpn_count.MPN, MoreColorCount

		----- Select top 1 productid as per MPN_bit
		,(SELECT top  1 ProductID FROM tb_product WHERE mpn = #tmp_mpn_count.MPN AND storeid = @StoreID order by ISNULL(MPN_bit,0) desc) AS Prdid
		
		----- Select top 1 productid as per MPN and variant lowest price
		--,(SELECT TOP 1 p.ProductID FROM tb_product p INNER JOIN tb_ProductVariantvalue pvv ON pvv.ProductID = p.ProductID WHERE p.mpn = #tmp_mpn_count.MPN AND p.storeid = @StoreID  AND p.active=1 AND p.deleted=0 ORDER BY ISNULL(variantsellprice,0) ASC) AS Prdid
		
		INTO #tmp_mpn_count_prdid
		FROM #tmp_mpn_count; 

		;WITH [CTE DUPLICATE] AS
		(
			 SELECT DISTINCT mpn,ISNULL(p.DisplayOrder,0) as 'DisplayOrder',0 as CategoryID , ISNULL(p.Name,'') AS Name,p.ProductID,ISNULL(p.Inventory,0) AS Inventory ,ISNULL(p.MainCategory,'') AS MainCategory,   
			 ISNULL(p.SEName,'') AS SEName,ISNULL(p.IsPack,0) as IsPack, ISNULL(p.ImageName,'') as ImageName, ISNULL(p.TagName,'') as TagName ,p.EstiArrivalDate,ISNULL(p.SKU,'') AS SKU, 
			 (SELECT TOP 1 (CASE WHEN ISNULL(VariantSellPrice,0) != 0 THEN VariantSellPrice ELSE ISNULL(VariantPrice,0) END) AS VariantSellPrice FROM tb_ProductVariantValue WHERE productid = p.ProductID) AS 'SalePrice',
			 (SELECT TOP 1 ISNULL(VariantPrice,0) AS VariantPrice FROM tb_ProductVariantValue WHERE productid = p.ProductID) AS 'Price',
			 (SELECT TOP 1 (Case When isnull(VariantSellPrice,0)>0 Then VariantSellPrice  Else isnull(VariantPrice,0) End) FROM tb_ProductVariantValue WHERE productid = p.ProductID) AS 'Searchprice',
			 (SELECT TOP 1 ISNULL(Discontinue,0) FROM tb_ProductVariantValue WHERE productid = p.ProductID) AS 'Discontinue', 
			 p.ToolTip,isnull(IsNewArrival,0) as Newarrival,isnull(IsBestSeller,0) as BestSeller,
			 ISNULL((SELECT AVG(Rating) FROM tb_Rating WHERE ProductID=p.ProductID and ISNULL(dbo.tb_Rating.IsApproved, 0)=1),0)  as avgrating,ISNULL((SELECT Count(Rating) FROM tb_Rating where StoreID=@StoreID and
			 ProductID=p.ProductID and ISNULL(dbo.tb_Rating.IsApproved, 0)=1),0) as reviewtotlacount,ShortDescription,'' as DiscountPercentage,
			 (m.ManufactureID) AS ManufactureID ,m.Name AS ManufactureName,m.SEName AS ManufactureSename,ISNULL(m.BlackLogo,'') AS Manufacturelogo,ISNULL(m.IsSpecialBrand,0) AS IsSpecialBrand
			 ,ISNULL(pii.Polarized,0) as 'Polarized', ISNULL(pii.RxAble,0) as 'RxAble', (CASE WHEN ISNULL(P.ModelName,'') != '' THEN P.ModelName ELSE P.NAME END) AS ModelName
			 FROM tb_Product p 
			 LEFT OUTER JOIN tb_ProductInfo pii ON p.ProductID = pii.ProductID
			 INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			 INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID   
			 Inner Join tb_Manufacture m On m.ManufactureID=p.ManufactureID
			 Where --And ((Case When (SalePrice Is Not Null And SalePrice!=0) Then SalePrice  Else Price End)!=0 Or (Case When (SalePrice Is Not Null And SalePrice!=0) Then SalePrice Else  Price End)!=null )
			 isnull(c.Deleted,0)=0 AND isnull(c.Active,0)=1 AND isnull(c.StoreID,0)= @StoreID 
			 AND isnull(p.Active,0)=1 And isnull(p.Deleted,0)=0 and isnull(p.StoreID,0)=@StoreID 
			 AND isnull(m.Deleted,0)=0 AND isnull(m.Active,0)=1 AND isnull(m.ManufactureID,0) = @ManufactureId AND isnull(m.StoreID,0) = @Storeid 
			 and p.productid in (select Prdid from #tmp_mpn_count_prdid)
		)
		SELECT * FROM (SELECT RN = ROW_NUMBER() OVER (ORDER BY  DisplayOrder ASC),Count(ProductID) Over() as tCount,CategoryID , Name,ProductID
		, Inventory,MainCategory , SEName, IsPack, ImageName, TagName, SKU, SalePrice,Price,ToolTip,Searchprice,Newarrival,BestSeller,avgrating
		,reviewtotlacount,ShortDescription,DisplayOrder,ManufactureID ,ManufactureName,ManufactureSename,Manufacturelogo,IsSpecialBrand, Polarized, RxAble
		, (select MoreColorCount from #tmp_mpn_count_prdid where Prdid = ProductID) as MoreColorCount, ModelName, Discontinue
		FROM [CTE DUPLICATE]) A  WHERE RN > @RowIdStart and RN <= @RowIdEnd

		-- Drop tables which are created for temprory
		--drop table tmp_mpn_count
		--drop table tmp_mpn_count_prdid

	END TRY

	BEGIN CATCH
		-- Drop tables which are created for temprory
		--drop table tmp_mpn_count
		--drop table tmp_mpn_count_prdid

		EXEC RethrowError
	END CATCH

END
