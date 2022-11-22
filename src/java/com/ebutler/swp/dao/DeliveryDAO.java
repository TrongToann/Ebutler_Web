/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.DeliveryDTO;
import com.ebutler.swp.dto.OrderDetailDTO;
import com.ebutler.swp.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DELL
 */
public class DeliveryDAO {
    private final String DELIVERY_LIST = "SELECT De.order_id, De.address,De.username_Shipper ,Ord.order_Date,Ord.customer_ID, Cus.name,Ord.total, De.status FROM (tblDelivery De JOIN tblOrder Ord ON De.order_id = Ord.order_ID) JOIN tblCustomer Cus ON Cus.username = Ord.customer_ID  ";
    private final String DELIVERY_LIST_DEYAIL = "SELECT OPD.id, De.order_id,OPD.product_detail_ID, PD.name, OPD.quantity, PD.price, OPD.status FROM ( tblDelivery De JOIN tblOrder_Product_Detail OPD ON De.order_id = OPD.order_ID ) JOIN tblProductDetail PD ON PD.id = OPD.product_detail_ID  WHERE De.order_id = ? ";
    private final String UPDATE_PRODUCT_ORDER = "UPDATE tblOrder_Product_Detail SET status = ? WHERE id = ? " ; 
    private final String UPDATE_DELIVERY = "UPDATE tblDelivery SET status = ? WHERE order_id = ?" ; 
    private final String UPDATE_ORDER = "UPDATE tblOrder SET status = ? WHERE order_ID = ? " ; 
    private final String CHECK_BEFORE_UPDATE_DELIVERY = "SELECT * FROM tblOrder_Product_Detail WHERE order_ID = ? AND status = 3 " ; 
    private final String CHECK_BEFORE_UPDATE_DELIVERY_CACEL = "SELECT * FROM tblOrder_Product_Detail WHERE order_ID = ? AND status = 4 " ; 
    private final String LOAD_LIST_FOR_CHECK = "SELECT * FROM tblOrder_Product_Detail WHERE order_ID = ? " ; 
    private final String FIND_SHIPPING_DETAIL = "SELECT nameCategory FROM tblShipper WHERE username = ? " ; 
    private final String ASSIGN_DELIVERY = "UPDATE tblDelivery SET username_Shipper = ? WHERE order_id = ? " ;
    private final String ASSIGN_DELIVERY_CHECKING = "SELECT username_Shipper FROM tblDelivery WHERE order_id = ? " ;
    private final String CHECKING_DELIVERY_STATUS = "SELECT OPD.status FROM tblDelivery De JOIN tblOrder_Product_Detail OPD ON De.order_id = OPD.order_ID WHERE De.order_id = ? AND OPD.product_detail_ID = ? " ;
    
    
    
    
    public List<DeliveryDTO> loadListDelivery(String user) throws SQLException, ClassNotFoundException {
        List<DeliveryDTO> listDelivery = new ArrayList() ;
        Connection conn = null ; 
        PreparedStatement ptm = null ; 
        ResultSet rs = null ;
        try {
            conn = DBUtils.getConnection() ; 
            if(conn != null) {
                ptm = conn.prepareStatement(DELIVERY_LIST) ;
                rs = ptm.executeQuery() ; 
                while (rs.next()) {
                    listDelivery.add(new DeliveryDTO(rs.getInt(1), rs.getString(2),rs.getString(3) ,rs.getDate(4),rs.getString(5) ,rs.getString(6), rs.getDouble(7), rs.getInt(8))) ;
                }
            }
        } catch (Exception e) {
        }finally {
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
        return listDelivery ;
    }
    public List<OrderDetailDTO> loadOrderDetail( int orderID ) throws SQLException {
        List<OrderDetailDTO> listOrder = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELIVERY_LIST_DEYAIL); 
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listOrder.add(new OrderDetailDTO(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4), rs.getInt(5), rs.getDouble(6), 0, rs.getInt(7))); 
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
    public boolean updateProductOrder(int status ,int id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_PRODUCT_ORDER); 
                ptm.setInt(1, status);
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
    public boolean updateDelivery(int status ,int orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_DELIVERY); 
                ptm.setInt(1, status);
                ptm.setInt(2, orderID);
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
    public boolean updateOrder(int status ,int orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_ORDER); 
                ptm.setInt(1, status);
                ptm.setInt(2, orderID);
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
    public List<OrderDetailDTO> checkForDelivery(int orderID) throws SQLException {
        List<OrderDetailDTO> listOrder = new ArrayList() ;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_BEFORE_UPDATE_DELIVERY); 
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery() ;
                while(rs.next()) {
                    listOrder.add(new OrderDetailDTO(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getDouble(5), rs.getInt(6))) ;  
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
    public List<OrderDetailDTO> checkForDeliveryCancel(int orderID) throws SQLException {
        List<OrderDetailDTO> listOrder = new ArrayList() ;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_BEFORE_UPDATE_DELIVERY_CACEL); 
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery() ;
                while(rs.next()) {
                    listOrder.add(new OrderDetailDTO(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getDouble(5), rs.getInt(6))) ;  
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
    public List<OrderDetailDTO> checkForDeliveryDefault(int orderID) throws SQLException {
        List<OrderDetailDTO> listOrder = new ArrayList() ;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LOAD_LIST_FOR_CHECK); 
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery() ;
                while(rs.next()) {
                    listOrder.add(new OrderDetailDTO(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getDouble(5), rs.getInt(6))) ;  
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
    public String findShippingDetail(String user) throws SQLException {
        String shippingDetail = null ; 
        Connection conn = null ; 
        PreparedStatement ptm = null ; 
        ResultSet rs = null ; 
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FIND_SHIPPING_DETAIL); 
                ptm.setString(1, user);
                rs = ptm.executeQuery() ;
                if(rs.next()) {
                    shippingDetail = rs.getString(1) ; 
                            
                }
            }
        } catch (Exception e) {
        }finally {
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
        return shippingDetail ; 
    }
    public boolean assignDelivery(String userName ,int orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(ASSIGN_DELIVERY); 
                ptm.setString(1, userName);
                ptm.setInt(2, orderID);
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
    public String assignDeliveryChecking(int orderID) throws SQLException {
        String checkHaving = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(ASSIGN_DELIVERY_CHECKING); 
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery() ; 
                if (rs.next()) {
                    checkHaving = rs.getString(1) ;
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
        return checkHaving;
    }
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        
    }
    public int getStatusDelivery(int orderID, int productID) throws SQLException {
        int shippingStatus = 0 ; 
        Connection conn = null ; 
        PreparedStatement ptm = null ; 
        ResultSet rs = null ; 
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECKING_DELIVERY_STATUS); 
                ptm.setInt(1, orderID);
                ptm.setInt(2, productID);
                rs = ptm.executeQuery() ;
                if(rs.next()) {
                    shippingStatus = rs.getInt(1) ;     
                }
            }
        } catch (Exception e) {
        }finally {
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
        return shippingStatus ; 
    }



}
