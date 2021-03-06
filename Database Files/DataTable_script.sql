USE [Eyeglasses]
GO
/****** Object:  Table [dbo].[tb_Address]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Address](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[CustomerID] [int] NULL,
	[FirstName] [nvarchar](500) NULL,
	[LastName] [nvarchar](500) NULL,
	[Company] [varchar](100) NULL,
	[Address1] [varchar](500) NULL,
	[Address2] [varchar](500) NULL,
	[City] [varchar](100) NULL,
	[State] [varchar](100) NULL,
	[Suite] [varchar](100) NULL,
	[ZipCode] [varchar](20) NULL,
	[Country] [int] NULL,
	[Phone] [varchar](20) NULL,
	[Fax] [varchar](20) NULL,
	[Email] [varchar](100) NULL,
	[PaymentMethodIDLastUsed] [varchar](100) NULL,
	[AddressType] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_Address_CreatedOn]  DEFAULT (getdate()),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_Address_Deleted]  DEFAULT ((0)),
	[MovetoPOS] [bit] NULL CONSTRAINT [DF_tb_Address_MovetoPOS]  DEFAULT ((0)),
	[POSAddressID] [int] NULL,
	[YahooCustomerID] [int] NULL,
	[YahooAddressID] [int] NULL,
	[IsPrimary] [int] NULL,
 CONSTRAINT [PK_tb_Address] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Admin]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Admin](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[EmailID] [varchar](100) NULL,
	[Password] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[AdminType] [tinyint] NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[Rights] [varchar](100) NULL,
	[EmailPassword] [varchar](100) NULL,
	[WebMailSignature] [varchar](max) NULL,
	[ImageName] [varchar](500) NULL,
	[IsPacker] [bit] NULL CONSTRAINT [DF_tb_Admin_IsPacker]  DEFAULT ((1)),
	[CustomRights] [nvarchar](500) NULL,
	[TemplateID] [int] NULL,
	[DefaultStoreId] [int] NULL CONSTRAINT [DF_tb_Admin_DefaultStoreId]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_Admin] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_AdminRights]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_AdminRights](
	[RightsID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_tb_AdminRights] PRIMARY KEY CLUSTERED 
(
	[RightsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_AppConfig]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_AppConfig](
	[AppConfigID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[ConfigName] [varchar](200) NULL,
	[ConfigValue] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_AppConfig_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_AppConfig] PRIMARY KEY CLUSTERED 
(
	[AppConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Category]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[Name] [varchar](500) NULL,
	[Description] [varchar](max) NULL,
	[Summary] [varchar](max) NULL,
	[SEName] [varchar](500) NULL,
	[SETitle] [varchar](500) NULL,
	[SEKeywords] [varchar](max) NULL,
	[SEDescription] [varchar](max) NULL,
	[ToolTip] [varchar](500) NULL,
	[ImageName] [varchar](500) NULL,
	[BannerImageName] [varchar](500) NULL,
	[DisplayOrder] [int] NULL,
	[IsFeatured] [bit] NULL,
	[IsPopular] [bit] NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_Category_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[HeaderText] [varchar](500) NULL,
	[ShowOnHeader] [bit] NULL,
	[ShortName] [varchar](500) NULL,
	[SearsCategoryID] [bigint] NULL CONSTRAINT [DF__tb_Catego__Sears__2D12A970]  DEFAULT ((0)),
	[Color] [varchar](500) NULL,
	[FeatureProductID] [varchar](500) NULL,
	[RightBanner] [varchar](500) NULL,
	[QuantityDiscountID] [int] NULL,
	[SmallBanner1] [nvarchar](300) NULL,
	[SmallBanner2] [nvarchar](300) NULL,
	[SmallBannerPosition1] [varchar](50) NULL,
	[SmallBannerPosition2] [varchar](50) NULL,
	[SmallBannerUrl1] [nvarchar](250) NULL,
	[SmallBannerUrl2] [nvarchar](250) NULL,
	[MainCategoryURL1] [nvarchar](500) NULL,
	[MainCategoryURL2] [nvarchar](500) NULL,
	[MainCategoryURL3] [nvarchar](500) NULL,
	[ChildCatCount] [int] NULL CONSTRAINT [DF_tb_Category_ChildCatCount]  DEFAULT ((0)),
	[ProductCount] [int] NULL CONSTRAINT [DF_tb_Category_ProductCount]  DEFAULT ((0)),
	[ProductTypeView] [bit] NULL DEFAULT ((0)),
	[CategoryTitle] [nvarchar](300) NULL,
	[IsSale] [bit] NULL,
 CONSTRAINT [PK_tb_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CategoryBanner]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CategoryBanner](
	[CbannerID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[StoreID] [int] NULL,
	[Title] [varchar](200) NULL,
	[BannerURL] [varchar](max) NULL,
	[ImageName] [varchar](max) NULL,
	[DisplayOrder] [int] NULL,
	[Active] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[HomeRotatorId] [int] NULL,
	[Pagination] [varchar](50) NULL,
	[IsMain] [int] NULL,
	[LinkTarget] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_tb_CategoryBanner] PRIMARY KEY CLUSTERED 
(
	[CbannerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CategoryColor]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CategoryColor](
	[CategoryColorID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[ColorName] [varchar](500) NULL,
 CONSTRAINT [PK_tb_CategoryColor] PRIMARY KEY CLUSTERED 
(
	[CategoryColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CategoryMapping]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_CategoryMapping](
	[CategoryMappingID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ParentCategoryID] [int] NOT NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_tb_CategoryMapping] PRIMARY KEY CLUSTERED 
(
	[CategoryMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Customer]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[FirstName] [nvarchar](500) NULL,
	[LastName] [nvarchar](500) NULL,
	[BillingEqualShippingbit] [bit] NULL,
	[BillingAddressID] [int] NULL,
	[ShippingAddressID] [int] NULL,
	[CreditCardID] [int] NULL CONSTRAINT [DF_tb_Customer_CreditCardID]  DEFAULT ((0)),
	[IsRegistered] [bit] NULL,
	[CustomerLevelID] [int] NULL,
	[IsLockedOut] [bit] NULL,
	[FailedPasswordAttemptCount] [int] NULL,
	[FailedPasswordAttemptDate] [datetime] NULL,
	[LastIPAddress] [varchar](50) NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[isfbuser] [bit] NULL DEFAULT ((0)),
	[TwitterScreen] [varchar](500) NULL,
	[TwitterId] [int] NULL,
	[iPhoneUser] [bit] NULL,
	[isGiftRegCust] [bit] NULL,
	[CoRegFirstName] [nvarchar](500) NULL,
	[CoRegLastName] [nvarchar](500) NULL,
	[Event] [nvarchar](500) NULL,
	[EventDate] [datetime] NULL,
	[MovetoPOS] [bit] NULL CONSTRAINT [DF_tb_Customer_MovetoPOS]  DEFAULT ((0)),
	[POSCustomerID] [int] NULL,
	[CouponCode] [varchar](50) NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[DiscountPercent] [money] NULL,
	[OrderPoint] [money] NULL,
	[URL] [nvarchar](max) NULL,
	[DateofBirth] [datetime] NULL,
	[Gender] [nvarchar](10) NULL,
	[Phone] [nvarchar](20) NULL,
	[Fax] [nvarchar](20) NULL,
	[OktoEmail] [bit] NULL,
	[Over13Checked] [bit] NULL,
	[PwdChanged] [datetime] NULL,
	[PwdchangedRequired] [bit] NULL,
	[ShippingMethodID] [int] NULL,
	[CustType] [int] NULL,
	[BirthDate] [datetime] NULL,
	[Token] [nvarchar](20) NULL,
 CONSTRAINT [PK_tb_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CustomerCustomPrescription]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_CustomerCustomPrescription](
	[CustomerCustomPrescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [int] NOT NULL,
	[OrderedCustomCartID] [int] NOT NULL,
	[RTSphere] [nvarchar](50) NULL,
	[RTCylinder] [nvarchar](50) NULL,
	[RTAxis] [nvarchar](50) NULL,
	[RTHorizontalPrism] [nvarchar](50) NULL,
	[RTVerticalPrism] [nvarchar](50) NULL,
	[RTAdd] [nvarchar](50) NULL,
	[RTDispTD] [nvarchar](50) NULL,
	[RTNearTD] [nvarchar](50) NULL,
	[LTSphere] [nvarchar](50) NULL,
	[LTCylinder] [nvarchar](50) NULL,
	[LTAxis] [nvarchar](50) NULL,
	[LTHorizontalPrism] [nvarchar](50) NULL,
	[LTVerticalPrism] [nvarchar](50) NULL,
	[LTAdd] [nvarchar](50) NULL,
	[LTDispTD] [nvarchar](50) NULL,
	[LTNearTD] [nvarchar](50) NULL,
	[Notes] [nvarchar](1000) NULL,
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_CustomerCustomPrescription_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_CustomerCustomPrescription_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_CustomerCustomPrescription] PRIMARY KEY CLUSTERED 
(
	[CustomerCustomPrescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_CustomerGroup]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CustomerGroup](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NULL,
	[Discount] [decimal](18, 2) NULL CONSTRAINT [DF_tb_CustomerGroup_Discount]  DEFAULT ((0)),
	[Active] [bit] NULL CONSTRAINT [DF_tb_CustomerGroup_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_CustomerGroup_Deleted]  DEFAULT ((0)),
	[CreatedOn] [date] NULL,
 CONSTRAINT [PK_tb_CustomerGroup] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CustomerGroupMapping]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_CustomerGroupMapping](
	[CustomerMappingId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[GroupId] [int] NULL,
 CONSTRAINT [PK_tb_CustomerGroupMapping] PRIMARY KEY CLUSTERED 
(
	[CustomerMappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_CustomerLevel]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_CustomerLevel](
	[CustomerLevelID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[LevelDiscountPercent] [money] NULL,
	[LevelDiscountAmount] [money] NULL,
	[LevelHasFreeShipping] [bit] NULL,
	[LevelHasnoTax] [bit] NULL,
	[DisplayOrder] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_tb_CustomerLevel] PRIMARY KEY CLUSTERED 
(
	[CustomerLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_CustomerPrescription]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CustomerPrescription](
	[CustomerPrescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[Prescription] [varchar](max) NULL,
	[SetDefault] [bit] NULL CONSTRAINT [DF_tb_CustomerPrescription_SetDefault]  DEFAULT ((0)),
	[Title] [varchar](max) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_CustomerPrescription] PRIMARY KEY CLUSTERED 
(
	[CustomerPrescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CustomerQuote]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CustomerQuote](
	[CustomerQuoteID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[StoreID] [int] NULL,
	[QuoteNumber] [varchar](50) NULL,
	[IsRevised] [bit] NULL,
	[OrderNumber] [int] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_CustomerQuote] PRIMARY KEY CLUSTERED 
(
	[CustomerQuoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CustomerQuoteItems]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CustomerQuoteItems](
	[CustomerQuoteItemID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerQuoteID] [int] NULL,
	[ProductID] [int] NULL,
	[SKU] [varchar](500) NULL,
	[Name] [varchar](500) NULL,
	[Options] [varchar](500) NULL,
	[Price] [money] NULL,
	[Quantity] [int] NULL,
	[Notes] [varchar](500) NULL,
 CONSTRAINT [PK_tb_CustomerQuoteItems] PRIMARY KEY CLUSTERED 
(
	[CustomerQuoteItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CustomerStatus]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CustomerStatus](
	[RecStatusID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[RecUniqueID] [varchar](50) NULL,
	[RecCustID] [int] NULL,
	[OrderNumber] [int] NULL,
	[CustomerQuoteID] [nvarchar](max) NULL,
 CONSTRAINT [PK_tb_CustomerStatus] PRIMARY KEY CLUSTERED 
(
	[RecStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CustomerTrackingInfo]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_CustomerTrackingInfo](
	[CustomerTrackingId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[URL] [nvarchar](max) NULL,
	[Type] [nvarchar](500) NULL,
	[TypeId] [int] NULL,
	[IpAddress] [nvarchar](100) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_CustomerTrackingInfo_CreatedOn]  DEFAULT (sysdatetimeoffset()),
	[Browser] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_CustomerTrackingInfo_Temp]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_CustomerTrackingInfo_Temp](
	[CustomerTrackingId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[URL] [nvarchar](max) NULL,
	[Type] [nvarchar](500) NULL,
	[TypeId] [int] NULL,
	[IpAddress] [nvarchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[Browser] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_CustomRightsMapping]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_CustomRightsMapping](
	[CustomMappingID] [int] IDENTITY(1,1) NOT NULL,
	[CustomRightsID] [int] NULL,
	[ParentCustomRightsID] [int] NULL,
	[MappingDisplayOrder] [int] NULL,
	[Storeid] [int] NULL,
	[AdminID] [int] NULL,
	[ProjectType] [int] NULL,
 CONSTRAINT [PK_tb_CustomRightsMapping] PRIMARY KEY CLUSTERED 
(
	[CustomMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_CustomRightsMaster]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_CustomRightsMaster](
	[CustomRightsID] [int] IDENTITY(1,1) NOT NULL,
	[PageName] [nvarchar](500) NULL,
	[TabName] [nvarchar](500) NULL,
	[CustomTemplateURL] [nvarchar](500) NULL,
	[DisplayOrder] [int] NULL,
	[IsUpdated] [bit] NULL,
	[ClassName] [nvarchar](500) NULL,
	[LiClassName] [nvarchar](50) NULL,
	[StoreID] [int] NULL,
	[ProjectType] [int] NULL,
 CONSTRAINT [PK_tb_CustomRightsMaster] PRIMARY KEY CLUSTERED 
(
	[CustomRightsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_DashboardSettings]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_DashboardSettings](
	[SettingID] [int] IDENTITY(1,1) NOT NULL,
	[Position] [varchar](50) NULL,
	[SectionName] [varchar](100) NULL,
	[ControlName] [varchar](100) NULL,
	[IsDisplay] [bit] NULL CONSTRAINT [DF_tb_DashboardSettings_IsDisplay]  DEFAULT ((0)),
	[DisplayPosition] [int] NULL CONSTRAINT [DF_tb_DashboardSettings_DisplayPosition]  DEFAULT ((0)),
	[StoreID] [int] NULL,
 CONSTRAINT [PK_tb_DashboardSettings] PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_EmailFolderRelation]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_EmailFolderRelation](
	[FolderRelID] [int] IDENTITY(1,1) NOT NULL,
	[ParentFolderID] [int] NULL,
	[ChildFolderID] [int] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_EmailFolderRelation] PRIMARY KEY CLUSTERED 
(
	[FolderRelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_EmailFolders]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_EmailFolders](
	[FolderID] [int] IDENTITY(1,1) NOT NULL,
	[FolderName] [varchar](100) NULL,
	[FolderEmail] [varchar](200) NULL,
	[ParentFolderID] [int] NULL,
	[IsDeleted] [bit] NULL,
	[Createdon] [datetime] NULL,
	[AgentID] [varchar](max) NULL,
 CONSTRAINT [PK_tb_EmailFolders] PRIMARY KEY CLUSTERED 
(
	[FolderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_EmailList]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_EmailList](
	[MailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [int] NULL,
	[FolderID] [int] NULL,
	[From] [varchar](100) NULL,
	[To] [varchar](100) NULL,
	[Subject] [varchar](max) NULL,
	[Body] [varchar](max) NULL,
	[SentOn] [datetime] NULL,
	[IsAttachment] [bit] NULL,
	[IsIncomming] [bit] NULL,
	[AttachmentName] [varchar](max) NULL,
	[Createdon] [datetime] NULL,
	[MessageID] [varchar](500) NULL,
	[Cc] [varchar](max) NULL,
	[Bcc] [varchar](max) NULL,
	[IsRead] [bit] NULL,
	[isDeleted] [bit] NULL,
	[isSpam] [bit] NULL,
	[AgentID] [int] NULL,
	[IsReadAgent] [bit] NULL,
 CONSTRAINT [PK_tb_EmailList] PRIMARY KEY CLUSTERED 
(
	[MailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_EmailTemplate]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_EmailTemplate](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[Label] [varchar](50) NULL,
	[EmailTo] [varchar](300) NULL,
	[EmailFrom] [varchar](300) NULL,
	[EmailCC] [varchar](300) NULL,
	[EmailBCC] [varchar](300) NULL,
	[Subject] [varchar](500) NULL,
	[EmailBody] [varchar](max) NULL,
	[EmailType] [tinyint] NULL,
	[IsPOTemplate] [bit] NULL,
 CONSTRAINT [PK_tb_EmailTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_FlatRateRange]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_FlatRateRange](
	[FlatRateID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingMethodName] [nvarchar](max) NULL,
	[PerOrder] [numeric](18, 2) NULL CONSTRAINT [DF__tb_FlatRa__PerOr__2453463D]  DEFAULT ((0)),
	[PerPound] [numeric](18, 2) NULL CONSTRAINT [DF__tb_FlatRa__PerPo__25476A76]  DEFAULT ((0)),
	[CountryName] [nvarchar](500) NULL CONSTRAINT [DF__tb_FlatRa__Count__263B8EAF]  DEFAULT ((0)),
	[Showonclient] [bit] NULL CONSTRAINT [DF__tb_FlatRa__Showo__272FB2E8]  DEFAULT ((0)),
	[Showonadmin] [bit] NULL CONSTRAINT [DF__tb_FlatRa__Showo__2823D721]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_FlatRateRange] PRIMARY KEY CLUSTERED 
(
	[FlatRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_FrameShapeGeneric_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_FrameShapeGeneric_MST](
	[FrameShapeGenericID] [int] IDENTITY(1,1) NOT NULL,
	[FrameShapeGenericName] [varchar](max) NULL,
	[FrameShapeGenericCode] [varchar](max) NULL,
	[ImageName] [nvarchar](max) NULL,
	[DisplayOrder] [int] NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NULL,
	[StoreID] [int] NULL,
	[ClassName] [nvarchar](500) NULL,
 CONSTRAINT [PK_tb_FrameShapeGeneric_MST] PRIMARY KEY CLUSTERED 
(
	[FrameShapeGenericID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_FrameShapeGenericMapping]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_FrameShapeGenericMapping](
	[FrameShapeGenericMappingID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[FrameShapeGenericID] [int] NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK_tb_FrameShapeGenericMapping] PRIMARY KEY CLUSTERED 
(
	[FrameShapeGenericMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_FrameStandardColor_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_FrameStandardColor_MST](
	[FrameStandardColorID] [int] IDENTITY(1,1) NOT NULL,
	[FrameStandardColorName] [varchar](max) NULL,
	[FrameStandardColorCode] [varchar](max) NULL,
	[ImageName] [nvarchar](max) NULL,
	[DisplayOrder] [int] NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK_tb_FrameStandardColor_MST] PRIMARY KEY CLUSTERED 
(
	[FrameStandardColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_FrameStandardColorMapping]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_FrameStandardColorMapping](
	[FrameStandardColorMappingID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[FrameStandardColorID] [int] NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK_tb_FrameStandardColorMapping] PRIMARY KEY CLUSTERED 
(
	[FrameStandardColorMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_GiftCard]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_GiftCard](
	[GiftCardID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[SerialNumber] [varchar](200) NULL,
	[CustomerID] [int] NULL,
	[OrderNumber] [int] NULL,
	[InitialAmount] [money] NULL,
	[Balance] [money] NULL,
	[ExpirationDate] [datetime] NULL,
	[EmailTo] [varchar](100) NULL,
	[EmailFrom] [varchar](100) NULL,
	[EmaiMessage] [varchar](max) NULL,
	[RecipientName] [varchar](200) NULL,
	[CreatedOn] [datetime] NULL,
	[RMANumber] [int] NULL,
	[Status] [bit] NULL CONSTRAINT [DF_tb_GiftCard_Status_1]  DEFAULT ((0)),
	[IsActive] [bit] NULL CONSTRAINT [DF_tb_GiftCard_IsActive]  DEFAULT ((0)),
	[GiftCardType] [int] NULL,
 CONSTRAINT [PK_tb_GiftCard] PRIMARY KEY CLUSTERED 
(
	[GiftCardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_GiftCardProduct]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_GiftCardProduct](
	[GiftCardProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK_tb_GiftCardProduct] PRIMARY KEY CLUSTERED 
(
	[GiftCardProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_GiftCardUsage]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_GiftCardUsage](
	[GiftCardUsageID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[GiftCardID] [int] NULL,
	[CustomerID] [int] NULL,
	[OrderNumber] [int] NULL,
	[Amount] [money] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_GiftCardUsage] PRIMARY KEY CLUSTERED 
(
	[GiftCardUsageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_GiftShoppingCart]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_GiftShoppingCart](
	[ShoppingCartID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[CouponDiscountAmount] [money] NULL,
	[Type] [int] NULL,
	[CustomDiscount] [money] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_GiftShoppingCart] PRIMARY KEY CLUSTERED 
(
	[ShoppingCartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_HtmlText]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_HtmlText](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NULL,
	[HtmlText] [ntext] NULL,
	[HtmlType] [int] NULL,
 CONSTRAINT [PK_tb_HtmlText] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ImageSizes]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ImageSizes](
	[ImageSizeID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[ImageName] [varchar](50) NULL,
	[ImageSize] [varchar](50) NULL,
 CONSTRAINT [PK_tb_ImageSizes] PRIMARY KEY CLUSTERED 
(
	[ImageSizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_LogoPosition]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_LogoPosition](
	[LogoPositionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[IsDefault] [bit] NULL,
	[StoreID] [int] NULL,
	[Active] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_Logoposition_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[DisplayOrder] [int] NULL CONSTRAINT [DF__tb_Logopo__Displ__0D7A0286]  DEFAULT ((0)),
	[Price] [numeric](18, 2) NULL,
	[Cost] [numeric](18, 2) NULL,
	[Deleted] [bit] NULL,
	[LocImageName] [varchar](1000) NULL,
	[LogoNumber] [int] NULL,
	[type] [varchar](50) NULL,
	[LogoSrNo] [int] NULL CONSTRAINT [DF__tb_Logopo__LogoS__0E6E26BF]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_Logoposition] PRIMARY KEY CLUSTERED 
(
	[LogoPositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_MailLog]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_MailLog](
	[MailID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[CustomerID] [int] NULL,
	[ToEmail] [varchar](100) NULL,
	[FromMail] [varchar](100) NULL,
	[Subject] [varchar](1000) NULL,
	[Body] [varchar](max) NULL,
	[IPAddress] [varchar](50) NULL,
	[ReplyTo] [int] NULL,
	[MailDate] [datetime] NULL,
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_MailLog_Deleted]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_MailLog] PRIMARY KEY CLUSTERED 
(
	[MailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Manufacture]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Manufacture](
	[ManufactureID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[Name] [varchar](500) NULL,
	[Description] [varchar](max) NULL,
	[SEKeywords] [varchar](max) NULL,
	[SEDescription] [varchar](max) NULL,
	[SEName] [varchar](500) NULL,
	[DisplayOrder] [int] NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_Manufacture_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL CONSTRAINT [DF_tb_Manufacture_UpdatedOn]  DEFAULT (getdate()),
	[ImageName] [nvarchar](400) NULL,
	[MenuIcon] [nvarchar](400) NULL,
	[IsSpecialBrand] [bit] NOT NULL CONSTRAINT [DF_tb_Manufacture_HideSellPrice]  DEFAULT ((0)),
	[Logo] [nvarchar](400) NULL,
	[Note] [nvarchar](max) NULL,
	[BannerImage] [nvarchar](400) NULL,
	[BannerTitle] [nvarchar](400) NULL,
	[BlackLogo] [nvarchar](400) NULL,
	[WhiteLogo] [nvarchar](400) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[ShowHomePage] [bit] NULL,
	[SEtitle] [nvarchar](max) NULL,
 CONSTRAINT [PK_tb_Manufacture] PRIMARY KEY CLUSTERED 
(
	[ManufactureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ManufactureVendorMap]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ManufactureVendorMap](
	[ManufactureVendorMapID] [int] IDENTITY(1,1) NOT NULL,
	[ManufactureID] [int] NULL,
	[VendorID] [int] NULL,
 CONSTRAINT [PK_tb_ManufactureVendorMap] PRIMARY KEY CLUSTERED 
(
	[ManufactureVendorMapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Order]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Order](
	[OrderNumber] [int] IDENTITY(1000,1) NOT NULL,
	[StoreID] [int] NULL,
	[OrderGUID] [varchar](50) NULL,
	[IsNew] [bit] NULL,
	[ShoppingCardID] [int] NULL,
	[CustomerID] [int] NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
	[Notes] [varchar](max) NULL,
	[GiftPackNote] [varchar](max) NULL,
	[BillingEqualsShipping] [bit] NULL,
	[BillingEmail] [varchar](100) NULL,
	[BillingFirstName] [varchar](50) NULL,
	[BillingLastName] [varchar](50) NULL,
	[BillingCompany] [varchar](100) NULL,
	[BillingAddress1] [nvarchar](500) NULL,
	[BillingAddress2] [nvarchar](500) NULL,
	[BillingSuite] [varchar](50) NULL,
	[BillingCity] [varchar](50) NULL,
	[BillingState] [varchar](50) NULL,
	[BillingZip] [varchar](10) NULL,
	[BillingCountry] [varchar](50) NULL,
	[BillingPhone] [varchar](20) NULL,
	[ShippingEmail] [varchar](100) NULL,
	[ShippingLastName] [varchar](50) NULL,
	[ShippingFirstName] [varchar](50) NULL,
	[ShippingCompany] [varchar](100) NULL,
	[ShippingAddress1] [nvarchar](500) NULL,
	[ShippingAddress2] [nvarchar](500) NULL,
	[ShippingSuite] [varchar](50) NULL,
	[ShippingCity] [varchar](50) NULL,
	[ShippingState] [varchar](50) NULL,
	[ShippingZip] [varchar](20) NULL,
	[ShippingCountry] [varchar](50) NULL,
	[ShippingPhone] [varchar](20) NULL,
	[ShippingMethod] [varchar](300) NULL,
	[OkToEmail] [bit] NULL,
	[CardName] [varchar](100) NULL,
	[CardType] [varchar](20) NULL,
	[CardNumber] [varchar](250) NULL,
	[CardVarificationCode] [varchar](10) NULL,
	[CardExpirationMonth] [varchar](50) NULL,
	[CardExpirationYear] [varchar](50) NULL,
	[GroupDiscountAmount] [money] NULL CONSTRAINT [DF_tb_Order_CouponDiscountAmount1]  DEFAULT ((0)),
	[CouponCode] [varchar](100) NULL,
	[CouponDiscountAmount] [money] NULL CONSTRAINT [DF_tb_Order_CouponDiscountAmount]  DEFAULT ((0)),
	[GiftCertiSerialNumber] [varchar](100) NULL,
	[GiftCertificateDiscountAmount] [money] NULL CONSTRAINT [DF_tb_Order_GiftCertificateDiscountAmount]  DEFAULT ((0)),
	[QuantityDiscountAmount] [money] NULL CONSTRAINT [DF_tb_Order_QuantityDiscountAmount]  DEFAULT ((0)),
	[LevelDiscountPercent] [money] NULL CONSTRAINT [DF_tb_Order_LevelDiscountPercent]  DEFAULT ((0)),
	[LevelDiscountAmount] [money] NULL CONSTRAINT [DF_tb_Order_LevelDiscountAmount]  DEFAULT ((0)),
	[CustomDiscount] [money] NULL CONSTRAINT [DF_tb_Order_CustomDiscount]  DEFAULT ((0)),
	[OrderSubtotal] [money] NULL,
	[OrderTax] [money] NULL,
	[OrderShippingCosts] [money] NULL,
	[OrderTotal] [money] NULL,
	[AuthorizationCode] [varchar](100) NULL,
	[AuthorizationResult] [varchar](max) NULL,
	[AuthorizationPNREF] [varchar](200) NULL,
	[TransactionCommand] [varchar](max) NULL,
	[LastIPAddress] [varchar](50) NULL,
	[PaymentGateway] [varchar](100) NULL,
	[PaymentMethod] [varchar](100) NULL,
	[ShippingTrackingNumber] [varchar](100) NULL,
	[ShippedVIA] [varchar](100) NULL,
	[OrderStatus] [varchar](200) NULL,
	[TransactionStatus] [varchar](200) NULL,
	[AVSResult] [varchar](500) NULL,
	[Cvc2Response] [varchar](50) NULL,
	[CaptureTxCommand] [varchar](max) NULL,
	[CaptureTXResult] [varchar](max) NULL,
	[VoidTXCommand] [varchar](max) NULL,
	[VoidTXResult] [varchar](max) NULL,
	[RefundTXCommand] [varchar](max) NULL,
	[RefundTXResult] [varchar](max) NULL,
	[RefundReason] [varchar](max) NULL,
	[CartType] [varchar](100) NULL,
	[Last4] [varchar](10) NULL,
	[AuthorizedOn] [datetime] NULL,
	[CapturedOn] [datetime] NULL,
	[RefundedOn] [datetime] NULL,
	[VoidedOn] [datetime] NULL,
	[FraudedOn] [datetime] NULL,
	[ShippedOn] [datetime] NULL,
	[OrderDate] [datetime] NULL,
	[Deleted] [bit] NULL,
	[ReferralLink] [varchar](200) NULL,
	[Referrer] [varchar](100) NULL,
	[RefundedAmount] [money] NULL CONSTRAINT [DF_tb_Order_RefundedAmount]  DEFAULT ((0)),
	[ChargeAmount] [money] NULL,
	[AuthorizedAmount] [money] NULL,
	[AdjustmentAmount] [money] NULL CONSTRAINT [DF_tb_Order_AdjustmentAmount]  DEFAULT ((0)),
	[AdjustmentCapturedOn] [datetime] NULL,
	[OrderNotes] [varchar](max) NULL,
	[isGiftWrap] [bit] NULL,
	[GiftWrapAmt] [money] NULL,
	[SalesRepName] [varchar](100) NULL,
	[THUB_POSTED_TO_ACCOUNTING] [char](1) NULL,
	[THUB_POSTED_DATE] [datetime] NULL,
	[THUB_ACCOUNTING_REF] [char](25) NULL,
	[InventoryWasReduced] [bit] NULL,
	[RefOrderID] [nvarchar](500) NULL,
	[IsPrinted] [bit] NULL,
	[IsMobileOrder] [bit] NULL CONSTRAINT [DF_tb_Order_IsMobileOrder]  DEFAULT ((0)),
	[IsPhoneOrder] [bit] NULL,
	[BatchId] [int] NULL CONSTRAINT [DF__tb_Order__BatchI__4A4E069C]  DEFAULT ((0)),
	[ShippingLabelMethod] [varchar](250) NULL,
	[ShippingLabelFileName] [nvarchar](max) NULL,
	[ShippingLabelCost] [money] NULL CONSTRAINT [DF__tb_Order__Shippi__4B422AD5]  DEFAULT ((0)),
	[ShippingLabelWeight1] [int] NULL CONSTRAINT [DF__tb_Order__Shippi__4C364F0E]  DEFAULT ((0)),
	[ShippingLabelPackageHeight] [int] NULL CONSTRAINT [DF__tb_Order__Shippi__4D2A7347]  DEFAULT ((0)),
	[ShippingLabelPackageWidth] [int] NULL CONSTRAINT [DF__tb_Order__Shippi__4E1E9780]  DEFAULT ((0)),
	[ShippingLabelPackageLength] [int] NULL CONSTRAINT [DF__tb_Order__Shippi__4F12BBB9]  DEFAULT ((0)),
	[NoOfLabels] [int] NULL CONSTRAINT [DF__tb_Order__NoOfLa__5006DFF2]  DEFAULT ((0)),
	[EbayTransactionID] [nvarchar](500) NULL,
	[CashReceived] [money] NULL,
	[CashChangedReturned] [money] NULL,
	[BankName] [varchar](150) NULL,
	[ChequeNumber] [varchar](50) NULL,
	[ChequeDate] [datetime] NULL,
	[CCReceiptNo] [varchar](50) NULL,
	[SalesAgentId] [int] NULL CONSTRAINT [DF__tb_Order__SalesA__369C13AA]  DEFAULT ((0)),
	[POSOrderNumber] [int] NULL,
	[IsPrintedSlip] [bit] NULL,
	[IsApproved] [bit] NULL CONSTRAINT [DF__tb_Order__IsAppr__48BAC3E5]  DEFAULT ((1)),
	[ReceiptNumber] [varchar](500) NULL,
	[DimensionValue] [int] NULL CONSTRAINT [DF__tb_Order__Dimens__4E739D3B]  DEFAULT ((0)),
	[ShippingDimension] [varchar](500) NULL,
	[gift_wrap_price] [money] NULL CONSTRAINT [DF__tb_Order__gift_w__5708E33C]  DEFAULT ((0)),
	[ship_promotion_discount] [money] NULL CONSTRAINT [DF__tb_Order__ship_p__57FD0775]  DEFAULT ((0)),
	[SerialNumber] [nvarchar](500) NULL,
	[isfullFillment] [bit] NULL CONSTRAINT [DF_tb_Order_isfullFillment]  DEFAULT ((0)),
	[internalnotes] [varchar](max) NULL,
	[ReturnedStock] [money] NULL,
	[ReturnedFee] [money] NULL,
	[isebayShip] [bit] NULL,
	[CustomerType] [nvarchar](50) NULL,
	[isAmazonuplaod] [bit] NULL CONSTRAINT [DF__tb_Order__isAmaz__20B7BF83]  DEFAULT ((0)),
	[ShippingLabelWeight_new] [numeric](18, 2) NULL,
	[ShippingLabelWeight] [numeric](18, 2) NULL,
	[CVVResult] [nvarchar](100) NULL,
	[IsMailSend] [bit] NULL CONSTRAINT [DF__tb_Order__IsMail__44F51FF9]  DEFAULT ((0)),
	[ShippedByStamps] [bit] NULL CONSTRAINT [DF__tb_Order__Shippe__45E94432]  DEFAULT ((0)),
	[RefSalesChannel] [nvarchar](max) NULL,
	[IsOverStockProcess] [bit] NULL,
	[IsJetUploaded] [bit] NULL CONSTRAINT [DF_tb_Order_IsJetUploaded]  DEFAULT ((0)),
	[PhoneOrderDiscount] [money] NULL,
	[AdditionalCharges] [money] NULL CONSTRAINT [DF_tb_Order_AdditionalCharges]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_order] PRIMARY KEY CLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_PriceRange]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_PriceRange](
	[PriceRangeId] [int] IDENTITY(1,1) NOT NULL,
	[PriceRangeName] [nvarchar](200) NULL,
	[SEName] [varchar](500) NULL,
	[MinPrice] [money] NULL,
	[MaxPrice] [money] NULL,
	[Deleted] [bit] NULL,
	[Status] [bit] NULL,
	[Created] [datetime] NULL,
	[ProductCount] [int] NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK_tb_PriceRange] PRIMARY KEY CLUSTERED 
(
	[PriceRangeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Product]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[ManufactureID] [int] NULL,
	[DistributorID] [int] NULL,
	[TaxClassID] [int] NULL,
	[ProductTypeID] [int] NULL,
	[QuantityDiscountID] [int] NULL,
	[Name] [varchar](500) NULL,
	[SEName] [varchar](max) NULL,
	[SKU] [varchar](500) NULL,
	[Price] [money] NULL,
	[SalePrice] [money] NULL,
	[OurPrice] [money] NULL,
	[SurCharge] [money] NULL,
	[Inventory] [int] NULL,
	[Weight] [decimal](18, 2) NULL,
	[Size] [varchar](100) NULL,
	[Color] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
	[UPC] [varchar](100) NULL,
	[Height] [varchar](20) NULL,
	[Width] [varchar](20) NULL,
	[Length] [varchar](20) NULL,
	[Material] [varchar](500) NULL,
	[Finish] [varchar](500) NULL,
	[Avail] [varchar](500) NULL,
	[AvaliableStartDate] [datetime] NULL,
	[AvailableEndDate] [datetime] NULL,
	[ImageName] [varchar](500) NULL,
	[PDFName] [varchar](500) NULL,
	[Discontinue] [bit] NULL,
	[MainCategory] [varchar](100) NULL,
	[IsKit] [bit] NULL,
	[IsPack] [bit] NULL,
	[IsFeatured] [bit] NULL,
	[IsFreeShipping] [bit] NULL,
	[IsNewArrival] [bit] NULL,
	[IsSaleclearance] [bit] NULL,
	[IsAuthorizeRefund] [bit] NULL,
	[IsBestSeller] [bit] NULL,
	[OutOfStockMessage] [varchar](max) NULL,
	[SEKeywords] [varchar](max) NULL,
	[SEDescription] [varchar](max) NULL,
	[SETitle] [varchar](max) NULL,
	[ToolTip] [varchar](500) NULL,
	[DisplayOrder] [int] NULL,
	[GiftWrap] [bit] NULL CONSTRAINT [DF_tb_Product_GiftWrap]  DEFAULT ((0)),
	[CallUsForPrice] [bit] NULL CONSTRAINT [DF_tb_Product_CallUsForPrice]  DEFAULT ((0)),
	[isFree19InchLCD] [bit] NULL CONSTRAINT [DF_tb_Product_isFree19InchLCD]  DEFAULT ((0)),
	[isFree22InchLCD] [bit] NULL CONSTRAINT [DF_tb_Product_isFree22InchLCD]  DEFAULT ((0)),
	[is3YearDVRWarranty] [bit] NULL CONSTRAINT [DF_tb_Product_is3YearDVRWarranty]  DEFAULT ((0)),
	[isFreeDVRUpgrade] [bit] NULL CONSTRAINT [DF_tb_Product_isFreeDVRUpgrade]  DEFAULT ((0)),
	[isFreeHDUpgrade] [bit] NULL CONSTRAINT [DF_tb_Product_isFreeHDUpgrade]  DEFAULT ((0)),
	[isFreeDVDBurner] [bit] NULL CONSTRAINT [DF_tb_Product_isFreeDVDBurner]  DEFAULT ((0)),
	[isFreeTechSupport] [bit] NULL CONSTRAINT [DF_tb_Product_isFreeTechSupport]  DEFAULT ((0)),
	[isSatisfactionGuaranteed] [bit] NULL CONSTRAINT [DF_tb_Product_isSatisfactionGuaranteed]  DEFAULT ((0)),
	[isTabbingDisplay] [bit] NULL CONSTRAINT [DF_tb_Product_isTabbingDisplay]  DEFAULT ((0)),
	[TabTitle1] [varchar](50) NULL,
	[TabTitle2] [varchar](50) NULL,
	[TabDesc2] [varchar](max) NULL,
	[TabTitle3] [varchar](50) NULL,
	[TabDesc3] [varchar](max) NULL,
	[TabTitle4] [varchar](50) NULL,
	[TabDesc4] [varchar](max) NULL,
	[TabTitle5] [varchar](50) NULL,
	[TabDesc5] [varchar](max) NULL,
	[ViewCount] [int] NULL,
	[LastViewDate] [datetime] NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[RelatedProduct] [varchar](max) NULL,
	[TagName] [varchar](50) NULL,
	[eBayListingType] [bit] NULL,
	[eBayListingDay] [int] NULL,
	[eBayCreatedOn] [datetime] NULL,
	[eBayLastUpdated] [datetime] NULL,
	[eBayListingFee] [money] NULL,
	[eBayProductID] [varchar](100) NULL,
	[eBayCategoryID] [bigint] NULL,
	[eBayStoreCategoryID] [bigint] NULL,
	[IsRestricted] [bit] NULL,
	[Perishable] [bit] NULL,
	[RequiresRefrigeration] [bit] NULL,
	[RequiresFreezing] [bit] NULL,
	[ContainsAlcohol] [bit] NULL,
	[MapPriceIndicator] [nvarchar](200) NULL,
	[ShippingStartDate] [datetime] NULL,
	[ShippingEndDate] [datetime] NULL,
	[ManufacturePartNo] [varchar](50) NULL,
	[Summary] [ntext] NULL,
	[SellerID] [int] NULL,
	[Isbn] [varchar](50) NULL,
	[ASIN] [varchar](255) NULL,
	[Srno] [int] NULL,
	[ProductSetID] [varchar](50) NULL,
	[BuyListingID] [int] NULL,
	[Features] [varchar](max) NULL,
	[Extended-warranty] [varchar](1000) NULL,
	[BuyCategoryID] [int] NULL,
	[Location] [varchar](500) NULL,
	[Condition] [varchar](50) NULL,
	[IsShipSeparately] [bit] NULL,
	[ManuItemURL] [nvarchar](256) NULL,
	[WebSiteShortTitle] [nvarchar](200) NULL,
	[WebSiteLongTitle] [nvarchar](200) NULL,
	[ItemPackage] [nvarchar](50) NULL,
	[ActivationMark] [bit] NULL,
	[Prop65] [bit] NULL,
	[Pro65Motherboard] [bit] NULL,
	[Age18Verification] [bit] NULL,
	[ChokingHazard1] [nvarchar](100) NULL,
	[ChokingHazard2] [nvarchar](100) NULL,
	[ChokingHazard3] [nvarchar](100) NULL,
	[ChokingHazard4] [nvarchar](100) NULL,
	[SellerPartNo] [nvarchar](40) NULL,
	[Shipping] [ntext] NULL,
	[BuyKeywords] [varchar](500) NULL,
	[IsFreeEngraving] [bit] NULL,
	[FreeProductSKU] [varchar](500) NULL,
	[ReturnPolicy] [varchar](max) NULL,
	[PackProductId] [varchar](max) NULL,
	[GiftWrapPrice] [money] NULL,
	[BuySellerSKU] [nvarchar](max) NULL,
	[YahooID] [nvarchar](max) NULL,
	[PageURL] [varchar](max) NULL,
	[ProductURL] [varchar](max) NULL,
	[MarryProducts] [nvarchar](max) NULL,
	[OptionalAccessories] [varchar](max) NULL,
	[LowInventory] [int] NULL CONSTRAINT [DF__tb_Produc__LowIn__65F62111]  DEFAULT ((0)),
	[IsInventoryLevelLow] [bit] NULL CONSTRAINT [DF__tb_Produc__IsInv__66EA454A]  DEFAULT ((0)),
	[IsAmzon] [bit] NULL CONSTRAINT [DF__tb_Produc__IsAmz__67DE6983]  DEFAULT ((0)),
	[AddOnItems] [nvarchar](max) NULL,
	[IsEmbroideryDesign] [bit] NULL CONSTRAINT [DF__tb_Produc__IsEmb__68D28DBC]  DEFAULT ((0)),
	[RequireRegistration] [bit] NULL CONSTRAINT [DF__tb_Produc__Requi__69C6B1F5]  DEFAULT ((0)),
	[IsCarryout] [bit] NULL CONSTRAINT [DF__tb_Produc__IsCar__6ABAD62E]  DEFAULT ((0)),
	[Format] [nvarchar](500) NULL,
	[HidePriceUntilCart] [bit] NULL CONSTRAINT [DF__tb_Produc__HideP__6BAEFA67]  DEFAULT ((0)),
	[IsDownloadProduct] [bit] NULL CONSTRAINT [DF__tb_Produc__IsDow__6CA31EA0]  DEFAULT ((0)),
	[IsHidden] [bit] NULL CONSTRAINT [DF__tb_Produc__IsHid__6D9742D9]  DEFAULT ((0)),
	[IsNextdayShipping] [bit] NULL CONSTRAINT [DF__tb_Produc__IsNex__6E8B6712]  DEFAULT ((0)),
	[ContactUsAvailability] [bit] NULL CONSTRAINT [DF__tb_Produc__Conta__6F7F8B4B]  DEFAULT ((0)),
	[IsInternationalShipping] [bit] NULL CONSTRAINT [DF__tb_Produc__IsInt__7073AF84]  DEFAULT ((0)),
	[ShowBuyButton] [bit] NULL CONSTRAINT [DF__tb_Produc__ShowB__7167D3BD]  DEFAULT ((0)),
	[FreeNextDayShippingHTML] [nvarchar](max) NULL,
	[Is2nddayShipping] [bit] NULL CONSTRAINT [DF__tb_Produc__Is2nd__725BF7F6]  DEFAULT ((0)),
	[Free2ndDayShippingHTML] [nvarchar](max) NULL,
	[FreeShippingHTML] [nvarchar](max) NULL,
	[ProductTypeName] [nvarchar](500) NULL,
	[PackSize] [int] NULL CONSTRAINT [DF__tb_Produc__PackS__73501C2F]  DEFAULT ((0)),
	[ProductSkus] [nvarchar](max) NULL,
	[Intheboxwarranty] [nvarchar](max) NULL,
	[IsBackOrdered] [bit] NULL CONSTRAINT [DF__tb_Produc__IsBac__74444068]  DEFAULT ((0)),
	[IsScratch] [bit] NULL CONSTRAINT [DF__tb_Produc__IsScr__753864A1]  DEFAULT ((0)),
	[UpgradeSKU] [nvarchar](max) NULL,
	[BackOrderedAvail] [nvarchar](200) NULL,
	[BeltsModel] [nvarchar](250) NULL,
	[BeltsType] [nvarchar](250) NULL,
	[BeltsColorMapping] [nvarchar](250) NULL,
	[BeltsAge] [nvarchar](100) NULL,
	[Colors] [nvarchar](250) NULL,
	[Gender] [nvarchar](50) NULL,
	[BeltsBrand] [nvarchar](250) NULL,
	[Sizes] [nvarchar](150) NULL,
	[ContainsTobacco] [bit] NULL CONSTRAINT [DF__tb_Produc__Conta__762C88DA]  DEFAULT ((0)),
	[amazonproductid] [nvarchar](250) NULL,
	[NeweggItemNumber] [nvarchar](250) NULL,
	[BuyReferenceID] [nvarchar](250) NULL,
	[EbayItemCondition] [varchar](500) NULL,
	[BoxWarranty] [varchar](500) NULL,
	[EbayCreated] [datetime] NULL,
	[ProductSummary] [varchar](max) NULL,
	[Materials] [varchar](max) NULL,
	[Brand] [varchar](max) NULL,
	[MovetoPOS] [bit] NULL CONSTRAINT [DF_tb_Product_MovetoPOS]  DEFAULT ((0)),
	[POSProductID] [int] NULL,
	[featureDescription] [nvarchar](max) NULL,
	[ShortDescription] [nvarchar](max) NULL,
	[Specification] [nvarchar](max) NULL,
	[Warranty] [varchar](max) NULL,
	[ProductText] [nvarchar](500) NULL,
	[Notes] [nvarchar](max) NULL,
	[IsLatest] [bit] NULL,
	[isHotDeal] [bit] NULL,
	[OverStock] [bit] NULL,
	[EstiArrivalDate] [datetime] NULL,
	[Cost] [money] NULL,
	[PerfectMachineDetail] [nvarchar](max) NULL,
	[WhatIncludedDetail] [nvarchar](max) NULL,
	[isUSPS] [bit] NULL,
	[Our_Price_UOM] [nvarchar](50) NULL,
	[Department_Name] [nvarchar](50) NULL,
	[MarketPlaces] [nvarchar](max) NULL,
	[InventoryUpdatedOn] [datetime] NULL,
	[isshipingmsg] [bit] NULL,
	[isoutofstock] [bit] NULL,
	[VideoURL] [nvarchar](max) NULL,
	[captionlong] [nvarchar](max) NULL,
	[captionlonglink] [nvarchar](max) NULL,
	[Bulletpoint1] [nvarchar](max) NULL,
	[Bulletpoint2] [nvarchar](max) NULL,
	[Bulletpoint3] [nvarchar](max) NULL,
	[Bulletpoint4] [nvarchar](max) NULL,
	[Bulletpoint5] [nvarchar](max) NULL,
	[ShippingInfo] [nvarchar](max) NULL,
	[CrosssaleProducts] [varchar](max) NULL,
	[ProductFaq] [varchar](max) NULL,
	[Isdefaultcategory] [int] NULL,
	[Isdefaultcategory2] [int] NULL,
	[Isdefaultcategory3] [int] NULL,
	[Isdefaultcategory4] [int] NULL,
	[is5yearwarranty] [bit] NULL,
	[is3yearwarranty] [bit] NULL,
	[Videocategoryid] [int] NULL,
	[ProductColormainFamily] [nvarchar](500) NULL,
	[LowInvtMailSent] [bit] NULL,
	[Row] [bit] NULL,
	[Vendor2] [bit] NULL,
	[Vendor1] [bit] NULL,
	[Column] [bit] NULL,
	[Rect] [bit] NULL,
	[IsSpotlight] [bit] NULL,
	[IsLowInvtMailSent] [bit] NULL,
	[VendorCode2] [varchar](50) NULL,
	[VendorCode1] [varchar](50) NULL,
	[VendorCode] [varchar](50) NULL,
	[MoreInfo] [nvarchar](max) NULL,
	[ProductForecolor] [varchar](50) NULL,
	[ProductColorFamily] [varchar](50) NULL,
	[COGsInv] [int] NULL,
	[FullLevelInv] [int] NULL,
	[BuyLevelInv] [int] NULL,
	[Bin] [nvarchar](max) NULL,
	[Shelf] [nvarchar](max) NULL,
	[Rack] [nvarchar](max) NULL,
	[Aisle] [nvarchar](max) NULL,
	[IsPriceMatch] [bit] NULL,
	[UPCFinal] [varchar](100) NULL,
	[UPCOrg] [varchar](100) NULL,
	[DiscontinuedOn] [datetime] NULL,
	[Ypath] [nvarchar](500) NULL,
	[Taxable] [bit] NULL,
	[Dimension] [nvarchar](500) NULL,
	[Image1] [varchar](max) NULL,
	[Manufacture] [varchar](100) NULL,
	[ItemID] [int] NULL,
	[AnimationSafetyLock] [int] NULL CONSTRAINT [DF_tb_Product_AnimationSafetyLock]  DEFAULT ((0)),
	[AmazonSafetyLock] [int] NULL CONSTRAINT [DF_tb_Product_AmazonSafetyLock]  DEFAULT ((1)),
	[EbaySafetyLock] [int] NULL CONSTRAINT [DF_tb_Product_EbaySafetyLock]  DEFAULT ((1)),
	[ApplyInvRule] [bit] NULL CONSTRAINT [DF_tb_Product_ApplyInvRule]  DEFAULT ((1)),
	[SafetyInv] [int] NULL CONSTRAINT [DF_tb_Product_SafetyInv]  DEFAULT ((0)),
	[InvWarehouseID] [int] NULL,
	[LastSoldOn] [datetime] NULL,
	[ProductAvgRating] [decimal](18, 0) NULL,
	[isShipViaTruck] [bit] NULL,
	[IsEligibleForGoogle] [bit] NULL,
	[varlocation] [varchar](1000) NULL,
	[NewArrivalDisplayOrder] [int] NULL CONSTRAINT [DF__tb_Produc__NewAr__294D0584]  DEFAULT ((0)),
	[FeaturedDisplayOrder] [int] NULL CONSTRAINT [DF__tb_Produc__Featu__2A4129BD]  DEFAULT ((0)),
	[IsHotStyle] [bit] NULL,
	[HotStyleDisplayOrder] [int] NULL CONSTRAINT [DF__tb_Produc__HotSt__2F05DEDA]  DEFAULT ((0)),
	[EbayInvupload] [bit] NULL CONSTRAINT [DF__tb_Produc__EbayI__34BEB830]  DEFAULT ((0)),
	[MPN] [nvarchar](500) NULL,
	[NameOfChannel] [nvarchar](500) NULL,
	[VendorID] [int] NULL,
	[Options] [nvarchar](max) NULL,
	[IsProductType] [int] NULL,
	[DescriptionforChannels] [nvarchar](max) NULL,
	[AmazonStauts] [bit] NULL,
	[WalmartProductID] [nvarchar](50) NULL,
	[WalmartCategorySelection] [nvarchar](50) NULL,
	[WalmartStatus] [nvarchar](50) NULL,
	[WalmartPrice] [money] NULL,
	[eBayItemID] [nvarchar](50) NULL,
	[eBayPrice] [money] NULL,
	[eBayStatus] [bit] NULL,
	[JetProductID] [nvarchar](50) NULL,
	[JetPrice] [money] NULL,
	[JetStatus] [bit] NULL,
	[VendorSKU] [nvarchar](500) NULL,
	[Ispublish] [int] NULL,
	[Season] [nvarchar](200) NULL,
	[isPersonalize] [bit] NULL,
	[ApplyFreeLogo] [bit] NULL,
	[IsDropShipper] [bit] NULL,
	[MinQuantity] [int] NOT NULL CONSTRAINT [DF__tb_Produc__MinQu__4B7734FF]  DEFAULT ((0)),
	[IsCloseOut] [bit] NULL,
	[SizeTemplateID] [int] NULL,
	[Measuringchart] [varchar](max) NULL,
	[Companion] [nvarchar](max) NULL,
	[OverrideDiscount] [bit] NOT NULL CONSTRAINT [DF__tb_Produc__Overr__498EEC8D]  DEFAULT ((0)),
	[MasterCloneID] [int] NULL,
	[InventorySelection] [int] NULL,
	[ManufacturersCost] [money] NULL,
	[ModelName] [nvarchar](100) NULL,
	[overstockproductid] [nvarchar](max) NULL,
	[OptionSku] [nvarchar](max) NULL,
	[IsJetUploaded] [bit] NULL CONSTRAINT [DF_tb_Product_IsJetUploaded]  DEFAULT ((0)),
	[MPN_bit] [bit] NULL,
	[JetNodeID] [int] NULL,
	[JetMessage] [nvarchar](max) NULL,
 CONSTRAINT [PK_tb_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ProductBridgeSize_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductBridgeSize_MST](
	[ProductBridgeSizeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductBridgeSize_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductBridgeSize_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductBridgeSize_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductBridgeSize_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductBridgeSize_MST] PRIMARY KEY CLUSTERED 
(
	[ProductBridgeSizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductCategory]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductCategory](
	[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ProductID] [int] NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_tb_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductFrameColor_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductFrameColor_MST](
	[ProductFrameColorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL,
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductFrameColor_MST] PRIMARY KEY CLUSTERED 
(
	[ProductFrameColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductFrameMaterial_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductFrameMaterial_MST](
	[ProductFrameMaterialID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductFrameMaterial_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductFrameMaterial_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductFrameMaterial_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductFrameMaterial_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductFrameMaterial_MST] PRIMARY KEY CLUSTERED 
(
	[ProductFrameMaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductFrameShape_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductFrameShape_MST](
	[ProductFrameShapeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductFrameShape_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductFrameShape_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductFrameShape_MST] PRIMARY KEY CLUSTERED 
(
	[ProductFrameShapeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductFrameType_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductFrameType_MST](
	[ProductFrameTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductFrameType_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductFrameType_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductFrameType_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductFrameType_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductFrameType_MST] PRIMARY KEY CLUSTERED 
(
	[ProductFrameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductImages]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductImages](
	[ProductImagesID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Imagename] [nvarchar](1000) NULL,
 CONSTRAINT [PK_tb_ProductImages] PRIMARY KEY CLUSTERED 
(
	[ProductImagesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductImgDesc]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ProductImgDesc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[ImageNo] [int] NULL,
	[Description] [varchar](max) NULL,
	[Imagename] [nvarchar](500) NULL,
	[StoreId] [int] NULL,
 CONSTRAINT [PK_tb_ProductImgDesc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ProductInfo]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductInfo](
	[ProductInfoID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[LensWidthmmEyeSize] [int] NULL,
	[LensHeightmm] [int] NULL,
	[LensBase] [int] NULL,
	[LensType] [int] NULL,
	[LensMaterial] [int] NULL,
	[LensColor] [nvarchar](500) NULL,
	[BridgeSize] [int] NULL,
	[FrameMaterial] [int] NULL,
	[FrameShape] [int] NULL,
	[FrameColor] [nvarchar](500) NULL,
	[FrameType] [int] NULL,
	[TempleLength] [int] NULL,
	[TempleMaterial] [int] NULL,
	[Polarized] [bit] NULL,
	[Photochromic] [bit] NULL,
	[RxAble] [bit] NULL,
	[RxServices] [bit] NULL,
	[Style] [nvarchar](50) NULL,
	[Theme] [nvarchar](50) NULL,
	[Magnification] [nvarchar](500) NULL,
	[ColorCode] [nvarchar](500) NULL,
	[StoreID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductInventoryMapping]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductInventoryMapping](
	[ProductInventoryMappingID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductVariantValueID] [int] NULL,
	[WarehouseInventoryTypeID] [int] NULL,
	[Inventory] [int] NULL,
	[StoreID] [int] NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductInventoryMapping_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductInventoryMapping_Deleted]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductInventoryMapping_CreatedOn]  DEFAULT (getdate()),
	[CreatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tb_ProductInventoryManagement] PRIMARY KEY CLUSTERED 
(
	[ProductInventoryMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductInventoryMgt]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ProductInventoryMgt](
	[InvID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[SKU] [varchar](500) NULL,
	[VariantValueID] [int] NULL,
	[UPC] [varchar](500) NULL,
	[Type] [varchar](10) NULL,
	[Qty] [int] NULL,
	[Cost] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductInventoryMgt_CreatedOn]  DEFAULT (getdate()),
	[CreatedBy] [int] NULL CONSTRAINT [DF_tb_ProductInventoryMgt_CreatedBy]  DEFAULT ((0)),
	[Active] [bit] NULL,
	[Inactiveon] [datetime] NULL,
	[InactiveBy] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[CustomCartID] [int] NULL CONSTRAINT [DF_tb_ProductInventoryMgt_CustomCartID]  DEFAULT ((0)),
	[WId] [int] NULL DEFAULT ((0)),
 CONSTRAINT [PK_tb_ProductInventoryMgt] PRIMARY KEY CLUSTERED 
(
	[InvID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ProductLensBase_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductLensBase_MST](
	[ProductLensBaseID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductLensBase_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductLensBase_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductLensBase_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductLensBase_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductLensBase_MST] PRIMARY KEY CLUSTERED 
(
	[ProductLensBaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductLensColor_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductLensColor_MST](
	[ProductLensColorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL,
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductLensColor_MST] PRIMARY KEY CLUSTERED 
(
	[ProductLensColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductLensHeightmm_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductLensHeightmm_MST](
	[ProductLensHeightmmID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductLensHeightmm_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductLensHeightmm_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductLensHeightmm_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductLensHeightmm_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductLensHeightmm_MST] PRIMARY KEY CLUSTERED 
(
	[ProductLensHeightmmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductLensMaterial_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductLensMaterial_MST](
	[ProductLensMaterialID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductLensMaterial_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductLensMaterial_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductLensMaterial_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductLensMaterial_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductLensMaterial_MST] PRIMARY KEY CLUSTERED 
(
	[ProductLensMaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductLensType_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductLensType_MST](
	[ProductLensTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductLensType_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductLensType_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductLensType_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductLensType_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductLensType_MST] PRIMARY KEY CLUSTERED 
(
	[ProductLensTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductLensWidth_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductLensWidth_MST](
	[ProductLensWidthID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductLensWidth_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductLensWidth_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductLensWidth_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductLensWidth_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductLensWidth_MST] PRIMARY KEY CLUSTERED 
(
	[ProductLensWidthID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductLogoPosition]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ProductLogoPosition](
	[ProLogoPositionId] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[LogoPositionId] [int] NULL,
	[ImageName] [varchar](500) NULL,
	[LogoPrice] [numeric](18, 2) NULL,
	[LogoCost] [numeric](18, 2) NULL,
	[LogoFree] [bit] NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_tb_ProductLogoposition] PRIMARY KEY CLUSTERED 
(
	[ProLogoPositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ProductSEO]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductSEO](
	[ProductSEOId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[SEOName] [nvarchar](400) NULL,
	[SEOURL] [nvarchar](500) NULL,
	[PageTitle] [nvarchar](500) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](max) NULL,
	[H1] [nvarchar](max) NULL,
	[H2] [nvarchar](max) NULL,
	[H3] [nvarchar](max) NULL,
	[H4] [nvarchar](max) NULL,
	[H5] [nvarchar](max) NULL,
	[H6] [nvarchar](max) NULL,
	[H7] [nvarchar](max) NULL,
	[FBWebLikes] [int] NULL CONSTRAINT [DF_tb_Product_SEO_FBWebLikes]  DEFAULT ((0)),
	[FBFirstPostedDate] [datetime] NULL,
	[FBLastPostedDate] [datetime] NULL,
	[FBNextSubmissionDays] [int] NULL CONSTRAINT [DF_tb_Product_SEO_FBNextSubmissionDays]  DEFAULT ((0)),
	[IsPromotedonFB] [bit] NULL CONSTRAINT [DF_tb_Product_SEO_IsPromotedonFB]  DEFAULT ((0)),
	[FBNextPostDate] [datetime] NULL,
	[IsPostedOnBlog] [bit] NULL,
	[BlogPostDate] [datetime] NULL,
	[PostAbout] [nvarchar](50) NULL,
	[Comment] [nvarchar](max) NULL,
	[IsPromotedonTW] [bit] NULL,
	[TWNextSubmissionDays] [int] NULL,
	[TweetDate] [datetime] NULL,
	[NextTweetDate] [datetime] NULL,
	[TotalTweets] [int] NULL CONSTRAINT [DF_tb_Product_SEO_TotalTweets]  DEFAULT ((0)),
	[IsPromotedOnPin] [bit] NULL,
	[TotalPins] [int] NULL CONSTRAINT [DF_tb_Product_SEO_TotalPins]  DEFAULT ((0)),
	[TotalPinBoards] [int] NULL CONSTRAINT [DF_tb_Product_SEO_TotalPinBoards]  DEFAULT ((0)),
	[PinNextSubmissionDays] [int] NULL CONSTRAINT [DF_tb_Product_SEO_PinNextSubmissionDays]  DEFAULT ((0)),
	[PinItDate] [datetime] NULL,
	[NextPinItDate] [datetime] NULL,
	[IsVideoOnYouTube] [bit] NULL,
	[YouTubeURL] [nvarchar](max) NULL,
	[YouTubeVideoDate] [datetime] NULL,
	[YouTubeNextSubmissionDays] [int] NULL,
	[YouTubePostDate] [datetime] NULL,
	[YouTubeNextPostDate] [datetime] NULL,
	[IsPromotedOnGoogle] [bit] NULL,
	[GoogleNextSubmissionDays] [int] NULL,
	[GooglePostDate] [datetime] NULL,
	[GoogleNextPostDate] [datetime] NULL,
	[IsPromotedOnInstagram] [bit] NULL,
	[InstNextSubmissionDays] [int] NULL CONSTRAINT [DF_tb_Product_SEO_InstNextSubmissionDays]  DEFAULT ((0)),
	[InstPostDate] [datetime] NULL,
	[InstNextPostDate] [datetime] NULL,
	[IsPromotedOnFlickr] [bit] NULL,
	[FlickrURL] [nvarchar](max) NULL,
	[FlickrNextSubmissionDays] [int] NULL CONSTRAINT [DF_tb_Product_SEO_FlickrNextSubmissionDays]  DEFAULT ((0)),
	[FlickrPostDate] [datetime] NULL,
	[FlickrNextPostDate] [datetime] NULL,
	[Deleted] [bit] NULL,
	[Active] [bit] NULL,
	[Createdon] [datetime] NULL CONSTRAINT [DF_tb_Product_SEO_Createdon]  DEFAULT (getdate()),
	[storeid] [int] NULL CONSTRAINT [DF__tb___store__6F9F86DC]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_Product_SEO] PRIMARY KEY CLUSTERED 
(
	[ProductSEOId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductSEOLog]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductSEOLog](
	[ProductSEOLogId] [int] IDENTITY(1,1) NOT NULL,
	[ProductSEOId] [int] NOT NULL,
	[ProductId] [int] NULL,
	[SEOName] [nvarchar](400) NULL,
	[SEOURL] [nvarchar](500) NULL,
	[PageTitle] [nvarchar](500) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](max) NULL,
	[H1] [nvarchar](max) NULL,
	[H2] [nvarchar](max) NULL,
	[H3] [nvarchar](max) NULL,
	[H4] [nvarchar](max) NULL,
	[H5] [nvarchar](max) NULL,
	[H6] [nvarchar](max) NULL,
	[H7] [nvarchar](max) NULL,
	[FBWebLikes] [int] NULL,
	[FBFirstPostedDate] [datetime] NULL,
	[FBLastPostedDate] [datetime] NULL,
	[FBNextSubmissionDays] [int] NULL,
	[IsPromotedonFB] [bit] NULL,
	[FBNextPostDate] [datetime] NULL,
	[IsPostedOnBlog] [bit] NULL,
	[BlogPostDate] [datetime] NULL,
	[PostAbout] [nvarchar](50) NULL,
	[Comment] [nvarchar](max) NULL,
	[IsPromotedonTW] [bit] NULL,
	[TWNextSubmissionDays] [int] NULL,
	[TweetDate] [datetime] NULL,
	[NextTweetDate] [datetime] NULL,
	[TotalTweets] [int] NULL,
	[IsPromotedOnPin] [bit] NULL,
	[TotalPins] [int] NULL,
	[TotalPinBoards] [int] NULL,
	[PinNextSubmissionDays] [int] NULL,
	[PinItDate] [datetime] NULL,
	[NextPinItDate] [datetime] NULL,
	[IsVideoOnYouTube] [bit] NULL,
	[YouTubeURL] [nvarchar](max) NULL,
	[YouTubeVideoDate] [datetime] NULL,
	[YouTubeNextSubmissionDays] [int] NULL,
	[YouTubePostDate] [datetime] NULL,
	[YouTubeNextPostDate] [datetime] NULL,
	[IsPromotedOnGoogle] [bit] NULL,
	[GoogleNextSubmissionDays] [int] NULL,
	[GooglePostDate] [datetime] NULL,
	[GoogleNextPostDate] [datetime] NULL,
	[IsPromotedOnInstagram] [bit] NULL,
	[InstNextSubmissionDays] [int] NULL,
	[InstPostDate] [datetime] NULL,
	[InstNextPostDate] [datetime] NULL,
	[IsPromotedOnFlickr] [bit] NULL,
	[FlickrURL] [nvarchar](max) NULL,
	[FlickrNextSubmissionDays] [int] NULL,
	[FlickrPostDate] [datetime] NULL,
	[FlickrNextPostDate] [datetime] NULL,
	[Deleted] [bit] NULL,
	[Active] [bit] NULL,
	[UpdatedBy] [int] NULL,
	[Updatedon] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[Createdon] [datetime] NULL,
	[StoreId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductTempleLength_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductTempleLength_MST](
	[ProductTempleLengthID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductTempleLength_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductTempleLength_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductTempleLength_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductTempleLength_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductTempleLength_MST] PRIMARY KEY CLUSTERED 
(
	[ProductTempleLengthID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductTempleMaterial_MST]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ProductTempleMaterial_MST](
	[ProductTempleMaterialID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ParentId] [int] NULL CONSTRAINT [DF_tb_ProductTempleMaterial_MST_ParentId]  DEFAULT ((0)),
	[DisplayOrder] [int] NULL,
	[ImageName] [nvarchar](500) NULL,
	[ClassName] [nvarchar](500) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_tb_ProductTempleMaterial_MST_Active]  DEFAULT ((1)),
	[Deleted] [bit] NULL CONSTRAINT [DF_tb_ProductTempleMaterial_MST_Deleted]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ProductTempleMaterial_MST_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_ProductTempleMaterial_MST] PRIMARY KEY CLUSTERED 
(
	[ProductTempleMaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ProductType]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ProductType](
	[ProductTypeID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[Name] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tb_ProductType] PRIMARY KEY CLUSTERED 
(
	[ProductTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ProductVariant]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ProductVariant](
	[VariantID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[VariantName] [varchar](100) NULL,
	[OldVariantId] [int] NULL,
 CONSTRAINT [PK_tb_ProductVariant] PRIMARY KEY CLUSTERED 
(
	[VariantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ProductVariantValue]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ProductVariantValue](
	[VariantValueID] [int] IDENTITY(1,1) NOT NULL,
	[VariantID] [int] NULL,
	[VariantValue] [varchar](100) NULL,
	[VariantPrice] [money] NULL,
	[DisplayOrder] [int] NULL,
	[ProductID] [int] NULL,
	[VariantProductID] [int] NULL,
	[Inventory] [int] NULL,
	[SKU] [varchar](500) NULL,
	[VariantCode] [nvarchar](15) NULL,
	[UPC] [varchar](500) NULL,
	[VariImageName] [varchar](500) NULL,
	[ProductTypeDeliveryID] [int] NULL,
	[ProductTypeID] [int] NULL,
	[VendorID] [int] NULL,
	[LowInventory] [bit] NULL,
	[IsInventoryLevelLow] [bit] NULL,
	[IsLowInvtMailSent] [bit] NULL,
	[SafetyInv] [int] NULL CONSTRAINT [DF_tb_ProductVariantValue_SafetyInv]  DEFAULT ((0)),
	[LastSoldOn] [datetime] NULL,
	[varlocation] [varchar](1000) NULL,
	[ASIN] [nvarchar](500) NULL,
	[MPN] [nvarchar](500) NULL,
	[FNSKU] [nvarchar](500) NULL,
	[FBMSellerSKU] [nvarchar](500) NULL,
	[FBASellerSKU] [nvarchar](500) NULL,
	[DealersCost] [money] NULL,
	[ManufacturersCost] [money] NULL,
	[FBAInventory] [int] NULL,
	[LuxotticaInventory] [int] NULL,
	[NHPInventory] [int] NULL,
	[Walmartinvetory] [int] NULL,
	[ebayinventory] [int] NULL,
	[EyeSize] [nvarchar](500) NULL,
	[BridgeSize] [nvarchar](500) NULL,
	[TempleWidth] [nvarchar](500) NULL,
	[LensHeight] [nvarchar](500) NULL,
	[TempleLength] [nvarchar](500) NULL,
	[LimitedEdition] [bit] NULL,
	[Swatchimage] [nvarchar](100) NULL,
	[colorname] [nvarchar](500) NULL,
	[VariantSellPrice] [money] NULL,
	[FutureInventory1] [int] NULL,
	[FutureInventory2] [int] NULL,
	[FutureInventory3] [int] NULL,
	[FutureDate1] [varchar](100) NULL,
	[FutureDate2] [varchar](100) NULL,
	[FutureDate3] [varchar](100) NULL,
	[dscoItemId] [numeric](18, 0) NULL,
	[OurPrice] [money] NULL,
	[Magnification] [nvarchar](50) NULL,
	[FittingBoxID] [nvarchar](max) NULL,
	[GTIN] [nvarchar](50) NULL,
	[Discontinue] [bit] NULL,
	[AllsyncInventory] [bit] NULL,
 CONSTRAINT [PK_tb_ProductVariantValue] PRIMARY KEY CLUSTERED 
(
	[VariantValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_PurchaseOrder]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_PurchaseOrder](
	[PONumber] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [int] NULL,
	[VendorID] [int] NULL,
	[PODate] [datetime] NULL,
	[Notes] [varchar](500) NULL,
	[PoAmount] [money] NULL,
	[PaymentComplete] [bit] NULL,
	[IsSent] [bit] NULL,
	[ShippingMethod] [varchar](500) NULL,
	[Deleted] [bit] NULL,
	[AdditionalCost] [money] NULL,
	[Adjustments] [money] NULL,
	[Tax] [money] NULL,
	[Shipping] [money] NULL,
	[FaxStatus] [nvarchar](100) NULL,
 CONSTRAINT [PK_tb_PurchaseOrder] PRIMARY KEY CLUSTERED 
(
	[PONumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_PurchaseOrderInvoiceList]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_PurchaseOrderInvoiceList](
	[POInvoiceListID] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOrderID] [int] NULL,
	[InvoiceNumber] [nvarchar](max) NULL,
	[FileName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tb_PurchaseOrderInvoiceList] PRIMARY KEY CLUSTERED 
(
	[POInvoiceListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Rating]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Rating](
	[RatingID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[Name] [varchar](500) NULL,
	[EmailID] [varchar](100) NULL,
	[ProductID] [int] NULL,
	[CustomerID] [int] NULL,
	[Rating] [int] NULL,
	[Comments] [varchar](max) NULL,
	[IsApproved] [int] NULL,
	[ApprovedDate] [datetime] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_Rating_CreatedOn]  DEFAULT (getdate()),
	[HelpFullCount] [int] NULL CONSTRAINT [DF_tb_Rating_HelpFullCount]  DEFAULT ((0)),
	[NotHelpFullCount] [int] NULL CONSTRAINT [DF_tb_Rating_NotHelpFullCount]  DEFAULT ((0)),
	[isVerified] [bit] NULL,
	[disapproveddate] [datetime] NULL,
	[CommentHeading] [varchar](500) NULL,
 CONSTRAINT [PK_tb_Rating] PRIMARY KEY CLUSTERED 
(
	[RatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ReferAFriend]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ReferAFriend](
	[ReferAFriendID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ReferralName] [nvarchar](100) NOT NULL,
	[ReferralEmail] [nvarchar](100) NOT NULL,
	[ToEmail1] [nvarchar](100) NOT NULL,
	[ToEmail2] [nvarchar](100) NULL,
	[ToEmail3] [nvarchar](100) NULL,
	[ReferralMessage] [nvarchar](1000) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ReferAFriend_CreatedOn]  DEFAULT (getdate()),
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_tb_ReferAFriend] PRIMARY KEY CLUSTERED 
(
	[ReferAFriendID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_SearchColor]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_SearchColor](
	[ColorID] [int] IDENTITY(1,1) NOT NULL,
	[ColorName] [varchar](max) NULL,
	[ColorCode] [varchar](max) NULL,
	[ImageName] [nvarchar](max) NULL,
	[DisplayOrder] [int] NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK_tb_SearchColor_1] PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_SearchColorMapping]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_SearchColorMapping](
	[SearchColorId] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ColorID] [int] NULL,
 CONSTRAINT [PK_tb_SearchColorMapping] PRIMARY KEY CLUSTERED 
(
	[SearchColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_SearchLog]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_SearchLog](
	[SearchLogID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[SearchTerm] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_SearchLog] PRIMARY KEY CLUSTERED 
(
	[SearchLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ServicePayment]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ServicePayment](
	[PaymentID] [int] NOT NULL,
	[PaymentMethod] [varchar](10) NULL,
	[StoreID] [int] NULL,
	[CashReceived] [money] NULL,
	[CashReturned] [money] NULL,
	[CardTypeID] [int] NULL,
	[CardName] [varchar](50) NULL,
	[CardNumber] [varchar](300) NULL,
	[ExpireMonth] [varchar](3) NULL,
	[ExpireYear] [varchar](5) NULL,
	[CCVNumber] [int] NULL,
	[CardReceiptRefNumber] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ServiceCartID] [int] NULL,
	[SubTotal] [money] NULL,
	[Discount] [money] NULL,
	[TaxAmount] [money] NULL,
	[TotalAmount] [money] NULL,
	[IsPaid] [bit] NULL CONSTRAINT [DF_tb_ServicePayment_IsPaid]  DEFAULT ((0)),
	[ServiceID] [int] NULL,
	[AuthorizationCode] [varchar](100) NULL,
	[AuthorizationResult] [varchar](max) NULL,
	[AuthorizationPNREF] [varchar](200) NULL,
	[TransactionCommand] [varchar](max) NULL,
	[TransactionStatus] [varchar](200) NULL,
	[AVSResult] [varchar](500) NULL,
	[AuthorizedOn] [datetime] NULL,
	[CapturedOn] [datetime] NULL,
	[Last4] [varchar](10) NULL,
	[ServiceGUID] [varchar](500) NULL,
	[Cust_Comment] [varchar](max) NULL,
	[ReceiptNumber] [varchar](50) NULL,
	[PartsDays] [int] NULL CONSTRAINT [DF_tb_ServicePayment_PartsDays]  DEFAULT ((0)),
	[LaborDays] [int] NULL CONSTRAINT [DF_tb_ServicePayment_LaborDays]  DEFAULT ((0)),
 CONSTRAINT [PK_tb_ServicePayment] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ShippingMethods]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ShippingMethods](
	[ShippingMethodID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingServiceID] [int] NULL,
	[Name] [varchar](500) NULL,
	[AdditionalPrice] [money] NULL CONSTRAINT [DF_tb_ShippingMethods_AdditionalPrice]  DEFAULT ((0)),
	[FixedPrice] [money] NULL CONSTRAINT [DF_tb_ShippingMethods_FixedPrice]  DEFAULT ((0)),
	[isRTShipping] [bit] NULL,
	[ShowOnClient] [bit] NULL,
	[ShowOnAdmin] [bit] NULL,
	[IsInternational] [bit] NULL,
	[Active] [bit] NULL,
	[Deleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ShippingMethods_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[StoreID] [int] NULL,
	[FixedPercentageBYTotalOrder] [money] NULL,
 CONSTRAINT [PK_tb_ShippingMethods] PRIMARY KEY CLUSTERED 
(
	[ShippingMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ShoppingCart]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ShoppingCart](
	[ShoppingCartID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_ShoppingCart_CreatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_tb_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[ShoppingCartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ShoppingCartItems]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ShoppingCartItems](
	[CustomCartID] [int] IDENTITY(1,1) NOT NULL,
	[ShoppingCartID] [int] NULL,
	[ProductID] [int] NULL,
	[Price] [money] NULL,
	[LensTypePrice] [money] NULL CONSTRAINT [DF_tb_ShoppingCartItems_LensTypePrice]  DEFAULT ((0)),
	[LensColorPrice] [money] NULL CONSTRAINT [DF_tb_ShoppingCartItems_LensColorPrice]  DEFAULT ((0)),
	[Quantity] [int] NULL,
	[Weight] [decimal](18, 2) NULL,
	[CategoryID] [int] NULL,
	[VariantNames] [varchar](500) NULL,
	[VariantValues] [varchar](500) NULL,
	[LensVisionType] [varchar](500) NULL,
	[LensType] [varchar](500) NULL,
	[LensColor] [varchar](500) NULL,
	[HasPrescription] [bit] NULL CONSTRAINT [DF_tb_ShoppingCartItems_HasPrescription]  DEFAULT ((0)),
	[PrescriptionId] [varchar](500) NULL CONSTRAINT [DF_tb_ShoppingCartItems_PrescriptionId]  DEFAULT ((0)),
	[PackageInclude] [nvarchar](max) NULL,
	[GiftWrapCharges] [money] NULL,
	[PackProductSKU] [nvarchar](500) NULL,
	[GiftWrapNote] [varchar](500) NULL,
	[FreeProductSKU] [nvarchar](500) NULL,
	[RelatedproductID] [int] NULL,
	[IsProductType] [int] NULL,
	[DiscountPrice] [money] NULL,
	[ProductInventory] [int] NULL,
	[ReturnCustomCartID] [int] NULL,
	[VariantValueId] [int] NULL,
 CONSTRAINT [PK_tb_ShoppingCartItems] PRIMARY KEY CLUSTERED 
(
	[CustomCartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_SizeMaster]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_SizeMaster](
	[SizeId] [int] IDENTITY(1,1) NOT NULL,
	[SizeName] [nvarchar](max) NULL,
	[SizeUrl] [nvarchar](max) NULL,
	[Active] [bit] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_tb_SizeMaster] PRIMARY KEY CLUSTERED 
(
	[SizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Sizes]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Sizes](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[showorder] [numeric](18, 0) NULL,
	[active] [int] NOT NULL,
	[date_in] [datetime] NULL CONSTRAINT [DF_tb_Sizes_date_in]  DEFAULT (getdate()),
	[last_mod_date] [datetime] NULL,
	[last_mod_user] [numeric](18, 0) NULL,
 CONSTRAINT [PK_tb_Sizes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_SizesTemplate]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_SizesTemplate](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tempname] [nvarchar](50) NULL,
	[tempDesc] [nvarchar](max) NULL,
	[active] [int] NOT NULL,
	[date_in] [datetime] NULL CONSTRAINT [DF_tb_SizesTemplate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tb_SizesTemplate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_SmallHomeBanner]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_SmallHomeBanner](
	[SmallBannerID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](300) NULL,
	[Displayorder] [int] NULL,
	[active] [bit] NULL,
	[Imageurl] [varchar](300) NULL,
	[Filename] [varchar](300) NULL,
	[Target] [varchar](300) NULL,
	[StoreID] [int] NULL CONSTRAINT [DF_tb_SmallHomeBanner_StoreID]  DEFAULT ((1)),
 CONSTRAINT [PK_SmallHomeBannerGroup] PRIMARY KEY CLUSTERED 
(
	[SmallBannerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_StateTax]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_StateTax](
	[StateTaxID] [int] IDENTITY(1,1) NOT NULL,
	[TaxClassID] [int] NULL,
	[StateID] [int] NULL,
	[TaxRate] [money] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_StateTax] PRIMARY KEY CLUSTERED 
(
	[StateTaxID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Themes]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Themes](
	[ThemeID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NULL,
	[Color] [varchar](50) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_tb_Themes] PRIMARY KEY CLUSTERED 
(
	[ThemeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_VendorCatalog]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_VendorCatalog](
	[VendorCatalogID] [int] IDENTITY(1,1) NOT NULL,
	[VendorID] [int] NULL,
	[CatalogName] [nvarchar](200) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[ReleaseDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tb_VendorCatalog_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tb_VendorCatalog] PRIMARY KEY CLUSTERED 
(
	[VendorCatalogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_VendorOptions]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_VendorOptions](
	[VendorID] [int] NULL,
	[VendorPriority] [varchar](50) NULL,
	[ProductOptionID] [int] NULL,
	[VendorSKU] [varchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_VendorPayment]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_VendorPayment](
	[VendorPaymentID] [int] IDENTITY(1,1) NOT NULL,
	[VendorID] [int] NULL,
	[PaidBy] [nvarchar](50) NULL,
	[TransactionReference] [nvarchar](1000) NULL,
	[TransactionDate] [datetime] NULL,
	[PurchaseOrders] [nvarchar](500) NULL,
	[Note] [varchar](max) NULL,
	[POAmount] [money] NULL,
	[PaidAmount] [money] NULL,
 CONSTRAINT [PK__tb_VendorP__3B80C458] PRIMARY KEY CLUSTERED 
(
	[VendorPaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_VendorPaymentPurchaseOrder]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_VendorPaymentPurchaseOrder](
	[VendorPaymentID] [int] NOT NULL,
	[PONumber] [int] NOT NULL,
	[PaidAmount] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_WarehouseInventoryType]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_WarehouseInventoryType](
	[WarehouseInventoryTypeID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryTypeName] [nvarchar](50) NULL,
	[DisplayOrder] [int] NULL,
	[Active] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tb_MasterWarehouseInventory] PRIMARY KEY CLUSTERED 
(
	[WarehouseInventoryTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_WareHouseProduct]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_WareHouseProduct](
	[WareHouseID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Inventory] [int] NULL,
	[Price] [money] NULL,
	[SKU] [nvarchar](250) NULL,
	[Name] [nvarchar](500) NULL,
	[CreatedOn] [datetime] NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK_tb_WareHouseproduct] PRIMARY KEY CLUSTERED 
(
	[WareHouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_WareHouseProductInventory]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_WareHouseProductInventory](
	[ProductInventoryID] [int] IDENTITY(1,1) NOT NULL,
	[WareHouseID] [int] NULL,
	[ProductID] [int] NULL,
	[Inventory] [int] NULL,
	[PreferredLocation] [bit] NULL,
 CONSTRAINT [PK_tb_WareHouseProductInventory] PRIMARY KEY CLUSTERED 
(
	[ProductInventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_WareHouseProductVariantInventory]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_WareHouseProductVariantInventory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WareHouseID] [int] NULL,
	[ProductID] [int] NULL,
	[VariantID] [int] NULL,
	[VariantValueID] [int] NULL,
	[Inventory] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[PreferredLocation] [bit] NULL,
 CONSTRAINT [PK_tb_WareHouseProductVariantInventory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_WishListItems]    Script Date: 28-Dec-18 3:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_WishListItems](
	[WishListID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [money] NULL,
	[VariantNames] [varchar](500) NULL,
	[VariantValues] [varchar](500) NULL,
	[PackProductId] [nvarchar](500) NULL,
	[CreateDate] [datetime] NULL CONSTRAINT [DF_tb_WishListItems_CreateDate]  DEFAULT (getdate()),
	[RelatedproductID] [int] NULL,
	[IsProductType] [int] NULL,
 CONSTRAINT [PK_tb_WishListItems] PRIMARY KEY CLUSTERED 
(
	[WishListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tb_CustomerQuote] ADD  CONSTRAINT [DF_tb_CustomerQuote_IsRevised]  DEFAULT ((0)) FOR [IsRevised]
GO
ALTER TABLE [dbo].[tb_CustomerQuote] ADD  CONSTRAINT [DF_tb_CustomerQuote_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tb_EmailFolders] ADD  CONSTRAINT [DF_tb_EmailFolders_ParentFolderID]  DEFAULT ((0)) FOR [ParentFolderID]
GO
ALTER TABLE [dbo].[tb_EmailList] ADD  CONSTRAINT [DF_tb_EmailList_OrderNumber]  DEFAULT ((0)) FOR [OrderNumber]
GO
ALTER TABLE [dbo].[tb_EmailList] ADD  CONSTRAINT [DF_tb_EmailList_IsRead]  DEFAULT ((1)) FOR [IsRead]
GO
ALTER TABLE [dbo].[tb_EmailList] ADD  CONSTRAINT [DF_tb_EmailList_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[tb_EmailList] ADD  CONSTRAINT [DF_tb_EmailList_isSpam]  DEFAULT ((0)) FOR [isSpam]
GO
ALTER TABLE [dbo].[tb_ProductFrameColor_MST] ADD  CONSTRAINT [DF_tb_ProductFrameColor_MST_ParentId]  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [dbo].[tb_ProductFrameColor_MST] ADD  CONSTRAINT [DF_tb_ProductFrameColor_MST_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[tb_ProductFrameColor_MST] ADD  CONSTRAINT [DF_tb_ProductFrameColor_MST_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[tb_ProductFrameColor_MST] ADD  CONSTRAINT [DF_tb_ProductFrameColor_MST_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tb_ProductLensColor_MST] ADD  CONSTRAINT [DF_tb_ProductLensColor_MST_ParentId]  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [dbo].[tb_ProductLensColor_MST] ADD  CONSTRAINT [DF_tb_ProductLensColor_MST_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[tb_ProductLensColor_MST] ADD  CONSTRAINT [DF_tb_ProductLensColor_MST_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[tb_ProductLensColor_MST] ADD  CONSTRAINT [DF_tb_ProductLensColor_MST_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_FBWebLikes]  DEFAULT ((0)) FOR [FBWebLikes]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_FBNextSubmissionDays]  DEFAULT ((0)) FOR [FBNextSubmissionDays]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_IsPromotedonFB]  DEFAULT ((0)) FOR [IsPromotedonFB]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_TotalTweets]  DEFAULT ((0)) FOR [TotalTweets]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_TotalPins]  DEFAULT ((0)) FOR [TotalPins]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_TotalPinBoards]  DEFAULT ((0)) FOR [TotalPinBoards]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_PinNextSubmissionDays]  DEFAULT ((0)) FOR [PinNextSubmissionDays]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_InstNextSubmissionDays]  DEFAULT ((0)) FOR [InstNextSubmissionDays]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_FlickrNextSubmissionDays]  DEFAULT ((0)) FOR [FlickrNextSubmissionDays]
GO
ALTER TABLE [dbo].[tb_ProductSEOLog] ADD  CONSTRAINT [DF_tb_Product_SEO_Log_Createdon]  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[tb_PurchaseOrder] ADD  CONSTRAINT [DF_tb_PurchaseOrder_PoAmount]  DEFAULT ((0)) FOR [PoAmount]
GO
ALTER TABLE [dbo].[tb_PurchaseOrder] ADD  CONSTRAINT [DF_tb_PurchaseOrder_PaymentComplete]  DEFAULT ((0)) FOR [PaymentComplete]
GO
ALTER TABLE [dbo].[tb_WareHouseProduct] ADD  CONSTRAINT [DF_tb_WareHouseproduct_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tb_Category]  WITH CHECK ADD  CONSTRAINT [FK_tb_Category_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_Category] CHECK CONSTRAINT [FK_tb_Category_tb_Store]
GO
ALTER TABLE [dbo].[tb_Customer]  WITH CHECK ADD  CONSTRAINT [FK_tb_Customer_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_Customer] CHECK CONSTRAINT [FK_tb_Customer_tb_Store]
GO
ALTER TABLE [dbo].[tb_CustomerLevel]  WITH CHECK ADD  CONSTRAINT [FK_tb_CustomerLevel_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_CustomerLevel] CHECK CONSTRAINT [FK_tb_CustomerLevel_tb_Store]
GO
ALTER TABLE [dbo].[tb_EmailTemplate]  WITH CHECK ADD  CONSTRAINT [FK_tb_EmailTemplate_17may2013_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_EmailTemplate] CHECK CONSTRAINT [FK_tb_EmailTemplate_17may2013_tb_Store]
GO
ALTER TABLE [dbo].[tb_EmailTemplate]  WITH CHECK ADD  CONSTRAINT [FK_tb_EmailTemplate_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_EmailTemplate] CHECK CONSTRAINT [FK_tb_EmailTemplate_tb_Store]
GO
ALTER TABLE [dbo].[tb_GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_tb_GiftCard_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_GiftCard] CHECK CONSTRAINT [FK_tb_GiftCard_tb_Store]
GO
ALTER TABLE [dbo].[tb_GiftCardProduct]  WITH CHECK ADD  CONSTRAINT [FK_tb_GiftCardProduct_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_GiftCardProduct] CHECK CONSTRAINT [FK_tb_GiftCardProduct_tb_Store]
GO
ALTER TABLE [dbo].[tb_MailLog]  WITH CHECK ADD  CONSTRAINT [FK_tb_MailLog_tb_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[tb_Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[tb_MailLog] CHECK CONSTRAINT [FK_tb_MailLog_tb_Customer]
GO
ALTER TABLE [dbo].[tb_MailLog]  WITH CHECK ADD  CONSTRAINT [FK_tb_MailLog_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_MailLog] CHECK CONSTRAINT [FK_tb_MailLog_tb_Store]
GO
ALTER TABLE [dbo].[tb_Order]  WITH CHECK ADD  CONSTRAINT [FK_tb_Order_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_Order] CHECK CONSTRAINT [FK_tb_Order_tb_Store]
GO
ALTER TABLE [dbo].[tb_PurchaseOrder]  WITH CHECK ADD  CONSTRAINT [FK_tb_PurchaseOrder_tb_Vendor] FOREIGN KEY([VendorID])
REFERENCES [dbo].[tb_Vendor] ([VendorID])
GO
ALTER TABLE [dbo].[tb_PurchaseOrder] CHECK CONSTRAINT [FK_tb_PurchaseOrder_tb_Vendor]
GO
ALTER TABLE [dbo].[tb_Rating]  WITH CHECK ADD  CONSTRAINT [FK_tb_Rating_tb_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[tb_Product] ([ProductID])
GO
ALTER TABLE [dbo].[tb_Rating] CHECK CONSTRAINT [FK_tb_Rating_tb_Product]
GO
ALTER TABLE [dbo].[tb_Rating]  WITH CHECK ADD  CONSTRAINT [FK_tb_Rating_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_Rating] CHECK CONSTRAINT [FK_tb_Rating_tb_Store]
GO
ALTER TABLE [dbo].[tb_ShippingMethods]  WITH CHECK ADD  CONSTRAINT [FK_tb_ShippingMethods_tb_ShippingServices] FOREIGN KEY([ShippingServiceID])
REFERENCES [dbo].[tb_ShippingServices] ([ShippingServiceID])
GO
ALTER TABLE [dbo].[tb_ShippingMethods] CHECK CONSTRAINT [FK_tb_ShippingMethods_tb_ShippingServices]
GO
ALTER TABLE [dbo].[tb_SmallHomeBanner]  WITH CHECK ADD  CONSTRAINT [FK_tb_SmallHomeBanner_tb_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[tb_Store] ([StoreID])
GO
ALTER TABLE [dbo].[tb_SmallHomeBanner] CHECK CONSTRAINT [FK_tb_SmallHomeBanner_tb_Store]
GO
ALTER TABLE [dbo].[tb_StateTax]  WITH CHECK ADD  CONSTRAINT [FK_tb_StateTax_tb_State] FOREIGN KEY([StateID])
REFERENCES [dbo].[tb_State] ([StateID])
GO
ALTER TABLE [dbo].[tb_StateTax] CHECK CONSTRAINT [FK_tb_StateTax_tb_State]
GO
ALTER TABLE [dbo].[tb_StateTax]  WITH CHECK ADD  CONSTRAINT [FK_tb_StateTax_tb_TaxClass] FOREIGN KEY([TaxClassID])
REFERENCES [dbo].[tb_TaxClass] ([TaxClassID])
GO
ALTER TABLE [dbo].[tb_StateTax] CHECK CONSTRAINT [FK_tb_StateTax_tb_TaxClass]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 for other 1 for sunglass 2 for eyeglass' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_ShoppingCartItems', @level2type=N'COLUMN',@level2name=N'IsProductType'
GO
