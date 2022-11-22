/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.ProductOrderHistoryDTO;
import com.ebutler.swp.dto.ServiceOrderedHistoryDTO;
import com.ebutler.swp.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dang Viet
 */
public class OrderHistoryDAO {
    private static final String GET_LIST_PRODUCT_ORDER_HISTORY = "select detail.product_detail_ID, order1.order_ID, customer.username, order1.order_Date, order1.payment, prodDetail.name,prodDetail.price,  detail.quantity , prodDetail.image, [provider].name AS [provider_name], product.name AS [product_category], detail.status \n" +
    "from tblCustomer customer JOIN tblOrder order1 ON customer.username = order1.customer_ID JOIN tblOrder_Product_Detail detail ON detail.order_ID = order1.order_ID JOIN tblProductDetail prodDetail ON prodDetail.id = detail.product_detail_ID\n" +
    "JOIN tblProvider [provider] ON [provider].username =  prodDetail.provider_ID\n" +
    "JOIN tblProduct product ON product.product_ID = prodDetail.product_ID\n" +
    "where customer.username = ? AND detail.status = ? order by order1.order_ID DESC";
    private static final String GET_LIST_SERVICE_ORDER_HISTORY = "SELECT order1.order_ID, customer.username, order1.order_Date, order1.payment, staff.name as [staff_name], service.name as  [service_name] , service.image, orderDetail.price, provider.name AS [provider_name] ,orderDetail.status \n" +
"FROM tblOrder order1 JOIN tblOrder_Service_Detail orderDetail ON order1.order_ID = orderDetail.order_ID \n" +
"JOIN tblStaff staff on staff.staff_ID = orderDetail.staff_ID JOIN tblCustomer customer ON customer.username = order1.customer_ID \n" +
"JOIN tblService service ON service.service_ID = orderDetail.id \n" +
"JOIN tblProvider provider ON staff.provider_ID = provider.username\n" +
"where customer.username=? and orderDetail.status = ?";
       

    public static List<ProductOrderHistoryDTO> getListProductOrderHistory(String username, int status) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductOrderHistoryDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_LIST_PRODUCT_ORDER_HISTORY);
            ptm.setString(1, username);
            ptm.setInt(2, status);
            rs = ptm.executeQuery();
            while (rs.next()) {
                ProductOrderHistoryDTO product = new ProductOrderHistoryDTO( rs.getInt("order_ID"),rs.getString("username"), rs.getString("order_Date"),rs.getString("payment"), rs.getString("name"), rs.getDouble("price") , rs.getInt("quantity"),rs.getString("image"), rs.getString("provider_name"), rs.getString("product_category") , rs.getInt("status"));
                product.setId(rs.getInt("product_detail_ID"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
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

        return list;
    }
    public static List<ServiceOrderedHistoryDTO> getListServideOrderHistory(String username, int status) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceOrderedHistoryDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_LIST_SERVICE_ORDER_HISTORY);
            ptm.setString(1, username);
            ptm.setInt(2, status);
            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceOrderedHistoryDTO(rs.getInt("order_ID"),rs.getString("username"), rs.getString("order_Date"),rs.getString("payment"), rs.getString("staff_name"), rs.getString("service_name") , rs.getString("image"),rs.getDouble("price"), rs.getString("provider_name"),rs.getInt("status")));
            }
        } catch (Exception e) {
            e.printStackTrace();
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

        return list;
    }
    public static List<ProductOrderHistoryDTO> getListProductOrderHistoryDelivered(String username, int status) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductOrderHistoryDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_LIST_PRODUCT_ORDER_HISTORY);
            ptm.setString(1, username);
            ptm.setInt(2, status);
            rs = ptm.executeQuery();
            while (rs.next()) {
                ProductOrderHistoryDTO product = new ProductOrderHistoryDTO(rs.getInt("order_ID") ,rs.getString("username"), rs.getString("order_Date"),rs.getString("payment"), rs.getString("name"), rs.getDouble("price") , rs.getInt("quantity"),rs.getString("image"), rs.getString("provider_name"), rs.getString("product_category") , rs.getInt("status"));
                product.setId(rs.getInt("product_detail_ID"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
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

        return list;
    }
    public static List<ServiceOrderedHistoryDTO> getListServideOrderHistoryDelivered(String username, int status) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceOrderedHistoryDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_LIST_SERVICE_ORDER_HISTORY);
            ptm.setString(1, username);
            ptm.setInt(2, status);
            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceOrderedHistoryDTO(rs.getInt("order_ID"),rs.getString("username"), rs.getString("order_Date"),rs.getString("payment"), rs.getString("staff_name"), rs.getString("service_name") , rs.getString("image"),rs.getDouble("price"), rs.getString("provider_name"),rs.getInt("status")));
            }
        } catch (Exception e) {
            e.printStackTrace();
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

        return list;
    }
     public static void main(String[] args) throws SQLException {
             List<ProductOrderHistoryDTO> list = getListProductOrderHistoryDelivered("vietdang123", 0);
             for (ProductOrderHistoryDTO x : list) {
                 System.out.println(x);
            }
    }
}
