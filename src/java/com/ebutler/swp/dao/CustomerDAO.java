/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.ProductCategoryDTO;
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
public class CustomerDAO {

    private static final String INSERT = "INSERT INTO tblCustomer (username, password, role_ID, phone, email, name, gender, dob, avatar, point, status)\n"
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_PRODUCT_CATEGORY_LIST = "SELECT category_ID, name, image\n"
            + "FROM tblProductCategory";
    private static final String GET_USER_PROFILE_INFO = "SELECT username, password, role_ID, phone, email, name, gender, dob, avatar, point, status\n"
            + "FROM tblCustomer\n"
            + "WHERE username = ?";
    private static final String GET_CURRENT_PSW = "SELECT password\n"
            + "FROM tblCustomer\n"
            + "WHERE username = ?";
    private static final String UPDATE_CURRENT_PSW = "UPDATE tblCustomer\n"
            + "SET password=?\n"
            + "WHERE username=?";
    private static final String UPDATE_CURRENT_CUSTOMER_INFO = "UPDATE tblCustomer SET avatar = ?,name = ?, email = ?,dob = ?, gender = ?, phone = ?\n"
            + "WHERE username = ?";
    private static final String CHECK_EXIST_ACCOUNT = "SELECT username\n"
            + "FROM tblCustomer\n"
            + "WHERE username = ?";
    private static final String CREATE_CUSTOMER = "INSERT into tblCustomer([username], [password], [role_ID], [phone], [email], [name], gender, dob, avatar, point,[status])\n"
            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String ACCUMULATE_POINT = "UPDATE tblCustomer\n"
            + "SET point = ?\n"
            + "WHERE username = ?";
    private static final String GET_POINT = "SELECT point\n"
            + "FROM tblCustomer\n"
            + "WHERE username = ?";
    private static final String UPLOAD_PHOTO = "UPDATE tblCustomer\n"
            + "SET avatar = ?\n"
            + "WHERE username = ?";
    private static final String GET_AVATAR = "SELECT avatar\n"
            + "FROM tblCustomer\n"
            + "WHERE username = ?";
    private final String UPDATE_WALLET = "UPDATE tblCustomer SET point = ? WHERE username = ?";

    public boolean InsertCus(CustomerDTO customer) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, customer.getUsername());
                ptm.setString(2, customer.getPassword());
                ptm.setString(3, customer.getRole_id());
                ptm.setString(4, customer.getPhone());
                ptm.setString(5, customer.getEmail());
                ptm.setString(6, customer.getName());
                ptm.setInt(7, customer.getGender());
                ptm.setString(8, customer.getDob());
                ptm.setString(9, customer.getAvatar());
                ptm.setDouble(10, customer.getPoint());
                ptm.setInt(11, customer.getStatus());
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

    public static boolean checkExistAccount(String username) throws SQLException {
        boolean check = true;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_EXIST_ACCOUNT);
                ptm.setString(1, username);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = false;
                }
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
        return check;
    }

    public static boolean createCustomer(CustomerDTO customer) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATE_CUSTOMER);
                ptm.setString(1, customer.getUsername());
                ptm.setString(2, customer.getPassword());
                ptm.setString(3, customer.getRole_id());
                ptm.setString(4, customer.getPhone());
                ptm.setString(5, customer.getEmail());
                ptm.setString(6, customer.getName());
                ptm.setInt(7, customer.getGender());
                ptm.setString(8, customer.getDob());
                ptm.setString(9, customer.getAvatar());
                ptm.setDouble(10, customer.getPoint());
                ptm.setInt(11, customer.getStatus());
                result = ptm.executeUpdate() > 0;
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
        return result;
    }

    public static List<ProductCategoryDTO> getProductCategoryList() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductCategoryDTO> list = new ArrayList<>();

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT_CATEGORY_LIST);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    list.add(new ProductCategoryDTO(rs.getString(1), rs.getString(2), rs.getString(3)));
                }
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

    public CustomerDTO getCurrentCustomer(String username) throws SQLException {
        CustomerDTO customer = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_USER_PROFILE_INFO);
                ptm.setString(1, username);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    customer = new CustomerDTO(rs.getString("username"), rs.getString("password"), rs.getString("role_ID"), rs.getString("phone"), rs.getString("email"), rs.getString("name"), rs.getInt("gender"), rs.getString("dob"), rs.getString("avatar"), rs.getInt("point"),rs.getInt("status"));
                }
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

        return customer;
    }

    public boolean updateCurrentCustomerInfo(String avatar, String name, String email, String dob, int gender, String phone, String username) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                //private final String UPDATE_CURRENT_CUSTOMER_INFO = "UPDATE tblCustomer SET avatar=?,name=?, email=?,dob= ?, gender=?, phone=?  WHERE username= ?";
                ptm = conn.prepareStatement(UPDATE_CURRENT_CUSTOMER_INFO);
                ptm.setString(1, avatar);
                ptm.setString(2, name);
                ptm.setString(3, email);
                ptm.setString(4, dob);
                ptm.setInt(5, gender);
                ptm.setString(6, phone);
                ptm.setString(7, username);

//                 rs = ptm.executeQuery();
//                if(rs.next()) {
//                    customer = new CustomerDTO(rs.getString("username"), rs.getString("password"), rs.getString("role_ID"), rs.getString("phone"), rs.getString("email"), rs.getString("name"), rs.getInt("gender"), rs.getString("dob"), rs.getString("avatar"), rs.getInt("status"));
//                }
                check = ptm.executeUpdate() > 0;
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

        return check;
    }

    public boolean updateCurrentPassword(String newPassword, String username) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_CURRENT_PSW);
                ptm.setString(1, newPassword);
                ptm.setString(2, username);
                check = ptm.executeUpdate() > 0;
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

    public String getCurrentCustomerPassword(String username) throws SQLException {
        String currentPsw = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_CURRENT_PSW);
                ptm.setString(1, username);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    currentPsw = rs.getString("password");
                }
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

        return currentPsw;
    }

    public static double getPoint(String username) throws SQLException {
        double point = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_POINT);
                ptm.setString(1, username);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    point = rs.getDouble("point");
                }
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

        return point;
    }

    public static boolean accumulatePoint(String username, double point) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(ACCUMULATE_POINT);
                ptm.setDouble(1, getPoint(username) + point);
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
    
    public boolean updateWallet(CustomerDTO customer) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_WALLET);
                ptm.setDouble(1, customer.getPoint());
                ptm.setString(2, customer.getUsername());
                return ptm.executeUpdate() > 0 ? true : false;
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

    public static String getAvatar(String username) throws SQLException {
        String avatar = "";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_AVATAR);
                ptm.setString(1, username);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    avatar = rs.getString("avatar");
                }
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

        return avatar;
    }

    public static void main(String[] arg) throws SQLException {
//        accumulatePoint("Khoi Le", 10);
//        uploadPhoto("Khoi Le", "1.png");
        System.out.println(getPoint("Khoi Le"));
    }

}
