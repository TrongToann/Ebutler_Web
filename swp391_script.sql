USE [master]
GO
DROP DATABASE [SWP391_Project]
GO
CREATE DATABASE [SWP391_Project] 
GO
USE [SWP391_Project]
----------------------------------------------------------------
-----USER ROLE-----
CREATE TABLE tblUserRole
(
	[role_ID] [nvarchar](10) PRIMARY KEY NOT NULL ,
	[role_Name] [nvarchar](20) UNIQUE NOT NULL ,
	[description] [nvarchar](Max)
)
GO

-----USER-----
CREATE TABLE tblUser
(
	username nvarchar(30) PRIMARY KEY,
	[password] nvarchar(30) NOT NULL,
	role_ID nvarchar(10) NOT NULL,
	[phone] nvarchar(11),
	[email] [nvarchar](30),
	[status] [decimal](1)
)
GO

CREATE TABLE tblCustomer
(
	[username] nvarchar(30) PRIMARY KEY,
	[password] [nvarchar](30) NOT NULL,
	[role_ID] [nvarchar](10) REFERENCES tblUserRole(role_ID) NOT NULL,
	[phone] nvarchar(11) NOT NULL,
	[email] [nvarchar](30) UNIQUE NOT NULL,
	[name] nvarchar(30) NOT NULL,
	gender [int],
	dob date,
	avatar nvarchar(max),
	point [decimal](9),
	[status] [decimal](1)
)
GO

CREATE TABLE tblProvider
(
	[username] nvarchar(30) PRIMARY KEY,
	[password] [nvarchar](30) NOT NULL,
	[role_ID] [nvarchar](10) REFERENCES tblUserRole(role_ID) NOT NULL,
	[phone] [nvarchar](11) UNIQUE ,
	[email] [nvarchar](30) UNIQUE ,
	[name] nvarchar(30) UNIQUE NOT NULL,
	[logo] nvarchar(max) ,
	[status] [decimal](1)
)
GO

-----ADDRESS-----
CREATE TABLE tblProvince_City
(
	[province_Name] [nvarchar](25) UNIQUE NOT NULL,
	[province_ID] [nvarchar](10) PRIMARY KEY
)
GO

CREATE TABLE tblDistrict
(
	[district_ID] nvarchar(10) PRIMARY KEY,
	[city_name] [nvarchar](35) NOT NULL ,
	[prefix] nvarchar(20) ,
	[province_ID] nvarchar(10) REFERENCES tblProvince_City([province_ID])
)
GO

CREATE TABLE tblAddress
(
	[address_ID] [int] IDENTITY(1,1) PRIMARY KEY ,
	street nvarchar(max) ,
	[district_ID] nvarchar(10) REFERENCES tblDistrict([district_ID]) NOT NULL ,
	[user_ID] nvarchar(30) REFERENCES tblUser(username) NOT NULL,
	[status] int
)
GO


-----PRODUCT-----
CREATE TABLE tblProductCategory
(
	category_ID nvarchar(10) PRIMARY KEY NOT NULL ,
	[name] nvarchar(20) UNIQUE NOT NULL,
	[image] [nvarchar](max) NOT NULL
)
GO

CREATE TABLE tblProduct
(
	product_ID nvarchar(10) PRIMARY KEY NOT NULL ,
	category_ID nvarchar(10) REFERENCES tblProductCategory(category_ID) NOT NULL,
	[name] nvarchar(60) UNIQUE NOT NULL,
	[image] nvarchar(max) NOT NULL,
)
GO

CREATE TABLE tblProductDetail
(
	id [int] IDENTITY(1,1) PRIMARY KEY ,
	provider_ID nvarchar(30) REFERENCES tblProvider(username) NOT NULL,
	product_ID nvarchar(10) REFERENCES tblProduct(product_ID) NOT NULL ,
	[name] nvarchar(60) NOT NULL,
	quantity decimal(2) NOT NULL,
	price decimal (9) NOT NULL,
	[image] nvarchar(max) ,
	[description] nvarchar(max) ,
	[status] decimal(1) NOT NULL
)
GO

-----ORDER-----
CREATE TABLE tblOrder
(
	order_ID [int] IDENTITY(1,1) PRIMARY KEY ,
	order_Date [date] NOT NULL ,
	customer_ID nvarchar(30) REFERENCES tblCustomer(username) NOT NULL,
	[status] decimal(1) NOT NULL  ,
	total decimal(9) NOT NULL,
	payment nvarchar(10),
)
GO

CREATE TABLE tblOrder_Product_Detail
(
	id [int] IDENTITY(1,1) PRIMARY KEY ,
	product_detail_ID [int] REFERENCES tblProductDetail(id) NOT NULL,
	order_ID [int] REFERENCES tblOrder(order_ID) NOT NULL ,
	quantity decimal(2) NOT NULL ,
	price decimal(9) NOT NULL ,
	[status] decimal(1) NOT NULL
)
GO

-----SERVICE-----
CREATE TABLE tblServiceCategory
(
	category_ID nvarchar(10) PRIMARY KEY NOT NULL ,
	[name] nvarchar(20) UNIQUE NOT NULL ,
	[image] nvarchar(max)
)
GO

CREATE TABLE tblService
(
	service_ID nvarchar(30) PRIMARY KEY NOT NULL ,
	category_ID nvarchar(10) REFERENCES tblServiceCategory(category_ID) NOT NULL,
	[name] nvarchar(40) UNIQUE NOT NULL ,
	[image] nvarchar(max)
)
GO

--STAFF
CREATE TABLE tblStaff
(
	staff_ID [int] IDENTITY(1,1) PRIMARY KEY ,
	provider_ID nvarchar(30) REFERENCES tblProvider(username) NOT NULL,
	service_ID nvarchar(30) REFERENCES tblService(service_ID) NOT NULL,
	[name] nvarchar(40) NOT NULL,
	[id_card] nvarchar(12) NOT NULL UNIQUE,
	[avatar] nvarchar(max),
	[status] decimal(1) NOT NULL,
)

GO


CREATE TABLE tblServiceDetail
(
	id [int] IDENTITY(1,1) PRIMARY KEY ,
	provider_ID nvarchar(30) REFERENCES tblProvider(username) NOT NULL ,
	service_ID nvarchar(30) REFERENCES tblService(service_ID) NOT NULL ,
	staff_ID [int] REFERENCES tblStaff(staff_ID),
	[name] nvarchar(30) NOT NULL ,
	[price] decimal(9) NOT NULL ,
	[description] nvarchar(max)  ,
	[status] decimal(1) NOT NULL
)
GO

CREATE TABLE tblOrder_Service_Detail
(
	id [int] IDENTITY(1,1) PRIMARY KEY ,
	staff_ID [int] REFERENCES tblStaff(staff_ID) NOT NULL ,
	service_Detail_ID [int] REFERENCES tblServiceDetail(id) NOT NULL ,
	order_ID [int] REFERENCES tblOrder(order_ID) NOT NULL ,
	price decimal(9) NOT NULL ,
	[status] decimal(1) NOT NULL
)
GO

-----REVENUE-----
CREATE TABLE tblRevenueByYear
(
	[year] decimal(4) PRIMARY KEY NOT NULL ,
	order_Count decimal(2) NOT NULL,
	role_Detail_Count decimal(2) NOT NULL,
	total decimal(9) NOT NULL
)
GO

CREATE TABLE tblRevenueByMonth
(
	revenue_Month_ID nvarchar(6) PRIMARY KEY NOT NULL ,
	[year] decimal(4) REFERENCES tblRevenueByYear(year) ,
	order_Count decimal(2) NOT NULL,
	role_Detail_Count decimal(2) NOT NULL,
	[month] decimal(2) NOT NULL ,
	propotion decimal(5,3) NOT NULL ,
	total decimal(9) NOT NULL
)
GO

-----ADMIN-----
CREATE TABLE tblAdminMaster
(
	[user_Name] nvarchar(30) PRIMARY KEY NOT NULL ,
	[password] nvarchar(30) NOT NULL
)
GO

CREATE TABLE tblAdminRole
(
	role_ID nvarchar(6) PRIMARY KEY NOT NULL ,
	role_Name nvarchar(20) UNIQUE NOT NULL
) 
GO

CREATE TABLE tblAdmin
(
	[user_Name] nvarchar(30) PRIMARY KEY NOT NULL ,
	password nvarchar(30) NOT NULL ,
	role_ID nvarchar(6) REFERENCES tblAdminRole(role_ID) NOT NULL
)
GO

CREATE TABLE tblDeliveryNotification (
	id int IDENTITY(1, 1) PRIMARY KEY,
	time datetime,
	username nvarchar(30),
	message nvarchar(max)
)

--- DELIVERY --
CREATE TABLE tblShipper
(
	username nvarchar(30) PRIMARY KEY,
	[password] nvarchar(30),
	[name] nvarchar(30),
	[phone] nvarchar(11),
	[MRC] nvarchar(6),
	[status] int,
	wallet decimal(12)
)
GO

CREATE TABLE tblDelivery
(
	id int IDENTITY(1,1) PRIMARY KEY,
	order_id int REFERENCES tblOrder(order_ID),
	address nvarchar(max),
	username_Shipper nvarchar(30) REFERENCES tblShipper(username),
	[status] int
)
GO

CREATE TABLE tblShipperIncome
(
	id int IDENTITY(1,1) PRIMARY KEY,
	[month] int,
	[year] int,
	shipper_id nvarchar(30) REFERENCES tblShipper(username),
	total decimal(12)
)
GO

CREATE TABLE tblReviewProduct
(
	id int IDENTITY(1,1) PRIMARY KEY,
	username nvarchar(30) REFERENCES tblCustomer(username),
	product_id int REFERENCES tblProductDetail(id),
	comment nvarchar(max),
	rating int,
	[status] int
)
GO

------------------------------------------------------- TRIGGER ---------------------------------------------------------------
--- bảng customer: đăng ký account -> cập nhật bảng user
CREATE TRIGGER trig_cus_insert ON tblCustomer 
FOR INSERT
AS
BEGIN
	DECLARE @username nvarchar(30), @password nvarchar(30), @role_ID nvarchar(10), @phone nvarchar (11), @email nvarchar(30), @status decimal(1)

	SELECT @username = username, @password = password, @role_ID = role_ID, @phone = phone, @email = email, @status = status
	FROM inserted

	INSERT INTO tblUser
		(username, password, role_ID, phone, email, status)
	VALUES
		(@username, @password, @role_ID, @phone, @email, @status)
END;
GO

--- bảng customer: chỉnh sửa thông tin -> cập nhật bảng user
CREATE TRIGGER trig_cus_updateStatus ON tblCustomer 
AFTER UPDATE
AS
BEGIN
	DECLARE @username nvarchar(30), @password nvarchar(30), @phone nvarchar (11), @email nvarchar(30), @status decimal(1)

	SELECT @username = username, @password = password, @phone = phone, @email = email, @status = status
	FROM inserted

	UPDATE tblUser SET password = @password, phone = @phone, email = @email,  status = @status WHERE username LIKE @username
END;
GO

--- bảng provider: đăng ký account -> cập nhật bảng user
CREATE TRIGGER trig_pro_insert ON tblProvider 
FOR INSERT
AS
BEGIN
	DECLARE @username nvarchar(30), @password nvarchar(30), @role_ID nvarchar(10), @phone nvarchar (11), @email nvarchar(30), @status decimal(1)

	SELECT @username = username, @password = password, @role_ID = role_ID, @phone = phone, @email = email, @status = status
	FROM inserted

	INSERT INTO tblUser
		(username, password, role_ID, phone, email, status)
	VALUES
		(@username, @password, @role_ID, @phone, @email, @status)
END;
GO

--- bảng provider: chỉnh sửa thông tin -> cập nhật bảng user
CREATE TRIGGER trig_pro_updateStatus ON tblProvider 
AFTER UPDATE
AS
BEGIN

	DECLARE @username nvarchar(30), @password nvarchar(30), @phone nvarchar (11), @email nvarchar(30), @status decimal(1)

	SELECT @username = username, @password = password, @phone = phone, @email = email, @status = status
	FROM inserted

	UPDATE tblUser SET password = @password, phone = @phone, email = @email,  status = @status WHERE username = @username
END;
GO

--- bảng shipper: tạo account -> cập nhật bảng user
CREATE TRIGGER trig_shipper_insert ON tblShipper
FOR INSERT
AS
BEGIN
	DECLARE @username nvarchar(30), @password nvarchar(30), @status decimal(1)

	SELECT @username = username, @password = password, @status = status
	FROM inserted

	INSERT INTO tblUser
		(username, password, role_ID, status)
	VALUES
		(@username, @password, 'SHIP', @status)
END;
GO

--- bảng provider: chỉnh sửa thông tin -> cập nhật bảng user
CREATE TRIGGER trig_shipper_updateStatus ON tblShipper 
AFTER UPDATE
AS
BEGIN

	DECLARE @username nvarchar(30), @status decimal(1)

	SELECT @username = username, @status = status
	FROM inserted

	UPDATE tblUser SET status = @status WHERE username = @username
END;
GO

-------- shipper income ---------
CREATE TRIGGER trig_shipper_income ON tblDelivery
AFTER UPDATE
AS
BEGIN
	IF (select COUNT(*)
	from inserted
	where status = 3) = 0
	RETURN

	DECLARE @order_date date, @order_id int, @price decimal(12), @shipper_id nvarchar(30)

	SELECT @order_id = order_id, @shipper_id = username_Shipper
	FROM inserted;

	SELECT @order_date = o.order_date
	FROM tblOrder o
	WHERE o.order_ID = @order_id

	SET @price = (select sum(price * quantity)
	from tblOrder_Product_Detail
	where order_ID = @order_id)*0.03

	IF (select COUNT(*)
	from tblShipperIncome sibm
	where MONTH(@order_date) = sibm.month and YEAR(@order_date) = sibm.year and @shipper_id = sibm.shipper_id) = 0
	BEGIN
		INSERT INTO tblShipperIncome
			(month, year, shipper_id, total)
		values
			(MONTH(@order_date), YEAR(@order_date), @shipper_id , @price)
	END
	ELSE
	BEGIN
		UPDATE tblShipperIncome SET total = total + @price WHERE month = MONTH(@order_date) and year = YEAR(@order_date) and shipper_id = @shipper_id
	END
END;
GO

-------------------- tblDeliveryNOtification -----------------
CREATE TRIGGER trig_delivery_notify ON tblDelivery
AFTER UPDATE, INSERT
AS
BEGIN
	DECLARE @insert int, @update int
	
	select @update = COUNT(*) from inserted where status = 3
	
	select @insert = COUNT(*) from inserted where status = 0 and username_Shipper IS NULL
	
	IF (@insert = 0 and @update = 0) RETURN

	DECLARE @time datetime, @username nvarchar(30), @message nvarchar(max), @status int

	SELECT @username = o.customer_ID, @status = i.status
	FROM inserted i JOIN tblOrder o ON i.order_id = o.order_ID;
	
	SET @time = CURRENT_TIMESTAMP
	
	IF (@status = 3)
	BEGIN
		SET @message = 'has received order on assigned address'
	END
	ELSE IF(@status = 0)
	BEGIN
		SET @message = 'has created new order on assigned address'
	END
	
	INSERT INTO tblDeliveryNotification(time, username, message) VALUES (@time, @username, @message)
END;
GO
-------------------------------------------------------- INSERT -----------------------------------------------------------------
-- bảng role

INSERT INTO tblUserRole
	(role_ID, role_Name, description)
VALUES
	('CUS', 'Customer', 'Welcome to shopping and using our service, manage your home, your building facilities')
INSERT INTO tblUserRole
	(role_ID, role_Name, description)
VALUES
	('PRO', 'Provider', 'Experience our services to promote products and make profits')

--Bảng thông tin provider 
--Theo Product
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('bach_hoa_xanh' , '12345678' , 'PRO', '0344350704' , 'bachhoaxanhne@gmail.com', 'Bach Hoa Xanh', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('dien_may_cho_lon' , '12345678' , 'PRO', '0344350888' , 'dienmaycholonne@gmail.com', 'Dien May Cho Lon', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('cho_tot_tot' , '12345678' , 'PRO', '0344350987' , 'chototsieutot@gmail.com', 'Cho Tot', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('homepurnish' , '12345678' , 'PRO', '0344353379' , 'homefurnishings@gmail.com', 'Home Furnishings', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('zarahome' , '12345678' , 'PRO', '0366357979' , 'zarahome@gmail.com', 'Zara Home', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('homefurniture' , '12345678' , 'PRO', '0966397979' , 'homeFurniture@gmail.com', 'Home Furniture', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('getintouch' , '12345678' , 'PRO', '0966694321' , 'getintouch@gmail.com', 'Get In Touch', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('petro' , '12345678' , 'PRO', '0966691234' , 'petro@gmail.com', 'Petro', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('minhchau' , '12345678' , 'PRO', '0966691235' , 'minhchau@gmail.com', 'Minh Chau Ceramic', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
--Theo Service
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('fptcompany' , '12345678' , 'PRO', '0966697979' , 'fptcompany@gmail.com', 'FPT', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('moveronline' , '12345678' , 'PRO', '0918154849' , 'moveOnline@gmail.com', 'Mover Online', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('electrician' , '12345678' , 'PRO', '0918145999' , 'elec@gmail.com', 'Electrician', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('homecleaning' , '12345678' , 'PRO', '0918149999' , 'homecleaning@gmail.com', 'Home Cleaning', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('homeimprovement' , '12345678' , 'PRO', '0918134948' , 'homeimprovement@gmail.com', 'Home Improvement', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('plumbers' , '12345678' , 'PRO', '0918134945' , 'plumbers@gmail.com', 'Plumbers', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('laundry' , '12345678' , 'PRO', '0918134947' , 'dryClean@gmail.com', 'Laundry / Dry Clean', 'https://thumbs.dreamstime.com/z/card-kitchen-shelves-cooking-utensils-retro-style-51223757.jpg', 1)
INSERT INTO tblProvider
	(username, password , role_ID , phone , email , name , logo , status)
VALUES
	('michelin_car_service' , '12345678' , 'PRO', '0918234947' , 'michelinlincar@gmail.com', 'Michelin Car Service', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIjRrt9Oxl-E2NTsmLUEX4rKFou5rEpwWt9K1P44AGM9jgvcbrC6cJiPZ69SyvsAEmaGY&usqp=CAU', 1)

-- Bảng tỉnh/thành
INSERT INTO tblProvince_City
	([province_Name], [province_ID])
VALUES
	(N'Hồ Chí Minh', '1'),
	(N'Hà Nội', '2'),
	(N'Đà Nẵng', '3'),
	(N'Bình Dương', '4'),
	( N'Đồng Nai', '5'),
	(N'Khánh Hòa', '6'),
	(N'Hải Phòng', '7'),
	(N'Long An', '8'),
	(N'Quảng Nam', '9'),
	(N'Bà Rịa Vũng Tàu', '10'),
	(N'Đăk Lăk', '11'),
	(N'Cần Thơ', '12'),
	(N'Bình Thuận ', '13'),
	(N'Lâm Đồng', '14'),
	(N'Thừa Thiên Huế', '15'),
	(N'Kiên Giang', '16'),
	( N'Bắc Ninh', '17'),
	(N'Quảng Ninh', '18'),
	(N'Thanh Hoa', '19'),
	( N'Nghệ An', '20'),
	(N'Hải Dương', '21'),
	(N'Gia Lai', '22'),
	(N'Bình Phước', '23'),
	(N'Hưng Yên', '24'),
	( N'Bình Định', '25'),
	(N'Tiền Giang', '26'),
	(N'Thái Bình', '27'),
	(N'Bắc Giang', '28'),
	(N'Hoà Bình', '29'),
	( N'An Giang', '30'),
	( N'Vĩnh Phúc', '31'),
	( N'Tây Ninh', '32'),
	(N'Thái Nguyên', '33'),
	(N'Lào Cai', '34'),
	(N'Nam Định', '35'),
	(N'Quang Ngãi', '36'),
	(N'Bến Tre', '37'),
	(N'Đắk Nông', '38'),
	(N'Cà Mau', '39'),
	(N'Vĩnh Long', '40'),
	(N'Ninh Bình', '41'),
	(N'Phú Thọ', '42'),
	(N'Ninh Thuận', '43'),
	(N'Phú Yên', '44'),
	(N'Hà Nam', '45'),
	(N'Hà Tĩnh', '46'),
	(N'Đồng Tháp', '47'),
	(N'Sóc Trăng', '48'),
	(N'Kon Tum', '49'),
	(N'Quãng Bình', '50'),
	(N'Quãng Trị', '51'),
	(N'Trà Vinh', '52'),
	(N'Hậu Giang', '53'),
	(N'Sơn La', '54'),
	(N'Bắc Liêu', '55'),
	(N'Yên Bái', '56'),
	( N'Tuyên Quang', '57'),
	( N'Điện Biên', '58'),
	(N'Lai Châu', '59'),
	(N'Lạng Sơn', '60'),
	(N'Hà Giang', '61'),
	(N'Bắc Kạn', '62'),
	(N'Cao Bằng', '63');
-- bảng địa chỉ
INSERT INTO tblDistrict
	([district_ID], [city_name], prefix, [province_ID])
VALUES
	(1, N'Bình Chánh', N'Huyện', 1),
	(2, N'Bình Tân', N'Quận', 1),
	(3, N'Bình Thạnh', N'Quận', 1),
	(4, N'Cần Giờ', N'Huyện', 1),
	(5, N'Củ Chi', N'Huyện', 1),
	(6, N'Gò Vấp', N'Quận', 1),
	(7, N'Hóc Môn', N'Huyện', 1),
	(8, N'Nhà Bè', N'Huyện', 1),
	(9, N'Phú Nhuận', N'Quận', 1),
	(10, N'Quận 1', N'Quận', 1),
	(11, N'Quận 10', N'Quận', 1),
	(12, N'Quận 11', N'Quận', 1),
	(13, N'Quận 12', N'Quận', 1),
	(14, N'Quận 2', N'Quận', 1),
	(15, N'Quận 3', N'Quận', 1),
	(16, N'Quận 4', N'Quận', 1),
	(17, N'Quận 5', N'Quận', 1),
	(18, N'Quận 6', N'Quận', 1),
	(19, N'Quận 7', N'Quận', 1),
	(20, N'Quận 8', N'Quận', 1),
	(21, N'Quận 9', N'Quận', 1),
	(22, N'Tân Bình', N'Quận', 1),
	(23, N'Tân Phú', N'Quận', 1),
	(24, N'Thủ Đức', N'Quận', 1),
	(25, N'Ba Đình', N'Quận', 2),
	(26, N'Ba Vì', N'Huyện', 2),
	(27, N'Bắc Từ Liêm', N'Quận', 2),
	(28, N'Cầu Giấy', N'Quận', 2),
	(29, N'Chương Mỹ', N'Huyện', 2),
	(30, N'Đan Phượng', N'Huyện', 2),
	(31, N'Đông Anh', N'Huyện', 2),
	(32, N'Đống Đa', N'Quận', 2),
	(33, N'Gia Lâm', N'Huyện', 2),
	(34, N'Hà Đông', N'Quận', 2),
	(35, N'Hai Bà Trưng', N'Quận', 2),
	(36, N'Hoài Đức', N'Huyện', 2),
	(37, N'Hoàn Kiếm', N'Quận', 2),
	(38, N'Hoàng Mai', N'Quận', 2),
	(39, N'Long Biên', N'Quận', 2),
	(40, N'Mê Linh', N'Huyện', 2),
	(41, N'Mỹ Đức', N'Huyện', 2),
	(42, N'Nam Từ Liêm', N'Quận', 2),
	(43, N'Phú Xuyên', N'Huyện', 2),
	(44, N'Phúc Thọ', N'Huyện', 2),
	(45, N'Quốc Oai', N'Huyện', 2),
	(46, N'Sóc Sơn', N'Huyện', 2),
	(47, N'Sơn Tây', N'Thị xã', 2),
	(48, N'Tây Hồ', N'Quận', 2),
	(49, N'Thạch Thất', N'Huyện', 2),
	(50, N'Thanh Oai', N'Huyện', 2),
	(51, N'Thanh Trì', N'Huyện', 2),
	(52, N'Thanh Xuân', N'Quận', 2),
	(53, N'Thường Tín', N'Huyện', 2),
	(54, N'Ứng Hòa', N'Huyện', 2),
	(55, N'Cẩm Lệ', N'Quận', 3),
	(56, N'Hải Châu', N'Quận', 3),
	(57, N'Hòa Vang', N'Huyện', 3),
	(58, N'Hoàng Sa', N'Huyện', 3),
	(59, N'Liên Chiểu', N'Quận', 3),
	(60, N'Ngũ Hành Sơn', N'Quận', 3),
	(61, N'Sơn Trà', N'Quận', 3),
	(62, N'Thanh Khê', N'Quận', 3),
	(63, N'Bàu Bàng', N'Huyện', 4),
	(64, N'Bến Cát', N'Thị xã', 4),
	(65, N'Dầu Tiếng', N'Huyện', 4),
	(66, N'Dĩ An', N'Thị xã', 4),
	(67, N'Phú Giáo', N'Huyện', 4),
	(68, N'Tân Uyên', N'Huyện', 4),
	(69, N'Thủ Dầu Một', N'Thị xã', 4),
	(70, N'Thuận An', N'Huyện', 4),
	(71, N'Biên Hòa', N'Thành phố', 5),
	(72, N'Cẩm Mỹ', N'Huyện', 5),
	(73, N'Định Quán', N'Huyện', 5),
	(74, N'Long Khánh', N'Thị xã', 5),
	(75, N'Long Thành', N'Huyện', 5),
	(76, N'Nhơn Trạch', N'Huyện', 5),
	(77, N'Tân Phú', N'Quận', 5),
	(78, N'Thống Nhất', N'Huyện', 5),
	(79, N'Trảng Bom', N'Huyện', 5),
	(80, N'Vĩnh Cửu', N'Huyện', 5),
	(81, N'Xuân Lộc', N'Huyện', 5),
	(82, N'Cam Lâm', N'Huyện', 6),
	(83, N'Cam Ranh', N'Thành phố', 6),
	(84, N'Diên Khánh', N'Huyện', 6),
	(85, N'Khánh Sơn', N'Huyện', 6),
	(86, N'Khánh Vĩnh', N'Huyện', 6),
	(87, N'Nha Trang', N'Thành phố', 6),
	(88, N'Ninh Hòa', N'Thị xã', 6),
	(89, N'Trường Sa', N'Huyện', 6),
	(90, N'Vạn Ninh', N'Huyện', 6),
	(91, N'An Dương', N'Huyện', 7),
	(92, N'An Lão', N'Huyện', 7),
	(93, N'Bạch Long Vĩ', N'Huyện', 7),
	(94, N'Cát Hải', N'Huyện', 7),
	(95, N'Đồ Sơn', N'Quận', 7),
	(96, N'Dương Kinh', N'Quận', 7),
	(97, N'Hải An', N'Quận', 7),
	(98, N'Hồng Bàng', N'Quận', 7),
	(99, N'Kiến An', N'Quận', 7),
	(100, N'Kiến Thụy', N'Huyện', 7),
	(101, N'Lê Chân', N'Quận', 7),
	(102, N'Ngô Quyền', N'Quận', 7),
	(103, N'Thủy Nguyên', N'Huyện', 7),
	(104, N'Tiên Lãng', N'Huyện', 7),
	(105, N'Vĩnh Bảo', N'Huyện', 7),
	(106, N'Bến Lức', N'Huyện', 8),
	(107, N'Cần Đước', N'Huyện', 8),
	(108, N'Cần Giuộc', N'Huyện', 8),
	(109, N'Châu Thành', N'Huyện', 8),
	(110, N'Đức Hòa', N'Huyện', 8),
	(111, N'Đức Huệ', N'Huyện', 8),
	(112, N'Kiến Tường', N'Thị xã', 8),
	(113, N'Mộc Hóa', N'Huyện', 8),
	(114, N'Tân An', N'Thành phố', 8),
	(115, N'Tân Hưng', N'Huyện', 8),
	(116, N'Tân Thạnh', N'Huyện', 8),
	(117, N'Tân Trụ', N'Huyện', 8),
	(118, N'Thạnh Hóa', N'Huyện', 8),
	(119, N'Thủ Thừa', N'Huyện', 8),
	(120, N'Vĩnh Hưng', N'Huyện', 8),
	(121, N'Bắc Trà My', N'Huyện', 9),
	(122, N'Đại Lộc', N'Huyện', 9),
	(123, N'Điện Bàn', N'Huyện', 9),
	(124, N'Đông Giang', N'Huyện', 9),
	(125, N'Duy Xuyên', N'Huyện', 9),
	(126, N'Hiệp Đức', N'Huyện', 9),
	(127, N'Hội An', N'Thành phố', 9),
	(128, N'Nam Giang', N'Huyện', 9),
	(129, N'Nam Trà My', N'Huyện', 9),
	(130, N'Nông Sơn', N'Huyện', 9),
	(131, N'Núi Thành', N'Huyện', 9),
	(132, N'Phú Ninh', N'Huyện', 9),
	(133, N'Phước Sơn', N'Huyện', 9),
	(134, N'Quế Sơn', N'Huyện', 9),
	(135, N'Tam Kỳ', N'Thành phố', 9),
	(136, N'Tây Giang', N'Huyện', 9),
	(137, N'Thăng Bình', N'Huyện', 9),
	(138, N'Tiên Phước', N'Huyện', 9),
	(139, N'Bà Rịa', N'Thị xã', 10),
	(140, N'Châu Đức', N'Huyện', 10),
	(141, N'Côn Đảo', N'Huyện', 10),
	(142, N'Đất Đỏ', N'Huyện', 10),
	(143, N'Long Điền', N'Huyện', 10),
	(144, N'Tân Thành', N'Huyện', 10),
	(145, N'Vũng Tàu', N'Thành phố', 10),
	(146, N'Xuyên Mộc', N'Huyện', 10),
	(147, N'Buôn Đôn', N'Huyện', 11),
	(148, N'Buôn Hồ', N'Thị xã', 11),
	(149, N'Buôn Ma Thuột', N'Thành phố', 11),
	(150, N'Cư Kuin', N'Huyện', 11),
	(151, N'Cư M\gar', N'Huyện', 11),
	(152, N'Ea H\Leo', N'Huyện', 11),
	(153, N'Ea Kar', N'Huyện', 11),
	(154, N'Ea Súp', N'Huyện', 11),
	(155, N'Krông Ana', N'Huyện', 11),
	(156, N'Krông Bông', N'Huyện', 11),
	(157, N'Krông Buk', N'Huyện', 11),
	(158, N'Krông Năng', N'Huyện', 11),
	(159, N'Krông Pắc', N'Huyện', 11),
	(160, N'Lăk', N'Huyện', 11),
	(161, N'M\Đrăk', N'Huyện', 11),
	(162, N' Thới Lai', N'Huyện', 12),
	(163, N'Bình Thủy', N'Quận', 12),
	(164, N'Cái Răng', N'Quận', 12),
	(165, N'Cờ Đỏ', N'Huyện', 12),
	(166, N'Ninh Kiều', N'Quận', 12),
	(167, N'Ô Môn', N'Quận', 12),
	(168, N'Phong Điền', N'Huyện', 12),
	(169, N'Thốt Nốt', N'Quận', 12),
	(170, N'Vĩnh Thạnh', N'Huyện', 12),
	(171, N'Bắc Bình', N'Huyện', 13),
	(172, N'Đảo Phú Quý', N'Huyện', 13),
	(173, N'Đức Linh', N'Huyện', 13),
	(174, N'Hàm Tân', N'Huyện', 13),
	(175, N'Hàm Thuận Bắc', N'Huyện', 13),
	(176, N'Hàm Thuận Nam', N'Huyện', 13),
	(177, N'La Gi', N'Thị xã', 13),
	(178, N'Phan Thiết', N'Thành phố', 13),
	(179, N'Tánh Linh', N'Huyện', 13),
	(180, N'Tuy Phong', N'Huyện', 13),
	(181, N'Bảo Lâm', N'Huyện', 14),
	(182, N'Bảo Lộc', N'Thành phố', 14),
	(183, N'Cát Tiên', N'Huyện', 14),
	(184, N'Đạ Huoai', N'Huyện', 14),
	(185, N'Đà Lạt', N'Thành phố', 14),
	(186, N'Đạ Tẻh', N'Huyện', 14),
	(187, N'Đam Rông', N'Huyện', 14),
	(188, N'Di Linh', N'Huyện', 14),
	(189, N'Đơn Dương', N'Huyện', 14),
	(190, N'Đức Trọng', N'Huyện', 14),
	(191, N'Lạc Dương', N'Huyện', 14),
	(192, N'Lâm Hà', N'Huyện', 14),
	(193, N'A Lưới', N'Huyện', 15),
	(194, N'Huế', N'Thành phố', 15),
	(195, N'Hương Thủy', N'Thị xã', 15),
	(196, N'Hương Trà', N'Huyện', 15),
	(197, N'Nam Đông', N'Huyện', 15),
	(198, N'Phong Điền', N'Huyện', 15),
	(199, N'Phú Lộc', N'Huyện', 15),
	(200, N'Phú Vang', N'Huyện', 15),
	(201, N'Quảng Điền', N'Huyện', 15),
	(202, N'An Biên', N'Huyện', 16),
	(203, N'An Minh', N'Huyện', 16),
	(204, N'Châu Thành', N'Huyện', 16),
	(205, N'Giang Thành', N'Huyện', 16),
	(206, N'Giồng Riềng', N'Huyện', 16),
	(207, N'Gò Quao', N'Huyện', 16),
	(208, N'Hà Tiên', N'Thị xã', 16),
	(209, N'Hòn Đất', N'Huyện', 16),
	(210, N'Kiên Hải', N'Huyện', 16),
	(211, N'Kiên Lương', N'Huyện', 16),
	(212, N'Phú Quốc', N'Huyện', 16),
	(213, N'Rạch Giá', N'Thành phố', 16),
	(214, N'Tân Hiệp', N'Huyện', 16),
	(215, N'U minh Thượng', N'Huyện', 16),
	(216, N'Vĩnh Thuận', N'Huyện', 16),
	(217, N'Bắc Ninh', N'Thành phố', 17),
	(218, N'Gia Bình', N'Huyện', 17),
	(219, N'Lương Tài', N'Huyện', 17),
	(220, N'Quế Võ', N'Huyện', 17),
	(221, N'Thuận Thành', N'Huyện', 17),
	(222, N'Tiên Du', N'Huyện', 17),
	(223, N'Từ Sơn', N'Thị xã', 17),
	(224, N'Yên Phong', N'Huyện', 17),
	(225, N'Ba Chẽ', N'Huyện', 18),
	(226, N'Bình Liêu', N'Huyện', 18),
	(227, N'Cẩm Phả', N'Thành phố', 18),
	(228, N'Cô Tô', N'Huyện', 18),
	(229, N'Đầm Hà', N'Huyện', 18),
	(230, N'Đông Triều', N'Huyện', 18),
	(231, N'Hạ Long', N'Thành phố', 18),
	(232, N'Hải Hà', N'Huyện', 18),
	(233, N'Hoành Bồ', N'Huyện', 18),
	(234, N'Móng Cái', N'Thành phố', 18),
	(235, N'Quảng Yên', N'Huyện', 18),
	(236, N'Tiên Yên', N'Huyện', 18),
	(237, N'Uông Bí', N'Thị xã', 18),
	(238, N'Vân Đồn', N'Huyện', 18),
	(239, N'Bá Thước', N'Huyện', 19),
	(240, N'Bỉm Sơn', N'Thị xã', 19),
	(241, N'Cẩm Thủy', N'Huyện', 19),
	(242, N'Đông Sơn', N'Huyện', 19),
	(243, N'Hà Trung', N'Huyện', 19),
	(244, N'Hậu Lộc', N'Huyện', 19),
	(245, N'Hoằng Hóa', N'Huyện', 19),
	(246, N'Lang Chánh', N'Huyện', 19),
	(247, N'Mường Lát', N'Huyện', 19),
	(248, N'Nga Sơn', N'Huyện', 19),
	(249, N'Ngọc Lặc', N'Huyện', 19),
	(250, N'Như Thanh', N'Huyện', 19),
	(251, N'Như Xuân', N'Huyện', 19),
	(252, N'Nông Cống', N'Huyện', 19),
	(253, N'Quan Hóa', N'Huyện', 19),
	(254, N'Quan Sơn', N'Huyện', 19),
	(255, N'Quảng Xương', N'Huyện', 19),
	(256, N'Sầm Sơn', N'Thị xã', 19),
	(257, N'Thạch Thành', N'Huyện', 19),
	(258, N'Thanh Hóa', N'Thành phố', 19),
	(259, N'Thiệu Hóa', N'Huyện', 19),
	(260, N'Thọ Xuân', N'Huyện', 19),
	(261, N'Thường Xuân', N'Huyện', 19),
	(262, N'Tĩnh Gia', N'Huyện', 19),
	(263, N'Triệu Sơn', N'Huyện', 19),
	(264, N'Vĩnh Lộc', N'Huyện', 19),
	(265, N'Yên Định', N'Huyện', 19),
	(266, N'Anh Sơn', N'Huyện', 20),
	(267, N'Con Cuông', N'Huyện', 20),
	(268, N'Cửa Lò', N'Thị xã', 20),
	(269, N'Diễn Châu', N'Huyện', 20),
	(270, N'Đô Lương', N'Huyện', 20),
	(271, N'Hoàng Mai', N'Thị xã', 20),
	(272, N'Hưng Nguyên', N'Huyện', 20),
	(273, N'Kỳ Sơn', N'Huyện', 20),
	(274, N'Nam Đàn', N'Huyện', 20),
	(275, N'Nghi Lộc', N'Huyện', 20),
	(276, N'Nghĩa Đàn', N'Huyện', 20),
	(277, N'Quế Phong', N'Huyện', 20),
	(278, N'Quỳ Châu', N'Huyện', 20),
	(279, N'Quỳ Hợp', N'Huyện', 20),
	(280, N'Quỳnh Lưu', N'Huyện', 20),
	(281, N'Tân Kỳ', N'Huyện', 20),
	(282, N'Thái Hòa', N'Thị xã', 20),
	(283, N'Thanh Chương', N'Huyện', 20),
	(284, N'Tương Dương', N'Huyện', 20),
	(285, N'Vinh', N'Thành phố', 20),
	(286, N'Yên Thành', N'Huyện', 20),
	(287, N'Bình Giang', N'Huyện', 21),
	(288, N'Cẩm Giàng', N'Huyện', 21),
	(289, N'Chí Linh', N'Thị xã', 21),
	(290, N'Gia Lộc', N'Huyện', 21),
	(291, N'Hải Dương', N'Thành phố', 21),
	(292, N'Kim Thành', N'Huyện', 21),
	(293, N'Kinh Môn', N'Huyện', 21),
	(294, N'Nam Sách', N'Huyện', 21),
	(295, N'Ninh Giang', N'Huyện', 21),
	(296, N'Thanh Hà', N'Huyện', 21),
	(297, N'Thanh Miện', N'Huyện', 21),
	(298, N'Tứ Kỳ', N'Huyện', 21),
	(299, N'An Khê', N'Thị xã', 22),
	(300, N'AYun Pa', N'Thị xã', 22),
	(301, N'Chư Păh', N'Huyện', 22),
	(302, N'Chư Pưh', N'Huyện', 22),
	(303, N'Chư Sê', N'Huyện', 22),
	(304, N'ChưPRông', N'Huyện', 22),
	(305, N'Đăk Đoa', N'Huyện', 22),
	(306, N'Đăk Pơ', N'Huyện', 22),
	(307, N'Đức Cơ', N'Huyện', 22),
	(308, N'Ia Grai', N'Huyện', 22),
	(309, N'Ia Pa', N'Huyện', 22),
	(310, N'KBang', N'Huyện', 22),
	(311, N'Kông Chro', N'Huyện', 22),
	(312, N'Krông Pa', N'Huyện', 22),
	(313, N'Mang Yang', N'Huyện', 22),
	(314, N'Phú Thiện', N'Huyện', 22),
	(315, N'Plei Ku', N'Thành phố', 22),
	(316, N'Bình Long', N'Thị xã', 23),
	(317, N'Bù Đăng', N'Huyện', 23),
	(318, N'Bù Đốp', N'Huyện', 23),
	(319, N'Bù Gia Mập', N'Huyện', 23),
	(320, N'Chơn Thành', N'Huyện', 23),
	(321, N'Đồng Phú', N'Huyện', 23),
	(322, N'Đồng Xoài', N'Thị xã', 23),
	(323, N'Hớn Quản', N'Huyện', 23),
	(324, N'Lộc Ninh', N'Huyện', 23),
	(325, N'Phú Riềng', N'Huyện', 23),
	(326, N'Phước Long', N'Thị xã', 23),
	(327, N'Ân Thi', N'Huyện', 24),
	(328, N'Hưng Yên', N'Thành phố', 24),
	(329, N'Khoái Châu', N'Huyện', 24),
	(330, N'Kim Động', N'Huyện', 24),
	(331, N'Mỹ Hào', N'Huyện', 24),
	(332, N'Phù Cừ', N'Huyện', 24),
	(333, N'Tiên Lữ', N'Huyện', 24),
	(334, N'Văn Giang', N'Huyện', 24),
	(335, N'Văn Lâm', N'Huyện', 24),
	(336, N'Yên Mỹ', N'Huyện', 24),
	(337, N'An Lão', N'Huyện', 25),
	(338, N'An Nhơn', N'Huyện', 25),
	(339, N'Hoài Ân', N'Huyện', 25),
	(340, N'Hoài Nhơn', N'Huyện', 25),
	(341, N'Phù Cát', N'Huyện', 25),
	(342, N'Phù Mỹ', N'Huyện', 25),
	(343, N'Quy Nhơn', N'Thành phố', 25),
	(344, N'Tây Sơn', N'Huyện', 25),
	(345, N'Tuy Phước', N'Huyện', 25),
	(346, N'Vân Canh', N'Huyện', 25),
	(347, N'Vĩnh Thạnh', N'Huyện', 25),
	(348, N'Cái Bè', N'Huyện', 26),
	(349, N'Cai Lậy', N'Thị xã', 26),
	(350, N'Châu Thành', N'Huyện', 26),
	(351, N'Chợ Gạo', N'Huyện', 26),
	(352, N'Gò Công', N'Thị xã', 26),
	(353, N'Gò Công Đông', N'Huyện', 26),
	(354, N'Gò Công Tây', N'Huyện', 26),
	(355, N'Huyện Cai Lậy', N'Huyện', 26),
	(356, N'Mỹ Tho', N'Thành phố', 26),
	(357, N'Tân Phú Đông', N'Huyện', 26),
	(358, N'Tân Phước', N'Huyện', 26),
	(359, N'Đông Hưng', N'Huyện', 27),
	(360, N'Hưng Hà', N'Huyện', 27),
	(361, N'Kiến Xương', N'Huyện', 27),
	(362, N'Quỳnh Phụ', N'Huyện', 27),
	(363, N'Thái Bình', N'Thành phố', 27),
	(364, N'Thái Thuỵ', N'Huyện', 27),
	(365, N'Tiền Hải', N'Huyện', 27),
	(366, N'Vũ Thư', N'Huyện', 27),
	(367, N'Bắc Giang', N'Thành phố', 28),
	(368, N'Hiệp Hòa', N'Huyện', 28),
	(369, N'Lạng Giang', N'Huyện', 28),
	(370, N'Lục Nam', N'Huyện', 28),
	(371, N'Lục Ngạn', N'Huyện', 28),
	(372, N'Sơn Động', N'Huyện', 28),
	(373, N'Tân Yên', N'Huyện', 28),
	(374, N'Việt Yên', N'Huyện', 28),
	(375, N'Yên Dũng', N'Huyện', 28),
	(376, N'Yên Thế', N'Huyện', 28),
	(377, N'Cao Phong', N'Huyện', 29),
	(378, N'Đà Bắc', N'Huyện', 29),
	(379, N'Hòa Bình', N'Thành phố', 29),
	(380, N'Kim Bôi', N'Huyện', 29),
	(381, N'Kỳ Sơn', N'Huyện', 29),
	(382, N'Lạc Sơn', N'Huyện', 29),
	(383, N'Lạc Thủy', N'Huyện', 29),
	(384, N'Lương Sơn', N'Huyện', 29),
	(385, N'Mai Châu', N'Huyện', 29),
	(386, N'Tân Lạc', N'Huyện', 29),
	(387, N'Yên Thủy', N'Huyện', 29),
	(388, N'An Phú', N'Huyện', 30),
	(389, N'Châu Đốc', N'Thị xã', 30),
	(390, N'Châu Phú', N'Huyện', 30),
	(391, N'Châu Thành', N'Huyện', 30),
	(392, N'Chợ Mới', N'Huyện', 30),
	(393, N'Long Xuyên', N'Thành phố', 30),
	(394, N'Phú Tân', N'Huyện', 30),
	(395, N'Tân Châu', N'Thị xã', 30),
	(396, N'Thoại Sơn', N'Huyện', 30),
	(397, N'Tịnh Biên', N'Huyện', 30),
	(398, N'Tri Tôn', N'Huyện', 30),
	(399, N'Bình Xuyên', N'Huyện', 31),
	(400, N'Lập Thạch', N'Huyện', 31),
	(401, N'Phúc Yên', N'Thị xã', 31),
	(402, N'Sông Lô', N'Huyện', 31),
	(403, N'Tam Đảo', N'Huyện', 31),
	(404, N'Tam Dương', N'Huyện', 31),
	(405, N'Vĩnh Tường', N'Huyện', 31),
	(406, N'Vĩnh Yên', N'Thành phố', 31),
	(407, N'Yên Lạc', N'Huyện', 31),
	(408, N'Bến Cầu', N'Huyện', 32),
	(409, N'Châu Thành', N'Huyện', 32),
	(410, N'Dương Minh Châu', N'Huyện', 32),
	(411, N'Gò Dầu', N'Huyện', 32),
	(412, N'Hòa Thành', N'Huyện', 32),
	(413, N'Tân Biên', N'Huyện', 32),
	(414, N'Tân Châu', N'Huyện', 32),
	(415, N'Tây Ninh', N'Thị xã', 32),
	(416, N'Trảng Bàng', N'Huyện', 32),
	(417, N'Đại Từ', N'Huyện', 33),
	(418, N'Định Hóa', N'Huyện', 33),
	(419, N'Đồng Hỷ', N'Huyện', 33),
	(420, N'Phổ Yên', N'Huyện', 33),
	(421, N'Phú Bình', N'Huyện', 33),
	(422, N'Phú Lương', N'Huyện', 33),
	(423, N'Sông Công', N'Thị xã', 33),
	(424, N'Thái Nguyên', N'Thành phố', 33),
	(425, N'Võ Nhai', N'Huyện', 33),
	(426, N'Bắc Hà', N'Huyện', 34),
	(427, N'Bảo Thắng', N'Huyện', 34),
	(428, N'Bảo Yên', N'Huyện', 34),
	(429, N'Bát Xát', N'Huyện', 34),
	(430, N'Lào Cai', N'Thành phố', 34),
	(431, N'Mường Khương', N'Huyện', 34),
	(432, N'Sa Pa', N'Huyện', 34),
	(433, N'Văn Bàn', N'Huyện', 34),
	(434, N'Xi Ma Cai', N'Huyện', 34),
	(435, N'Giao Thủy', N'Huyện', 35),
	(436, N'Hải Hậu', N'Huyện', 35),
	(437, N'Mỹ Lộc', N'Huyện', 35),
	(438, N'Nam Định', N'Thành phố', 35),
	(439, N'Nam Trực', N'Huyện', 35),
	(440, N'Nghĩa Hưng', N'Huyện', 35),
	(441, N'Trực Ninh', N'Huyện', 35),
	(442, N'Vụ Bản', N'Huyện', 35),
	(443, N'Xuân Trường', N'Huyện', 35),
	(444, N'Ý Yên', N'Huyện', 35),
	(445, N'Ba Tơ', N'Huyện', 36),
	(446, N'Bình Sơn', N'Huyện', 36),
	(447, N'Đức Phổ', N'Huyện', 36),
	(448, N'Lý Sơn', N'Huyện', 36),
	(449, N'Minh Long', N'Huyện', 36),
	(450, N'Mộ Đức', N'Huyện', 36),
	(451, N'Nghĩa Hành', N'Huyện', 36),
	(452, N'Quảng Ngãi', N'Thành phố', 36),
	(453, N'Sơn Hà', N'Huyện', 36),
	(454, N'Sơn Tây', N'Huyện', 36),
	(455, N'Sơn Tịnh', N'Huyện', 36),
	(456, N'Tây Trà', N'Huyện', 36),
	(457, N'Trà Bồng', N'Huyện', 36),
	(458, N'Tư Nghĩa', N'Huyện', 36),
	(459, N'Ba Tri', N'Huyện', 37),
	(460, N'Bến Tre', N'Thành phố', 37),
	(461, N'Bình Đại', N'Huyện', 37),
	(462, N'Châu Thành', N'Huyện', 37),
	(463, N'Chợ Lách', N'Huyện', 37),
	(464, N'Giồng Trôm', N'Huyện', 37),
	(465, N'Mỏ Cày Bắc', N'Huyện', 37),
	(466, N'Mỏ Cày Nam', N'Huyện', 37),
	(467, N'Thạnh Phú', N'Huyện', 37),
	(468, N'Cư Jút', N'Huyện', 38),
	(469, N'Dăk GLong', N'Huyện', 38),
	(470, N'Dăk Mil', N'Huyện', 38),
	(471, N'Dăk R\Lấp', N'Huyện', 38),
	(472, N'Dăk Song', N'Huyện', 38),
	(473, N'Gia Nghĩa', N'Thị xã', 38),
	(474, N'Krông Nô', N'Huyện', 38),
	(475, N'Tuy Đức', N'Huyện', 38),
	(476, N'Cà Mau', N'Thành phố', 39),
	(477, N'Cái Nước', N'Huyện', 39),
	(478, N'Đầm Dơi', N'Huyện', 39),
	(479, N'Năm Căn', N'Huyện', 39),
	(480, N'Ngọc Hiển', N'Huyện', 39),
	(481, N'Phú Tân', N'Huyện', 39),
	(482, N'Thới Bình', N'Huyện', 39),
	(483, N'Trần Văn Thời', N'Huyện', 39),
	(484, N'U Minh', N'Huyện', 39),
	(485, N'Bình Minh', N'Huyện', 40),
	(486, N'Bình Tân', N'Quận', 40),
	(487, N'Long Hồ', N'Huyện', 40),
	(488, N'Mang Thít', N'Huyện', 40),
	(489, N'Tam Bình', N'Huyện', 40),
	(490, N'Trà Ôn', N'Huyện', 40),
	(491, N'Vĩnh Long', N'Thành phố', 40),
	(492, N'Vũng Liêm', N'Huyện', 40),
	(493, N'Gia Viễn', N'Huyện', 41),
	(494, N'Hoa Lư', N'Huyện', 41),
	(495, N'Kim Sơn', N'Huyện', 41),
	(496, N'Nho Quan', N'Huyện', 41),
	(497, N'Ninh Bình', N'Thành phố', 41),
	(498, N'Tam Điệp', N'Thị xã', 41),
	(499, N'Yên Khánh', N'Huyện', 41),
	(500, N'Yên Mô', N'Huyện', 41),
	(501, N'Cẩm Khê', N'Huyện', 42),
	(502, N'Đoan Hùng', N'Huyện', 42),
	(503, N'Hạ Hòa', N'Huyện', 42),
	(504, N'Lâm Thao', N'Huyện', 42),
	(505, N'Phù Ninh', N'Huyện', 42),
	(506, N'Phú Thọ', N'Thị xã', 42),
	(507, N'Tam Nông', N'Huyện', 42),
	(508, N'Tân Sơn', N'Huyện', 42),
	(509, N'Thanh Ba', N'Huyện', 42),
	(510, N'Thanh Sơn', N'Huyện', 42),
	(511, N'Thanh Thủy', N'Huyện', 42),
	(512, N'Việt Trì', N'Thành phố', 42),
	(513, N'Yên Lập', N'Huyện', 42),
	(514, N'Bác Ái', N'Huyện', 43),
	(515, N'Ninh Hải', N'Huyện', 43),
	(516, N'Ninh Phước', N'Huyện', 43),
	(517, N'Ninh Sơn', N'Huyện', 43),
	(518, N'Phan Rang - Tháp Chàm', N'Thành phố', 43),
	(519, N'Thuận Bắc', N'Huyện', 43),
	(520, N'Thuận Nam', N'Huyện', 43),
	(521, N'Đông Hòa', N'Huyện', 44),
	(522, N'Đồng Xuân', N'Huyện', 44),
	(523, N'Phú Hòa', N'Huyện', 44),
	(524, N'Sơn Hòa', N'Huyện', 44),
	(525, N'Sông Cầu', N'Thị xã', 44),
	(526, N'Sông Hinh', N'Huyện', 44),
	(527, N'Tây Hòa', N'Huyện', 44),
	(528, N'Tuy An', N'Huyện', 44),
	(529, N'Tuy Hòa', N'Thành phố', 44),
	(530, N'Bình Lục', N'Huyện', 45),
	(531, N'Duy Tiên', N'Huyện', 45),
	(532, N'Kim Bảng', N'Huyện', 45),
	(533, N'Lý Nhân', N'Huyện', 45),
	(534, N'Phủ Lý', N'Thành phố', 45),
	(535, N'Thanh Liêm', N'Huyện', 45),
	(536, N'Cẩm Xuyên', N'Huyện', 46),
	(537, N'Can Lộc', N'Huyện', 46),
	(538, N'Đức Thọ', N'Huyện', 46),
	(539, N'Hà Tĩnh', N'Thành phố', 46),
	(540, N'Hồng Lĩnh', N'Thị xã', 46),
	(541, N'Hương Khê', N'Huyện', 46),
	(542, N'Hương Sơn', N'Huyện', 46),
	(543, N'Kỳ Anh', N'Huyện', 46),
	(544, N'Lộc Hà', N'Huyện', 46),
	(545, N'Nghi Xuân', N'Huyện', 46),
	(546, N'Thạch Hà', N'Huyện', 46),
	(547, N'Vũ Quang', N'Huyện', 46),
	(548, N'Cao Lãnh', N'Thành phố', 47),
	(549, N'Châu Thành', N'Huyện', 47),
	(550, N'Hồng Ngự', N'Thị xã', 47),
	(551, N'Huyện Cao Lãnh', N'Huyện', 47),
	(552, N'Huyện Hồng Ngự', N'Huyện', 47),
	(553, N'Lai Vung', N'Huyện', 47),
	(554, N'Lấp Vò', N'Huyện', 47),
	(555, N'Sa Đéc', N'Thị xã', 47),
	(556, N'Tam Nông', N'Huyện', 47),
	(557, N'Tân Hồng', N'Huyện', 47),
	(558, N'Thanh Bình', N'Huyện', 47),
	(559, N'Tháp Mười', N'Huyện', 47),
	(560, N'Châu Thành', N'Huyện', 48),
	(561, N'Cù Lao Dung', N'Huyện', 48),
	(562, N'Kế Sách', N'Huyện', 48),
	(563, N'Long Phú', N'Huyện', 48),
	(564, N'Mỹ Tú', N'Huyện', 48),
	(565, N'Mỹ Xuyên', N'Huyện', 48),
	(566, N'Ngã Năm', N'Huyện', 48),
	(567, N'Sóc Trăng', N'Thành phố', 48),
	(568, N'Thạnh Trị', N'Huyện', 48),
	(569, N'Trần Đề', N'Huyện', 48),
	(570, N'Vĩnh Châu', N'Huyện', 48),
	(571, N'Đăk Glei', N'Huyện', 49),
	(572, N'Đăk Hà', N'Huyện', 49),
	(573, N'Đăk Tô', N'Huyện', 49),
	(574, N'Ia HDrai', N'Huyện', 49),
	(575, N'Kon Plông', N'Huyện', 49),
	(576, N'Kon Rẫy', N'Huyện', 49),
	(577, N'KonTum', N'Thành phố', 49),
	(578, N'Ngọc Hồi', N'Huyện', 49),
	(579, N'Sa Thầy', N'Huyện', 49),
	(580, N'Tu Mơ Rông', N'Huyện', 49),
	(581, N'Ba Đồn', N'Thị xã', 50),
	(582, N'Bố Trạch', N'Huyện', 50),
	(583, N'Đồng Hới', N'Thành phố', 50),
	(584, N'Lệ Thủy', N'Huyện', 50),
	(585, N'Minh Hóa', N'Huyện', 50),
	(586, N'Quảng Ninh', N'Huyện', 50),
	(587, N'Quảng Trạch', N'Huyện', 50),
	(588, N'Tuyên Hóa', N'Huyện', 50),
	(589, N'Cam Lộ', N'Huyện', 51),
	(590, N'Đa Krông', N'Huyện', 51),
	(591, N'Đảo Cồn cỏ', N'Huyện', 51),
	(592, N'Đông Hà', N'Thành phố', 51),
	(593, N'Gio Linh', N'Huyện', 51),
	(594, N'Hải Lăng', N'Huyện', 51),
	(595, N'Hướng Hóa', N'Huyện', 51),
	(596, N'Quảng Trị', N'Thị xã', 51),
	(597, N'Triệu Phong', N'Huyện', 51),
	(598, N'Vĩnh Linh', N'Huyện', 51),
	(599, N'Càng Long', N'Huyện', 52),
	(600, N'Cầu Kè', N'Huyện', 52),
	(601, N'Cầu Ngang', N'Huyện', 52),
	(602, N'Châu Thành', N'Huyện', 52),
	(603, N'Duyên Hải', N'Huyện', 52),
	(604, N'Tiểu Cần', N'Huyện', 52),
	(605, N'Trà Cú', N'Huyện', 52),
	(606, N'Trà Vinh', N'Thành phố', 52),
	(607, N'Châu Thành', N'Huyện', 53),
	(608, N'Châu Thành A', N'Huyện', 53),
	(609, N'Long Mỹ', N'Huyện', 53),
	(610, N'Ngã Bảy', N'Thị xã', 53),
	(611, N'Phụng Hiệp', N'Huyện', 53),
	(612, N'Vị Thanh', N'Thành phố', 53),
	(613, N'Vị Thủy', N'Huyện', 53),
	(614, N'Bắc Yên', N'Huyện', 54),
	(615, N'Mai Sơn', N'Huyện', 54),
	(616, N'Mộc Châu', N'Huyện', 54),
	(617, N'Mường La', N'Huyện', 54),
	(618, N'Phù Yên', N'Huyện', 54),
	(619, N'Quỳnh Nhai', N'Huyện', 54),
	(620, N'Sơn La', N'Thành phố', 54),
	(621, N'Sông Mã', N'Huyện', 54),
	(622, N'Sốp Cộp', N'Huyện', 54),
	(623, N'Thuận Châu', N'Huyện', 54),
	(624, N'Vân Hồ', N'Huyện', 54),
	(625, N'Yên Châu', N'Huyện', 54),
	(626, N'Bạc Liêu', N'Thành phố', 55),
	(627, N'Đông Hải', N'Huyện', 55),
	(628, N'Giá Rai', N'Huyện', 55),
	(629, N'Hòa Bình', N'Huyện', 55),
	(630, N'Hồng Dân', N'Huyện', 55),
	(631, N'Phước Long', N'Huyện', 55),
	(632, N'Vĩnh Lợi', N'Huyện', 55),
	(633, N'Lục Yên', N'Huyện', 56),
	(634, N'Mù Cang Chải', N'Huyện', 56),
	(635, N'Nghĩa Lộ', N'Thị xã', 56),
	(636, N'Trạm Tấu', N'Huyện', 56),
	(637, N'Trấn Yên', N'Huyện', 56),
	(638, N'Văn Chấn', N'Huyện', 56),
	(639, N'Văn Yên', N'Huyện', 56),
	(640, N'Yên Bái', N'Thành phố', 56),
	(641, N'Yên Bình', N'Huyện', 56),
	(642, N'Chiêm Hóa', N'Huyện', 57),
	(643, N'Hàm Yên', N'Huyện', 57),
	(644, N'Lâm Bình', N'Huyện', 57),
	(645, N'Na Hang', N'Huyện', 57),
	(646, N'Sơn Dương', N'Huyện', 57),
	(647, N'Tuyên Quang', N'Thành phố', 57),
	(648, N'Yên Sơn', N'Huyện', 57),
	(649, N'Điện Biên', N'Huyện', 58),
	(650, N'Điện Biên Đông', N'Huyện', 58),
	(651, N'Điện Biên Phủ', N'Thành phố', 58),
	(652, N'Mường Ảng', N'Huyện', 58),
	(653, N'Mường Chà', N'Huyện', 58),
	(654, N'Mường Lay', N'Thị xã', 58),
	(655, N'Mường Nhé', N'Huyện', 58),
	(656, N'Nậm Pồ', N'Huyện', 58),
	(657, N'Tủa Chùa', N'Huyện', 58),
	(658, N'Tuần Giáo', N'Huyện', 58),
	(659, N'Lai Châu', N'Thị xã', 59),
	(660, N'Mường Tè', N'Huyện', 59),
	(661, N'Nậm Nhùn', N'Huyện', 59),
	(662, N'Phong Thổ', N'Huyện', 59),
	(663, N'Sìn Hồ', N'Huyện', 59),
	(664, N'Tam Đường', N'Huyện', 59),
	(665, N'Tân Uyên', N'Huyện', 59),
	(666, N'Than Uyên', N'Huyện', 59),
	(667, N'Bắc Sơn', N'Huyện', 60),
	(668, N'Bình Gia', N'Huyện', 60),
	(669, N'Cao Lộc', N'Huyện', 60),
	(670, N'Chi Lăng', N'Huyện', 60),
	(671, N'Đình Lập', N'Huyện', 60),
	(672, N'Hữu Lũng', N'Huyện', 60),
	(673, N'Lạng Sơn', N'Thành phố', 60),
	(674, N'Lộc Bình', N'Huyện', 60),
	(675, N'Tràng Định', N'Huyện', 60),
	(676, N'Văn Lãng', N'Huyện', 60),
	(677, N'Văn Quan', N'Huyện', 60),
	(678, N'Bắc Mê', N'Huyện', 61),
	(679, N'Bắc Quang', N'Huyện', 61),
	(680, N'Đồng Văn', N'Huyện', 61),
	(681, N'Hà Giang', N'Thành phố', 61),
	(682, N'Hoàng Su Phì', N'Huyện', 61),
	(683, N'Mèo Vạc', N'Huyện', 61),
	(684, N'Quản Bạ', N'Huyện', 61),
	(685, N'Quang Bình', N'Huyện', 61),
	(686, N'Vị Xuyên', N'Huyện', 61),
	(687, N'Xín Mần', N'Huyện', 61),
	(688, N'Yên Minh', N'Huyện', 61),
	(689, N'Ba Bể', N'Huyện', 62),
	(690, N'Bắc Kạn', N'Thị xã', 62),
	(691, N'Bạch Thông', N'Huyện', 62),
	(692, N'Chợ Đồn', N'Huyện', 62),
	(693, N'Chợ Mới', N'Huyện', 62),
	(694, N'Na Rì', N'Huyện', 62),
	(695, N'Ngân Sơn', N'Huyện', 62),
	(696, N'Pác Nặm', N'Huyện', 62),
	(697, N'Bảo Lạc', N'Huyện', 63),
	(698, N'Bảo Lâm', N'Huyện', 63),
	(699, N'Cao Bằng', N'Thị xã', 63),
	(700, N'Hạ Lang', N'Huyện', 63),
	(701, N'Hà Quảng', N'Huyện', 63),
	(702, N'Hòa An', N'Huyện', 63),
	(703, N'Nguyên Bình', N'Huyện', 63),
	(704, N'Phục Hòa', N'Huyện', 63),
	(705, N'Quảng Uyên', N'Huyện', 63),
	(706, N'Thạch An', N'Huyện', 63),
	(707, N'Thông Nông', N'Huyện', 63),
	(708, N'Trà Lĩnh', N'Huyện', 63),
	(709, N'Trùng Khánh', N'Huyện', 63);

-- bảng loại sản phẩm theo khu vực

INSERT INTO tblProductCategory
	(category_ID, name, image)
VALUES
	('KC', 'Kitchen', 'https://png.pngtree.com/png-clipart/20220823/original/pngtree-cartoon-kitchen-png-png-image_8476833.png')
INSERT INTO tblProductCategory
	(category_ID, name, image)
VALUES
	('LVR', 'Living Room', 'https://static.vecteezy.com/system/resources/thumbnails/009/586/037/small/interior-moderm-living-room-isometric-view-3d-render-png.png')
INSERT INTO tblProductCategory
	(category_ID, name, image)
VALUES
	('BR', 'Bedroom', 'https://png.pngtree.com/png-clipart/20220823/original/pngtree-isentropic-bedroom-png-png-image_8474318.png')
INSERT INTO tblProductCategory
	(category_ID, name, image)
VALUES
	('OSH', 'Outside Home', 'https://png.pngtree.com/png-clipart/20220228/original/pngtree-yellow-flower-in-vase-png-image_7325173.png')
INSERT INTO tblProductCategory
	(category_ID, name, image)
VALUES
	('BAR', 'Bathroom', 'https://www.transparentpng.com/thumb/bathtub/bathtub-icons-png-10.png')

-- bảng loại sản phẩm
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('1', 'KC', 'Spoon', 'https://www.freeiconspng.com/thumbs/fork-and-knife-png/fork-and-knife-png-spoon--24.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('2', 'KC', 'Bowl', 'https://www.pngall.com/wp-content/uploads/2018/05/Bowl-PNG-Image.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('3', 'KC', 'Cooking Pot', 'https://www.pngall.com/wp-content/uploads/10/Cooking-Pot-PNG-Photos.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('4', 'KC', 'Rice Cooker', 'https://www.weightwatchers.com/us/shop/assets-proxy/weight-watchers/image/upload/q_auto/v1/prod/en-us-ec/static-asset/US_RICE_COOKER_520321-9969_TRANSPARENT_1200x1200.png?auto=webp')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('5', 'KC', 'Soap', 'https://pngimg.com/uploads/soap/soap_PNG55.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('6', 'KC', 'Gas', 'https://gas24h.com.vn/upload/products/2020/06/size2/1636352267-0-s-gas-xanh-duong.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('7', 'KC', 'Water Bottle', 'https://www.transparentpng.com/thumb/water-bottle/fO4Ttp-water-bottle-vector.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('8', 'KC', 'Fridge', 'https://www.fisherpaykel.com/dw/image/v2/BCJJ_PRD/on/demandware.static/-/Sites-fpa-master-catalog/default/dw65aad765/pdp/fp-02-RF730QZUVB1-10-mug-dp.png?sw=585&sh=706&sm=fit')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('9', 'KC', 'Food', 'https://freepngimg.com/save/13869-healthy-food-png-picture/740x560')

INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('10', 'LVR', 'Television', 'https://www.pngmart.com/files/7/LED-Television-PNG-Transparent.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('11', 'LVR', 'Table & Chair', 'https://png.pngtree.com/png-clipart/20220117/original/pngtree-simple-hand-painted-table-and-chair-transparent-material-png-image_7122618.png')

INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('12', 'BR', 'Bed', 'https://www.transparentpng.com/thumb/bed/luxury-leather-storage-bed-transparent-png-XlWqDj.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('13', 'BR', 'Curtain', 'https://blinckr.com/image/cache/catalog/Cotton%20Candy%20Fuschia%20Curtain/Cottoncandy%20Fuschia%20Curtain_Transparent-270x270.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('14', 'BR', 'Wardrobe & Mirror ', 'https://files.ekmcdn.com/ronzfurniture/images/roma-large-4-door-wardrobe-almirah-white-603453--2190-p.png?v=38ec6a49-65cb-49b2-b612-f4fc372582b7')

INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('15', 'BAR', 'Shower', 'https://www.nicepng.com/png/full/635-6350081_hot-water-shower-with-water-png.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('16', 'BAR', 'Dental Hygiene Tools', 'https://www.jennyngaidds.com/storage/app/media/stock/cleaning-tools.png')

INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('17', 'OSH', 'Flower Vase ', 'https://i.pinimg.com/originals/29/e3/e4/29e3e4350ee14bc5dcc5726c2d5c9ba7.png')
INSERT INTO tblProduct
	(product_ID, category_ID, name , image)
VALUES
	('18', 'OSH', 'Fire Extinguisher', 'https://freepngimg.com/save/140738-fire-extinguisher-vector-hd-image-free/1181x2115')

--Bảng sản phẩm chi tiết theo từng sản phẩm cứng 


INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '1', 'Dinner Spoon Silver', 50, 3, 'https://masflex.com.ph/wp-content/uploads/2021/04/YS-83.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '1', 'Cake Fork Silver', 50, 2, 'https://img.christofle.com/image/upload/s--2MQbtDgo--/c_limit,dpr_2.0,f_auto,h_500,q_auto,w_500/media/catalog/product/C/a/Cake_20fork_20America_20_20Silver_20plated_00001046000101_F_2_1.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '1', 'Tea Spoon Gold', 50, 8, 'https://www.nicepng.com/png/full/137-1375331_milano-tea-spoon-gold-plated-gold-spoon-png.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '1', 'Tea Spoon Wooden Gold', 50, 7, 'https://cdn-amz.woka.io/images/I/71VDt3URLML._SR720,720_.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '1', 'Tea Spoon Chrome', 50, 6, 'https://www.wmf-professional.com/media/catalog/product/cache/2/image/508x/040ec09b1e35df139433887a97daa66f/5/4/5483726040.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '1', 'Table Knife Gold', 50, 5, 'https://img.christofle.com/image/upload/s--1noiI0BK--/c_limit,dpr_2.0,f_auto,h_500,q_auto,w_500/Products/02327012001101_STQ_qvsbbn.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '1', ' Dinner Fork Gold', 50, 3, 'https://img.christofle.com/image/upload/s--2Wk8N2t9--/c_limit,dpr_2.0,f_auto,h_500,q_auto,w_500/Products/354003_F_pnpdg2.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '1', 'Table Knife Gold', 50, 5, 'https://groupeabp.com/wp-content/uploads/product_images/4079.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '1', ' Dinner Fork Gold', 50, 3, 'https://img.christofle.com/image/upload/s--2Wk8N2t9--/c_limit,dpr_2.0,f_auto,h_500,q_auto,w_500/Products/354003_F_pnpdg2.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '2', 'Speckle Rice Bowl White', 50, 4, 'http://cdn.shopify.com/s/files/1/2270/8601/products/ace6984-hr_vrij_01_grande.png?v=1632137970' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '2', 'Speckle Rice Bowl Blue', 50, 3, 'https://assets.kogan.com/images/butlerco/BTR-505m/1-f198e87c17-505m-removebg-preview.png?auto=webp&canvas=340%2C226&fit=bounds&height=226&quality=90&width=340' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '2', 'Platinum Rim Salad Bowl Ivory', 50, 8, 'https://cdn.shopify.com/s/files/1/0253/0590/7299/products/312895010059_Plumes_or_Coupe_salade_Individual_salad_bowl_1024x1024@2x.png?v=1622543521' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '2', 'Botanical Salad Bowl Green', 50, 7, 'https://chairish-prod.freetls.fastly.net/image/product/master/f7dab701-5b6b-44f9-9abc-70f743e60edf/1990s-mikasa-queens-garden-ivy-leaf-pattern-salad-serving-set-5-pieces-1865' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '2', 'Regale Soup Bowl Black & Gold', 50, 6, 'https://sslimages.shoppersstop.com/sys-master/images/h75/hd2/8899184197662/9633369_9999.png_2000Wx3000H' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '2', 'Polka Soup Bowl', 50, 5, 'https://cdn.shopify.com/s/files/1/1317/9515/products/IMG_20150929_210249_edit_1024x1024@2x.png?v=1536599901' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '2', 'Nurina Cereal Bowl Dcream', 50, 7, 'https://www.seekpng.com/png/detail/990-9900037_800-x-596-8-cereal-bowl-with-cereal.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '2', 'Wooden Bowl', 50, 5, 'https://lofory.com/wp-content/uploads/2021/11/Natural-Wooden-Salad-Bowl-6.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '2', 'Ceramic Bowl', 50, 12, 'https://static.vecteezy.com/system/resources/previews/009/664/965/non_2x/empty-porcelain-ceramic-bowl-on-transparent-background-file-free-png.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
---------------
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '3', 'Ferric Iron Fry Pan', 50, 9, 'https://hellokitchen.com.au/wp-content/uploads/2021/09/PC220312-2.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '3', 'Ferric Cast Iron Kadai Black', 50, 9, 'https://mrbutlers.com/pub/media/catalog/product/cache/cf2a296d1dbef50483d61587672f6c7d/p/n/pngs-fileartboard-7_1.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '3', 'Classic Deep Pan', 50, 6, 'https://vietnamshine.com/wp-content/uploads/2017/11/ih-classic-deep-pan-26cm.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '3', 'Pietra-e-legno Sauce Pot', 50, 7, 'https://services.electrolux-medialibrary.com/118ed4c0ee6546f4a7684c7fef8c985aNrZmYkM861d1f/view/WS_PN/PSAAPL170PE00007.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '3', 'Classic Deep Pan', 50, 9, 'https://vietnamshine.com/wp-content/uploads/2017/11/ih-classic-deep-pan-26cm.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '3', 'Gourmet Sauce Pot', 50, 10, 'https://www.aegnewzealand.co.nz/remote.jpg.ashx?width=3200&urlb64=aHR0cHM6Ly9yZXNvdXJjZS5lbGVjdHJvbHV4LmNvbS5hdS9QdWJsaWMvSW1hZ2UyL3Byb2R1Y3QvMjgzMjUvNTIxMTAvQkUtQUVHSGVyb0Nhcm91c2VsL0FFR0hlcm9DYXJvdXNlbC5wbmc&hmac=iqIYRok8jtw' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '3', 'Classic Cooking Pot 22cm', 50, 15, 'https://cdn11.bigcommerce.com/s-1fdhnzvx71/images/stencil/532x532/products/128/407/PSL31320I_2017_10_27_20_11_39_UTC__22917.1581348822.386.513__17625.1588179770.png?c=1' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '3', 'Classic Cooking Pot 26cm', 50, 20, 'https://cdn11.bigcommerce.com/s-1fdhnzvx71/images/stencil/532x532/products/127/404/PSL31320I_2017_10_27_20_11_39_UTC__78759.1581349083.386.513__48351.1588179416.png?c=1' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '3', 'Maximus Cooking Pot ', 50, 12, 'https://www.dehomebiz.com.my/image/dehomebiz/image/cache/data/all_product_images/product-729/morphy_richards_562010_multi_cooker_photo_10-810x585.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '3', 'Pro-x Deep Cooking Pot', 50, 12, 'https://media.prod.bunnings.com.au/api/public/content/29487e61f0614b409cf652abc5d3fc00?v=17f6a09f&t=w500dpr1' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '3', 'Forever Sauce Pan', 50, 12, 'https://cdn11.bigcommerce.com/s-jta5lqjn53/images/stencil/532x532/products/573/1084/6720c__56824.1581430091.png?c=1' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '3', 'Marburg Grill Pan Black', 50, 12, 'https://assets.kogan.com/images/sirjohnsgifts/SJG-1331223855140/1-1907e02c68-107190.png?auto=webp&canvas=340%2C226&fit=bounds&height=226&quality=90&width=340' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '3', 'Ferric Iron Fry Pan', 50, 9, 'https://hellokitchen.com.au/wp-content/uploads/2021/09/PC220312-2.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('minhchau', '3', 'Ferric Cast Iron Kadai Black', 50, 9, 'https://mrbutlers.com/pub/media/catalog/product/cache/cf2a296d1dbef50483d61587672f6c7d/p/n/pngs-fileartboard-7_1.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '3', 'Classic Deep Pan', 50, 6, 'https://vietnamshine.com/wp-content/uploads/2017/11/ih-classic-deep-pan-26cm.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '3', 'Pietra-e-legno Sauce Pot', 50, 7, 'https://services.electrolux-medialibrary.com/118ed4c0ee6546f4a7684c7fef8c985aNrZmYkM861d1f/view/WS_PN/PSAAPL170PE00007.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '3', 'Classic Deep Pan', 50, 9, 'https://vietnamshine.com/wp-content/uploads/2017/11/ih-classic-deep-pan-26cm.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '3', 'Gourmet Sauce Pot', 50, 10, 'https://www.aegnewzealand.co.nz/remote.jpg.ashx?width=3200&urlb64=aHR0cHM6Ly9yZXNvdXJjZS5lbGVjdHJvbHV4LmNvbS5hdS9QdWJsaWMvSW1hZ2UyL3Byb2R1Y3QvMjgzMjUvNTIxMTAvQkUtQUVHSGVyb0Nhcm91c2VsL0FFR0hlcm9DYXJvdXNlbC5wbmc&hmac=iqIYRok8jtw' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '3', 'Classic Cooking Pot 22cm', 50, 15, 'https://cdn11.bigcommerce.com/s-1fdhnzvx71/images/stencil/532x532/products/128/407/PSL31320I_2017_10_27_20_11_39_UTC__22917.1581348822.386.513__17625.1588179770.png?c=1' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '3', 'Classic Cooking Pot 26cm', 50, 20, 'https://cdn11.bigcommerce.com/s-1fdhnzvx71/images/stencil/532x532/products/127/404/PSL31320I_2017_10_27_20_11_39_UTC__78759.1581349083.386.513__48351.1588179416.png?c=1' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '3', 'Maximus Cooking Pot ', 50, 12, 'https://www.dehomebiz.com.my/image/dehomebiz/image/cache/data/all_product_images/product-729/morphy_richards_562010_multi_cooker_photo_10-810x585.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '3', 'Pro-x Deep Cooking Pot', 50, 12, 'https://cf.shopee.com.my/file/554f71cfcee00d75f4191c5c268e6b21' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '3', 'Forever Sauce Pan', 50, 12, 'https://cdn11.bigcommerce.com/s-jta5lqjn53/images/stencil/532x532/products/573/1084/6720c__56824.1581430091.png?c=1' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '3', 'Marburg Grill Pan Black', 50, 12, 'https://assets.kogan.com/images/sirjohnsgifts/SJG-1331223855140/1-1907e02c68-107190.png?auto=webp&canvas=340%2C226&fit=bounds&height=226&quality=90&width=340' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '4', 'Cuckoo 1l Rice Cooker', 50, 150,
		'https://samnec.com.vn/uploads/san-pham/2022-09-05-16-00-27cr-0690fsiwhcrvncv.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '4', 'Ava 1l Rice Cooker', 50, 50, 'https://sg-live-01.slatic.net/p/bc091a4d22da96467c979647cc21dbb2.png'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '4', 'Toshiba 1.2l Rice Cooker', 50, 120,
		'https://tchome.vn/Data/images/tuanup/10-3/t40/product_12731_3.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '4', 'HappyCook 1.2l Rice Cooker', 50, 120,
		'https://salt.tikicdn.com/ts/product/22/56/de/3f94a1e353909adc1ffd8ecb7d558f3c.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '4', 'HappyCook 1.8l Rice Cooker', 50, 210,
		'https://salt.tikicdn.com/ts/product/26/8a/29/84b2d31e29b2cf887830d0ee91f94027.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'Lix Dishwashing liquid', 50, 5,
		'https://cdn.shopify.com/s/files/1/2297/2851/products/Dish-washingLiquidLIXFreshLemonSize400gbottle_700x700.png?v=1597204384'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'SunLight Dishwashing liquid', 50, 7,
		'https://cdn.shopify.com/s/files/1/0403/2203/9970/products/CP_3_F.png?v=1607953014' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'SurF Dishwashing liquid', 50, 7,
		'https://vn-live-05.slatic.net/p/44b65bcdcc81a8c4278a9ef08bb4c8b4.png_525x525q80.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'IziHome Dishwashing liquid', 50, 7, 'https://cf.shopee.vn/file/30b38cfaebd50eefcd45e300b78a0ed0' ,
		'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'EazyClean Dishwashing liquid', 50, 7,
		'http://ezeecares.com/wp-content/uploads/2013/09/ezee-dish-gel-yellow-green.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'Net Dishwashing liquid', 50, 6,
		'https://asmart.com.vn/wp-content/uploads/2021/09/NRC-NET-DD-huong-chanh-800g.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'Gift Dishwashing liquid', 50, 5,
		'https://vn-test-11.slatic.net/p/f87a22d9aa4acf8527cdc286c798b9bc.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'LifeBouy', 50, 13,
		'https://www.lifebuoy.in/content/dam/brands/lifebuoy/india/2133695-lifebuoy-innovation-total-soap-wrapper-125g---total-10.png'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'DoubleRich ShowerGel', 50, 17, 'https://sovina.vn/wp-content/uploads/2016/10/DBR1.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'Puri ShowerGel', 50, 12, 'https://media.ulta.com/i/ulta/2581853?w=720' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '5', 'Palmolive ShowerGel', 50, 15,
		'https://aswaqrak.ae/pub/media/catalog/product/cache/9e61d75d633e5fc1a695bad0376a2475/c/c/8714789515656.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'Composite CPS Gas', 50, 46,
		'https://dailygashcm.com/wp-content/uploads/2018/07/Dai_Ly_Gas_Miss_binh-gas-chong-chay-no-composite-muc-nuoc-gas.png' ,
		'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'PetroVietNam Bink Gas', 50, 146, 'https://gasviet.vn/wp-content/uploads/2018/12/gasviet-5.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1
)
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'Composite 6kg Gas', 50, 23,
		'https://hethonggasbinhminh.vn/wp-content/uploads/2021/03/Dai_Ly_Gas_Miss_Conposite.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'Oil Grey Gas', 50, 38,
		'https://www.swift-fuels.com/wp-content/uploads/2020/04/11kg-patio-gas-refill.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'ELF Gaz 12kg', 50, 38, 'https://gasluaxanh.com/wp-content/uploads/2021/04/total-elf-redbig.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.'
, 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'Family Gas 12kg', 50, 40,
		'https://gasluaxanh.com/wp-content/uploads/2021/04/gas-gia-dinh-do-12kg-793x800-2.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'Family Gas 45kg', 50, 138,
		'https://gasluaxanh.com/wp-content/uploads/2021/04/Binh-Gas-Gia-Dinh-Xam-45-Kg.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'Family Gas Red 12kg', 50, 40,
		'https://gastuchau.vn/files/product/binh-gas-gia-dinh-do12-kg-gsnmvptl.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'Oil Green Gas', 50, 39,
		'https://www.nicepng.com/png/full/74-743171_all-you-need-to-know-about-lpg-gas.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('petro', '6', 'Family Gas Blue 12kg', 50, 40,
		'https://images.squarespace-cdn.com/content/v1/5defa892a8313b70e3c9dab6/1596113910190-K9B91HYK4DRGAIE001H3/12kg+butane.png?format=1000w'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Satori Water 20L', 50, 5,
		'https://bizweb.dktcdn.net/100/422/803/products/satori.png?v=1625619757127' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Vihawa Water 20L', 50, 6,
		'https://thienhau.vn/wp-content/uploads/2014/07/nuoc-tinh-khiet-vihawa-20-lit-600x600.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Bidrico Water 20L', 50, 3,
		'https://dailynuockhoang.vn/wp-content/uploads/2019/10/Nuoc-Bidrico-20l-co-voi-600x614.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'I-on Life Water 20L', 50, 7,
		'https://www.queanhwater.com/wp-content/uploads/2019/07/b%C3%ACnh-n%C6%B0%E1%BB%9Bc-ion-life-19l_qu%E1%BA%BF-anh-food.png'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Lavi Water 20L', 50, 6,
		'https://nuockhoanglavievn.com/wp-content/uploads/2019/11/b%C3%ACnh-s%E1%BB%A9.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Viva Water 20L', 50, 6,
		'https://nuocuongtruongphat.com/wp-content/uploads/2020/03/nuoc-lavie-co-voi.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Aquafina 350ml *24', 50, 9, 'https://sangphatwater.vn/Upload/product/nuoc-aquafina-350l-8276.png' ,
		'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Aquafina 500ml *24', 50, 10, 'https://nuocsuoisala.com/wp-content/uploads/2022/07/aquafina-500l.png'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Lavie 500ml *24', 50, 88,
		'https://nuockhoanglaviehanoi.com/wp-content/uploads/2019/04/1-thung-lavie-bao-nhieu-chai.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '7', 'Satori 500ml *24', 50, 10, 'https://nuocsuoisala.com/wp-content/uploads/2022/07/Satori-500ml.png' ,
		'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '8', 'Samsung Inverter 236l', 50, 73,
		'https://2momart.vn/upload/products/082020/tu-lanh-samsung-inverter-rt22m4032dx-sv-gia-re.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '8', 'Toshiba Inverter 180l', 50, 53,
		'https://prices.vn/storage/photos/7/product/1594787705-tu-lanh-toshiba-inverter-gr-b22vu-ukg-180l0.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '8', 'Toshiba Inverter 90l', 50, 31,
		'https://vn-test-11.slatic.net/p/dc71e47775b9a4d4ccbe7700472fa481.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '8', 'Samsung Inverter 208l', 50, 61,
		'https://bizweb.dktcdn.net/100/184/135/products/1-43.png?v=1599541482817' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '8', 'Panasonic Inverter 322l', 50, 160,
		'https://2momart.vn/upload/products/052021/tu-lanh-panasonic-nr-bc360qkvn-nghieng-trai.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '8', 'Panasonic Inverter 322l', 50, 157,
		'https://2momart.vn/upload/products/052021/tu-lanh-panasonic-nr-bc360qkvn-nghieng-trai.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '8', 'Samsung Inverter 307l', 50, 140,
		'http://anhchinh.vn/media/product/14975_rb27n4190bu.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '8', 'LG Inverter 266l', 50, 80,
		'https://cdn.tgdd.vn/Products/Images/1943/106246/tu-lanh-lg-gn-l702sd-300x300.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '8', 'Panasonic Inverter 417l', 50, 204,
		'https://www.panasonic.com/content/dam/pim/vn/vi/NR/NR-BX4/NR-BX471GPK/ast-1271373.png.pub.thumb.644.644.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1
)
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Australian beef thighs 250g', 50, 11,
		'https://cdn.gdaymeat.com.au/wp-content/uploads/2022/03/Chucksteak666.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Beef encrusted 250g', 50, 8,
		'https://cdn.shopify.com/s/files/1/0278/9765/9462/products/groundbeef_250x250@2x.png?v=1591194631' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Australian beef middle 250g', 50, 8,
		'https://cdn.shopify.com/s/files/1/2297/2851/products/AustralianWagyuChuckEyeSteakSize300g-400g_Priceperkg_800x800.png?v=1628223330'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Bacon 250g', 50, 9,
		'https://dtgxwmigmg3gc.cloudfront.net/imagery/assets/derivations/icon/512/512/true/eyJpZCI6IjQ1ZjA5ZTU0Zjk0NzI3ZmI0NDRmOGM4Yjc3MGE1YTBjIiwic3RvcmFnZSI6InB1YmxpY19zdG9yZSJ9?signature=f96f37b69f389ae8fa821a36e4985d192b08fac01aea5a56ab6ea1397a9dbf05'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Australian beef thighs 500g', 50, 13,
		'https://cdn.shopify.com/s/files/1/2297/2851/products/AustralianWagyuChuckEyeSteakSize300g-400g_Priceperkg_800x800.png?v=1628223330'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Combo Grilled Meat 560g', 50, 26, 'https://cdn.shopify.com/s/files/1/0525/5829/9312/products/01_Starter_570x570.png?v=1615520877' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Australian beef ribs 500g', 50, 13,
		'https://cdn.shopify.com/s/files/1/0269/7723/9113/products/Beefcubeswhite_97668cbf-ab96-42ed-8815-84ff5d773cea_400x.png?v=1602324399'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Frozen Salmon 300g', 50, 12,
		'https://product.hstatic.net/200000077081/product/c_3f4771a6d5264caf998330d76d71abf6_1024x1024.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Frozen Fins Salmon 200g', 50, 30000,
		'https://thumbs.dreamstime.com/z/chopsticks-vector-illustration-eastern-traditional-cuisine-91586868.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Shirmp 500g', 50, 15,
		'https://www.balbiino.ee/wp-content/uploads/2019/12/KRR039-MARINE-koormiata-krevett-70-90-500g.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Saba Fish 400g', 50, 3,
		'https://images.squarespace-cdn.com/content/v1/5b182f57b105981d7e0a93d7/1530229488856-EWS2J3NQM0U2U041AQR7/4.png?format=1000w'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '9', 'Orange Fish 1.3kg', 50, 11, 'https://salmon-farm.com/wp-content/uploads/2021/12/27-12-2021.png' ,
		'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '10', 'Samsung SmartTV 55inch', 50, 148,
		'https://images.samsung.com/is/image/samsung/p6pim/vn/ua55au7002kxxv/gallery/vn-uhd-au7002-ua55au7002kxxv-531928752?$650_519_PNG$'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '10', 'LG SmartTV', 50, 140,
		'https://bizweb.dktcdn.net/thumb/1024x1024/100/443/782/products/smart-tivi-lg-75uq8050psb-4k-75-inch-1.png?v=1664265469930'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('dien_may_cho_lon', '10', 'Sony GoogleTV', 50, 154,
		'https://tuson.vn/uploads/product/Tivi/Sony/2022/KD-65X75K/KD-65X75K%20AVATAR.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '10', 'Samsung SmartTV 43inch', 50, 118,
		'https://images.samsung.com/is/image/samsung/vn-uhd-nu7090-ua50nu7090kxxv-frontblack-108921423?$650_519_PNG$' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1
)
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '10', 'TCL SmartTV 55inch', 50, 109,
		'https://pre-dispatcher.tclking.com/content/dam/brandsite/region/vietnam/tivi-tcl-55-inch/Q716-front.png?auto=webp,smallest'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '10', 'LG SmartTV 55inch', 50, 130,
		'https://pre-dispatcher.tclking.com/content/dam/brandsite/region/vietnam/tivi-tcl-55-inch/Q716-front.png?auto=webp,smallest'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '10', 'Samsung SmartTV 50inch', 50, 130,
		'https://images.samsung.com/is/image/samsung/p6pim/vn/ua50au7700kxxv/gallery/vn-uhd-au7000-383862-ua50au7700kxxv-421623795?$650_519_PNG$'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '10', 'Sony SmartTV 55inch', 50, 148,
		'https://d13o3tuo14g2wf.cloudfront.net/thumbnails%2Flarge%2FAsset+Hierarchy%2FConsumer+Assets%2FTelevision%2FBRAVIA+LCD+HDTV%2FFY+22%2FX85K%2FProduct+shots%2FX85K_55_65_75%2FeComm%2F1--X85K-65-Sony-FRNT.png.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMTNvM3R1bzE0ZzJ3Zi5jbG91ZGZyb250Lm5ldC90aHVtYm5haWxzJTJGbGFyZ2UlMkZBc3NldCtIaWVyYXJjaHklMkZDb25zdW1lcitBc3NldHMlMkZUZWxldmlzaW9uJTJGQlJBVklBK0xDRCtIRFRWJTJGRlkrMjIlMkZYODVLJTJGUHJvZHVjdCtzaG90cyUyRlg4NUtfNTVfNjVfNzUlMkZlQ29tbSUyRjEtLVg4NUstNjUtU29ueS1GUk5ULnBuZy5wbmciLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjIxNDU3NjIwMDB9fX1dfQ__&Signature=TSRDmdrCnA7UhvXLkMZLkzYIkCK-apxdu4nxJ66CSLOLOTxIm8L9Dcb9H7CGgJ5jQ7mEsuOy6PxyVqrw9CSk2xwmm3Ja03PTiRWAoMPwAPyYF9lkHN5vzgeiR7ipLUmia-i-rCX8kKm27bWgb~xK11EfSMfbvlaBQov9yQGgMjzY5yXfjmaQ~baIFdHJ-9Prvl8DdfBsxAu4r-6LmZfra3yRGk41lqPOksfde3XAp55YYbVzPLC6eLK28uaVlu~76T0g-h0SbxfLgL1nF9hA8~e04WVvzxuo2iI58C7LVJdxqhzW15bGFt0~zXE80FyN5KRryRjxoc3pGvLCItG9kQ__&Key-Pair-Id=K37BLT9C6HMMJ0'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '10', 'Sony SmartTV 55inch', 50, 138,
		'https://d13o3tuo14g2wf.cloudfront.net/thumbnails%2Flarge%2FAsset+Hierarchy%2FConsumer+Assets%2FTelevision%2FBRAVIA+LCD+HDTV%2FFY+22%2FX85K%2FProduct+shots%2FX85K_55_65_75%2FeComm%2F1--X85K-65-Sony-FRNT.png.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMTNvM3R1bzE0ZzJ3Zi5jbG91ZGZyb250Lm5ldC90aHVtYm5haWxzJTJGbGFyZ2UlMkZBc3NldCtIaWVyYXJjaHklMkZDb25zdW1lcitBc3NldHMlMkZUZWxldmlzaW9uJTJGQlJBVklBK0xDRCtIRFRWJTJGRlkrMjIlMkZYODVLJTJGUHJvZHVjdCtzaG90cyUyRlg4NUtfNTVfNjVfNzUlMkZlQ29tbSUyRjEtLVg4NUstNjUtU29ueS1GUk5ULnBuZy5wbmciLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjIxNDU3NjIwMDB9fX1dfQ__&Signature=TSRDmdrCnA7UhvXLkMZLkzYIkCK-apxdu4nxJ66CSLOLOTxIm8L9Dcb9H7CGgJ5jQ7mEsuOy6PxyVqrw9CSk2xwmm3Ja03PTiRWAoMPwAPyYF9lkHN5vzgeiR7ipLUmia-i-rCX8kKm27bWgb~xK11EfSMfbvlaBQov9yQGgMjzY5yXfjmaQ~baIFdHJ-9Prvl8DdfBsxAu4r-6LmZfra3yRGk41lqPOksfde3XAp55YYbVzPLC6eLK28uaVlu~76T0g-h0SbxfLgL1nF9hA8~e04WVvzxuo2iI58C7LVJdxqhzW15bGFt0~zXE80FyN5KRryRjxoc3pGvLCItG9kQ__&Key-Pair-Id=K37BLT9C6HMMJ0'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Wood Trestle Table', 50, 500,
		'https://optimise2.assets-servd.host/fine-elk/production/images/Products/WEB_Oxford-trestle-table_metal-frame-bespoke.png?w=1200&q=80&fm=webp&fit=crop&crop=focalpoint&fp-x=0.5&fp-y=0.5&dm=1519299764&s=002a1d317198f96c03fbc516e8905490'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Wood Mango Coffee Table', 50, 70, 'https://static.henkschram.com/images/77004%20(1).png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1
)
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Square Wood Mango Table', 50, 100,
		'https://5.imimg.com/data5/SELLER/Default/2022/5/ON/KL/IA/138536105/6-500x500.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Cement Finish Table', 50, 200,
		'http://static1.squarespace.com/static/57239bd5f8baf385ff553066/5f96ea5ccc17a47254c7b088/5f986a7960c99853043154d9/1604436153903/?format=1500w'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Square Wood Mango Table', 50, 100,
		'https://5.imimg.com/data5/SELLER/Default/2022/5/ON/KL/IA/138536105/6-500x500.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Leather Sofa', 50, 200,
		'https://leathersofaco.com/reddot/uploads/img/content/cID_1307/canto-leather-sofa.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'L Shaped Sofa', 50, 750,
		'https://cdn.shopify.com/s/files/1/2405/3057/products/TINA_dimension_-01_2048x.png?v=1657697978' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Oak ArmChair', 50, 200,
		'https://cdn.shopify.com/s/files/1/0174/2162/products/DYKE_AND_DEAN_DE_MACHINEKAMER_Hans_Fauteuil_OAK_ARMCHAIR_GREY.png?v=1657655861'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'OBeveled Wood Table', 50, 55,
		'https://www.cherrystonefurniture.com/images/thumbs/0000249_flare-oval-coffee-table_450.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Lacquered Chair', 50, 55,
		'https://pilma.com/wp-content/uploads/2021/05/0743-657RJ-SILLA-NIZA-LACADO-ROJO.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '11', 'Small Tool Chair', 50, 25, 'https://cdn.pixabay.com/photo/2014/12/21/23/50/stool-576147__340.png' ,
		'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '12', 'Wooden Box Bed', 50, 309,
		'https://www.godrejinterio.com/imagestore/B2C/MONC00016/MONC00016_01_1500x1500.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '12', 'White Box Bed', 50, 499, 'https://cdn4.afydecor.com/Beds/364/364.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '12', 'Bed With tail Drawer', 50, 890,
		'https://i.pinimg.com/736x/a9/39/90/a93990110944eb88f736be83cf0edb08--bookcase-headboard-beds-online.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '12', 'Hotel Bed', 50, 299,
		'https://i.pinimg.com/originals/9d/85/e6/9d85e62e83ed9a35caf92635b2c9e1cf.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '13', 'Linen Curtain With Piping', 50, 59,
		'https://static.wixstatic.com/media/8cc929_8d50830520e442b6af50a06c8961fd39~mv2.png/v1/fill/w_420,h_420,al_c,lg_1,q_85,enc_auto/8cc929_8d50830520e442b6af50a06c8961fd39~mv2.png'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('zarahome', '13', 'Cottan Curtain', 50, 39,
		'https://assets.pbimgs.com/pbimgs/ab/images/dp/wcm/202243/0058/seaton-textured-cotton-curtain-2-z.jpg'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '13', 'Cut-out Linen Curtain', 50, 49,
		'https://i.pinimg.com/564x/86/70/c3/8670c3f39b057bc5dc74eb77ad15bbf2--velvet-curtains-blue-curtains.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '13', 'White Linen Curtain', 50, 50,
		'https://i.pinimg.com/originals/1b/98/fc/1b98fcd65b6c372023898e800a84fbad.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Aberton 6 Door Wardrobe', 50, 500,
		'https://www.panemirates.com/images/pan-aberton-6-door-wardrobe-p40565-176939_image.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Janousek 6 Door Wardrobe', 50, 400,
		'https://secure.img1-cg.wfcdn.com/im/68746066/compr-r85/9819/98192010/carlsson-6-door-wardrobe.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Claudius 3 Door Wardrobe', 50, 300,
		'https://www.zadinteriors.com/store/wp-content/uploads/2021/06/6-x-4-side-view_3Door_dim.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Milan Collection 3 Door', 50, 200,
		'https://www.highcountrydoors.com/mfg_photos/Milan_collection_03.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Heinrich 6 Door Wardrobe', 50, 10,
		'https://image.made-in-china.com/2f0j00pWrzPveMEjqZ/Modern-Home-Six-Door-Wardrobes-Furniture-Sets-Designs-6-Door-MDF-Wooden-Bedroom-Wardrobe.jpg'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Ranstead 2 Door Wardrobe', 50, 70,
		'https://cdnprod.mafretailproxy.com/sys-master-root/h02/h26/12826476642334/011NFM1900023_media_2_480Wx480H' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Preystin Mirror 40x150cm', 50, 70,
		'https://m.media-amazon.com/images/I/41-i-GYwLBL._AC_UL320_.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Syrah Wall Mirror 19x133cm', 50, 70,
		'https://www.panemirates.com/qatar/en/images/pan-akira-wall-mirror-60x90cm-silver-p32997-140856_thumb.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('homefurniture', '14', 'Galen Wall Mirror Gold 62x62cm', 50, 70,
		'https://www.panemirates.com/images/pan-galen-wall-mirror-gold-62x62cm-p25441-104195_image.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '15', 'Shower By Plastic EL-H109', 50, 23,
		'https://salt.tikicdn.com/cache/w1200/ts/product/0f/7f/25/e11a9bd40c22a7d263ad4dc46ac22717.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '15', 'Shower By Inox EL-H110', 50, 3,
		'https://dienmay.vatbau.com/Products/Images/9338/230939/eurolife-el-h110-2-2-org.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '15', 'Shower Mitsubishi Cleansui', 50, 99,
		'https://www.mitsubishicleansui.vn/voisenkhuclo/wp-content/uploads/sites/3/2020/09/ES301_luxury.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '16', 'Electric ToothBrush Halio', 50, 11,
		'https://lh3.googleusercontent.com/xjIOWSy1Q2gOt9GjZT-zGk2QrWuApsk-0VfjYRCtoJT0YaOh3SvwSxl5z6kZLbN6YK8gzeLtzzJVFIzga4hJEOmWeub_XpGX'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '16', 'Electric ToothBrush Halio', 50, 120,
		'https://product.hstatic.net/1000006063/product/ht_1024x1024_2x_c7d5207180434e55b1c5d169a000814d_1024x1024.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.'
, 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '16', 'Electric ToothBrush P/S', 50, 110,
		'https://crestoralbproshop.com/media/wysiwyg/00069055132494_C1N0.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '16', 'Bamboo Charcoal ToothPaste', 50, 4,
		'https://www.colgate.com/content/dam/cp-sites/oral-care/oral-care-center/en-in/product-detail-pages/toothpaste/colgate-charcoal-clean.png'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '16', 'PS ToothPaste', 50, 99,
		'https://product.hstatic.net/1000190126/product/ps_nguasaurang_vt-1367645-png_d3974f6f1e3543b6bedae40c62d01931.png' ,
		'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '16', 'Dental Clinic ToothPaste', 50, 59,
		'https://ibeaudy.vn/wp-content/uploads/2021/01/unnamed-300x300.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '17', 'Table Flower Vase', 50, 85,
		'https://i.pinimg.com/originals/19/d4/ca/19d4ca41435bfd70f475ffce7a96f3b1.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('bach_hoa_xanh', '17', 'Table Flower Vase', 50, 75, 'https://www.picng.com/upload/vase/png_vase_25246.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '17', 'Table Flower Vase', 50, 65,
		'https://cdn.shopify.com/s/files/1/2566/7252/products/0321-3-5-5_1200x1200.png?v=1646346669' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '17', 'Table Flower Vase', 50, 55, 'https://cdn.pixabay.com/photo/2018/01/11/10/00/rose-3075776__340.png' ,
		'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '17', 'Table Flower Vase', 50, 45,
		'https://ae01.alicdn.com/kf/H1a00a8aab20f483d923885edd5fb9223U/Modern-Black-Face-Vase-Ceramic-Head-Flower-Pot-Flower-Arrangement-Container-Living-Room-Dining-Table-Flower.jpg'
, 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '18', 'Globural Fire Extinguisher 6kg', 50, 60,
		'https://media1.svb-media.de/en/images/517538/gloria-pd6ga-powder-fire-extinguisher-6-kg-fire-class-abc.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '18', 'Globural Fire Extinguisher 8kg', 50, 70,
		'http://sc04.alicdn.com/kf/Hd9f07c037ab8417fa2d52ad28fd5c978F.jpg' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '18', 'Powder Fire Extinguisher 2kg', 50, 18,
		'https://eversafe.net/wp-content/uploads/2021/07/Home-Safety-Kit-04.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )
INSERT INTO tblProductDetail
	(provider_ID, product_ID, name, quantity, price, image, description, status)
VALUES
	('cho_tot_tot', '18', 'Powder Fire Extinguisher 4kg', 50, 38,
		'https://www.uniquefire.com/wp-content/uploads/2019/04/4-kg-fire-extinguisher-1.png' , 'A large, silver-plated vegetable spoon with the matching potato spoon from WMFs Rome series.The spoons are ideal for serving a wide variety of vegetables.Great companion on an elegantly set dining table.' , 1 )

--Bảng loại dịch vụ theo nhóm 

INSERT INTO tblServiceCategory
	(category_ID, name, image)
VALUES
	('HC', 'Home Cleaning', 'https://www.pngkey.com/png/full/224-2244033_whether-you-need-my-cleaning-services-for-your.png')
INSERT INTO tblServiceCategory
	(category_ID, name, image)
VALUES
	('HI', 'Home Improvement', 'https://rothfield.com.au/wp-content/uploads/2021/06/Rothfield_3PL_Hero-Banner-.png')
INSERT INTO tblServiceCategory
	(category_ID, name, image)
VALUES
	('PBS', 'Plumbers', 'https://static.wixstatic.com/media/403b64_dc829afea69b46108304d88808cfe46e~mv2.png/v1/fill/w_416,h_350,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/Yelm-Plumbing-and-Pumps-Sewer-Line-Repai.png')
INSERT INTO tblServiceCategory
	(category_ID, name, image)
VALUES
	('IT', 'IT Service', 'https://www.pngplay.com/wp-content/uploads/13/Software-IT-Services-Transparent-Background.png')
INSERT INTO tblServiceCategory
	(category_ID, name, image)
VALUES
	('CAR', 'Car Service', 'https://previews.123rf.com/images/macrovector/macrovector1503/macrovector150300186/37345149-car-service-concept-with-auto-repair-and-maintenance-decorative-icons-set-vector-illustration.jpg')
--Bảng loại dịch vụ 

INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('1', 'HC', 'Deep Cleaning', 'https://spicandspan.de/assets/icons/sas_logo_icon_only.svg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('2', 'HC', 'Sofa Cleaning', 'https://freesvg.org/img/Sofa-lineart.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('3', 'HC', 'Exterior Cleaning', 'https://ozclean.com.au/goldcoast/images/services/exterior/exclusive-benefits.svg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('4', 'HC', 'Mattress Cleaning', 'https://cdn2.iconfinder.com/data/icons/cordless-stick-vacuum-cleaner-vac/324/stick-vac-13-512.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('5', 'HC', 'Carpet Cleaning', 'https://cdn2.iconfinder.com/data/icons/cleaning-hygiene/160/carpet-cleaning-512.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('6', 'HC', 'Scrubs Cleaning', 'https://previews.123rf.com/images/jemastock/jemastock1909/jemastock190928324/130728070-cleaning-and-hygiene-equipment-cleaning-shampoo-scrub-brush-icon-cartoon-vector-illustration-graphic.jpg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('7', 'HC', 'Window Cleaning', 'https://freesvg.org/img/1571751673windowwasher.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('8', 'HC', 'Ozone Treatment', 'https://cdn.shopify.com/s/files/1/0575/4470/4165/files/3457313_1000x1000.png?v=1624268288')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('9', 'HC', 'Disinfection', 'https://icons.veryicon.com/png/o/healthcate-medical/medical-health-1/disinfect.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('10', 'HC', 'Full Cleaning', 'https://cdn-icons-png.flaticon.com/512/994/994941.png')

INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('11', 'HI', 'Decluttering', 'https://cdn.iconscout.com/icon/premium/png-256-thumb/declutter-2105384-1770481.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('12', 'HI', 'Packing $ Unpacking', 'https://moveinterstate.com/wp-content/uploads/2020/02/Packing-square.svg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('13', 'HI', 'Transport Home', 'https://cdn-icons-png.flaticon.com/512/4950/4950837.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('14', 'HI', 'Electrician', 'https://media.istockphoto.com/vectors/electrician-man-working-to-install-and-maintain-electrical-equipment-vector-id1210520046?b=1&k=20&m=1210520046&s=170667a&w=0&h=34pJUCfo0VR2t2Ar4eU5pa47SYXMksIXbBfmIOx0z50=')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('15', 'HI', 'Curtain Decor', 'https://media.istockphoto.com/vectors/curtain-icon-vector-isolated-contour-symbol-illustration-vector-id1205466877?k=20&m=1205466877&s=170667a&w=0&h=QT9EIRhCG46MHaJZZcMiJ_bzHwmlGyyVvbZRCOa0kZM=')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('16', 'HI', 'Paint & Wallpaper', 'https://previews.123rf.com/images/seamartini/seamartini2011/seamartini201100228/158659605-house-renovation-professional-wallpapering-service-workman-in-overalls-and-paper-hat-aligning-wallpa.jpg')

INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('17', 'PBS', 'Piping', 'https://e7.pngegg.com/pngimages/152/870/png-clipart-custom-plumbing-plumber-central-heating-home-repair-toilet-angle-furniture-thumbnail.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('18', 'PBS', 'Filter', 'https://cdn-icons-png.flaticon.com/512/4992/4992693.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('19', 'PBS', 'Water Heater', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNGryqz3CztYinE033TCu4htn4_WOblNczKV7rz7JG6yfQANpOHcIubh_IUboqbhLSyg8&usqp=CAU')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('20', 'PBS', 'Sink', 'https://previews.123rf.com/images/iconisa/iconisa1710/iconisa171001916/87222545-plumber-service-tools-sink-vector-line-icon-sign-illustration-on-white-background-editable-strokes.jpg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('21', 'PBS', 'Pumps', 'https://previews.123rf.com/images/stockgiu/stockgiu1710/stockgiu171006843/88794587-line-pump-toilet-equipment-service-repair-vector-illustration.jpg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('22', 'PBS', 'Toilet', 'https://previews.123rf.com/images/unitonevector/unitonevector1904/unitonevector190401860/121210801-man-plumber-in-uniform-with-plunger-in-hand-toilet-bowl-bathroom-vector-illustration-toilet-cleaning.jpg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('23', 'PBS', 'Bathtub', 'https://previews.123rf.com/images/unitonevector/unitonevector1904/unitonevector190401897/123347605-bathtub-fixing-banner-cartoon-bathroom-home-interior-vector-illustration-professional-plumbing-servi.jpg')

INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('24', 'IT', 'Satellite TV', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3uzCURZscS3Fy7xXZuSu63eVmdTl1EjLBkevzUYfXMMdNqBmaqoELzDGEWSgP74HDx3Y&usqp=CAU')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('25', 'IT', 'Wifi', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Wifiservice.svg/800px-Wifiservice.svg.png')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('26', 'IT', 'Computers', 'https://images.all-free-download.com/images/graphiclarge/funny_computer_repair_service_elements_vector_572010.jpg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('27', 'IT', 'Home CCTV', 'https://i.pinimg.com/564x/9c/2b/42/9c2b425b1cb70553ae41614b2ebcd14e.jpg')

INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('28', 'CAR', 'Carwash', 'https://media.istockphoto.com/vectors/carwash-classic-car-design-vector-id1254591911')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('29', 'CAR', 'Engine Oil, Oil Filter', 'https://img.freepik.com/premium-vector/engine-oil-with-oil-filter-tire-isolated-white-background_258836-182.jpg?w=2000')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('30', 'CAR', 'Car Interior Cleaning', 'https://previews.123rf.com/images/kokandr/kokandr1409/kokandr140900056/31403016-car-interior-wash-and-clean.jpg')
INSERT INTO tblService
	(service_ID, category_ID, name , image)
VALUES
	('31', 'CAR', 'Car Baterry', 'https://previews.123rf.com/images/sabelskaya/sabelskaya1712/sabelskaya171200446/92148248-adult-man-mechanic-in-blue-uniform-in-car-service-set-one-person-holding-car-battery-charger-another.jpg')
GO
--bảng nhân viên

INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '1', 'Nguyen The Viet', '550422001234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '1', 'Tran Nhat Minh', '550422001235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '1', 'Tran Nguyen Dat Phu', '550422001422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '1', 'Trang Quoc Dat', '550422121235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '1', 'Nguyen The Phong', '554122001234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '1', 'Nguyen Hoang Thai Quy', '594122111294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '1', 'Nguyen Le Thai Viet', '941230012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '1', 'Nguyen Thai Dat Trang', '599122001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '2', 'Nguyen Trang Quoc', '000422001234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '2', 'Tran Nhat Minh Hai', '590421001235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '2', 'Nguyen Tran Phu', '000498001422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '2', 'Nguyen Tien Tai', '550422129640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '2', 'Le The Phong', '000122001234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '2', 'Le Ton Nu Hoang', '114122111294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '2', 'Le Thai Nguyen', '943210012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '2', 'Tran Tien Trang', '000000001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '3', 'Nguyen Trang Quoc Phu', '001422001234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '3', 'Nguyen Than hTra', '500421001235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '3', 'Bui Nguyen Thanh Mai', '100498001422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '3', 'Tran Phung Hoang Minh', '120422129640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '4', 'Le The Phong Dat', '000122000000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '4', 'Le Ton Nu', '114198111294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '4', 'Le Thai Thi Nguyen', '003210012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '4', 'Tran Tien Trang', '000010001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '5', 'Tran Thi Thuy An', '300498001422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '5', 'Nguyen Phan Hoang Vy', '210422129640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '5', 'Nguyen Thanh Thuy Truc', '870122000000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '6', 'Nguyen Ngoc Truc', '004198111294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '6', 'Nguyen Quyet Chinh', '001230012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '6', 'Nguyen Anh Tuan', '000120001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '7', 'Tran Nhat Nam', '123120001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '7', 'Le Thi Ngoc Truc', '990120001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '7', 'Tran Thuy Tien', '800120001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '7', 'Do Phuong Thao', '060120001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '7', 'Tran Nguyen Hoang Phuc', '000123001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '8', 'Le Chi Minh', '670122000000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '8', 'Le Nguyen Diem Quynh', '004198222294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '9', 'Truong Nhat Tuyen', '001234512940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '9', 'Trinh Gia Huy', '000970001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '10', 'Le Kim Nguyen', '000870001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '10', 'Do Manh Huy', '000770001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homecleaning', '10', 'Nguyen Huu Duc', '000670001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
GO

INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '11', 'Nguyen The Hoang Long', '550543001234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '11', 'Tran Hoang Phuc Long', '405522001235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '11', 'Nguyen Tien Hoang', '550444441422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '11', 'Phong Quoc Dat', '761822121235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '11', 'Hoang Kieu Long', '554643201234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
GO

INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '12', 'Le Duc Thuan', '594122110000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '12', 'Nguyen Hoang Ton', '852360012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '12', 'Nguyen Thai Kim', '000122001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '12', 'Nguyen Trang Loan', '000564001234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '12', 'Tran Nhat Hai', '220421001235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '13', 'Doan Ngoc Han', '000948001422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '13', 'Ngoc Tien', '550422946640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '13', 'Le Hoang Phong', '001122001234', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '13', 'Le Ton Nu Hue', '114112311294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('moveronline', '13', 'Ngo Tuan Tu', '043210012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
GO

INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('electrician', '14', 'Tran Tien Trang Hoang', '000010001295', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('electrician', '14', 'Nguyen Quoc Phu', '001422001334', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('electrician', '14', 'Nguyen Thanh Tuan Tu', '500461001235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('electrician', '14', 'Nguyen Thanh Mai', '100498009422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('electrician', '14', 'Tran Hoang Minh', '120922129640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('electrician', '14', 'Le Phong Dat', '000122009000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('electrician', '14', 'Le Ton Nam', '114198191294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('electrician', '14', 'Le Thi Nguyen', '003910012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
GO

INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '15', 'Tran Tien Trang Anh', '000110001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '15', 'Tran Thi Thuy Diem', '310498001422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '15', 'Nguyen Phan Vy', '210422729640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '15', 'Nguyen Thuy Truc', '870127000000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '16', 'Nguyen Ngoc Trang', '004178111294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '16', 'Nguyen Quyet Tam', '001270012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('homeimprovement', '16', 'Nguyen Anh Tam', '000120701294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
GO

INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('getintouch', '17', 'Nguyen Quoc Phong', '011422001334', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('plumbers', '17', 'Nguyen Thanh Tu', '100461001235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('getintouch', '18', 'Nguyen Tron gAnh', '110498009422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('plumbers', '18', 'Tran Hoang Man', '110922129640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('getintouch', '19', 'Le Phong Dien', '100122009000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('plumbers', '19', 'Le Tran Tinh', '014198191294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('getintouch', '20', 'Le Tran Tien', '001910012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('plumbers', '20', 'Tran Trong Anh', '050110001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('getintouch', '21', 'Tran Tien Tai', '320498001422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('plumbers', '21', 'Nguyen Phan Tuan Kiet', '210429729640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('getintouch', '22', 'Nguyen Truc Anh Kiet', '870927000000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('plumbers', '22', 'Nguyen Tuan Phong', '001178111294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('getintouch', '23', 'Nguyen Tran Tam', '001670012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('plumbers', '23', 'Nguyen Anh Tam', '000125701294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
GO

INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '24', 'Le Ky Quoc', '011922001334', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '24', 'Nguyen Thanh Tung', '180461001235', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '24', 'Trang Tuan Dat', '110468009422', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '25', 'Nguyen Trong Toan', '109922127979', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '25', 'Doan Gia Bao', '100192009000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '25', 'Dang Hoang Viet', '064198191294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '25', 'Le The Khoi', '001914012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '25', 'Tran Trong Anh Tai', '050160001294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '26', 'Tran Tuan Tai', '320498001822', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '26', 'Nguyen Tuan Kiet', '210429929640', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '26', 'Nguyen Anh Kiet', '870927060000', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '27', 'Nguyen Tien Phong', '001176111294', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '27', 'Nguyen Tran Anh Tam', '001640012940', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('fptcompany', '27', 'Nguyen Thi Tam', '000125701594', 'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=', 1)
GO

INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '28', 'Lee Chong Wei', '011922001330', 'https://cdn.icon-icons.com/icons2/1736/PNG/512/4043260-avatar-male-man-portrait_113269.png', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '28', 'Park Kim Son', '120461001575', 'https://www.pngitem.com/pimgs/m/576-5768840_cartoon-man-png-avatar-transparent-png.png', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '28', 'David Touliver', '110468009431', 'https://www.pennmedicine.org/-/media/images/miscellaneous/random%20generic%20photos/smiling_man_with_beard.ashx?mw=620&mh=408', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '28', 'Tran Thanh Hung', '109922120079', 'https://image.shutterstock.com/image-vector/cool-beard-man-vector-logo-260nw-1719020434.jpg', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '29', 'Nguyen Quang Dung', '100192123000', 'https://freesvg.org/img/myAvatar.png', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '29', 'Nguyen Truong Giang', '064192341294', 'https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '29', 'Nguyen The Anh', '001914456940', 'https://as2.ftcdn.net/v2/jpg/02/23/50/73/1000_F_223507324_jKl7xbsaEdUjGr42WzQeSazKRighVDU4.jpg', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '30', 'Tran Cong Khoi', '111914456940', 'https://deadline.com/wp-content/uploads/2020/11/Stephen-Lang-Headshot-Matt-Sayles-e1605093774374.jpg', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '30', 'Le Quan Thanh', '001914123940', 'https://cdn.dribbble.com/users/1040983/screenshots/5807325/media/c3d495a1d644ae646190ee51a64607d5.png?compress=1&resize=400x300&vertical=top', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '30', 'Tran Cong Thanh', '101914456940', 'https://thumbs.dreamstime.com/b/happy-smiling-geek-hipster-beard-man-cool-avatar-geek-man-avatar-104871313.jpg', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '31', 'Le Duong Bao', '121914456940', 'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector.png', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '31', 'Ngo Nhat Nam', '031914456940', 'https://images.assetsdelivery.com/compings_v2/yupiramos/yupiramos2004/yupiramos200436847.jpg', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '31', 'Nguyen Phuoc Thinh', '041914456940', 'https://static.vecteezy.com/system/resources/previews/004/476/164/original/young-man-avatar-character-icon-free-vector.jpg', 1)
INSERT INTO tblStaff
	(provider_ID,service_ID,name,id_card,avatar,status)
VALUES
	('michelin_car_service', '31', 'Nguyen Trong Dung', '051914456940', 'https://image.shutterstock.com/image-vector/isolated-avatar-afro-american-man-260nw-2012367269.jpg', 1)

--Bảng detail service
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '1', '1', 'Deep Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '1', '2', 'Deep Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '1', '3', 'Deep Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '1', '4', 'Deep Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '1', '5', 'Deep Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '1', '6', 'Deep Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '1', '7', 'Deep Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '1', '8', 'Deep Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '2', '9', 'Sofa Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '2', '10', 'Sofa Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '2', '11', 'Sofa Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '2', '12', 'Sofa Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '2', '13', 'Sofa Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '2', '14', 'Sofa Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '2', '15', 'Sofa Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '2', '16', 'Sofa Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '3', '17', 'Exterior Cleaning', 15, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '3', '18', 'Exterior Cleaning', 15, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '3', '19', 'Exterior Cleaning', 15, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '3', '20', 'Exterior Cleaning', 15, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '4', '21', 'Mattress Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '4', '22', 'Mattress Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '4', '23', 'Mattress Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '4', '24', 'Mattress Cleaning', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '5', '25', 'Carpet Cleaning', 18, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '5', '26', 'Carpet Cleaning', 18, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '5', '27', 'Carpet Cleaning', 18, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '6', '28', 'Scrubs Cleaning', 22, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '6', '29', 'Scrubs Cleaning', 22, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '6', '30', 'Scrubs Cleaning', 22, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '7', '31', 'Window Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '7', '32', 'Window Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '7', '33', 'Window Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '7', '34', 'Window Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '7', '35', 'Window Cleaning', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '8', '36', 'Ozone Treatment', 48, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '8', '37', 'Ozone Treatment', 48, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '9', '38', 'Disinfection', 52, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '9', '39', 'Disinfection', 52, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '10', '40', 'Full Cleaning', 67, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '10', '41', 'Full Cleaning', 67, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homecleaning', '10', '42', 'Full Cleaning', 67, 'Get ready all the time. Helping you with the best service', 1)
GO

INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '11', '43', 'Decluttering', 60, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '11', '44', 'Decluttering', 60, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '11', '45', 'Decluttering', 60, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '11', '46', 'Decluttering', 60, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '11', '47', 'Decluttering', 60, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '12', '48', 'Packing $ Unpacking', 10, 'Get ready all the time. Helping you with the best service', 1)
GO

INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '12', '49', 'Packing $ Unpacking', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '12', '50', 'Packing $ Unpacking', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '22', '51', 'Packing $ Unpacking', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '12', '52', 'Packing $ Unpacking', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '13', '53', 'Transport Home', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '13', '54', 'Transport Home', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '13', '55', 'Transport Home', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '13', '56', 'Transport Home', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('moveronline', '13', '57', 'Transport Home', 20, 'Get ready all the time. Helping you with the best service', 1)
GO

INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('electrician', '14', '58', 'Electrician', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('electrician', '14', '59', 'Electrician', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('electrician', '14', '60', 'Electrician', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('electrician', '14', '61', 'Electrician', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('electrician', '14', '62', 'Electrician', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('electrician', '14', '63', 'Electrician', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('electrician', '14', '64', 'Electrician', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('electrician', '14', '65', 'Electrician', 10, 'Get ready all the time. Helping you with the best service', 1)
GO

INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '15', '66', 'Curtain Decor', 8, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '15', '67', 'Curtain Decor', 8, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '15', '68', 'Curtain Decor', 8, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '15', '69', 'Curtain Decor', 8, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '16', '70', 'Paint & Wallpaper', 22, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '16', '71', 'Paint & Wallpaper', 22, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('homeimprovement', '16', '72', 'Paint & Wallpaper', 22, 'Get ready all the time. Helping you with the best service', 1)
GO

INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('getintouch', '17', '73', 'Piping', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('plumbers', '17', '74', 'Piping', 11, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('getintouch', '18', '75', 'Filter', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('plumbers', '18', '76', 'Filter', 11, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('getintouch', '19', '77', 'Water Heater', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('plumbers', '19', '78', 'Water Heater', 11, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('getintouch', '20', '79', 'Sink', 9, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('plumbers', '20', '80', 'Sink', 8, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('getintouch', '21', '81', 'Pumps', 9, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('plumbers', '21', '82', 'Pumps', 8, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('getintouch', '22', '83', 'Toilet', 6, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('plumbers', '22', '84', 'Toilet', 6, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('getintouch', '23', '85', 'Bathtub', 12, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('plumbers', '23', '86', 'Bathtub', 14, 'Get ready all the time. Helping you with the best service', 1)
GO

INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '24', '87', 'Satellite TV', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '24', '88', 'Satellite TV', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '24', '89', 'Satellite TV', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '25', '90', 'Wifi', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '25', '91', 'Wifi', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '25', '92', 'Wifi', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '25', '93', 'Wifi', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '25', '94', 'Wifi', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '26', '95', 'Computers', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '26', '96', 'Computers', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '26', '97', 'Computers', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '27', '98', 'Home CCTV', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES 
	('fptcompany', '27', '99', 'Home CCTV', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('fptcompany', '27', '100', 'Home CCTV', 5, 'Get ready all the time. Helping you with the best service', 1)

INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '28', '101', 'Carwash', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '28', '102', 'Carwash', 11, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '28', '103', 'Carwash', 10, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '28', '104', 'Carwash', 13, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '29', '105', 'Engine Oil and Oil Filter', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '29', '106', 'Engine Oil and Oil Filter', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '29', '107', 'Engine Oil and Oil Filter', 20, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '30', '108', 'Car Interior Cleaning', 17, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '30', '109', 'Car Interior Cleaning', 17, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '30', '110', 'Car Interior Cleaning', 17, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '31', '111', 'Car Baterry', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '31', '112', 'Car Baterry', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '31', '113', 'Car Baterry', 5, 'Get ready all the time. Helping you with the best service', 1)
INSERT INTO tblServiceDetail
	(provider_ID, service_ID, staff_ID,name,price,description,status)
VALUES
	('michelin_car_service', '31', '114', 'Car Baterry', 5, 'Get ready all the time. Helping you with the best service', 1)


INSERT INTO tblShipper
	(username, password, name,phone,MRC, status, wallet)
VALUES
	('ebutler1', '12345678', 'Nguyen Van A','0364613014' ,'006358',1, 0)
INSERT INTO tblShipper
	(username, password, name,phone,MRC, status, wallet)
VALUES
	('ebutler2', '12345678', 'Nguyen Anh Tuan','0311648204' ,'105358', 1, 0)
INSERT INTO tblShipper
	(username, password, name,phone,MRC, status, wallet)
VALUES
	('ebutler3', '12345678', 'Nguyen Thi Hong','0944351304' ,'006497', 1, 0)
INSERT INTO tblShipper
	(username, password, name,phone,MRC, status, wallet)
VALUES
	('ebutler4', '12345678', 'Nguyen Manh Quang','0644315201' ,'009213', 1, 0)
INSERT INTO tblShipper
	(username, password, name,phone,MRC, status, wallet)
VALUES
	('ebutler5', '12345678', 'Le Ba Hau','0622942014' ,'613497', 1, 0)




CREATE TABLE tblCustomer
(
	[username] nvarchar(30) PRIMARY KEY,
	[password] [nvarchar](30) NOT NULL,
	[role_ID] [nvarchar](10) REFERENCES tblUserRole(role_ID) NOT NULL,
	[phone] nvarchar(11) NOT NULL,
	[email] [nvarchar](30) UNIQUE NOT NULL,
	[name] nvarchar(30) NOT NULL,
	gender [int],
	dob date,
	avatar nvarchar(max),
	point [decimal](9),
	[status] [decimal](1)
)
GO

INSERT INTO tblUser
	(username, [password], role_ID, [phone], email, [status])
VALUES
	('baobaobao', '1', 'CUS' ,'0322654879', 1, 1)

INSERT INTO tblUser
	(username, [password], role_ID, [phone], email, [status])
VALUES
	('baobaobao', '1', 'CUS' ,'0322654879', 1, 1)