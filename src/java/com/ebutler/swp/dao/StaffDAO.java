/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.StaffDTO;
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
public class StaffDAO {
//    private static final String GET_LIST_STAFF_BY_SERVICE_DETAIL = "select staff.staff_ID, staff.provider_ID, staff.service_ID, staff.name, staff.id_card, staff.avatar, staff.status, detail.price from tblStaff staff JOIN tblServiceDetail detail ON staff.staff_ID = detail.staff_ID WHERE staff.service_ID = ?";

    private static final String GET_LIST_STAFF_BY_SERVICE_DETAIL = "select staff.staff_ID, staff.provider_ID, staff.service_ID, staff.name, staff.id_card, staff.avatar, staff.status, detail.price\n"
            + "from [tblStaff] staff JOIN [tblServiceDetail] detail\n"
            + "ON staff.staff_ID = detail.staff_ID JOIN tblService service ON service.service_ID = detail.service_ID  WHERE staff.service_ID = ?";

    private static final String UPDATE_STAFF_STATUS = "UPDATE tblStaff SET status = ? WHERE staff_ID = ?  ";

    public static boolean updateStatus(int status, int staff_ID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_STAFF_STATUS);
                ptm.setInt(1, status);
                ptm.setInt(2, staff_ID);
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

    public static ArrayList<StaffDTO> getListStaffByServiceDetail(String serviceID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ArrayList<StaffDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_LIST_STAFF_BY_SERVICE_DETAIL);
            ptm.setString(1, serviceID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new StaffDTO(rs.getInt("staff_ID"), rs.getString("provider_ID"), rs.getString("service_ID"), rs.getString("name"), rs.getString("id_card"), rs.getString("avatar"), rs.getInt("status"), rs.getDouble("price")));
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
        List<StaffDTO> list = getListStaffByServiceDetail("1");

        for (StaffDTO x : list) {
            System.out.println(x);
        }
    }
}
