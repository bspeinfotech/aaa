USE [Eyeglasses]
GO
/****** Object:  StoredProcedure [dbo].[GuiGetBrandAllSearchdataEG]    Script Date: 28-Dec-18 3:07:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
* Modified by: Bhavesh Jadav
* Modified on: 26-sep-18
* Description: changes related to MPN
*/

-- EXEC GuiGetBrandAllSearchdataEG 3280,2

ALTER PROCEDURE [dbo].[GuiGetBrandAllSearchdataEG]    
(
	@ManufactureId AS INT = 0,
	@Storeid	AS INT = 0
)	
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON;
		BEGIN
			-- Get MPN and more color count of product as per ManufactureID
			SELECT MPN, (count(PRODUCTID) - 1 ) AS MoreColorCount
			INTO #tmp_mpn_count
			FROM tb_Product 
			WHERE ManufactureID = @ManufactureId and storeid = @StoreID
			GROUP BY MPN

			-- Select productId though MPN from products colors
			SELECT #tmp_mpn_count.MPN, MoreColorCount
			,(SELECT top  1 ProductID FROM tb_product WHERE mpn = #tmp_mpn_count.MPN AND storeid = @Storeid order by ISNULL(MPN_bit,0) desc) AS Prdid
			INTO #tmp_mpn_count_prdid
			FROM #tmp_mpn_count; 

			-- start select Product Facet Info 
			SELECT pin.ProductInfoID, ISNULL(pin.ProductID,0) AS 'ProductID',ISNULL(pin.FrameType,0) AS 'FrameType',ISNULL(pin.FrameShape,0) AS 'FrameShape',ISNULL(pin.LensColor,0) AS 'LensColor',ISNULL(pin.FrameColor,0) AS 'FrameColor', ISNULL(pin.RxAble,0) AS 'RxAble' FROM tb_ProductInfo pin 		
			INNER JOIN tb_Product p ON p.ProductID = pin.ProductID
			INNER JOIN tb_Manufacture m On P.ManufactureID = m.ManufactureID 
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID  
			WHERE ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 		
			AND p.Active=1 AND p.Deleted=0 AND p.StoreID = @Storeid AND pin.StoreID=@Storeid	
			AND ISNULL(M.Deleted,0)= 0 AND ISNULL(M.Active,0) = 1 AND ISNULL(M.StoreID,0) = @Storeid
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			-- end bind Product Facet Info 

			-- start select Gender
			SELECT 'Men' AS Name,p.ProductID, 2 AS ID,'filter-men.png' AS ImageName,CASE WHEN ISNULL(salePrice,0) > 0 THEN ISNULL(salePrice,0) ELSE ISNULL(price,0) END price  FROM  tb_product p  
			INNER JOIN tb_Manufacture m ON M.ManufactureID = P.ManufactureID
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID   
			WHERE  ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 
			AND ISNULL(P.Gender,'') LIKE '%2%' AND ISNULL(p.Active,0)=1 AND ISNULL(p.Storeid,0)=@Storeid AND ISNULL(p.Deleted,0)=0 
			AND ISNULL(m.Active,0)=1 AND ISNULL(m.Deleted,0)=0 AND P.ManufactureID = @ManufactureId
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			UNION
			SELECT 'Women' AS Name,p.ProductID, 3 AS ID,'filter-women.png' AS ImageName,CASE WHEN ISNULL(salePrice,0) > 0 THEN ISNULL(salePrice,0) ELSE ISNULL(price,0) END price  FROM  tb_product p  
			INNER JOIN tb_Manufacture m ON M.ManufactureID = P.ManufactureID
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID   
			WHERE  ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 
			AND ISNULL(Gender,'') LIKE '%3%' AND ISNULL(p.Active,0)=1 AND ISNULL(p.Storeid,0)=@Storeid AND ISNULL(p.Deleted,0)=0 
			AND ISNULL(m.Active,0)=1 AND ISNULL(m.Deleted,0)=0 AND P.ManufactureID = @ManufactureId
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			UNION
			SELECT 'Unisex' AS Name,p.ProductID, 4 AS ID,'filter-unisex.png' AS ImageName,CASE WHEN ISNULL(salePrice,0) > 0 THEN ISNULL(salePrice,0) ELSE ISNULL(price,0) END price  FROM  tb_product p  
			INNER JOIN tb_Manufacture m ON M.ManufactureID = P.ManufactureID
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID   
			WHERE  ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 
			AND ISNULL(Gender,'') LIKE '%4%' AND ISNULL(p.Active,0)=1 AND ISNULL(p.Storeid,0)=@Storeid AND ISNULL(p.Deleted,0)=0 
			AND ISNULL(m.Active,0)=1 AND ISNULL(m.Deleted,0)=0 AND P.ManufactureID = @ManufactureId
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			UNION
			SELECT 'Kids' AS Name,p.ProductID, 5 AS ID,'filter-kids.png' AS ImageName,CASE WHEN ISNULL(salePrice,0) > 0 THEN ISNULL(salePrice,0) ELSE ISNULL(price,0) END price  FROM  tb_product p  
			INNER JOIN tb_Manufacture m ON M.ManufactureID = P.ManufactureID
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID   
			WHERE  ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 
			AND ISNULL(Gender,'') LIKE '%5%' AND ISNULL(p.Active,0)=1 AND ISNULL(p.Storeid,0)=@Storeid AND ISNULL(p.Deleted,0)=0 
			AND ISNULL(m.Active,0)=1 AND ISNULL(m.Deleted,0)=0 AND P.ManufactureID = @ManufactureId
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			-- end select Gender

			-- start select ProductType (Category)
			SELECT DISTINCT pt.Name,p.ProductID, pt.ProductTypeID AS ID, case When isnull(p.salePrice,0) > 0 then isnull(p.salePrice,0) else isnull(p.price,0) end price, isnull(m.DisplayOrder,0) 
			FROM tb_product p
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			INNER JOIN tb_ProductType pt on pt.ProductTypeID = p.ProductTypeID
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID   
			WHERE ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 		
			AND isnull(p.Active,0)=1 AND isnull(p.Deleted,0)=0 AND isnull(p.Storeid,0)=@Storeid 
			AND isnull(m.Deleted,0)=0 AND isnull(m.Active,0)=1 AND isnull(m.ManufactureID,0) = @ManufactureId AND isnull(m.StoreID,0) = @Storeid
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			ORDER BY isnull(m.DisplayOrder,0)
			-- end select ProductType (Category)

			-- start select frame type
			SELECT ft.name,p.ProductID,ft.ProductFrameTypeID AS ID, case When isnull(p.salePrice,0) > 0 then isnull(p.salePrice,0) else isnull(p.price,0) end price, isnull(ft.DisplayOrder,0) AS DisplayOrder 
			FROM tb_product p
			INNER JOIN tb_ProductInfo pin ON PIN.ProductID = p.ProductID
			INNER JOIN tb_ProductFrameType_MST ft ON ft.ProductFrameTypeID = pin.FrameType 
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID  
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			WHERE ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 		
			AND isnull(p.Active,0)=1 AND isnull(p.Deleted,0)=0 AND isnull(p.Storeid,0)=@Storeid 
			AND isnull(m.Deleted,0)=0 AND isnull(m.Active,0)=1 AND isnull(m.ManufactureID,0) = @ManufactureId AND isnull(m.StoreID,0) = @Storeid
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			ORDER BY isnull(ft.DisplayOrder,0)
			-- end select frame type

			-- start select frame shape
			SELECT fs.FrameShapeGenericName AS 'Name',p.ProductID,fs.FrameShapeGenericID AS ID, case When isnull(p.salePrice,0) > 0 then isnull(p.salePrice,0) else isnull(p.price,0) end price, isnull(fs.DisplayOrder,0) AS DisplayOrder 
			FROM tb_product p
			INNER JOIN tb_ProductInfo pin ON PIN.ProductID = p.ProductID
			INNER JOIN tb_FrameShapeGenericMapping fsm ON fsm.ProductID = pin.ProductID
			INNER JOIN tb_FrameShapeGeneric_MST fs ON fs.FrameShapeGenericID = fsm.FrameShapeGenericID 
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID  
			WHERE ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID AND ISNULL(fsm.StoreiD,0) = @Storeid 		
			AND isnull(p.Active,0)=1 AND isnull(p.Deleted,0)=0 AND isnull(p.Storeid,0)=@Storeid
			AND isnull(m.Deleted,0)=0 AND isnull(m.Active,0)=1 AND isnull(m.ManufactureID,0) = @ManufactureId AND isnull(m.StoreID,0) = @Storeid
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			ORDER BY isnull(fs.DisplayOrder,0)
			-- end select frame shape

			-- start select lence color
			SELECT DISTINCT lc.LensColorGenericName AS 'Name',p.ProductID,lc.LensColorGenericID AS ID, case When isnull(p.salePrice,0) > 0 then isnull(p.salePrice,0) else isnull(p.price,0) end price, isnull(lc.DisplayOrder,0) AS DisplayOrder 
			FROM tb_product p
			INNER JOIN tb_ProductInfo pin ON PIN.ProductID = p.ProductID
			INNER JOIN tb_LensColorGenericMapping lcm ON lcm.ProductID = pin.ProductID
			INNER JOIN tb_LensColorGeneric_MST lc ON lc.LensColorGenericID = lcm.LensColorGenericID
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID  
			WHERE ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 		
			AND isnull(p.Active,0)=1 AND isnull(p.Deleted,0)=0 AND isnull(p.Storeid,0)=@Storeid 
			AND isnull(m.Deleted,0)=0 AND isnull(m.Active,0)=1 AND isnull(m.ManufactureID,0) = @ManufactureId AND isnull(m.StoreID,0) = @Storeid
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			ORDER BY isnull(lc.DisplayOrder,0)
			-- start select lence color

			-- start select frame color
			SELECT DISTINCT fc.FrameStandardColorName AS 'Name',p.ProductID,fc.FrameStandardColorID AS ID, case When isnull(p.salePrice,0) > 0 then isnull(p.salePrice,0) else isnull(p.price,0) end price, isnull(fc.DisplayOrder,0) AS DisplayOrder 
			FROM tb_product p
			INNER JOIN tb_ProductInfo pin ON PIN.ProductID = p.ProductID
			INNER JOIN tb_FrameStandardColorMapping fcm ON fcm.ProductID = pin.ProductID
			INNER JOIN tb_FrameStandardColor_MST fc ON fc.FrameStandardColorID= fcm.FrameStandardColorID
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			INNER JOIN  tb_ProductCategory ON p.ProductID = tb_ProductCategory.ProductID 
			INNER JOIN  tb_Category c ON tb_ProductCategory.CategoryID = c.CategoryID  
			WHERE ISNULL(c.Deleted,0)=0 AND ISNULL(c.Active,0)=1 AND ISNULL(c.StoreID,0)= @StoreID 		
			AND isnull(p.Active,0)=1 AND isnull(p.Deleted,0)=0 AND isnull(p.Storeid,0)=@Storeid 
			AND isnull(m.Deleted,0)=0 AND isnull(m.Active,0)=1 AND isnull(m.ManufactureID,0) = @ManufactureId AND isnull(m.StoreID,0) = @Storeid
			AND p.productid in (select Prdid from #tmp_mpn_count_prdid)
			ORDER BY isnull(fc.DisplayOrder,0)
			-- end select frame color

			---- Drop tables which are created for temprory
			--DROP TABLE tmp_mpn_count
			--DROP TABLE tmp_mpn_count_prdid

		END
	END TRY

	BEGIN CATCH
		EXEC ReThrowError
	END CATCH
end
