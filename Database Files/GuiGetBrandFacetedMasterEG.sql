USE [Eyeglasses]
GO
/****** Object:  StoredProcedure [dbo].[GuiGetBrandFacetedMasterEG]    Script Date: 28-Dec-18 3:08:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GuiGetBrandFacetedMasterEG]
(
	@Storeid		AS INT = 0,
	@Manufactureid	AS INT = 0
)
AS
BEGIN
	BEGIN TRY
		BEGIN
		SET NOCOUNT ON; 

			-- start Gender Master
			SELECT 'Men' as Name, 2 as Displayorder, 'filter-men.png' as 'ImageName'
			UNION
			SELECT 'Women' as Name, 3 as Displayorder, 'filter-women.png' as 'ImageName'  		
			UNION
			SELECT 'Unisex' as Name, 4 as Displayorder, 'filter-unisex.png' as 'ImageName' 
			UNION
			SELECT 'Kids' as Name, 5 as Displayorder, 'filter-kids.png' as 'ImageName' 
			ORDER BY Displayorder
			-- end Gender Master
		
			-- start Product type (Category) Master
			SELECT DISTINCT pt.Name, pt.ProductTypeID, (SELECT TOP 1 ImageName from tb_Category where Name = PT.Name) AS 'ImageName' FROM tb_product p
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			INNER JOIN tb_ProductType pt on pt.ProductTypeID = p.ProductTypeID
			WHERE ISNULL(p.StoreiD,0) = @Storeid AND ISNULL(p.Active,0) = 1 AND isnull(p.Deleted,0) = 0 AND ISNULL(pt.StoreID,0) = @Storeid
			and p.ManufactureID = @Manufactureid
			-- end Product type (Category) Master

			-- start ProductFrameType Master
			SELECT DISTINCT ft.Name,ft.ImageName, ft.DisplayOrder, ft.ProductFrameTypeID FROM tb_ProductFrameType_MST ft
			INNER JOIN tb_ProductInfo pin ON pin.FrameType = ft.ProductFrameTypeID
			INNER JOIN tb_Product P on p.ProductID = pin.ProductID
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			WHERE ISNULL(p.StoreiD,0) = @Storeid AND ISNULL(p.Active,0) = 1 AND isnull(p.Deleted,0) = 0 
			AND ISNULL(ft.Deleted,0) = 0 and m.ManufactureID = @Manufactureid
			-- end ProductFrameType Master

			-- start FrameShapeName Master
			SELECT DISTINCT fs.FrameShapeGenericName AS 'Name', fs.FrameShapeGenericCode AS 'FrameShapeCode', fs.ImageName, fs.DisplayOrder, fs.FrameShapeGenericID
			FROM tb_FrameShapeGeneric_MST fs
			INNER JOIN tb_FrameShapeGenericMapping fsm ON fsm.FrameShapeGenericID = fs.FrameShapeGenericID 
			INNER JOIN tb_ProductCategory pc ON pc.ProductId = fsm.ProductId 
			INNER JOIN tb_Product P on p.ProductID =  fsm.ProductId 
			WHERE ISNULL(fs.Active,0) = 1 AND ISNULL(fs.Deleted,0) = 0
			AND ISNULL(fsm.StoreiD,0) = @Storeid 
			AND ISNULL(p.StoreiD,0) = @Storeid AND ISNULL(p.Active,0) = 1 AND ISNULL(p.Deleted,0) = 0 
			AND ISNULL(pc.CategoryID,0) IN ( SELECT CategoryID  FROM tb_Category WHERE StoreID=@StoreId AND isnull(active,0)=1 AND isnull(deleted,0)=0 )
			-- end FrameShapeName Master

			-- start lense color Master
			SELECT DISTINCT ISNULL(lc.LensColorGenericName,0) as 'Name', ISNULL(lc.LensColorGenericCode,0) AS 'ColorCode', ISNULL(lc.ImageName,0) AS 'ImageName' , ISNULL(lc.DisplayOrder,0) AS 'DisplayOrder', lc.LensColorGenericID 
			FROM tb_LensColorGeneric_MST lc
			INNER JOIN tb_LensColorGenericMapping lcm on lcm.LensColorGenericID = lc.LensColorGenericID
			INNER JOIN tb_Product P on p.ProductID = lcm.ProductID
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			WHERE ISNULL(p.StoreiD,0) = @Storeid AND ISNULL(p.Active,0) = 1 AND ISNULL(p.Deleted,0) = 0 
			AND  ISNULL(lc.Active,0) = 1 and ISNULL(lc.Deleted,0) = 0 AND m.ManufactureID = @Manufactureid  
			ORDER BY isnull(lc.DisplayOrder,0)
			-- end lense color Master

			-- start frame color Master
			SELECT DISTINCT ISNULL(fc.FrameStandardColorName,'') AS 'Name', ISNULL(fc.FrameStandardColorCode,'') AS 'ColorCode', ISNULL(fc.ImageName,'') AS 'ImageName', ISNULL(fc.DisplayOrder,0) AS 'DisplayOrder', fc.FrameStandardColorID 
			FROM tb_FrameStandardColor_MST fc
			INNER JOIN tb_FrameStandardColorMapping fcm on fcm.FrameStandardColorID = fc.FrameStandardColorID
			INNER JOIN tb_Product P on p.ProductID = fcm.ProductID
			INNER JOIN tb_Manufacture m on m.ManufactureID = p.ManufactureID
			WHERE ISNULL(p.StoreiD,0) = @Storeid AND ISNULL(p.Active,0) = 1 AND ISNULL(p.Deleted,0) = 0 
			AND ISNULL(fc.Active,0) = 1 and ISNULL(fc.Deleted,0) = 0 AND m.ManufactureID = @Manufactureid  
			ORDER BY isnull(fc.DisplayOrder,0)
			-- end frame color Master
		END
	END TRY

	BEGIN CATCH
		EXEC RethrowError
	END CATCH
END
