/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.ShipperDTO;
import com.ebutler.swp.dto.UserDTO;
import com.ebutler.swp.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class UserDAO {

    private final String SEARCH_US = "SELECT username from tblUser WHERE username LIKE ?";

//    Sua select * lai bao oi
    private final String SEARCH_US_PW = "SELECT * from tblUser WHERE username LIKE ? AND password LIKE ? AND status = 1";
//    Sua select * lai bao oi

    private final String SEARCH_US_PHONE = "SELECT username from tblUser WHERE phone LIKE ?";
    private final String SEARCH_US_EMAIL = "SELECT username from tblUser WHERE email LIKE ?";
    private final String GET_ROLE_BY_EMAIL = "SELECT role_ID from tblUser WHERE email LIKE ?";
    private final String GET_USER_BY_EMAIL = "SELECT username, password, role_ID, phone, status from tblUser WHERE email LIKE ?";
    private final String GET_SHIPPER = "SELECT * FROM tblShipper WHERE username= ? AND password = ? "; 
    private final String UPDATE_SHIPPER_WALLET = "UPDATE tblShipper SET wallet = ? WHERE username = ? ";  

    public boolean isExisted(String username) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_US);
                ptm.setString(1, username);
                rs = ptm.executeQuery();
                return rs.next();
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

        return true;
    }

    public boolean isExistedPhone(String phone) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_US_PHONE);
                ptm.setString(1, phone);
                rs = ptm.executeQuery();
                return rs.next();
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

        return true;
    }

    public boolean isExistedEmail(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_US_EMAIL);
                ptm.setString(1, email);
                rs = ptm.executeQuery();
                return rs.next();
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

        return true;
    }

    public UserDTO Login(String username, String password) throws SQLException {
        UserDTO user = new UserDTO();

        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_US_PW);
                ptm.setString(1, username);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String role_ID = rs.getString("role_ID");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    int status = rs.getInt("status");

                    user = new UserDTO(username, password, role_ID, phone, email, status);
                }
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

        return user;
    }

    public String getRoleIDByEmail(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String role = "";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_ROLE_BY_EMAIL);
                ptm.setString(1, email);
                rs = ptm.executeQuery();
                role = rs.getString("role_ID");
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
        return role;
    }
    
    public UserDTO getUserByEmail(String email) throws SQLException {
        UserDTO user = new UserDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_USER_BY_EMAIL);
                ptm.setString(1, email);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    String role_ID = rs.getString("role_ID");
                    String phone = rs.getString("phone");
                    int status = rs.getInt("status");

                    user = new UserDTO(username, password, role_ID, phone, email, status);
                }
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

        return user;
    }
    
    public ShipperDTO getShipper(String username, String password) throws SQLException {
        ShipperDTO newShipper = new ShipperDTO() ; 
        Connection conn = null ; 
        PreparedStatement ptm = null ; 
        ResultSet rs = null ; 
        try {
            conn = DBUtils.getConnection() ; 
            if (conn != null) {
                ptm = conn.prepareStatement(GET_SHIPPER) ; 
                ptm.setString(1, username);
                ptm.setString(2, password);
                rs = ptm.executeQuery() ; 
                if(rs.next()) {
                    newShipper = new ShipperDTO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getDouble(7)) ; 
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
        return newShipper ; 
    }
    public boolean updateShipperWallet(double wallet ,String username) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false  ;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_SHIPPER_WALLET);
                ptm.setDouble(1, wallet);
                ptm.setString(2, username);
                check = ptm.executeUpdate() > 0 ? true : false;
                
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
}
