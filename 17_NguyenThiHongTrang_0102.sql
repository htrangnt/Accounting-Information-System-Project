Create database HTTTKTBH_BHX
use HTTTKTBH_BHX

CREATE TABLE Hanghoa (
    MaH nvarchar(12) PRIMARY KEY,
    TenH nvarchar(30) NOT NULL,
    DongiaH decimal(10,2) NOT NULL,
    Donvitinh nvarchar(5) NOT NULL,
    Hansudung date NOT NULL,
    NoiSX nvarchar(100),
    LoaiH nvarchar(20),
    Mota ntext
);

CREATE TABLE Nhanvien (
    MaNV nvarchar(12) PRIMARY KEY,
    TenNV nvarchar(25) NOT NULL,
    Gioitinh nvarchar(3) NOT NULL,
    Ngaysinh date NOT NULL,
    SDT nvarchar(11) NOT NULL,
    DiachiNV nvarchar(100),
    Chucvu nvarchar(20) NOT NULL
);

CREATE TABLE Khachhang (
    MaKH nvarchar(12) PRIMARY KEY,
    TenKH nvarchar(25) NOT NULL,
    DiachiKH nvarchar(100),
    SDTKH nvarchar(11) NOT NULL,
    NgaysinhKH date,
    GioitinhKH nvarchar(3)
);

CREATE TABLE Hoadon (
    MaHD nvarchar(12) PRIMARY KEY,
    Ngayban date NOT NULL,
    Tongtien decimal(13,2) NOT NULL,
    PTTT nvarchar(30) NOT NULL,
    MaKH nvarchar(12),
    MaNV nvarchar(12),
    FOREIGN KEY (MaKH) REFERENCES Khachhang(MaKH),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);

CREATE TABLE Nhacungcap (
    MaNCC nvarchar(12) PRIMARY KEY,
    TenNCC nvarchar(50) NOT NULL,
    Diachi nvarchar(100) NOT NULL,
    Email nvarchar(25)
);

CREATE TABLE Phieukiemke (
    MaPKK nvarchar(12) PRIMARY KEY,
    NgayKK date NOT NULL,
    GhichuPKK ntext,
    MaNV nvarchar(12),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);

CREATE TABLE Phieuxuat (
    MaPX nvarchar(12) PRIMARY KEY,
    Ngayxuat date NOT NULL,
    GhichuPX ntext,
    MaNV nvarchar(12),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);

CREATE TABLE Phieunhap (
    MaPN nvarchar(12) PRIMARY KEY,
    Ngaynhap date NOT NULL,
    Tongtiennhap decimal(14,2) NOT NULL,
    GhichuPN ntext,
    MaNV nvarchar(12),
    MaNCC nvarchar(12),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV),
    FOREIGN KEY (MaNCC) REFERENCES Nhacungcap(MaNCC)
);

CREATE TABLE Taikhoan (
    Username nvarchar(30) PRIMARY KEY,
    Password nvarchar(30) NOT NULL,
    MaNV nvarchar(12),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);

CREATE TABLE Chitiet_Hoadon (
    SL_hangban int,
    Dongia_ban decimal(10,2),
    Magiamgia nvarchar(12),
    TKNo nvarchar(10),
    TKCo nvarchar(10),
    MaH nvarchar(12),
    MaHD nvarchar(12),
    PRIMARY KEY (MaH, MaHD),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaHD) REFERENCES Hoadon(MaHD)
);

CREATE TABLE Chitiet_PKK (
    SL_hangKK int,
    MaH nvarchar(12),
    MaPKK nvarchar(12),
    PRIMARY KEY (MaH, MaPKK),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaPKK) REFERENCES Phieukiemke(MaPKK)
);

CREATE TABLE Chitiet_PX (
    SL_hangxuat int,
    Dongiaxuat decimal(10,2),
    MaH nvarchar(12),
    MaPX nvarchar(12),
    PRIMARY KEY (MaH, MaPX),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaPX) REFERENCES Phieuxuat(MaPX)
);

CREATE TABLE Chitiet_PN (
    SL_hangnhap int,
    Dongianhap decimal(10,2),
    MaH nvarchar(12),
    MaPN nvarchar(12),
    PRIMARY KEY (MaH, MaPN),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaPN) REFERENCES Phieunhap(MaPN)
);

CREATE TABLE DMTK1 (
    SoTKC1 nvarchar(10) PRIMARY KEY,
    TenTKC1 nvarchar(100),
    Ghichu_TKC1 ntext
);

CREATE TABLE DMTK2 (
    SoTKC2 nvarchar(10) PRIMARY KEY,
    TenTKC2 nvarchar(100),
    Ghichu_TKC2 ntext,
    SoTKC1 nvarchar(10),
    FOREIGN KEY (SoTKC1) REFERENCES DMTK1(SoTKC1)
);

CREATE TABLE TK_chitiet (
    SoTKCT nvarchar(10) PRIMARY KEY,
    TenTKCT nvarchar(100),
    Ghichu_TKCT ntext,
    SoTKC2 nvarchar(10),
    FOREIGN KEY (SoTKC2) REFERENCES DMTK2(SoTKC2)
);

CREATE TABLE But_toan (
    MaCT nvarchar(12) PRIMARY KEY,
    NgayHT date,
    DienGiai ntext,
    SotienNo float,
    SotienCo float,
    MaHD nvarchar(12),
    MaPN nvarchar(12),
    MaPX nvarchar(12),
    SoTKCT nvarchar(10),
    FOREIGN KEY (MaHD) REFERENCES Hoadon(MaHD),
    FOREIGN KEY (MaPN) REFERENCES Phieunhap(MaPN),
    FOREIGN KEY (MaPX) REFERENCES Phieuxuat(MaPX),
    FOREIGN KEY (SoTKCT) REFERENCES TK_chitiet(SoTKCT)
);

CREATE TABLE SDDK (
    MaSDDK nvarchar(12) PRIMARY KEY,
    DuNo_DK float,
    DuCo_DK float,
    Ngaydauky date,
    SoTKCT nvarchar(10),
    FOREIGN KEY (SoTKCT) REFERENCES TK_chitiet(SoTKCT)
);
--============================================================================
INSERT INTO Hanghoa (MaH, TenH, DongiaH, Donvitinh, Hansudung, NoiSX, LoaiH, Mota) VALUES
('H001', N'Gạo thơm ST25', 24000, N'Kg', '2026-12-31', N'Sóc Trăng', N'Lương thực', N'Gạo thơm chất lượng cao'),
('H002', N'Đường trắng tinh luyện', 18000, N'Kg', '2026-06-30', N'Bình Dương', N'Đường sữa', N'Đường tinh luyện trắng'),
('H003', N'Nước mắm 40N', 45000, N'Chai', '2027-03-31', N'Phú Quốc', N'Gia vị', N'Nước mắm cá cơm truyền thống'),
('H004', N'Dầu ăn hướng dương', 52000, N'Chai', '2027-08-31', N'Long An', N'Dầu ăn', N'Dầu ăn tốt cho tim mạch'),
('H005', N'Mì gói chay', 6000, N'Gói', '2026-10-31', N'TP.HCM', N'Thực phẩm khô', N'Mì ăn liền vị chay'),
('H006', N'Sữa tươi tiệt trùng', 32000, N'Hộp', '2025-08-31', N'Đồng Nai', N'Sữa', N'Sữa tươi nguyên kem'),
('H007', N'Nước suối 500ml', 5000, N'Chai', '2027-12-31', N'Lâm Đồng', N'Đồ uống', N'Nước uống đóng chai'),
('H008', N'Bánh quy bơ', 38000, N'Hộp', '2026-05-31', N'Bình Dương', N'Bánh kẹo', N'Bánh quy vị bơ'),
('H009', N'Xúc xích tiệt trùng', 15000, N'Cây', '2025-11-30', N'Đồng Nai', N'Đồ nguội', N'Xúc xích ăn liền'),
('H010', N'Trái cây sấy tổng hợp', 42000, N'Gói', '2026-09-30', N'Lâm Đồng', N'Snack', N'Trái cây sấy hỗn hợp'),
('H011', N'Gạo Nhật Japonica', 35000, N'Kg', '2027-01-31', N'An Giang', N'Lương thực', N'Gạo dẻo hạt tròn'),
('H012', N'Bột ngọt 454g', 27000, N'Gói', '2026-12-31', N'TP.HCM', N'Gia vị', N'Bột ngọt tinh luyện'),
('H013', N'Nước tương đậm đặc', 30000, N'Chai', '2027-03-15', N'Bình Dương', N'Gia vị', N'Nước tương đậu nành lên men'),
('H014', N'Dầu ô liu nguyên chất', 125000, N'Chai', '2028-07-01', N'Tây Ban Nha', N'Dầu ăn', N'Dầu ô liu Extra Virgin'),
('H015', N'Mì trứng tươi', 17000, N'Gói', '2025-12-30', N'TP.HCM', N'Thực phẩm khô', N'Mì trứng làm từ lúa mì'),
('H016', N'Sữa chua uống', 11000, N'Chai', '2025-05-25', N'Hưng Yên', N'Sữa', N'Sữa chua uống men sống'),
('H017', N'Nước ngọt có gas', 14000, N'Lon', '2027-02-28', N'Đà Nẵng', N'Đồ uống', N'Nước giải khát có gas'),
('H018', N'Bánh xốp kem vani', 24000, N'Hộp', '2026-07-30', N'Bình Dương', N'Bánh kẹo', N'Bánh xốp kem hương vani'),
('H019', N'Phô mai que', 18000, N'Gói', '2025-04-20', N'Đồng Nai', N'Đồ nguội', N'Phô mai que chiên giòn'),
('H020', N'Khoai tây chiên lát', 25000, N'Gói', '2026-11-15', N'Lâm Đồng', N'Snack', N'Khoai tây chiên vị mặn'),
('H021', N'Gạo nếp thơm', 28000, N'Kg', '2027-10-30', N'Cần Thơ', N'Lương thực', N'Gạo nếp dẻo thơm'),
('H022', N'Bột canh i-ốt', 9000, N'Gói', '2026-06-15', N'Hà Nội', N'Gia vị', N'Bột canh bổ sung i-ốt'),
('H023', N'Gia vị lẩu thái', 18000, N'Gói', '2026-10-10', N'TP.HCM', N'Gia vị', N'Gia vị lẩu hương vị Thái'),
('H024', N'Dầu gạo nguyên chất', 95000, N'Chai', '2028-01-20', N'Cần Thơ', N'Dầu ăn', N'Dầu gạo nguyên chất'),
('H025', N'Mì Omachi sốt bò', 8000, N'Gói', '2026-08-01', N'TP.HCM', N'Thực phẩm khô', N'Mì ăn liền vị bò'),
('H026', N'Sữa đặc có đường', 29000, N'Hộp', '2027-02-01', N'Bình Dương', N'Sữa', N'Sữa đặc béo ngậy'),
('H027', N'Nước trái cây cam ép', 17000, N'Hộp', '2026-12-12', N'Tây Ninh', N'Đồ uống', N'Nước cam 100%'),
('H028', N'Bánh bông lan trứng muối', 45000, N'Hộp', '2026-07-15', N'Đồng Nai', N'Bánh kẹo', N'Bánh bông lan nhân trứng muối'),
('H029', N'Xúc xích hun khói', 22000, N'Cây', '2025-11-05', N'Hà Nội', N'Đồ nguội', N'Xúc xích hun khói kiểu Đức'),
('H030', N'Rong biển sấy giòn', 30000, N'Gói', '2027-03-20', N'Hàn Quốc', N'Snack', N'Rong biển sấy giòn vị truyền thống');


INSERT INTO Nhanvien (MaNV, TenNV, Gioitinh, Ngaysinh, SDT, DiachiNV, Chucvu) VALUES
('NV001', N'Nguyễn Văn An', N'Nam', '1998-03-15', '0901123456', N'12 Nguyễn Trãi, P.3, Q.1, TP.HCM', N'Nhân viên bán hàng'),
('NV002', N'Trần Thị Bình', N'Nữ', '1999-07-22', '0902987654', N'45 Cách Mạng Tháng 8, P.10, Q.3, TP.HCM', N'Kế toán'),
('NV003', N'Lê Minh Cường', N'Nam', '1997-11-05', '0903874521', N'78 Điện Biên Phủ, P.15, Q.Bình Thạnh, TP.HCM', N'Quản lý cửa hàng'),
('NV004', N'Phạm Thị Dung', N'Nữ', '2000-01-19', '0904231876', N'22 Lý Thường Kiệt, P.7, Q.10, TP.HCM', N'Thủ kho'),
('NV005', N'Hoàng Văn Em', N'Nam', '1996-09-09', '0905789123', N'9 Trường Chinh, P.14, Q.Tân Bình, TP.HCM', N'Nhân viên bán hàng'),
('NV006', N'Nguyễn Thị Hồng', N'Nữ', '2001-04-12', '0906453128', N'101 Nguyễn Văn Đậu, P.5, Q.Phú Nhuận, TP.HCM', N'Nhân viên bán hàng'),
('NV007', N'Đỗ Quốc Huy', N'Nam', '1995-12-02', '0907894561', N'56 Ung Văn Khiêm, P.25, Q.Bình Thạnh, TP.HCM', N'Thủ kho'),
('NV008', N'Võ Thị Lan', N'Nữ', '1998-06-30', '0908567432', N'23 Nguyễn Hữu Thọ, P.Tân Phong, Q.7, TP.HCM', N'Nhân viên bán hàng'),
('NV009', N'Bùi Anh Tuấn', N'Nam', '1997-02-14', '0909345678', N'12A Dương Bá Trạc, P.2, Q.8, TP.HCM', N'Admin'),
('NV010', N'Ngô Thị Yến', N'Nữ', '1999-10-25', '0910123456', N'80 Hoàng Hoa Thám, P.7, Q.Bình Thạnh, TP.HCM', N'Kế toán'),
('NV011', N'Lâm Hoàng Phúc', N'Nam', '1996-06-21', '0911789456', N'150 Nguyễn Thị Minh Khai, P.6, Q.3, TP.HCM', N'Nhân viên bán hàng'),
('NV012', N'Nguyễn Thị Thu', N'Nữ', '1998-08-17', '0912654987', N'34 Phạm Văn Đồng, P.1, Q.Gò Vấp, TP.HCM', N'Nhân viên bán hàng'),
('NV013', N'Trần Quốc Long', N'Nam', '1995-05-09', '0913987123', N'19 Trần Huy Liệu, P.12, Q.Phú Nhuận, TP.HCM', N'Quản lý cửa hàng'),
('NV014', N'Lê Thị Liên', N'Nữ', '2000-03-01', '0914765123', N'67 Nguyễn Thái Học, P.Cầu Ông Lãnh, Q.1, TP.HCM', N'Thủ kho'),
('NV015', N'Đặng Hữu Nghĩa', N'Nam', '1997-12-28', '0915238741', N'88 Trần Bình Trọng, P.1, Q.10, TP.HCM', N'Nhân viên bán hàng'),
('NV016', N'Phạm Thu Hằng', N'Nữ', '1999-09-15', '0916123987', N'101 Nguyễn Sơn, P.Phú Thạnh, Q.Tân Phú, TP.HCM', N'Kế toán'),
('NV017', N'Hoàng Gia Huy', N'Nam', '1994-11-22', '0917345621', N'27 Võ Văn Ngân, P.Linh Chiểu, TP.Thủ Đức', N'Thủ kho'),
('NV018', N'Võ Ngọc Trâm', N'Nữ', '1998-02-10', '0918456732', N'11 Nguyễn Ảnh Thủ, P.Trung Mỹ Tây, Q.12, TP.HCM', N'Nhân viên bán hàng'),
('NV019', N'Đinh Minh Khôi', N'Nam', '1996-07-27', '0919543762', N'5 Nguyễn Văn Lượng, P.10, Q.Gò Vấp, TP.HCM', N'Admin'),
('NV020', N'Lý Thị Tố Anh', N'Nữ', '2001-05-18', '0920345671', N'301 Lãnh Binh Thăng, P.8, Q.11, TP.HCM', N'Kế toán'),
('NV021', N'Nguyễn Tấn Lộc', N'Nam', '1998-11-11', '0921456783', N'20 Vũ Tùng, P.2, Q.Bình Thạnh, TP.HCM', N'Nhân viên bán hàng'),
('NV022', N'Phan Thị Nhung', N'Nữ', '1997-01-29', '0922567891', N'41 Bạch Đằng, P.2, Q.Tân Bình, TP.HCM', N'Thủ kho'),
('NV023', N'Huỳnh Minh Thiện', N'Nam', '1995-02-24', '0923678912', N'90 Nguyễn Ảnh Thủ, Q.12, TP.HCM', N'Quản lý cửa hàng'),
('NV024', N'Lê Hồng Ngọc', N'Nữ', '1999-12-14', '0924789123', N'55 Lê Văn Việt, P.Hiệp Phú, TP.Thủ Đức', N'Nhân viên bán hàng'),
('NV025', N'Đào Văn Hòa', N'Nam', '1996-03-30', '0925879314', N'72 Nguyễn Tri Phương, P.7, Q.5, TP.HCM', N'Nhân viên bán hàng'),
('NV026', N'Vũ Thị Mỹ Duyên', N'Nữ', '2000-01-05', '0926987431', N'144 Tô Hiến Thành, P.15, Q.10, TP.HCM', N'Kế toán'),
('NV027', N'Hoàng Minh Trí', N'Nam', '1994-09-17', '0927891432', N'88 Thành Thái, P.14, Q.10, TP.HCM', N'Thủ kho'),
('NV028', N'Trần Mỹ Hạnh', N'Nữ', '1998-06-03', '0928945123', N'315 Nguyễn Oanh, P.10, Q.Gò Vấp, TP.HCM', N'Nhân viên bán hàng'),
('NV029', N'Đặng Quốc Thịnh', N'Nam', '1997-04-22', '0929456132', N'45 Hoàng Văn Thụ, P.8, Q.Phú Nhuận, TP.HCM', N'Admin'),
('NV030', N'Ngô Thị Thanh', N'Nữ', '1999-11-09', '0930123456', N'50 Trần Não, P.An Phú, TP.Thủ Đức', N'Nhân viên bán hàng');


INSERT INTO Khachhang (MaKH, TenKH, DiachiKH, SDTKH, NgaysinhKH, GioitinhKH) VALUES
('KH001', N'Nguyễn Thị Hoa', N'12 Nguyễn Trãi, P.3, Q.1, TP.HCM', '0911123456', '1990-05-10', N'Nữ'),
('KH002', N'Lê Văn Nam', N'45 CMT8, P.10, Q.3, TP.HCM', '0912234567', '1988-08-20', N'Nam'),
('KH003', N'Trần Thị Mai', N'78 Điện Biên Phủ, P.15, Q.Bình Thạnh', '0913345678', '1995-03-12', N'Nữ'),
('KH004', N'Phạm Minh Tâm', N'22 Lý Thường Kiệt, P.7, Q.10', '0914456789', '1992-11-01', N'Nam'),
('KH005', N'Hoàng Thu Hà', N'9 Trường Chinh, P.14, Q.Tân Bình', '0915567890', '1996-07-07', N'Nữ'),
('KH006', N'Đỗ Quang Huy', N'101 Nguyễn Văn Đậu, P.5, Q.Phú Nhuận', '0916678901', '1993-01-25', N'Nam'),
('KH007', N'Võ Thị Hạnh', N'56 Ung Văn Khiêm, P.25, Q.Bình Thạnh', '0917789012', '1994-09-18', N'Nữ'),
('KH008', N'Bùi Anh Đức', N'23 Nguyễn Hữu Thọ, P.Tân Phong, Q.7', '0918890123', '1989-12-30', N'Nam'),
('KH009', N'Ngô Mỹ Linh', N'12A Dương Bá Trạc, P.2, Q.8', '0919901234', '1997-04-05', N'Nữ'),
('KH010', N'Lý Quốc Khánh', N'80 Hoàng Hoa Thám, P.7, Q.Bình Thạnh', '0920012345', '1991-02-28', N'Nam'),
('KH011', N'Huỳnh Thị Ánh', N'34 Phạm Văn Đồng, P.1, Q.Gò Vấp', '0921123456', '1998-10-11', N'Nữ'),
('KH012', N'Nguyễn Tấn Phát', N'19 Trần Huy Liệu, P.12, Q.Phú Nhuận', '0922234567', '1994-03-21', N'Nam'),
('KH013', N'Phan Thị Yến', N'67 Nguyễn Thái Học, P.Cầu Ông Lãnh, Q.1', '0923345678', '1999-01-03', N'Nữ'),
('KH014', N'Lê Quốc Đạt', N'88 Trần Bình Trọng, P.1, Q.10', '0924456789', '1993-09-14', N'Nam'),
('KH015', N'Đặng Ngọc Hà', N'101 Nguyễn Sơn, P.Phú Thạnh, Q.Tân Phú', '0925567890', '1997-06-30', N'Nữ'),
('KH016', N'Vũ Minh Tuấn', N'27 Võ Văn Ngân, P.Linh Chiểu, TP.Thủ Đức', '0926678901', '1995-07-19', N'Nam'),
('KH017', N'Trần Mỹ Duyên', N'11 Nguyễn Ảnh Thủ, P.Trung Mỹ Tây, Q.12', '0927789012', '1998-12-25', N'Nữ'),
('KH018', N'Hoàng Nhật Huy', N'5 Nguyễn Văn Lượng, P.10, Q.Gò Vấp', '0928890123', '1992-03-30', N'Nam'),
('KH019', N'Tô Thị Thuỷ', N'301 Lãnh Binh Thăng, P.8, Q.11', '0929901234', '1996-02-28', N'Nữ'),
('KH020', N'Nguyễn Đình Khoa', N'20 Vũ Tùng, P.2, Q.Bình Thạnh', '0930012345', '1990-10-22', N'Nam'),
('KH021', N'Hồ Bích Ngọc', N'41 Bạch Đằng, P.2, Q.Tân Bình', '0931123456', '1999-07-01', N'Nữ'),
('KH022', N'Đinh Tuấn Hải', N'90 Nguyễn Ảnh Thủ, Q.12', '0932234567', '1994-04-15', N'Nam'),
('KH023', N'Trương Thị Minh', N'55 Lê Văn Việt, P.Hiệp Phú, TP.Thủ Đức', '0933345678', '1997-11-05', N'Nữ'),
('KH024', N'Đoàn Hữu Nghĩa', N'72 Nguyễn Tri Phương, P.7, Q.5', '0934456789', '1995-08-09', N'Nam'),
('KH025', N'Lý Thị Thanh', N'144 Tô Hiến Thành, P.15, Q.10', '0935567890', '1998-01-27', N'Nữ'),
('KH026', N'Phạm Đức Long', N'88 Thành Thái, P.14, Q.10', '0936678901', '1993-06-17', N'Nam'),
('KH027', N'Trần Nhật Phương', N'315 Nguyễn Oanh, P.10, Q.Gò Vấp', '0937789012', '1996-12-12', N'Nữ'),
('KH028', N'Võ Minh Khôi', N'45 Hoàng Văn Thụ, P.8, Q.Phú Nhuận', '0938890123', '1992-09-20', N'Nam'),
('KH029', N'Đặng Ngọc Trâm', N'50 Trần Não, P.An Phú, TP.Thủ Đức', '0939901234', '1999-03-14', N'Nữ'),
('KH030', N'Nguyễn Thiện Phúc', N'28 Lê Lợi, P.Bến Nghé, Q.1', '0940012345', '1995-02-20', N'Nam');


INSERT INTO Hoadon (MaHD, Ngayban, Tongtien, PTTT, MaKH, MaNV) VALUES
('HD001', '2025-11-01', 152000, N'Tiền mặt', 'KH001', 'NV001'),
('HD002', '2025-11-01', 235000, N'Chuyển khoản', 'KH002', 'NV005'),
('HD003', '2025-11-02', 89000, N'Tiền mặt', 'KH003', 'NV008'),
('HD004', '2025-11-02', 318000, N'Ví điện tử', 'KH004', 'NV006'),
('HD005', '2025-11-03', 127000, N'Tiền mặt', 'KH005', 'NV012'),
('HD006', '2025-11-03', 98000, N'Chuyển khoản', 'KH006', 'NV002'),
('HD007', '2025-11-04', 450000, N'Ví điện tử', 'KH007', 'NV003'),
('HD008', '2025-11-04', 67000, N'Tiền mặt', 'KH008', 'NV001'),
('HD009', '2025-11-05', 231000, N'Chuyển khoản', 'KH009', 'NV016'),
('HD010', '2025-11-05', 192000, N'Tiền mặt', 'KH010', 'NV018'),
('HD011', '2025-11-06', 158000, N'Ví điện tử', 'KH011', 'NV001'),
('HD012', '2025-11-06', 244000, N'Tiền mặt', 'KH012', 'NV008'),
('HD013', '2025-11-07', 93000, N'Chuyển khoản', 'KH013', 'NV005'),
('HD014', '2025-11-07', 365000, N'Ví điện tử', 'KH014', 'NV006'),
('HD015', '2025-11-08', 121000, N'Tiền mặt', 'KH015', 'NV012'),
('HD016', '2025-11-08', 98000, N'Chuyển khoản', 'KH016', 'NV002'),
('HD017', '2025-11-09', 450000, N'Tiền mặt', 'KH017', 'NV003'),
('HD018', '2025-11-09', 77000, N'Ví điện tử', 'KH018', 'NV001'),
('HD019', '2025-11-10', 268000, N'Chuyển khoản', 'KH019', 'NV016'),
('HD020', '2025-11-10', 199000, N'Tiền mặt', 'KH020', 'NV018');



INSERT INTO Chitiet_Hoadon (SL_hangban, Dongia_ban, Magiamgia, TKNo, TKCo, MaH, MaHD) VALUES
(2, 24000, NULL, '131101', '511101', 'H001', 'HD001'),
(1, 18000, NULL, '131101', '511101', 'H002', 'HD001'),
(1, 6000,  NULL, '131101', '511101', 'H005', 'HD001'),
(3, 38000, NULL, '131101', '511101', 'H008', 'HD002'),
(1, 52000, NULL, '131101', '511101', 'H004', 'HD002'),
(2, 32000, NULL, '131101', '511101', 'H006', 'HD003'),
(1, 45000, NULL, '131101', '511101', 'H003', 'HD004'),
(2, 5000,  NULL, '131101', '511101', 'H007', 'HD004'),
(1, 38000, NULL, '131101', '511101', 'H008', 'HD004'),
(3, 6000,  NULL, '131101', '511101', 'H005', 'HD004'),
(1, 42000, NULL, '131101', '511101', 'H010', 'HD005'),
(2, 6000,  NULL, '131101', '511101', 'H005', 'HD005'),
(1, 32000, NULL, '131101', '511101', 'H006', 'HD006'),
(2, 15000, NULL, '131101', '511101', 'H009', 'HD006'),
(1, 24000, NULL, '131101', '511101', 'H001', 'HD006'),
(2, 45000, NULL, '131101', '511101', 'H003', 'HD007'),
(2, 38000, NULL, '131101', '511101', 'H008', 'HD007'),
(1, 52000, NULL, '131101', '511101', 'H004', 'HD007'),
(3, 5000,  NULL, '131101', '511101', 'H007', 'HD007'),
(1, 67000, NULL, '131101', '511101', 'H004', 'HD008'),
(2, 18000, NULL, '131101', '511101', 'H002', 'HD009'),
(1, 38000, NULL, '131101', '511101', 'H008', 'HD009'),
(1, 24000, NULL, '131101', '511101', 'H001', 'HD009'),
(1, 15000, NULL, '131101', '511101', 'H009', 'HD010'),
(3, 6000,  NULL, '131101', '511101', 'H005', 'HD010'),
(2, 24000, NULL, '131101', '511101', 'H001', 'HD011'),
(1, 38000, NULL, '131101', '511101', 'H008', 'HD011'),
(1, 6000,  NULL, '131101', '511101', 'H005', 'HD012'),
(1, 32000, NULL, '131101', '511101', 'H006', 'HD012'),
(2, 5000,  NULL, '131101', '511101', 'H007', 'HD012'),
(1, 38000, NULL, '131101', '511101', 'H008', 'HD012'),
(1, 42000, NULL, '131101', '511101', 'H010', 'HD012'),
(3, 6000, NULL, '131101', '511101', 'H005', 'HD013'),
(1, 125000, NULL, '131101', '511101', 'H014', 'HD014'),
(1, 30000,  NULL, '131101', '511101', 'H013', 'HD014'),
(2, 24000,  NULL, '131101', '511101', 'H001', 'HD014'),
(1, 38000,  NULL, '131101', '511101', 'H008', 'HD014'),
(1, 17000, NULL, '131101', '511101', 'H015', 'HD015'),
(2, 11000, NULL, '131101', '511101', 'H016', 'HD015'),
(1, 5000,  NULL, '131101', '511101', 'H007', 'HD015'),
(1, 24000, NULL, '131101', '511101', 'H001', 'HD016'),
(1, 18000, NULL, '131101', '511101', 'H002', 'HD016'),
(2, 38000, NULL, '131101', '511101', 'H008', 'HD017'),
(1, 45000, NULL, '131101', '511101', 'H003', 'HD017'),
(1, 52000, NULL, '131101', '511101', 'H004', 'HD017'),
(1, 5000, NULL, '131101', '511101', 'H007', 'HD018'),
(2, 30000, NULL, '131101', '511101', 'H018', 'HD019'),
(1, 25000, NULL, '131101', '511101', 'H020', 'HD019'),
(1, 38000, NULL, '131101', '511101', 'H008', 'HD019'),
(1, 42000, NULL, '131101', '511101', 'H010', 'HD019'),
(1, 30000, NULL, '131101', '511101', 'H030', 'HD020'),
(2, 18000, NULL, '131101', '511101', 'H012', 'HD020'),
(1, 24000, NULL, '131101', '511101', 'H001', 'HD020');


INSERT INTO Nhacungcap (MaNCC, TenNCC, Diachi, Email) VALUES
('NCC001', N'Công ty Gạo An Phát', N'12 Quốc lộ 1A, TP.Tân An, Long An', 'contact@anphat.vn'),
('NCC002', N'Công ty Đường Ngọt Việt', N'45 Đại lộ Bình Dương, TP.Thủ Dầu Một', 'info@duongngot.vn'),
('NCC003', N'Nước mắm Biển Xanh', N'22 Trần Hưng Đạo, TP.Phú Quốc, Kiên Giang', 'sales@bienxanh.vn'),
('NCC004', N'Dầu Thực Vật Sài Gòn', N'90 Tân Sơn Nhì, Q.Tân Phú, TP.HCM', 'support@dausaigon.vn'),
('NCC005', N'Sữa Tươi Miền Nam', N'15 Lê Duẩn, TP.Biên Hòa, Đồng Nai', 'info@suatmnam.vn'),
('NCC006', N'Công ty Bánh Kẹo Ngọt Ngào', N'88 Lê Hồng Phong, TP.Thủ Dầu Một', 'contact@ngotngao.vn'),
('NCC007', N'Nước Uống Xanh', N'67 Hai Bà Trưng, TP.Bảo Lộc, Lâm Đồng', 'nuocuongxanh@gmail.com'),
('NCC008', N'Thực Phẩm Chay An Lạc', N'23 Nguyễn Trãi, Quận 5, TP.HCM', 'cs@anlacfoods.vn'),
('NCC009', N'Xúc Xích Đức Việt', N'120 Giải Phóng, Quận Hoàng Mai, Hà Nội', 'dv@ducvietfoods.vn'),
('NCC010', N'Trái Cây Sấy Đà Lạt', N'33 Hoàng Diệu, TP.Đà Lạt, Lâm Đồng', 'dalatdryfruit@gmail.com'),
('NCC011', N'Công ty Nước Giải Khát Miền Nam', N'48 Nguyễn Văn Linh, Q.7, TP.HCM', 'drink@sbg.vn'),
('NCC012', N'Gia Vị Việt Nam', N'77 Trường Chinh, Q.Tân Bình, TP.HCM', 'giavi@vfoods.vn'),
('NCC013', N'Dầu Ăn Golden Oil', N'55 Võ Văn Kiệt, Quận 1, TP.HCM', 'goldenoil@gmail.com'),
('NCC014', N'Thực Phẩm Khô Đại Lộc', N'90 Lê Văn Việt, TP.Thủ Đức', 'dryfoods@dailoc.vn'),
('NCC015', N'Công ty Sữa Chua Thành Phát', N'19 Nguyễn Văn Cừ, Q.5, TP.HCM', 'sp@thanhphatmilk.vn'),
('NCC016', N'Nước Ngọt Hồng Hà', N'5 Trần Phú, TP.Đà Nẵng', 'hongha.drink@gmail.com'),
('NCC017', N'Gia Vị Quốc Việt', N'60 CMT8, Q.3, TP.HCM', 'quocviet.spice@gmail.com'),
('NCC018', N'Thực Phẩm Đông Lạnh Đại Dương', N'88 Nguyễn Thị Minh Khai, Q.1, TP.HCM', 'coldfood@daiduong.vn'),
('NCC019', N'Bánh Snack Hảo Hạng', N'34 Pasteur, Q.1, TP.HCM', 'snackpremium@gmail.com'),
('NCC020', N'Đồ Uống Trà Xanh Thiên Nhiên', N'210 Võ Thị Sáu, Q.3, TP.HCM', 'greentea@thiennhien.vn');


INSERT INTO Phieukiemke (MaPKK, NgayKK, GhichuPKK, MaNV) VALUES
('PKK001', '2025-01-31', N'Kiểm kê định kỳ cuối tháng 1', 'NV004'),
('PKK002', '2025-02-28', N'Kiểm kê hàng cận date tháng 2', 'NV007'),
('PKK003', '2025-03-31', N'Kiểm kê tồn kho quý 1', 'NV003'),
('PKK004', '2025-04-30', N'Kiểm kê hàng hóa quầy rau củ', 'NV004'),
('PKK005', '2025-05-31', N'Kiểm kê kho chính định kỳ', 'NV007'),
('PKK006', '2025-06-30', N'Kiểm kê hàng khuyến mãi', 'NV003'),
('PKK007', '2025-07-31', N'Kiểm kê kho lạnh', 'NV004'),
('PKK008', '2025-08-31', N'Kiểm kê hàng đông lạnh', 'NV007'),
('PKK009', '2025-09-30', N'Kiểm kê quý 3, điều chỉnh tồn kho', 'NV003'),
('PKK010', '2025-10-31', N'Kiểm kê hàng hóa cận hạn sử dụng', 'NV004'),
('PKK011', '2025-11-15', N'Kiểm kê đột xuất theo yêu cầu quản lý', 'NV003'),
('PKK012', '2025-11-30', N'Kiểm kê cuối tháng 11', 'NV004'),
('PKK013', '2025-12-15', N'Kiểm kê chuẩn bị cuối năm', 'NV007'),
('PKK014', '2025-12-25', N'Kiểm kê giai đoạn cao điểm lễ tết', 'NV004'),
('PKK015', '2025-12-31', N'Kiểm kê tổng hợp cuối năm', 'NV003');


INSERT INTO Chitiet_PKK (SL_hangKK, MaH, MaPKK) VALUES
(120, 'H001', 'PKK001'),
(85,  'H002', 'PKK001'),
(60,  'H003', 'PKK001'),
(45,  'H004', 'PKK001'),
(150, 'H005', 'PKK002'),
(90,  'H006', 'PKK002'),
(70,  'H007', 'PKK002'),
(50,  'H008', 'PKK002'),
(40,  'H009', 'PKK003'),
(55,  'H010', 'PKK003'),
(65,  'H011', 'PKK003'),
(30,  'H012', 'PKK003'),
(110, 'H013', 'PKK004'),
(95,  'H014', 'PKK004'),
(130, 'H015', 'PKK004'),
(70,  'H016', 'PKK004'),
(200, 'H017', 'PKK005'),
(160, 'H018', 'PKK005'),
(140, 'H019', 'PKK005'),
(180, 'H020', 'PKK005'),
(90,  'H001', 'PKK006'),
(75,  'H005', 'PKK006'),
(60,  'H009', 'PKK006'),
(45,  'H002', 'PKK007'),
(50,  'H006', 'PKK007'),
(35,  'H010', 'PKK007'),
(80,  'H003', 'PKK008'),
(55,  'H007', 'PKK008'),
(40,  'H011', 'PKK008'),
(100, 'H004', 'PKK009'),
(85,  'H008', 'PKK009'),
(65,  'H012', 'PKK009'),
(70,  'H013', 'PKK010'),
(55,  'H017', 'PKK010'),
(45,  'H021', 'PKK010'),
(60,  'H014', 'PKK011'),
(50,  'H018', 'PKK011'),
(95,  'H015', 'PKK012'),
(80,  'H019', 'PKK012'),
(110, 'H016', 'PKK013'),
(90,  'H020', 'PKK013'),
(150, 'H021', 'PKK014'),
(120, 'H022', 'PKK014'),
(130, 'H023', 'PKK015'),
(105, 'H024', 'PKK015');


INSERT INTO Phieuxuat (MaPX, Ngayxuat, GhichuPX, MaNV) VALUES
('PX001', '2025-11-01', N'Xuất hàng bán lẻ ca sáng', 'NV005'),
('PX002', '2025-11-05', N'Xuất hàng bán lẻ ca tối', 'NV008'),
('PX003', '2025-11-09', N'Xuất hàng giao cho khách đặt online', 'NV001'),
('PX004', '2025-11-10', N'Xuất hàng cho đại lý khu vực quận 7', 'NV011'),
('PX005', '2025-11-14', N'Xuất hàng khuyến mãi cuối tuần', 'NV015'),
('PX006', '2025-11-19', N'Xuất điều chuyển hàng sang kho chi nhánh 2', 'NV004'),
('PX007', '2025-11-20', N'Xuất hàng hủy do hết hạn sử dụng', 'NV007'),
('PX008', '2025-11-27', N'Xuất hàng tặng cho chương trình tri ân khách hàng', 'NV018'),
('PX009', '2025-11-30', N'Xuất hàng bổ sung quầy kệ siêu thị', 'NV021'),
('PX010', '2025-12-08', N'Xuất hàng giao hợp đồng tiệc cưới', 'NV013'),
('PX011', '2025-12-06', N'Xuất hàng trả lại nhà cung cấp do lỗi bao bì', 'NV022'),
('PX012', '2025-12-26', N'Xuất hàng mẫu dùng thử cho khách', 'NV028'),
('PX013', '2025-12-07', N'Xuất hàng điều chỉnh tồn kho sau kiểm kê', 'NV004'),
('PX014', '2025-12-19', N'Xuất hàng phục vụ nội bộ cửa hàng', 'NV003'),
('PX015', '2025-12-22', N'Xuất hàng bán buôn cho siêu thị đối tác', 'NV023');


INSERT INTO Chitiet_PX (SL_hangxuat, Dongiaxuat, MaH, MaPX) VALUES
(20, 24000, 'H001', 'PX001'),
(15, 18000, 'H002', 'PX001'),
(30, 6000,  'H005', 'PX001'),
(25, 5000,  'H007', 'PX002'),
(18, 32000, 'H006', 'PX002'),
(10, 38000, 'H008', 'PX002'),
(12, 24000, 'H001', 'PX003'),
(8,  45000, 'H003', 'PX003'),
(20, 6000,  'H005', 'PX003'),
(10, 15000, 'H009', 'PX003'),
(40, 24000, 'H001', 'PX004'),
(30, 18000, 'H002', 'PX004'),
(25, 45000, 'H003', 'PX004'),
(20, 52000, 'H004', 'PX004'),
(35, 6000,  'H005', 'PX005'),
(25, 5000,  'H007', 'PX005'),
(15, 38000, 'H008', 'PX005'),
(30, 24000, 'H001', 'PX006'),
(20, 32000, 'H006', 'PX006'),
(18, 42000, 'H010', 'PX006'),
(10, 32000, 'H006', 'PX007'),
(8,  15000, 'H009', 'PX007'),
(12, 38000, 'H008', 'PX007'),
(20, 5000,  'H007', 'PX008'),
(15, 6000,  'H005', 'PX008'),
(10, 38000, 'H008', 'PX008'),
(25, 24000, 'H001', 'PX009'),
(20, 18000, 'H002', 'PX009'),
(15, 30000, 'H018', 'PX009'),
(30, 45000, 'H003', 'PX010'),
(25, 52000, 'H004', 'PX010'),
(40, 5000,  'H007', 'PX010'),
(10, 24000, 'H001', 'PX011'),
(12, 18000, 'H002', 'PX011'),
(8,  52000, 'H004', 'PX011'),
(5,  6000,  'H005', 'PX012'),
(5,  32000, 'H006', 'PX012'),
(5,  42000, 'H010', 'PX012'),
(15, 24000, 'H001', 'PX013'),
(10, 18000, 'H002', 'PX013'),
(8,  6000,  'H005', 'PX013'),
(6,  38000, 'H008', 'PX013'),
(10, 32000, 'H006', 'PX014'),
(8,  30000, 'H018', 'PX014'),
(6,  25000, 'H020', 'PX014'),
(50, 24000, 'H001', 'PX015'),
(40, 18000, 'H002', 'PX015'),
(30, 45000, 'H003', 'PX015'),
(20, 52000, 'H004', 'PX015');


INSERT INTO Phieunhap (MaPN, Ngaynhap, Tongtiennhap, GhichuPN, MaNV, MaNCC) VALUES
('PN001', '2025-10-28', 13500000, N'Nhập gạo An Phát đợt 1', 'NV004', 'NCC001'),
('PN002', '2025-10-29', 8200000,  N'Nhập đường Ngọt Việt', 'NV007', 'NCC002'),
('PN003', '2025-10-30', 5600000,  N'Nhập nước mắm Biển Xanh', 'NV012', 'NCC003'),
('PN004', '2025-11-01', 14500000, N'Nhập dầu ăn Sài Gòn', 'NV004', 'NCC004'),
('PN005', '2025-11-01', 9800000,  N'Nhập sữa tươi Miền Nam', 'NV016', 'NCC005'),
('PN006', '2025-11-02', 6200000,  N'Nhập bánh kẹo Ngọt Ngào', 'NV004', 'NCC006'),
('PN007', '2025-11-02', 7200000,  N'Nhập nước uống đóng chai Xanh', 'NV007', 'NCC007'),
('PN008', '2025-11-03', 4800000,  N'Nhập thực phẩm chay An Lạc', 'NV012', 'NCC008'),
('PN009', '2025-11-03', 15600000, N'Nhập xúc xích Đức Việt', 'NV004', 'NCC009'),
('PN010', '2025-11-04', 5100000,  N'Nhập trái cây sấy Đà Lạt', 'NV016', 'NCC010'),
('PN011', '2025-11-04', 8700000,  N'Nhập nước giải khát Miền Nam', 'NV004', 'NCC011'),
('PN012', '2025-11-05', 6900000,  N'Nhập gia vị Việt Nam', 'NV007', 'NCC012'),
('PN013', '2025-11-05', 11200000, N'Nhập dầu ăn Golden Oil', 'NV012', 'NCC013'),
('PN014', '2025-11-06', 7600000,  N'Nhập thực phẩm khô Đại Lộc', 'NV004', 'NCC014'),
('PN015', '2025-11-06', 5400000,  N'Nhập sữa chua Thành Phát', 'NV016', 'NCC015');


INSERT INTO Chitiet_PN (SL_hangnhap, Dongianhap, MaH, MaPN) VALUES
(200, 18000, 'H001', 'PN001'),
(150, 16000, 'H002', 'PN001'),
(180, 12000, 'H005', 'PN002'),
(120, 10000, 'H007', 'PN002'),
(90, 37000, 'H003', 'PN003'),
(70, 45000, 'H004', 'PN003'),
(200, 48000, 'H006', 'PN004'),
(150, 50000, 'H008', 'PN004'),
(180, 13500, 'H009', 'PN005'),
(160, 14000, 'H010', 'PN005'),
(220, 4000, 'H011', 'PN006'),
(180, 3500, 'H012', 'PN006'),
(300, 3000, 'H013', 'PN007'),
(250, 2800, 'H014', 'PN007'),
(120, 12000, 'H015', 'PN008'),
(90,  10000, 'H016', 'PN008'),
(180, 38000, 'H017', 'PN009'),
(150, 36000, 'H018', 'PN009'),
(140, 22000, 'H019', 'PN010'),
(110, 20000, 'H020', 'PN010'),
(250, 6000, 'H021', 'PN011'),
(200, 5500, 'H022', 'PN011'),
(130, 9000, 'H023', 'PN012'),
(120, 8500, 'H024', 'PN012'),
(210, 46000, 'H006', 'PN013'),
(180, 43000, 'H008', 'PN013'),
(150, 15000, 'H025', 'PN014'),
(120, 14000, 'H026', 'PN014'),
(170, 11000, 'H027', 'PN015'),
(130, 10000, 'H028', 'PN015');


INSERT INTO Taikhoan (Username, Password, MaNV) VALUES
('bh01', '123456', 'NV001'),
('kt02', '123456', 'NV002'),
('ql03', '123456', 'NV003'),
('kho04', '123456', 'NV004'),
('bh05', '123456', 'NV005'),
('bh06', '123456', 'NV006'),
('kho07', '123456', 'NV007'),
('bh08', '123456', 'NV008'),
('admin09', '123456', 'NV009'),
('kt10', '123456', 'NV010'),
('bh11', '123456', 'NV011'),
('bh12', '123456', 'NV012'),
('ql13', '123456', 'NV013'),
('kho14', '123456', 'NV014'),
('bh15', '123456', 'NV015'),
('kt16', '123456', 'NV016'),
('kho17', '123456', 'NV017'),
('bh18', '123456', 'NV018'),
('admin19', '123456', 'NV019'),
('kt20', '123456', 'NV020'),
('bh21', '123456', 'NV021'),
('kho22', '123456', 'NV022'),
('ql23', '123456', 'NV023'),
('bh24', '123456', 'NV024'),
('bh25', '123456', 'NV025'),
('kt26', '123456', 'NV026'),
('kho27', '123456', 'NV027'),
('bh28', '123456', 'NV028'),
('admin29', '123456', 'NV029'),
('bh30', '123456', 'NV030');


INSERT INTO DMTK1 (SoTKC1, TenTKC1, Ghichu_TKC1) VALUES
('111', N'Tiền mặt', NULL),
('112', N'Tiền gửi ngân hàng', NULL),
('131', N'Phải thu khách hàng', NULL),
('133', N'Thuế GTGT được khấu trừ', NULL),
('141', N'Tạm ứng', NULL),
('151', N'Hàng mua đang đi đường', NULL),
('152', N'Nguyên liệu, vật liệu', NULL),
('153', N'Công cụ, dụng cụ', NULL),
('156', N'Hàng hóa', NULL),
('157', N'Hàng gửi đi bán', NULL),
('331', N'Phải trả người bán', NULL),
('333', N'Thuế và các khoản phải nộp Nhà nước', NULL),
('334', N'Phải trả người lao động', NULL),
('511', N'Doanh thu bán hàng và cung cấp dịch vụ', NULL),
('521', N'Các khoản giảm trừ doanh thu', NULL),
('632', N'Giá vốn hàng bán', NULL),
('635', N'Chi phí tài chính', NULL),
('641', N'Chi phí bán hàng', NULL),
('642', N'Chi phí quản lý doanh nghiệp', NULL),
('811', N'Chi phí khác', NULL),
('711', N'Thu nhập khác', NULL),
('821', N'Chi phí thuế thu nhập doanh nghiệp', NULL),
('911', N'Xác định kết quả kinh doanh', NULL);


INSERT INTO DMTK2 (SoTKC2, TenTKC2, Ghichu_TKC2, SoTKC1) VALUES
('1111', N'Tiền Việt Nam', NULL, '111'),
('1112', N'Ngoại tệ', NULL, '111'),
('1113', N'Vàng tiền tệ', NULL, '111'),
('1121', N'Tiền Việt Nam', NULL, '112'),
('1122', N'Ngoại tệ', NULL, '112'),
('1123', N'Vàng tiền tệ', NULL, '112'),
('1331', N'Thuế GTGT được khấu trừ của hàng hóa, dịch vụ', NULL, '133'),
('1332', N'Thuế GTGT được khấu trừ của TSCĐ', NULL, '133'),
('1531', N'Công cụ, dụng cụ', NULL, '153'),
('1532', N'Bao bì luân chuyển', NULL, '153'),
('1533', N'Đồ dùng cho thuê', NULL, '153'),
('1534', N'Thiết bị, phụ tùng thay thế', NULL, '153'),
('1561', N'Giá mua hàng hóa', NULL, '156'),
('1562', N'Chi phí thu mua hàng hóa', NULL, '156'),
('1567', N'Hàng hóa bất động sản', NULL, '156'),
('3331', N'Thuế giá trị gia tăng phải nộp', NULL, '333'),
('3332', N'Thuế tiêu thụ đặc biệt', NULL, '333'),
('3333', N'Thuế xuất, nhập khẩu', NULL, '333'),
('3334', N'Thuế thu nhập doanh nghiệp', NULL, '333'),
('3335', N'Thuế thu nhập cá nhân', NULL, '333'),
('3336', N'Thuế tài nguyên', NULL, '333'),
('3337', N'Thuế nhà đất, tiền thuê đất', NULL, '333'),
('3338', N'Thuế bảo vệ môi trường và các loại thuế khác', NULL, '333'),
('3339', N'Phí, lệ phí và các khoản phải nộp khác', NULL, '333'),
('3341', N'Phải trả công nhân viên', NULL, '334'),
('3348', N'Phải trả người lao động khác', NULL, '334'),
('5111', N'Doanh thu bán hàng hóa', NULL, '511'),
('5112', N'Doanh thu bán các thành phẩm', NULL, '511'),
('5113', N'Doanh thu cung cấp dịch vụ', NULL, '511'),
('5114', N'Doanh thu trợ cấp, trợ giá', NULL, '511'),
('5117', N'Doanh thu kinh doanh bất động sản đầu tư', NULL, '511'),
('5118', N'Doanh thu khác', NULL, '511'),
('5211', N'Chiết khấu thương mại', NULL, '521'),
('5212', N'Giảm giá hàng bán', NULL, '521'),
('5213', N'Hàng bán bị trả lại', NULL, '521'),
('6411', N'Chi phí nhân viên', NULL, '641'),
('6412', N'Chi phí nguyên vật liệu, bao bì', NULL, '641'),
('6413', N'Chi phí dụng cụ, đồ dùng', NULL, '641'),
('6414', N'Chi phí khấu hao TSCĐ', NULL, '641'),
('6415', N'Chi phí bảo hành', NULL, '641'),
('6417', N'Chi phí dịch vụ mua ngoài', NULL, '641'),
('6418', N'Chi phí bằng tiền khác', NULL, '641'),
('6421', N'Chi phí nhân viên quản lý', NULL, '642'),
('6422', N'Chi phí vật liệu quản lý', NULL, '642'),
('6423', N'Chi phí đồ dùng văn phòng', NULL, '642'),
('6424', N'Chi phí khấu hao TSCĐ', NULL, '642'),
('6425', N'Thuế, phí và lệ phí', NULL, '642'),
('6426', N'Chi phí dự phòng', NULL, '642'),
('6427', N'Chi phí dịch vụ mua ngoài', NULL, '642'),
('6428', N'Chi phí bằng tiền khác', NULL, '642'),
('8211', N'Chi phí thuế TNDN hiện hành', NULL, '821'),
('8212', N'Chi phí thuế TNDN hoãn lại', NULL, '821'),
('3311', N'Phải trả người bán hàng hóa', NULL, '331'),
('6321', N'Giá vốn hàng bán siêu thị',NULL, '632'),
('8111', N'Chi phí hàng hủy, hao hụt',NULL, '811');


INSERT INTO TK_chitiet (SoTKCT, TenTKCT, Ghichu_TKCT, SoTKC2) VALUES
('111101', N'Quỹ tiền mặt tại quầy thu ngân', N'Tiền mặt dùng giao dịch bán lẻ tại siêu thị', '1111'),
('111102', N'Quỹ tiền mặt tại phòng kế toán', N'Tiền mặt do phòng kế toán quản lý', '1111'),
('111201', N'Tiền mặt USD', N'Tiền mặt ngoại tệ USD', '1112'),
('111301', N'Vàng miếng SJC', N'Vàng miếng SJC dùng làm phương tiện thanh toán/dự trữ', '1113'),
('111302', N'Vàng nhẫn', N'Vàng nhẫn dùng làm phương tiện thanh toán/dự trữ', '1113'),
('112101', N'Tiền gửi tại Vietcombank', N'Tài khoản thanh toán tại Vietcombank', '1121'),
('112102', N'Tiền gửi tại BIDV', N'Tài khoản thanh toán tại BIDV', '1121'),
('133101', N'Thuế GTGT hàng hóa', N'Thuế GTGT được khấu trừ của hàng hóa mua vào', '1331'),
('133102', N'Thuế GTGT dịch vụ', N'Thuế GTGT được khấu trừ của dịch vụ mua vào', '1331'),
('133201', N'Thuế GTGT TSCĐ cửa hàng', N'Thuế GTGT khấu trừ của TSCĐ tại cửa hàng', '1332'),
('133202', N'Thuế GTGT TSCĐ kho', N'Thuế GTGT khấu trừ của TSCĐ tại kho trung tâm', '1332'),
('153101', N'Kệ trưng bày', N'Kệ, quầy kệ trưng bày hàng hóa', '1531'),
('153102', N'Xe đẩy hàng', N'Xe đẩy, xe kéo dùng trong siêu thị và kho', '1531'),
('153301', N'Tủ mát cho thuê', N'Tủ mát cho thuê lại cho nhà cung cấp trưng bày', '1533'),
('153302', N'Tủ đông cho thuê', N'Tủ đông cho thuê lại cho nhà cung cấp', '1533'),
('156101', N'Hàng lương thực', N'Gạo, nếp, mì, thực phẩm khô cơ bản', '1561'),
('156102', N'Đồ uống và sữa', N'Nước suối, nước ngọt, sữa tươi, sữa chua…', '1561'),
('156201', N'Chi phí thu mua hàng nội địa', N'Vận chuyển, bốc xếp, chi phí mua hàng trong nước', '1562'),
('156202', N'Chi phí thu mua hàng nhập khẩu', N'Vận chuyển, bảo hiểm, thông quan hàng nhập khẩu', '1562'),
('333101', N'Thuế GTGT đầu ra bán lẻ', N'Thuế GTGT đầu ra từ hoạt động bán lẻ tại siêu thị', '3331'),
('333102', N'Thuế GTGT đầu ra bán sỉ', N'Thuế GTGT đầu ra từ hoạt động bán sỉ, hợp đồng', '3331'),
('333201', N'Thuế TTĐB đồ uống có cồn', N'Thuế TTĐB áp trên đồ uống có cồn (nếu có)', '3332'),
('334102', N'Lương nhân viên kho', N'Lương phải trả thủ kho, nhân viên nhập – xuất', '3341'),
('334801', N'Thu lao cộng tác viên', N'Tiền công trả cộng tác viên, thời vụ', '3348'),
('334802', N'Tiền làm thêm giờ', N'Tiền làm thêm giờ chưa thanh toán', '3348'),
('511201', N'Doanh thu thành phẩm tự chế biến', N'Các sản phẩm BHX tự sơ chế, đóng gói lại', '5112'),
('511202', N'Doanh thu thành phẩm khác', N'Các thành phẩm khác (nếu có)', '5112'),
('511301', N'Doanh thu phí giao hàng', N'Phí giao hàng thu từ khách', '5113'),
('511302', N'Doanh thu dịch vụ khác', N'Dịch vụ đóng gói, dịch vụ tiện ích khác', '5113'),
('511401', N'Trợ giá từ nhà cung cấp', N'Hỗ trợ giá, marketing từ NCC', '5114'),
('511402', N'Trợ cấp từ công ty mẹ', N'Khoản trợ cấp giá bán, khuyến mãi', '5114'),
('511801', N'Thu nhập thanh lý TSCĐ', N'Thu nhập từ thanh lý, nhượng bán TSCĐ', '5118'),
('511802', N'Thu nhập khác', N'Các khoản thu nhập khác không thường xuyên', '5118'),
('521101', N'CKTM khách hàng thân thiết', N'Chiết khấu cho khách thành viên, tích điểm', '5211'),
('521102', N'CKTM theo doanh số', N'Chiết khấu theo doanh số mua hàng', '5211'),
('521201', N'Giảm giá hàng cận date', N'Giảm giá các mặt hàng cận hạn sử dụng', '5212'),
('521202', N'Giảm giá hàng khuyến mãi', N'Giảm giá theo chương trình khuyến mãi', '5212'),
('521301', N'Hàng trả lại do lỗi chất lượng', N'Hàng khách trả vì lỗi, hư hỏng', '5213'),
('521302', N'Hàng trả lại do sai quy cách', N'Hàng trả vì giao sai mẫu, sai quy cách', '5213'),
('641101', N'Lương nhân viên bán hàng', N'Lương, phụ cấp NV bán hàng', '6411'),
('641702', N'Chi phí quảng cáo bán hàng', N'Chi phí chạy quảng cáo, treo banner', '6417'),
('641801', N'Chi khuyến mãi trực tiếp cho khách', N'Phiếu quà tặng, chi tặng kèm', '6418'),
('641802', N'Chi hỗ trợ khai trương, sự kiện', N'Chi tổ chức event, khai trương', '6418'),
('642101', N'Lương nhân viên quản lý', N'Lương ban quản lý cửa hàng', '6421'),
('642102', N'BHXH, BHYT NV quản lý', N'Các khoản trích theo lương NV quản lý', '6421'),
('642201', N'Văn phòng phẩm', N'Giấy, mực in, bút…', '6422'),
('642202', N'Vật tư bảo trì nhỏ', N'Bóng đèn, ốc vít, vật tư bảo trì nhỏ', '6422'),
('642301', N'Đồ dùng phòng làm việc', N'Bàn, ghế, tủ hồ sơ', '6423'),
('642302', N'Thiết bị văn phòng nhỏ', N'Quạt, máy hủy giấy, dụng cụ nhỏ', '6423'),
('642401', N'Khấu hao TSCĐ phòng quản lý', N'Khấu hao máy tính, máy in, nội thất phòng QL', '6424'),
('642402', N'Khấu hao phương tiện quản lý', N'Khấu hao xe máy, ô tô dùng cho quản lý', '6424'),
('642501', N'Lệ phí môn bài', N'Lệ phí môn bài ghi nhận vào chi phí', '6425'),
('642502', N'Các khoản thuế, phí khác', N'Thuế, phí, lệ phí quản lý khác', '6425'),
('642601', N'Dự phòng phải thu khó đòi', N'Chi phí trích lập dự phòng phải thu khó đòi', '6426'),
('642602', N'Dự phòng giảm giá hàng tồn kho', N'Dự phòng giảm giá hàng tồn kho', '6426'),
('642701', N'Chi phí điện, nước, internet', N'Hóa đơn điện, nước, internet', '6427'),
('642702', N'Chi phí bảo vệ, vệ sinh', N'Thuê bảo vệ, vệ sinh', '6427'),
('642801', N'Chi công tác phí quản lý', N'Đi lại, công tác phí', '6428'),
('642802', N'Chi tiếp khách, hội nghị', N'Chi tiếp khách, hội nghị, hội thảo', '6428'),
('821101', N'Thuế TNDN năm hiện hành', N'Chi phí thuế TNDN phải nộp năm nay', '8211'),
('821102', N'Truy thu thuế TNDN', N'Phần truy thu thuế TNDN các năm trước', '8211'),
('821201', N'Chi phí thuế TNDN hoãn lại phát sinh', N'Chi phí thuế TNDN hoãn lại trong kỳ', '8212'),
('821202', N'Điều chỉnh thuế TNDN hoãn lại', N'Điều chỉnh số thuế TNDN hoãn lại đã ghi nhận', '8212'),
('331101', N'Phải trả người bán hàng hóa', N'Phải trả nhà cung cấp hàng hóa', '3311'),
('632101', N'Giá vốn hàng bán siêu thị', N'Giá vốn hàng hóa bán ra tại Bách Hóa Xanh', '6321'),
('811101', N'Chi phí hàng hủy, hao hụt', N'Hàng hủy, hao hụt sau kiểm kê, hết hạn', '8111'),
('511101', N'Doanh thu bán hàng hóa', N'Doanh thu bán hàng hóa tại Bách Hóa Xanh', '5111'),
('33101', N'Phải trả nhà cung cấp (chi tiết)', N'Khoản phải trả NCC hàng hóa – chi tiết', '3311');



INSERT INTO But_toan (MaCT, NgayHT, DienGiai, SotienNo, SotienCo, MaHD, MaPN, MaPX, SoTKCT) VALUES
-- ================== BÚT TOÁN HÓA ĐƠN BÁN HÀNG ==================
('BT001', '2025-11-01', N'Thu tiền bán hàng HD001', 152000, 0, 'HD001', NULL, NULL, '111101'),
('BT002', '2025-11-01', N'Ghi nhận doanh thu bán hàng HD001', 0, 152000, 'HD001', NULL, NULL, '511101'),
('BT003', '2025-11-01', N'Thu tiền bán hàng HD002 (chuyển khoản)', 235000, 0, 'HD002', NULL, NULL, '112101'),
('BT004', '2025-11-01', N'Ghi nhận doanh thu bán hàng HD002', 0, 235000, 'HD002', NULL, NULL, '511101'),
('BT005', '2025-11-02', N'Thu tiền bán hàng HD003', 89000, 0, 'HD003', NULL, NULL, '111101'),
('BT006', '2025-11-02', N'Ghi nhận doanh thu bán hàng HD003', 0, 89000, 'HD003', NULL, NULL, '511101'),
('BT007', '2025-11-02', N'Thu tiền bán hàng HD004 (ví điện tử)', 318000, 0, 'HD004', NULL, NULL, '112101'),
('BT008', '2025-11-02', N'Ghi nhận doanh thu bán hàng HD004', 0, 318000, 'HD004', NULL, NULL, '511101'),
('BT009', '2025-11-03', N'Thu tiền bán hàng HD005', 127000, 0, 'HD005', NULL, NULL, '111101'),
('BT010', '2025-11-03', N'Ghi nhận doanh thu bán hàng HD005', 0, 127000, 'HD005', NULL, NULL, '511101'),
('BT011', '2025-11-03', N'Thu tiền bán hàng HD006 (chuyển khoản)', 98000, 0, 'HD006', NULL, NULL, '112101'),
('BT012', '2025-11-03', N'Ghi nhận doanh thu bán hàng HD006', 0, 98000, 'HD006', NULL, NULL, '511101'),
('BT013', '2025-11-04', N'Thu tiền bán hàng HD007 (ví điện tử)', 450000, 0, 'HD007', NULL, NULL, '112101'),
('BT014', '2025-11-04', N'Ghi nhận doanh thu bán hàng HD007', 0, 450000, 'HD007', NULL, NULL, '511101'),
('BT015', '2025-11-04', N'Thu tiền bán hàng HD008', 67000, 0, 'HD008', NULL, NULL, '111101'),
('BT016', '2025-11-04', N'Ghi nhận doanh thu bán hàng HD008', 0, 67000, 'HD008', NULL, NULL, '511101'),
('BT017', '2025-11-05', N'Thu tiền bán hàng HD009 (chuyển khoản)', 231000, 0, 'HD009', NULL, NULL, '112101'),
('BT018', '2025-11-05', N'Ghi nhận doanh thu bán hàng HD009', 0, 231000, 'HD009', NULL, NULL, '511101'),
-- ================== BÚT TOÁN PHIẾU NHẬP HÀNG ==================
('BT019', '2025-10-28', N'Nhập hàng theo phiếu PN001', 13500000, 0, NULL, 'PN001', NULL, '156101'),
('BT020', '2025-10-28', N'Ghi nhận phải trả NCC phiếu PN001', 0, 13500000, NULL, 'PN001', NULL, '33101'),
('BT021', '2025-10-29', N'Nhập hàng theo phiếu PN002', 8200000, 0, NULL, 'PN002', NULL, '156101'),
('BT022', '2025-10-29', N'Ghi nhận phải trả NCC phiếu PN002', 0, 8200000, NULL, 'PN002', NULL, '33101'),
('BT023', '2025-10-30', N'Nhập hàng theo phiếu PN003', 5600000, 0, NULL, 'PN003', NULL, '156101'),
('BT024', '2025-10-30', N'Ghi nhận phải trả NCC phiếu PN003', 0, 5600000, NULL, 'PN003', NULL, '33101'),
('BT025', '2025-11-01', N'Nhập hàng theo phiếu PN004', 14500000, 0, NULL, 'PN004', NULL, '156101'),
('BT026', '2025-11-01', N'Ghi nhận phải trả NCC phiếu PN004', 0, 14500000, NULL, 'PN004', NULL, '33101'),
('BT027', '2025-11-01', N'Nhập hàng theo phiếu PN005', 9800000, 0, NULL, 'PN005', NULL, '156101'),
('BT028', '2025-11-01', N'Ghi nhận phải trả NCC phiếu PN005', 0, 9800000, NULL, 'PN005', NULL, '33101'),
('BT029', '2025-11-02', N'Nhập hàng theo phiếu PN006', 6200000, 0, NULL, 'PN006', NULL, '156101'),
('BT030', '2025-11-02', N'Ghi nhận phải trả NCC phiếu PN006', 0, 6200000, NULL, 'PN006', NULL, '33101'),
('BT031', '2025-11-02', N'Nhập hàng theo phiếu PN007', 7200000, 0, NULL, 'PN007', NULL, '156101'),
('BT032', '2025-11-02', N'Ghi nhận phải trả NCC phiếu PN007', 0, 7200000, NULL, 'PN007', NULL, '33101'),
-- ================== BÚT TOÁN PHIẾU XUẤT HÀNG ==================
('BT033', '2025-11-01', N'Giá vốn hàng xuất bán lẻ ca sáng - PX001', 310000, 0, NULL, NULL, 'PX001', '632101'),
('BT034', '2025-11-01', N'Xuất kho hàng bán lẻ ca sáng - PX001', 0, 310000, NULL, NULL, 'PX001', '156101'),
('BT035', '2025-11-05', N'Giá vốn hàng xuất bán lẻ ca tối - PX002', 260000, 0, NULL, NULL, 'PX002', '632101'),
('BT036', '2025-11-05', N'Xuất kho hàng bán lẻ ca tối - PX002', 0, 260000, NULL, NULL, 'PX002', '156101'),
('BT037', '2025-11-09', N'Giá vốn hàng giao đơn online - PX003', 195000, 0, NULL, NULL, 'PX003', '632101'),
('BT038', '2025-11-09', N'Xuất kho hàng giao đơn online - PX003', 0, 195000, NULL, NULL, 'PX003', '156101'),
('BT039', '2025-11-10', N'Giá vốn hàng xuất cho đại lý Q7 - PX004', 540000, 0, NULL, NULL, 'PX004', '632101'),
('BT040', '2025-11-10', N'Xuất kho hàng bán buôn cho đại lý Q7 - PX004', 0, 540000, NULL, NULL, 'PX004', '156101'),
('BT041', '2025-11-14', N'Hàng khuyến mãi cuối tuần - PX005', 120000, 0, NULL, NULL, 'PX005', '641801'),
('BT042', '2025-11-14', N'Xuất kho hàng khuyến mãi cuối tuần - PX005', 0, 120000, NULL, NULL, 'PX005', '156101'),
('BT043', '2025-11-20', N'Hàng hủy do hết hạn sử dụng - PX007', 80000, 0, NULL, NULL, 'PX007', '811101'),
('BT044', '2025-11-20', N'Xuất kho hàng hủy do hết hạn - PX007', 0, 80000, NULL, NULL, 'PX007', '156101'),
('BT045', '2025-11-27', N'Hàng tặng chương trình tri ân khách hàng - PX008', 150000, 0, NULL, NULL, 'PX008', '641801'),
('BT046', '2025-11-27', N'Xuất kho hàng tặng tri ân khách hàng - PX008', 0, 150000, NULL, NULL, 'PX008', '156101');


INSERT INTO SDDK (MaSDDK, DuNo_DK, DuCo_DK, Ngaydauky, SoTKCT) VALUES
('SD001', 50000000, 0, '2025-11-01', '111101'),
('SD002', 20000000, 0, '2025-11-01', '111102'),
('SD003', 150000000, 0, '2025-11-01', '112101'),  
('SD004', 80000000, 0, '2025-11-01', '112102'),
('SD005', 12000000, 0, '2025-11-01', '133101'),  
('SD006', 3000000, 0, '2025-11-01', '133102'),   
('SD007', 200000000, 0, '2025-11-01', '156101'), 
('SD008', 120000000, 0, '2025-11-01', '156102'), 
('SD009', 10000000, 0, '2025-11-01', '156201'),  
('SD010', 15000000, 0, '2025-11-01', '156202'),  
('SD011', 0, 90000000, '2025-11-01', '33101'),   
('SD012', 0, 60000000, '2025-11-01', '331101'),   
('SD013', 0, 5000000, '2025-11-01', '333101'), 
('SD014', 0, 0, '2025-11-01', '511101'),        
('SD015', 0, 0, '2025-11-01', '632101'),         
('SD016', 0, 0, '2025-11-01', '641801'),          
('SD017', 0, 0, '2025-11-01', '811101');          


--==========================================================================================================


--Ràng buộc toàn vẹn 1 – Giới tính khách hàng
CREATE TRIGGER trg_RBTV1_Khachhang_Gioitinh
ON Khachhang
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted
        WHERE GioitinhKH NOT IN (N'Nam', N'Nữ')
    )
    BEGIN
        RAISERROR (N'Giới tính khách hàng phải là "Nam" hoặc "Nữ".', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


--Ràng buộc toàn vẹn 2 – Giới tính nhân viên
CREATE TRIGGER trg_RBTV2_Nhanvien_Gioitinh
ON Nhanvien
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted
        WHERE Gioitinh NOT IN (N'Nam', N'Nữ')
    )
    BEGIN
        RAISERROR (N'Giới tính nhân viên không hợp lệ.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


--Ràng buộc toàn vẹn 3 – Phương thức thanh toán
CREATE TRIGGER trg_RBTV3_Hoadon_PTTT
ON Hoadon
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted
        WHERE PTTT NOT IN (N'Tiền mặt', N'Chuyển khoản', N'Ví điện tử')
    )
    BEGIN
        RAISERROR (N'Phương thức thanh toán không hợp lệ.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


--Ràng buộc toàn vẹn 4 – Số lượng hàng bán > 0
CREATE TRIGGER trg_RBTV4_CTHD_SoLuong
ON Chitiet_Hoadon
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted
        WHERE SL_hangban <= 0
    )
    BEGIN
        RAISERROR (N'Số lượng hàng bán phải lớn hơn 0.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


--Ràng buộc toàn vẹn 5 – Đơn giá bán > 0
CREATE TRIGGER trg_RBTV5_CTHD_DonGia
ON Chitiet_Hoadon
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted
        WHERE Dongia_ban <= 0
    )
    BEGIN
        RAISERROR (N'Đơn giá bán phải lớn hơn 0.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


--Ràng buộc toàn vẹn 6 – Mỗi nhân viên chỉ có một tài khoản đăng nhập
CREATE TRIGGER trg_RBTV6_Taikhoan_MaNV_Unique
ON Taikhoan
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
       SELECT 1
        FROM inserted i
        JOIN Taikhoan t ON i.MaNV = t.MaNV AND i.Username <> t.Username
        WHERE i.MaNV IS NOT NULL )
    BEGIN
        RAISERROR (N'Nhân viên này đã được cấp tài khoản.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
    IF EXISTS (
        SELECT MaNV
        FROM inserted
        WHERE MaNV IS NOT NULL
        GROUP BY MaNV
        HAVING COUNT(*) > 1  )
    BEGIN
        RAISERROR (N'Một nhân viên bị gán nhiều tài khoản trong dữ liệu nhập.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;


--Ràng buộc toàn vẹn 7 – Không trùng dòng chi tiết trên cùng hóa đơn bán hàng
CREATE TRIGGER trg_RBTV7_CTHD_Duplicate
ON Chitiet_Hoadon
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Chitiet_Hoadon c ON i.MaHD = c.MaHD AND i.MaH  = c.MaH AND (i.MaHD <> c.MaHD OR i.MaH <> c.MaH)
    )
    BEGIN
        RAISERROR (N'Mặt hàng này đã tồn tại trên hóa đơn.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
    IF EXISTS (
        SELECT MaHD, MaH
        FROM inserted
        GROUP BY MaHD, MaH
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR (N'Trùng mặt hàng trên cùng hóa đơn trong dữ liệu nhập.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;


--Ràng buộc toàn vẹn 8 – Số dư đầu kỳ chỉ 1 bên Nợ hoặc Có
CREATE TRIGGER trg_RBTV8_SDDK_OnlyOneSide
ON SDDK
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted WHERE DuNo_DK > 0 AND DuCo_DK > 0 )
    BEGIN
        RAISERROR (N'Số dư đầu kỳ không được đồng thời có cả bên Nợ và bên Có.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;


--Ràng buộc toàn vẹn 9 – Mỗi bút toán chỉ ghi một bên Nợ hoặc Có
CREATE TRIGGER trg_RBTV9_ButToan_OneSide
ON But_toan
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE  (ISNULL(SotienNo, 0) > 0 AND ISNULL(SotienCo, 0) > 0)
            OR (ISNULL(SotienNo, 0) = 0 AND ISNULL(SotienCo, 0) = 0)
    )
    BEGIN
        RAISERROR (N'Bút toán phải có đúng một bên Nợ hoặc Có khác 0.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;


--Ràng buộc toàn vẹn 10 – Tài khoản đăng nhập phải gắn với nhân viên có chức vụ cho phép
CREATE TRIGGER trg_Taikhoan_CheckRole
ON Taikhoan
FOR INSERT, UPDATE
AS
BEGIN
IF EXISTS (SELECT 1
        FROM inserted tk
        LEFT JOIN Nhanvien nv ON tk.MaNV = nv.MaNV
        WHERE nv.MaNV IS NULL
        OR nv.Chucvu NOT IN (N'Admin',N'Quản lý cửa hàng',N'Kế toán',N'Nhân viên bán hàng'))
BEGIN
RAISERROR (N'Chức vụ mới không thuộc nhóm được cấp tài khoản. Vui lòng xử lý (khóa / xóa) tài khoản trước.',16, 1);        
ROLLBACK TRANSACTION;
END
END;


--Ràng buộc toàn vẹn 11 – Không để hóa đơn trống
CREATE TRIGGER trg_CTHD_PreventDeleteLastRow
ON Chitiet_Hoadon
AFTER DELETE
AS
BEGIN
    IF EXISTS (
        SELECT d.MaHD
        FROM deleted d JOIN Hoadon h ON h.MaHD = d.MaHD
        LEFT JOIN Chitiet_Hoadon ct ON ct.MaHD = h.MaHD
        GROUP BY d.MaHD
        HAVING COUNT(ct.MaHD) = 0   )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 60012, N'Hóa đơn phải có ít nhất một dòng chi tiết.', 1;
    END
END;



--Ràng buộc toàn vẹn 12 – Không cho phép xuất quá số lượng đã nhập
CREATE TRIGGER trg_CTPX_CheckSoLuongXuat
ON Chitiet_PX
FOR INSERT, UPDATE
AS
BEGIN
IF EXISTS ( SELECT 1
FROM (SELECT MaH, SUM(SL_hangnhap) AS TongNhap FROM Chitiet_PN GROUP BY MaH) pn
RIGHT JOIN (SELECT MaH, SUM(SL_hangxuat) AS TongXuat FROM Chitiet_PX GROUP BY MaH) px ON pn.MaH = px.MaH
WHERE px.MaH IN (SELECT DISTINCT MaH FROM inserted)
AND ISNULL(pn.TongNhap, 0) < px.TongXuat )
BEGIN
RAISERROR (N'Số lượng xuất vượt quá số lượng đã nhập (tồn kho âm).', 16, 1);
ROLLBACK TRANSACTION;
END
END;


--Ràng buộc toàn vẹn 13 – Kiểm tra thành tiền bán hàng
CREATE TRIGGER trg_CTHD_CheckSL_Dongia
ON Chitiet_Hoadon
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE SL_hangban <= 0 OR Dongia_ban < 0  )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 60001, N'Số lượng và đơn giá bán phải lớn hơn 0.', 1;
    END
END;


--Ràng buộc toàn vẹn 14 – Số dư đầu kỳ không âm
CREATE TRIGGER trg_SDDK_CheckValue
ON SDDK
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS ( SELECT 1 FROM inserted
        WHERE DuNo_DK < 0 OR DuCo_DK < 0)
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 60004, N'Số dư đầu kỳ không được âm.', 1;
    END
END;


--Ràng buộc toàn vẹn 15: Tài khoản Nợ và tài khoản Có không được trùng nhau
CREATE TRIGGER trg_CTHD_TKNo_TKCo_NotEqual
ON Chitiet_Hoadon
FOR INSERT, UPDATE
AS
BEGIN
IF EXISTS (SELECT 1 FROM inserted WHERE TKNo IS NOT NULL AND TKCo IS NOT NULL AND TKNo = TKCo)
BEGIN
RAISERROR (N'Tài khoản Nợ và tài khoản Có không được trùng nhau.', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END
END;



--=====================================================================================================
CREATE VIEW vw_Hoadon_Chitiet
AS
SELECT
    hd.MaHD,
    hd.Ngayban,
    hd.Tongtien,
    hd.PTTT,
    hd.MaKH,
    hd.MaNV,
    ct.MaH,
    ct.SL_hangban,
    ct.Dongia_ban,
    ct.Magiamgia,
    ct.TKNo,
    ct.TKCo
FROM Hoadon hd
JOIN Chitiet_Hoadon ct
    ON hd.MaHD = ct.MaHD;

CREATE VIEW vw_Phieukiemke_Chitiet
AS
SELECT
    -- Bảng Phieukiemke
    pkk.MaPKK,
    pkk.NgayKK,
    pkk.GhichuPKK,
    pkk.MaNV,
    ct.MaH,
    ct.SL_hangKK
FROM Phieukiemke pkk
JOIN Chitiet_PKK ct
    ON pkk.MaPKK = ct.MaPKK;


CREATE VIEW vw_Phieunhap_Chitiet
AS
SELECT
    -- Bảng Phieunhap
    pn.MaPN,
    pn.Ngaynhap,
    pn.Tongtiennhap,
    pn.GhichuPN,
    pn.MaNV,
    pn.MaNCC,
    ct.MaH,
    ct.SL_hangnhap,
    ct.Dongianhap
FROM Phieunhap pn
JOIN Chitiet_PN ct
    ON pn.MaPN = ct.MaPN;

CREATE VIEW vw_Phieuxuat_Chitiet
AS
SELECT
    px.MaPX,
    px.Ngayxuat,
    px.GhichuPX,
    px.MaNV,
    ct.MaH,
    ct.SL_hangxuat,
    ct.Dongiaxuat
FROM Phieuxuat px
JOIN Chitiet_PX ct
    ON px.MaPX = ct.MaPX;


--=====================================================================================
CREATE PROC usp_BaoCao_HangNhapKho
    @TuNgay  date,      
    @DenNgay date        
AS
BEGIN

    SELECT 
        pn.MaPN,
        pn.Ngaynhap,
        pn.Tongtiennhap,
        ncc.TenNCC,
        nv.TenNV,
        hh.TenH,
        ctpn.SL_hangnhap,
        ctpn.Dongianhap,
        ThanhTienNhap = ctpn.SL_hangnhap * ctpn.Dongianhap
    FROM Phieunhap pn
        JOIN Chitiet_PN ctpn ON pn.MaPN = ctpn.MaPN
        JOIN Hanghoa hh      ON ctpn.MaH = hh.MaH
        LEFT JOIN Nhacungcap ncc ON pn.MaNCC = ncc.MaNCC
        LEFT JOIN Nhanvien nv    ON pn.MaNV = nv.MaNV
    WHERE pn.Ngaynhap BETWEEN @TuNgay AND @DenNgay
    ORDER BY pn.Ngaynhap, pn.MaPN, ctpn.MaH;
END;



CREATE PROC usp_BaoCao_HangXuatKho
    @TuNgay  date,      
    @DenNgay date        
AS
BEGIN
    SELECT 
        px.MaPX,
        px.Ngayxuat,
        nv.TenNV,
        hh.TenH,
        ctx.SL_hangxuat,
        ctx.Dongiaxuat,
        ThanhTienXuat = ctx.SL_hangxuat * ctx.Dongiaxuat
    FROM Phieuxuat px
        JOIN Chitiet_PX ctx ON px.MaPX = ctx.MaPX
        JOIN Hanghoa hh     ON ctx.MaH = hh.MaH
        LEFT JOIN Nhanvien nv ON px.MaNV = nv.MaNV
    WHERE px.Ngayxuat BETWEEN @TuNgay AND @DenNgay
    ORDER BY px.Ngayxuat, px.MaPX, ctx.MaH;
END;


CREATE PROC usp_BaoCao_DoanhThu
    @TuNgay  date,  
    @DenNgay date   
AS
BEGIN
    SELECT 
        hd.MaHD,
        hd.Ngayban,
        hd.PTTT,
        kh.TenKH,
        nv.TenNV,
        DoanhThuHD = SUM(ct.SL_hangban * ct.Dongia_ban)
    FROM Hoadon hd
        JOIN Chitiet_Hoadon ct ON hd.MaHD = ct.MaHD
        LEFT JOIN Khachhang kh  ON hd.MaKH = kh.MaKH
        LEFT JOIN Nhanvien nv   ON hd.MaNV = nv.MaNV
    WHERE hd.Ngayban BETWEEN @TuNgay AND @DenNgay
    GROUP BY 
        hd.MaHD, hd.Ngayban, hd.PTTT,
        kh.MaKH, kh.TenKH,
        nv.MaNV, nv.TenNV
    ORDER BY hd.Ngayban, hd.MaHD;
    SELECT 
        TongDoanhThu = SUM(ct.SL_hangban * ct.Dongia_ban)
    FROM Hoadon hd
        JOIN Chitiet_Hoadon ct ON hd.MaHD = ct.MaHD
    WHERE hd.Ngayban BETWEEN @TuNgay AND @DenNgay;
END;