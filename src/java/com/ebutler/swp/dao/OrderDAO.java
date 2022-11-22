/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.OrderDTO;
import com.ebutler.swp.utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author thekh
 */
public class OrderDAO {

    private static final String INSERT = "\n"
            + "INSERT INTO tblOrder(order_Date, customer_ID, status, total, payment)\n"
            + "VALUES(?, ?, ?, ?, ?)";
    private static final String INSERT_DETAIL = "\n"
            + "INSERT INTO tblOrder_Product_Detail(product_detail_ID, order_ID, quantity, price, [status])\n"
            + "VALUES(?, ?, ?, ?, ?)";
    private static final String GET_ALL_ORDER = "\n"
            + "SELECT order_ID, order_Date, customer_ID, status, total\n"
            + "FROM tblOrder";
    private static final String INSERT_SERVICE_DETAIL = "\n"
            + "INSERT INTO tblOrder_Service_Detail(staff_ID, service_Detail_ID, order_ID, price, [status])\n"
            + "VALUES(?, ?, ?, ?, ?)";
    private static final String INSERT_DELIVERY = "\n"
            + "INSERT INTO tblDelivery(order_id, address, username_Shipper ,[status])\n"
            + "VALUES(?, ?, ?, ?)";

    public static void insertOrder(Date date, String username, int status, double total, String payment) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setDate(1, date);
                ptm.setString(2, username);
                ptm.setInt(3, status);
                ptm.setDouble(4, total);
                ptm.setString(5, payment);
                ptm.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
//product_detail_ID, order_ID, quantity, price, [status]

    public static void insertOrderDetail(String id, int order_id, int quantity, double price, int status) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_DETAIL);
                ptm.setString(1, id);
                ptm.setInt(2, order_id);
                ptm.setInt(3, quantity);
                ptm.setDouble(4, price);
                ptm.setInt(5, status);
                ptm.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
//    order_ID, order_Date, customer_ID, status, total

    public static List<OrderDTO> getAllOrder() throws SQLException {
        List<OrderDTO> listOrder = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_ALL_ORDER);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int order_ID = rs.getInt("order_ID");
                    Date date = rs.getDate("order_Date");
                    String customer_ID = rs.getString("customer_ID");
                    int status = rs.getInt("status");
                    double total = rs.getDouble("total");
                    listOrder.add(new OrderDTO(order_ID, date, customer_ID, status, total));
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listOrder;
    }

    public static void insertOrderServiceDetail(int staff_ID, int service_Detail_ID, int order_ID, double price, int status) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_SERVICE_DETAIL);
                ptm.setInt(1, staff_ID);
                ptm.setInt(2, service_Detail_ID);
                ptm.setInt(3, order_ID);
                ptm.setDouble(4, price);
                ptm.setInt(5, status);
                ptm.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public static void insertDelivery(int order_id, String address) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_DELIVERY);
                ptm.setInt(1, order_id);
                ptm.setString(2, address);
                ptm.setString(3, null);
                ptm.setInt(4, 0);
                ptm.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public static void main(String[] args) {
        try {
//            insertOrder(java.sql.Date.valueOf(java.time.LocalDate.now()), "khoi le", 0, 2, "COD", "Grab");
//            insertOrderDetail("12", 2, 1, 66, 0);
//            List<OrderDTO> list = getAllOrder();
//            for (OrderDTO order : list) {
//                System.out.println(order);
//            }

//            insertOrderServiceDetail(1, 1, 1, 2000, 0);
            insertDelivery(3, "Điện Biên Phủ");
        } catch (Exception e) {
        }

    }
}
