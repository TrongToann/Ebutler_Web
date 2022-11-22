/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.OrderDTO;
import com.ebutler.swp.dto.OrderDetailDTO;
import com.ebutler.swp.dto.OrderDetailInfoDTO;
import com.ebutler.swp.dto.ProductDTO;
import com.ebutler.swp.dto.ProductDetailDTO;
import com.ebutler.swp.dto.ProviderDTO;
import com.ebutler.swp.dto.ProviderServiceDTO1;
import com.ebutler.swp.dto.ProviderStaffDTO;
import com.ebutler.swp.dto.ShipperDTO;
import com.ebutler.swp.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ProviderDAO {

    private final String INSERT = "INSERT tblProvider (username, password, role_ID, phone, email, name, logo, status)\n"
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private final String LIST_PRODUCT = "SELECT id , name , image , price , quantity , description , status  FROM tblProductDetail WHERE provider_ID = ? ";
    private static final String GET_PROVIDER_INFO = "SELECT username, password , role_ID , phone, email , name , logo , status FROM tblProvider WHERE username = ? AND password = ?";
    private final String LIST_SERVICE = "SELECT DISTINCT SD.name , SC.name ,S.image ,S.name , SD.price , SD.status   FROM ( tblServiceDetail SD JOIN tblService S ON SD.service_ID = S.service_ID ) JOIN tblServiceCategory SC "
            + "ON SC.category_ID = S.category_ID WHERE SD.provider_ID = ?";
    private final String SEARCH_PRODUCT = "SELECT id , name , image , price , quantity , description , status  FROM tblProductDetail WHERE provider_ID = ? AND name like ? ";
    private final String SEARCH_SERVICE = "SELECT DISTINCT SD.name , SC.name ,S.image ,S.name , SD.price , SD.status   FROM ( tblServiceDetail SD JOIN tblService S ON SD.service_ID = S.service_ID ) JOIN tblServiceCategory SC "
            + " ON SC.category_ID = S.category_ID WHERE SD.provider_ID = ? AND SD.name like ?";
    private final String SEARCH_STAFF = "SELECT Staff.staff_ID,S.name , Staff.name, Staff.id_card, Staff.avatar, Staff.status FROM tblStaff Staff JOIN tblService S ON Staff.service_ID = S.service_ID WHERE Staff.provider_ID = ? AND Staff.name like ? ";
    private final String FILER_BY_NAME = "SELECT id , name , image , price , quantity , description , status  FROM tblProductDetail WHERE provider_ID = ? ORDER BY name ASC";
    private final String FILER_BY_PRICE_UP = "SELECT id , name , image , price , quantity , description , status  FROM tblProductDetail WHERE provider_ID = ? ORDER BY price ASC";
    private final String FILER_BY_PRICE_DOWN = "SELECT id , name , image , price , quantity , description , status  FROM tblProductDetail WHERE provider_ID = ? ORDER BY price DESC";
    private final String DELETE_PRODUCT = "UPDATE tblProductDetail SET status = 2 WHERE id = ? AND provider_ID = ? ";
    private final String DELETE_SERVICE = "UPDATE tblServiceDetail SET status = 2 WHERE name = ? AND provider_ID = ? AND price = ? ";
    private final String EDIT_PRODUCT = "UPDATE tblProductDetail SET name = ? , price = ? , quantity = ? , status = ? WHERE id = ? AND provider_ID = ?";
    private final String FILER_SERVICE_BY_NAME = "SELECT DISTINCT SD.name , SC.name ,S.image ,S.name , SD.price , SD.status   FROM ( tblServiceDetail SD JOIN tblService S ON SD.service_ID = S.service_ID ) JOIN tblServiceCategory SC "
            + "ON SC.category_ID = S.category_ID WHERE SD.provider_ID = ? ORDER by SD.name ASC";
    private final String FILER_SERVICE_BY_PRICE_UP = "SELECT DISTINCT SD.name , SC.name ,S.image ,S.name , SD.price , SD.status   FROM ( tblServiceDetail SD JOIN tblService S ON SD.service_ID = S.service_ID ) JOIN tblServiceCategory SC "
            + "ON SC.category_ID = S.category_ID WHERE SD.provider_ID = ? ORDER by SD.price ASC";
    private final String FILER_SERVICE_BY_PRICE_DOWN = "SELECT DISTINCT SD.name , SC.name ,S.image ,S.name , SD.price , SD.status   FROM ( tblServiceDetail SD JOIN tblService S ON SD.service_ID = S.service_ID ) JOIN tblServiceCategory SC "
            + "ON SC.category_ID = S.category_ID WHERE SD.provider_ID = ? ORDER by SD.price DESC";
    private final String LIST_STAFF = "SELECT Staff.staff_ID,S.name , Staff.name, Staff.id_card, Staff.avatar, Staff.status FROM tblStaff Staff JOIN tblService S ON Staff.service_ID = S.service_ID WHERE Staff.provider_ID = ? ";
    private final String FILTER_STAFF_BY_NAME = "SELECT Staff.staff_ID,S.name , Staff.name, Staff.id_card, Staff.avatar, Staff.status FROM tblStaff Staff JOIN tblService S ON Staff.service_ID = S.service_ID WHERE Staff.provider_ID = ? ORDER BY Staff.name ASC ";
    private final String DELETE_STAFF = "UPDATE tblStaff SET status = 2 WHERE staff_ID = ? AND provider_ID = ? ";
    private final String LIST_PRODUCT_CATEGORY = "SELECT * FROM tblProductCategory";
    private final String LIST_PRODUCT_CATEGORY_CHOOSE = "SELECT P.product_ID, P.category_ID, P.name , P.image FROM tblProduct P JOIN tblProductCategory PC  ON P.category_ID = PC.category_ID WHERE PC.name = ? ";
    private final String CHANGE_PASSWORD = "UPDATE tblProvider SET password = ? WHERE username = ? ";
    private final String EDIT_SERVICE = "UPDATE tblServiceDetail SET name = ? , price = ? , status = ?  WHERE name = ?  AND price = ? ";
    private final String EDIT_STAFF = "UPDATE tblStaff SET name = ? , id_card = ? , status = ? WHERE staff_ID = ? AND provider_ID = ?  ";
    private final String EDIT_PROVIDER_PROFILE = "UPDATE tblProvider SET phone = ? , email = ? , name = ? WHERE username = ?   ";
    private final String EDIT_PROVIDER_PROFILE_TOO = "UPDATE tblUser SET phone = ? , email = ? WHERE username = ?  ";
    private final String PROVIDER_ADD_PRODUCT = "INSERT INTO tblProductDetail(provider_ID, product_ID, name, quantity, price, image, description, status) VALUES (?, ?, ?, ?, ?, ? ,? ,1 )";
    private final String LIST_SERVICE_CATEGORY = "SELECT * FROM tblServiceCategory";
    private final String LIST_SERVICE_CATEGORY_CHOOSE = "SELECT * FROM tblService Ser JOIN tblServiceCategory SC ON SC.category_ID = Ser.category_ID WHERE SC.name = ? ";
    private final String PROVIDER_ADD_SERVICE = "INSERT INTO tblServiceDetail(provider_ID, service_ID, staff_ID , name , price , description , status) VALUES (? , ? , null , ? , ? , null , 1 )";
    private final String ADD_STAFF = "INSERT INTO tblStaff(provider_ID, service_ID, name, id_card, avatar, status) VALUES (?, ?, ?, ?, ?, 3)";
    private final String FILTER_STAFF_PENDING = "SELECT Staff.staff_ID,S.name , Staff.name, Staff.id_card, Staff.avatar, Staff.status FROM tblStaff Staff JOIN tblService S ON Staff.service_ID = S.service_ID WHERE Staff.provider_ID = ? AND status = 3";
    private final String LIST_ORDER_PRODUCT = "SELECT DISTINCT Ord.order_ID, Ord.order_Date, Ord.customer_ID, Ord.status, Ord.total , PD.provider_ID FROM ( tblOrder Ord JOIN tblOrder_Product_Detail OrdP ON Ord.order_ID = OrdP.order_ID ) JOIN tblProductDetail PD ON PD.id = OrdP.product_detail_ID WHERE PD.provider_ID = ? ";
    private final String LIST_ORDER_SERVICE = "SELECT DISTINCT Ord.order_ID, Ord.order_Date, Ord.customer_ID, Ord.status, Ord.total, PD.provider_ID FROM ( tblOrder Ord JOIN tblOrder_Service_Detail OrdS ON Ord.order_ID = OrdS.order_ID ) JOIN tblServiceDetail PD ON PD.id = OrdS.service_detail_ID WHERE PD.provider_ID = ? ";
    private final String LIST_ORDERDETAIL = "SELECT OrdP.id , Ord.order_ID, OrdP.product_detail_ID, PD.name, OrdP.quantity, PD.price, Ord.total, OrdP.status FROM ( tblOrder Ord JOIN tblOrder_Product_Detail OrdP ON Ord.order_ID = OrdP.order_ID ) JOIN tblProductDetail PD ON PD.id = OrdP.product_detail_ID WHERE PD.provider_ID = ? AND Ord.order_ID = ? ";
    private final String LIST_ORDER_SERVICE_DETAIL = "SELECT OrdP.id , Ord.order_ID, OrdP.service_Detail_ID, PD.name, OrdP.staff_ID, PD.price, OrdP.status FROM ( tblOrder Ord JOIN tblOrder_Service_Detail OrdP ON Ord.order_ID = OrdP.order_ID ) JOIN tblServiceDetail PD ON PD.id = OrdP.service_Detail_ID WHERE PD.provider_ID = ? AND Ord.order_ID = ? ";
    private final String LoadOrderInfor = "SELECT Ord.order_ID, Ord.order_Date, Ord.status, Cus.name, Cus.phone, Cus.email FROM tblOrder Ord JOIN tblCustomer Cus ON Ord.customer_ID = Cus.username  WHERE order_ID = ? AND customer_ID = ? ";
    //DELETE ORDER 
    private final String PROVIDER_DELETE_ORDER = "UPDATE tblOrder SET status = 3 WHERE order_ID = ? ";
    private final String PROVIDER_DELETE_ORDER_DETAIL = "UPDATE tblOrder_Product_Detail SET status = 4 WHERE order_ID = ? ";
    private final String PROVIDER_DELETE_ORDER_SHIPPER = "UPDATE tblDelivery SET status = 4 WHERE order_id = ? ";
    private final String PROVIDER_QUANTITY_PRODUCT = "SELECT quantity FROM tblProductDetail WHERE id = ? ";
    private final String PROVIDER_UPDATE_QUANTITY_PRODUCT = "UPDATE tblProductDetail SET quantity = ? WHERE id = ?  ";

    private final String PROVIDER_DELETE_SERVICE_ORDER_DETAIL = "UPDATE tblOrder_Service_Detail SET status = 4 WHERE order_ID = ? ";
    private static final String UPLOAD_PHOTO = "UPDATE tblProvider SET logo = ? WHERE username = ?  ";
    private final String SHIPPER_PROVIDER = "SELECT shi.name, shi.phone  FROM tblOrder ord JOIN tblDelivery De ON De.order_id = ord.order_ID JOIN tblShipper shi ON shi.username = De.username_Shipper  WHERE ord.order_ID = ? " ;
    
    
    public ShipperDTO getShipperInfo(int orderID) throws SQLException {
        ShipperDTO shipper = null ; 
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SHIPPER_PROVIDER);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    shipper = new ShipperDTO(rs.getString(1), rs.getString(2)) ;
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (conn != null) {
                conn.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return shipper;
    }
    
    public static boolean uploadPhoto(String username, String path) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPLOAD_PHOTO);
                ptm.setString(1, path);
                ptm.setString(2, username);
                check = ptm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (conn != null) {
                conn.close();
            }
            if (ptm != null) {
                ptm.close();
            }
        }

        return check;
    }

    public boolean InsertPro(ProviderDTO provider) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, provider.getUsername());
                ptm.setString(2, provider.getPassword());
                ptm.setString(3, provider.getRole_id());
                ptm.setString(4, provider.getPhone());
                ptm.setString(5, provider.getEmail());
                ptm.setString(6, provider.getName());
                ptm.setString(7, provider.getLogo());
                ptm.setInt(8, provider.getStatus());
                return (ptm.executeUpdate() > 0) ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ptm != null) {
                ptm.close();
            }
        }

        return false;
    }

    public int getProductQuantity(int id) throws SQLException {
        int quantity = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(PROVIDER_QUANTITY_PRODUCT);
                ptm.setInt(1, id);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    quantity = rs.getInt(1);
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (conn != null) {
                conn.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return quantity;
    }

    public boolean updateReturnQuantity(int quantity, int id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(PROVIDER_UPDATE_QUANTITY_PRODUCT);
                ptm.setInt(1, quantity);
                ptm.setInt(2, id);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public static ProviderDTO getProvider(String username, String password) throws SQLException {
        ProviderDTO provider = new ProviderDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PROVIDER_INFO);
                ptm.setString(1, username);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    provider = new ProviderDTO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6),
                            rs.getString(7), rs.getInt(8));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (conn != null) {
                conn.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return provider;
    }

    public List<ProductDetailDTO> loadListProduct(ProviderDTO provider) throws SQLException {
        List<ProductDetailDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_PRODUCT);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listProduct.add(new ProductDetailDTO(rs.getString(1), rs.getString(2), rs.getString(3),
                            rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getInt(7)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }

    public List<ProviderStaffDTO> loadListStaff(ProviderDTO provider) throws SQLException {
        List<ProviderStaffDTO> listService = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_STAFF);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listService.add(new ProviderStaffDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listService;
    }

    public List<ProviderServiceDTO1> loadListService(ProviderDTO provider) throws SQLException {
        List<ProviderServiceDTO1> listService = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_SERVICE);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listService.add(new ProviderServiceDTO1(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), null, rs.getInt(6)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listService;
    }

    public List<ProductDetailDTO> searchProduct(ProviderDTO provider, String search) throws SQLException {
        List<ProductDetailDTO> listSearch = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_PRODUCT);
                ptm.setString(1, provider.getUsername());
                ptm.setString(2, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listSearch.add(new ProductDetailDTO(rs.getString(1), rs.getString(2), rs.getString(3),
                            rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getInt(7)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listSearch;
    }

    public List<ProviderServiceDTO1> searchService(ProviderDTO provider, String search) throws SQLException {
        List<ProviderServiceDTO1> listService = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_SERVICE);
                ptm.setString(1, provider.getUsername());
                ptm.setString(2, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listService.add(new ProviderServiceDTO1(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), null, rs.getInt(6)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listService;
    }

    public List<ProviderStaffDTO> searchStaff(ProviderDTO provider, String search) throws SQLException {
        List<ProviderStaffDTO> listStaff = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_STAFF);
                ptm.setString(1, provider.getUsername());
                ptm.setString(2, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listStaff.add(new ProviderStaffDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listStaff;
    }

    public List<ProductDetailDTO> filterByName(ProviderDTO provider) throws SQLException {
        List<ProductDetailDTO> listFilter = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FILER_BY_NAME);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listFilter.add(new ProductDetailDTO(rs.getString(1), rs.getString(2), rs.getString(3),
                            rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getInt(7)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listFilter;
    }

    public List<ProductDetailDTO> filterByPriceUp(ProviderDTO provider) throws SQLException {
        List<ProductDetailDTO> listFilter = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FILER_BY_PRICE_UP);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listFilter.add(new ProductDetailDTO(rs.getString(1), rs.getString(2), rs.getString(3),
                            rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getInt(7)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listFilter;
    }

    public List<ProductDetailDTO> filterByPriceDown(ProviderDTO provider) throws SQLException {
        List<ProductDetailDTO> listFilter = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FILER_BY_PRICE_DOWN);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listFilter.add(new ProductDetailDTO(rs.getString(1), rs.getString(2), rs.getString(3),
                            rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getInt(7)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listFilter;
    }

    public List<ProviderServiceDTO1> filterServiceByName(ProviderDTO provider) throws SQLException {
        List<ProviderServiceDTO1> listFilter = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FILER_SERVICE_BY_NAME);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listFilter.add(new ProviderServiceDTO1(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), null, rs.getInt(6)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listFilter;
    }

    public List<ProviderStaffDTO> filterServiceByPending(ProviderDTO provider) throws SQLException {
        List<ProviderStaffDTO> listFilter = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FILTER_STAFF_PENDING);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listFilter.add(new ProviderStaffDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listFilter;
    }

    public List<ProviderServiceDTO1> filterServiceByPriceUp(ProviderDTO provider) throws SQLException {
        List<ProviderServiceDTO1> listFilter = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FILER_SERVICE_BY_PRICE_UP);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listFilter.add(new ProviderServiceDTO1(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), null, rs.getInt(6)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listFilter;
    }

    public List<ProviderServiceDTO1> filterServiceByPriceDown(ProviderDTO provider) throws SQLException {
        List<ProviderServiceDTO1> listFilter = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FILER_SERVICE_BY_PRICE_DOWN);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listFilter.add(new ProviderServiceDTO1(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), null, rs.getInt(6)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listFilter;
    }

    public List<ProviderStaffDTO> filterStaffByName(ProviderDTO provider) throws SQLException {
        List<ProviderStaffDTO> listFilter = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FILTER_STAFF_BY_NAME);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listFilter.add(new ProviderStaffDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listFilter;
    }

    public boolean deleteProduct(ProviderDTO provider, String productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_PRODUCT);
                ptm.setString(1, productID);
                ptm.setString(2, provider.getUsername());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteService(ProviderDTO provider, String serviceName, String price) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_SERVICE);
                ptm.setString(1, serviceName);
                ptm.setString(2, provider.getUsername());
                ptm.setString(3, price);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteStaff(ProviderDTO provider, String staffID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_STAFF);
                ptm.setString(1, staffID);
                ptm.setString(2, provider.getUsername());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean editProduct(ProviderDTO provider, String productName, String productPrice, String productQuantity, String productStatus, String productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(EDIT_PRODUCT);
                ptm.setString(1, productName);
                ptm.setString(2, productPrice);
                ptm.setString(3, productQuantity);
                ptm.setString(4, productStatus);
                ptm.setString(5, productID);
                ptm.setString(6, provider.getUsername());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<ProductDTO> loadListProductCategory() throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_PRODUCT_CATEGORY);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listProduct.add(new ProductDTO(rs.getString(1), rs.getString(2), rs.getString(3)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }

    public List<ProductDTO> loadListProductCategoryChoose(String categoryID) throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_PRODUCT_CATEGORY_CHOOSE);
                ptm.setString(1, categoryID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listProduct.add(new ProductDTO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }

    public boolean changePassword(ProviderDTO provider, String newPassword) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHANGE_PASSWORD);
                ptm.setString(1, newPassword);
                ptm.setString(2, provider.getUsername());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean editService(String newServiceName, String newServicePrice, String newServiceStatus, String oldServiceName, String oldServicePrice) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(EDIT_SERVICE);
                ptm.setString(1, newServiceName);
                ptm.setString(2, newServicePrice);
                ptm.setString(3, newServiceStatus);
                ptm.setString(4, oldServiceName);
                ptm.setString(5, oldServicePrice);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean editStaff(String staffName, String staffIDCard, String staffStatus, String staffID, ProviderDTO provider) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(EDIT_STAFF);
                ptm.setString(1, staffName);
                ptm.setString(2, staffIDCard);
                ptm.setString(3, staffStatus);
                ptm.setString(4, staffID);
                ptm.setString(5, provider.getUsername());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean editProviderProfile(ProviderDTO provider, String phone, String email, String name) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(EDIT_PROVIDER_PROFILE);
                ptm.setString(1, phone);
                ptm.setString(2, email);
                ptm.setString(3, name);
                ptm.setString(4, provider.getUsername());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean editProviderProfileTOO(ProviderDTO provider, String phone, String email) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(EDIT_PROVIDER_PROFILE_TOO);
                ptm.setString(1, phone);
                ptm.setString(2, email);
                ptm.setString(3, provider.getUsername());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

//provider_ID, product_ID, name, quantity, price, image, description, status
    public boolean providerAddProduct(ProviderDTO provider, String productID, String productName, String quantity, String price, String img, String description) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(PROVIDER_ADD_PRODUCT);
                ptm.setString(1, provider.getUsername());
                ptm.setString(2, productID);
                ptm.setString(3, productName);
                ptm.setString(4, quantity);
                ptm.setString(5, price);
                ptm.setString(6, img);
                ptm.setString(7, description);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean providerAddService(ProviderDTO provider, String serviceID, String name, String price) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(PROVIDER_ADD_SERVICE);
                ptm.setString(1, provider.getUsername());
                ptm.setString(2, serviceID);
                ptm.setString(3, name);
                ptm.setString(4, price);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<ProviderServiceDTO1> loadListServiceCategory() throws SQLException {
        List<ProviderServiceDTO1> listService = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_SERVICE_CATEGORY);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listService.add(new ProviderServiceDTO1(rs.getString(1), rs.getString(2), rs.getString(3)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listService;
    }

    public boolean providerAddStaff(ProviderDTO provider, String service_ID, String name, String id_card, String avatar) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(ADD_STAFF);
                ptm.setString(1, provider.getUsername());
                ptm.setString(2, service_ID);
                ptm.setString(3, name);
                ptm.setString(4, id_card);
                ptm.setString(5, avatar);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<ProviderServiceDTO1> loadListServiceCategoryChoose(String categoryID) throws SQLException {
        List<ProviderServiceDTO1> listService = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_SERVICE_CATEGORY_CHOOSE);
                ptm.setString(1, categoryID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listService.add(new ProviderServiceDTO1(rs.getString(1), rs.getString(3), rs.getString(2), rs.getString(4)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listService;
    }

    public List<OrderDTO> loadListOrder(ProviderDTO provider) throws SQLException {
        List<OrderDTO> listOrder = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_ORDER_PRODUCT);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listOrder.add(new OrderDTO(rs.getInt(1), rs.getDate(2), rs.getString(3), rs.getInt(4), rs.getDouble(5), rs.getString(6)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listOrder;
    }

    public List<OrderDTO> loadListOrderService(ProviderDTO provider) throws SQLException {
        List<OrderDTO> listOrder = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_ORDER_SERVICE);
                ptm.setString(1, provider.getUsername());
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listOrder.add(new OrderDTO(rs.getInt(1), rs.getDate(2), rs.getString(3), rs.getInt(4), rs.getDouble(5), rs.getString(6)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listOrder;
    }

    public List<OrderDetailDTO> loadOrderDetail(ProviderDTO provider, int orderID) throws SQLException {
        List<OrderDetailDTO> listOrder = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_ORDERDETAIL);
                ptm.setString(1, provider.getUsername());
                ptm.setInt(2, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listOrder.add(new OrderDetailDTO(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getInt(5), rs.getDouble(6), 0, rs.getInt(8)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listOrder;
    }

    public List<OrderDetailDTO> loadOrderServiceDetail(ProviderDTO provider, int orderID) throws SQLException {
        List<OrderDetailDTO> listOrder = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_ORDER_SERVICE_DETAIL);
                ptm.setString(1, provider.getUsername());
                ptm.setInt(2, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listOrder.add(new OrderDetailDTO(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getInt(5), rs.getDouble(6), rs.getInt(7)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listOrder;
    }

    public List<OrderDetailInfoDTO> loadOrderInfo(int orderID, String customerID) throws SQLException {
        List<OrderDetailInfoDTO> listOrder = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LoadOrderInfor);
                ptm.setInt(1, orderID);
                ptm.setString(2, customerID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listOrder.add(new OrderDetailInfoDTO(rs.getInt(1), rs.getDate(2), rs.getInt(3), rs.getString(4), rs.getString(5), rs.getString(6)));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listOrder;
    }

    public boolean deleteOrder(int orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(PROVIDER_DELETE_ORDER);
                ptm.setInt(1, orderID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteOrderDetail(int orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(PROVIDER_DELETE_ORDER_DETAIL);
                ptm.setInt(1, orderID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteOrder_ServiceDetail(int orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(PROVIDER_DELETE_SERVICE_ORDER_DETAIL);
                ptm.setInt(1, orderID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteOrderDelivery(int orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(PROVIDER_DELETE_ORDER_SHIPPER);
                ptm.setInt(1, orderID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public static void main(String[] args) throws SQLException {
//        ProviderDAO dao = new ProviderDAO();
//        boolean check = false;
//        boolean check1 = false;
//        ProviderDTO provider = new ProviderDTO();
//        provider = dao.getProvider("provider2", "1");
//        for (OrderDetailInfoDTO providerServiceDTO1 : listOrder) { 
//            System.out.println(providerServiceDTO1.toString());
//        }
//        List<OrderDTO> listOrder = new ArrayList();
//        listOrder = dao.loadListOrder(provider);
//        for (OrderDTO orderDTO : listOrder) {
//            System.out.println(orderDTO.toString());
//        }
//        System.out.println(check);
        System.out.println(getProvider("provider1", "1").getUsername());
    }
}
