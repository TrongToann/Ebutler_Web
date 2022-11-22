/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.AddressDTO;
import com.ebutler.swp.dto.CityDTO;
import com.ebutler.swp.dto.ProvinceDTO;
import com.ebutler.swp.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class AddressDAO {

    private final String SELECT_PROVINCE = "SELECT province_ID, province_Name FROM tblProvince_City";
    private final String SELECT_CITY = "SELECT district_ID, city_name, province_ID FROM tblDistrict WHERE province_ID = ?";
    private final String INSERT_ADDRESS = "INSERT INTO tblAddress(street, district_ID, user_ID, status) VALUES (?, ?, ?, ?)";
    private final String DELETE_ADDRESS = "UPDATE tblAddress SET status = -1 WHERE user_ID = ? and address_ID = ?";
    private final String SET_ADDRESS_DEFAULT = "UPDATE tblAddress SET status = 1 WHERE user_ID = ? and address_ID = ?";
    private final String RESET_ADDRESS_DEFAULT = "UPDATE tblAddress SET status = 0 WHERE status <> -1";
    private final String SELECT_ADDRESS = "SELECT a.street, a.district_ID, user_ID, status, d.city_name, pc.province_Name, a.address_ID, pc.province_ID FROM tblAddress as a JOIN tblDistrict d ON a.district_ID = d.district_ID JOIN tblProvince_City pc ON d.province_ID = pc.province_ID WHERE user_ID = ? and a.status <> -1 ORDER BY a.status DESC";
    
    private final String COUNT_ADDRESS = "select COUNT(*) from tblAddress where user_ID = ? and status = 1" ;
    
    private final String SELECT_PROVINCE_ID = "SELECT [province_Name] FROM tblProvince_City WHERE [province_ID] = ?";
    private final String SELECT_CITY_ID = "SELECT [city_name] FROM  tblDistrict WHERE [district_ID] = ?";
    
    public int CountAddress(String username) throws SQLException {
        int count = 0;

        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(COUNT_ADDRESS);
                ptm.setString(1, username);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    count = rs.getInt(1);
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
        return count;
    }
    
    public String SelectProvinceById(String provinceID) throws SQLException {
        String name = "";

        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT_PROVINCE_ID);
                ptm.setString(1, provinceID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    name = rs.getNString(1);
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
        return name;
    }
    
    public String SelectCityById(String CityID) throws SQLException {
        String name = "";

        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT_CITY_ID);
                ptm.setString(1, CityID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    name = rs.getString(1);
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
        return name;
    }
    
    public ArrayList<ProvinceDTO> SelectProvince() throws SQLException {
        ArrayList<ProvinceDTO> list = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT_PROVINCE);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    list.add(new ProvinceDTO(rs.getString(1), rs.getString(2)));
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

    public ArrayList<CityDTO> SelectCity(String province_id) throws SQLException {
        ArrayList<CityDTO> list = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT_CITY);
                ptm.setString(1, province_id);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    list.add(new CityDTO(rs.getString(1), rs.getString(2), rs.getString(3)));
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

    public boolean InserAddress(AddressDTO address) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_ADDRESS);
                ptm.setNString(1, address.getStreet());
                ptm.setNString(2, address.getDistrict_id());
                ptm.setNString(3, address.getUser_id());
                ptm.setInt(4, address.getStatus());
                return (ptm.executeUpdate() > 0) ? true : false;
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

        return false;
    }

    public boolean DeleteAddress(int address_id, String username) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_ADDRESS);
                ptm.setString(1, username);
                ptm.setInt(2, address_id);
                return (ptm.executeUpdate() > 0) ? true : false;
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

        return false;
    }

    public boolean SetAddressDefault(int address_id, String username) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(RESET_ADDRESS_DEFAULT);
                ptm.executeUpdate();

                ptm = conn.prepareStatement(SET_ADDRESS_DEFAULT);
                ptm.setString(1, username);
                ptm.setInt(2, address_id);
                return (ptm.executeUpdate() > 0) ? true : false;
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

        return false;
    }

    public ArrayList<AddressDTO> SelectAddress(String user_id) throws SQLException {
        ArrayList<AddressDTO> list = new ArrayList<AddressDTO>();

        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SELECT_ADDRESS);
                ptm.setString(1, user_id);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    AddressDTO address = new AddressDTO(rs.getString(2), rs.getString(1), rs.getString(3), rs.getInt(4));
                    address.setDistrict_name(rs.getString(5));
                    address.setProvince_name(rs.getString(6));
                    address.setId(rs.getInt(7));
                    address.setProvince_id(rs.getString(8));

                    list.add(address);
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
}
