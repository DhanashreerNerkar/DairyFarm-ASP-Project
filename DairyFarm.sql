USE [master]
GO
/****** Object:  Database [OnlineInvoiceBillingSystem1]    Script Date: 06-07-2020 22:39:47 ******/
CREATE DATABASE [OnlineInvoiceBillingSystem1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineInvoiceBillingSystem1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\OnlineInvoiceBillingSystem1.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'OnlineInvoiceBillingSystem1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\OnlineInvoiceBillingSystem1_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineInvoiceBillingSystem1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [OnlineInvoiceBillingSystem1]
GO
/****** Object:  StoredProcedure [dbo].[DeleteCartItem]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteCartItem] 
	-- Add the parameters for the stored procedure here
	@prm_unm nvarchar(50)='',
	@prm_upswd nvarchar(50)='',
	@prm_pid int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Tbl_Cart
	where 
	User_ID in (Select User_ID from Tbl_User where User_Name=@prm_unm and User_Pwd=@prm_upswd)
	and PID=@prm_pid 
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_rawmaterial]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_delete_rawmaterial]
	-- Add the parameters for the stored procedure here
	@prm_pid int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Tbl_RawMaterial where PID=@prm_pid
END

GO
/****** Object:  StoredProcedure [dbo].[sp_get_iddata]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_get_iddata] 
	@prm_pid int=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select * from Tbl_RawMaterial where PID=@prm_pid
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_orders]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_insert_orders] 
	-- Add the parameters for the stored procedure here
	   @prm_ono nvarchar(50)=null
       ,@prm_uid int=0
    --   ,@prm_unm nvarchar(50)=null
	   --,@prm_upswd nvarchar(50)=null
	   ,@prm_pid int=0
       ,@prm_ppr int=0 
       ,@prm_qty int=0

	  
	   
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here		 
	--set @prm_uid= (Select @prm_uid from Tbl_User where User_Name=@prm_unm and User_Pwd=@prm_upswd)

	INSERT INTO Tbl_Orders(Order_No,User_ID,Date,PID,Quantity,ProductTotal) 
	VALUES(
	@prm_ono,
	@prm_uid,
	getdate(),
	@prm_pid,
	@prm_qty,
	@prm_ppr*@prm_qty 
	) 
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_rawaterial]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_rawaterial]
	-- Add the parameters for the stored procedure here
	@prm_pcd nvarchar(50)='',
	@prm_pnm nvarchar(50)='',
	@prm_ppr int=0,
	@prm_pimg nvarchar(1000)=''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
	insert into Tbl_RawMaterial(PCode,PName,PPrice,PImage) values(@prm_pcd,@prm_pnm,@prm_ppr,@prm_pimg)
END

GO
/****** Object:  StoredProcedure [dbo].[sp_searched_item]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_searched_item]
	-- Add the parameters for the stored procedure here
	@prm_search_item nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Tbl_RawMaterial WHERE PName LIKE '%' + @prm_search_item + '%'
END

GO
/****** Object:  StoredProcedure [dbo].[sp_update_rawmaterial]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_update_rawmaterial] 
	-- Add the parameters for the stored procedure here
	@prm_pid int=0,
	@prm_pcd nvarchar(50)='',
	@prm_pnm nvarchar(50)='',
	@prm_ppr int=0,
	@prm_pimg nvarchar(1000)=''
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
	update Tbl_RawMaterial	set PCode=@prm_pcd,PName=@prm_pnm,PPrice=@prm_ppr,PImage=@prm_pimg 
	where PID=@prm_pid
END

GO
/****** Object:  StoredProcedure [dbo].[sp_usercart]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_usercart]
	@prm_username nvarchar(50)=null,
	@prm_userpswd nvarchar(50)=null,
	@prm_itemid int=0, 
	@prm_date nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO Tbl_Cart(User_ID,PID,Date)
	VALUES ((SELECT User_ID FROM Tbl_User WHERE User_Name=@prm_username and User_Pwd=@prm_userpswd),@prm_itemid
	,@prm_date)

END

GO
/****** Object:  StoredProcedure [dbo].[sp_validate_user]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_validate_user]
	-- Add the parameters for the stored procedure here
	@prm_unm nvarchar(50)='',
	@prm_upwd nvarchar(50)=''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select count (*) as cnt from Tbl_User where User_Name=@prm_unm and User_Pwd=@prm_upwd
END

GO
/****** Object:  StoredProcedure [dbo].[sp_view_cart]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_view_cart] 
	-- Add the parameters for the stored procedure here
	  @prm_unm nvarchar(50)='',
	  @prm_upwd nvarchar(50)=''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--select * from Tbl_RawMaterial Where PID in
--(select C.PID from Tbl_Cart C INNER JOIN Tbl_User U on C.User_ID=U.User_ID where U.User_ID in 
--(Select User_ID from Tbl_User where User_Name=@prm_unm and User_Pwd=@prm_upwd))

SELECT 
Tbl_Cart.Cart_ID, Tbl_Cart.PID, Tbl_Cart.User_ID, 
Tbl_RawMaterial.PCode, Tbl_RawMaterial.PName, Tbl_RawMaterial.PPrice, Tbl_RawMaterial.PImage, Tbl_RawMaterial.Quantity
FROM   Tbl_Cart INNER JOIN
             Tbl_RawMaterial ON Tbl_Cart.PID = Tbl_RawMaterial.PID INNER JOIN
             Tbl_User ON Tbl_Cart.User_ID = Tbl_User.User_ID and Tbl_Cart.User_ID in 
			 (Select u.USER_ID from Tbl_User u where u.User_Name=@prm_unm and u.User_Pwd=@prm_upwd)
	  

END

GO
/****** Object:  StoredProcedure [dbo].[sp_view_order]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_view_order]
	-- Add the parameters for the stored procedure here
	@prm_ordernum nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT r.PName,r.PPrice,o.Quantity,o.ProductTotal
		from Tbl_Orders o inner join Tbl_RawMaterial r
			on o.PID=r.PID
	where o.Order_No=@prm_ordernum
END

GO
/****** Object:  StoredProcedure [dbo].[sp_view_rawmaterial]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_view_rawmaterial]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   select * from Tbl_RawMaterial
END

GO
/****** Object:  Table [dbo].[Tbl_Cart]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Cart](
	[Cart_ID] [int] IDENTITY(1,1) NOT NULL,
	[PID] [int] NULL,
	[User_ID] [int] NULL,
	[Date] [nvarchar](15) NULL,
 CONSTRAINT [PK_Tbl_Cart] PRIMARY KEY CLUSTERED 
(
	[Cart_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ControlTable]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ControlTable](
	[Ordernumber] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Orders]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Orders](
	[Order_ID] [int] IDENTITY(1,1) NOT NULL,
	[Order_No] [nvarchar](50) NULL,
	[User_ID] [int] NULL,
	[Date] [datetime] NULL,
	[PID] [int] NULL,
	[Quantity] [int] NULL,
	[ProductTotal] [float] NULL,
 CONSTRAINT [PK_Tbl_Orders] PRIMARY KEY CLUSTERED 
(
	[Order_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_RawMaterial]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_RawMaterial](
	[PID] [int] IDENTITY(1,1) NOT NULL,
	[PCode] [nvarchar](50) NULL,
	[PName] [nvarchar](50) NULL,
	[PPrice] [int] NOT NULL,
	[PImage] [nvarchar](1000) NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_Tbl_RawMaterial] PRIMARY KEY CLUSTERED 
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_User]    Script Date: 06-07-2020 22:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_User](
	[User_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_Name] [nvarchar](50) NULL,
	[User_Pwd] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tbl_User] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Tbl_ControlTable] ADD  CONSTRAINT [DF_Tbl_ControlTable_Ordernumber]  DEFAULT ((0)) FOR [Ordernumber]
GO
USE [master]
GO
ALTER DATABASE [OnlineInvoiceBillingSystem1] SET  READ_WRITE 
GO
