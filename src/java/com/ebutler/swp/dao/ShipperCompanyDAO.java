/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.ProvinceDTO;
import com.ebutler.swp.dto.ShipperCompanyDTO;
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
public class ShipperCompanyDAO {
    private final String GET_SHIPPER_COMPANY = "select id, name, logo from tblShipperCompany";
    
    public ArrayList<ShipperCompanyDTO> SelectShipperCompany() throws SQLException {
        ArrayList<ShipperCompanyDTO> list = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                ptm = conn.prepareStatement(GET_SHIPPER_COMPANY);
                rs = ptm.executeQuery();
                while(rs.next()){
                    list.add(new ShipperCompanyDTO(rs.getInt(1), rs.getString(2), rs.getString(3)));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
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
