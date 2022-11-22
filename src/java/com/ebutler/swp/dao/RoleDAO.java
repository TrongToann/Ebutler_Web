/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.RoleDTO;
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
public class RoleDAO {
    private final String GET_ROLE = "SELECT role_ID, role_Name, description FROM tblUserRole";
    
    public ArrayList<RoleDTO> GetRole() throws SQLException {
        ArrayList<RoleDTO> role_list = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.getConnection();
            
            if(conn != null) {
                ptm = conn.prepareStatement(GET_ROLE);
                rs = ptm.executeQuery();
                
                while(rs.next()) {
                    String id = rs.getString(1);
                    String name = rs.getString(2);
                    String description = rs.getString(3);
                    
                    role_list.add(new RoleDTO(id, name, description));
                }
            }
        
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            if(conn != null) conn.close();
            if(ptm != null) ptm.close();
            if(rs != null) rs.close();
        }
        
        return role_list;
    }
}
