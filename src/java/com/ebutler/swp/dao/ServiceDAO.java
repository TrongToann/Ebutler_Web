/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.ServiceCartDTO;
import com.ebutler.swp.dto.ServiceCategoryDTO;
import com.ebutler.swp.dto.ServiceDTO;
import com.ebutler.swp.dto.ServiceDetailDTO;
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
public class ServiceDAO {

    private static final String GET_SERVICE_CATEGORY_LIST = "SELECT category_ID, name, image\n"
            + "FROM tblServiceCategory";

    private static final String GET_SERVICE_CATEGORY_SERVICE_ID = "SELECT distinct cate.category_ID, cate.name, cate.image, service.service_ID\n"
            + "FROM tblServiceCategory cate JOIN tblService service ON cate.category_ID = service.category_ID\n"
            + "WHERE cate.category_ID = ?";

    private static final String GET_SERVICE_LIST = "SELECT DISTINCT s.service_ID, s.category_ID, s.name, s.image, sd.status\n"
            + "FROM tblService s JOIN tblServiceDetail sd ON s.service_ID = sd.service_ID\n"
            + "WHERE category_ID = ? AND sd.status = 1";

    private static final String SEARCH_SERVICE_CATEGORY = "SELECT service_ID, category_ID, name, image\n"
            + "FROM tblService\n"
            + "WHERE category_ID = ? AND name LIKE ?";

    private static final String SORT_SERVICE_CATEGORY_WORD_UP = "SELECT service_ID, category_ID, name, image\n"
            + "FROM tblService\n"
            + "WHERE category_ID = ?\n"
            + "ORDER BY name ASC";

    private static final String SORT_SERVICE_CATEGORY_WORD_DOWN = "SELECT service_ID, category_ID, name, image\n"
            + "FROM tblService\n"
            + "WHERE category_ID = ?\n"
            + "ORDER BY name DESC";

    private static final String SORT_SERVICE_DETAIL_WORD_UP = "SELECT detail.id, detail.provider_ID, detail.service_ID, detail.staff_ID, detail.name, detail.price, detail.description, detail.status\n"
            + "FROM tblServiceCategory cate JOIN tblService service ON cate.category_ID = service.category_ID JOIN tblServiceDetail detail ON detail.service_ID = service.service_ID\n"
            + "WHERE cate.category_ID = ? AND service.service_ID = ?\n"
            + "ORDER BY detail.name ASC";

    private static final String SORT_SERVICE_DETAIL_WORD_DOWN = "SELECT detail.id, detail.provider_ID, detail.service_ID, detail.staff_ID, detail.name, detail.price, detail.description, detail.status\n"
            + "FROM tblServiceCategory cate JOIN tblService service ON cate.category_ID = service.category_ID JOIN tblServiceDetail detail ON detail.service_ID = service.service_ID\n"
            + "WHERE cate.category_ID = ? AND service.service_ID = ?\n"
            + "ORDER BY detail.name DESC";

    private static final String SORT_SERVICE_DETAIL_PRICE_UP = "SELECT detail.id, detail.provider_ID, detail.service_ID, detail.staff_ID, detail.name, detail.price, detail.description, detail.status\n"
            + "FROM tblServiceCategory cate JOIN tblService service ON cate.category_ID = service.category_ID JOIN tblServiceDetail detail ON detail.service_ID = service.service_ID\n"
            + "WHERE cate.category_ID = ? AND service.service_ID = ?\n"
            + "ORDER BY detail.price ASC";

    private static final String SORT_SERVICE_DETAIL_PRICE_DOWN = "SELECT detail.id, detail.provider_ID, detail.service_ID, detail.staff_ID, detail.name, detail.price, detail.description, detail.status\n"
            + "FROM tblServiceCategory cate JOIN tblService service ON cate.category_ID = service.category_ID JOIN tblServiceDetail detail ON detail.service_ID = service.service_ID\n"
            + "WHERE cate.category_ID = ? AND service.service_ID = ?\n"
            + "ORDER BY detail.price DESC";

    private static final String SEARCH_SERVICE_DETAIL_BY_NAME = "SELECT detail.id, detail.provider_ID, detail.service_ID, detail.staff_ID, detail.name, detail.price, detail.description, detail.status\n"
            + "FROM tblServiceCategory cate JOIN tblService service ON cate.category_ID = service.category_ID JOIN tblServiceDetail detail ON detail.service_ID = service.service_ID\n"
            + "WHERE cate.category_ID = ? AND service.service_ID = ? AND detail.name LIKE ?";

    private static final String GET_SERVICE_DETAIL_LIST = "SELECT detail.id, detail.provider_ID, detail.service_ID, detail.staff_ID, detail.name, detail.price, detail.description, detail.status\n"
            + "FROM tblServiceCategory cate JOIN tblService service ON cate.category_ID = service.category_ID JOIN tblServiceDetail detail ON detail.service_ID = service.service_ID\n"
            + "WHERE cate.category_ID = ? AND service.service_ID = ?";
    private static final String GET_SERVICE_BY_ID = "SELECT provider_ID, service_ID, staff_ID, name, price, description, status\n"
            + "FROM tblServiceDetail\n"
            + "WHERE id = ?";

    private static final String GET_SERVICE_INFO = "SELECT se.id, pr.[name] as provider_name, se.staff_ID, se.[name], st.[name] as staff_name, se.price, st.avatar, se.[description], st.[status]\n"
            + "FROM [tblServiceDetail] se\n"
            + "JOIN [tblStaff] st ON se.staff_ID = st.staff_ID\n"
            + "JOIN [tblProvider] pr ON se.provider_ID = pr.username\n"
            + "WHERE se.id = ?";

    private static final String UPLOAD_PHOTO = "UPDATE tblService SET image = ? WHERE service_ID = ?  ";

    public static boolean uploadPhoto(String service_ID, String path) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPLOAD_PHOTO);
                ptm.setString(1, path);
                ptm.setString(2, service_ID);
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

    public static List<ServiceCategoryDTO> getListServiceCategory() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceCategoryDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SERVICE_CATEGORY_LIST);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceCategoryDTO(rs.getString("category_ID"), rs.getString("name"), rs.getString("image")));
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

    public static List<ServiceDetailDTO> getListServiceDetailByType(String categoryID, String serviceID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SERVICE_DETAIL_LIST);
            ptm.setString(1, categoryID);
            ptm.setString(2, serviceID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceDetailDTO(rs.getInt("id"), rs.getString("provider_ID"), rs.getString("service_ID"), rs.getInt("staff_ID"), rs.getString("name"), rs.getDouble("price"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ServiceCategoryDTO> getListServiceByServiceID(String categoryID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceCategoryDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SERVICE_CATEGORY_SERVICE_ID);
            ptm.setString(1, categoryID);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceCategoryDTO(rs.getString("service_ID")));
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

    public static List<ServiceDetailDTO> sortListServiceDetailByTypeWordUP(String categoryID, String serviceID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_SERVICE_DETAIL_WORD_UP);
            ptm.setString(1, categoryID);
            ptm.setString(2, serviceID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceDetailDTO(rs.getInt("id"), rs.getString("provider_ID"), rs.getString("service_ID"), rs.getInt("staff_ID"), rs.getString("name"), rs.getDouble("price"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ServiceDetailDTO> sortListServiceDetailByTypeWordDOWN(String categoryID, String serviceID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_SERVICE_DETAIL_WORD_DOWN);
            ptm.setString(1, categoryID);
            ptm.setString(2, serviceID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceDetailDTO(rs.getInt("id"), rs.getString("provider_ID"), rs.getString("service_ID"), rs.getInt("staff_ID"), rs.getString("name"), rs.getDouble("price"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ServiceDetailDTO> searchListServiceDetailByType(String categoryID, String serviceID, String name) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SEARCH_SERVICE_DETAIL_BY_NAME);
            ptm.setString(1, categoryID);
            ptm.setString(2, serviceID);
            ptm.setString(3, "%" + name + "%");
            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceDetailDTO(rs.getInt("id"), rs.getString("provider_ID"), rs.getString("service_ID"), rs.getInt("staff_ID"), rs.getString("name"), rs.getDouble("price"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ServiceDetailDTO> sortListServiceDetailByTypePriceDOWN(String categoryID, String serviceID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_SERVICE_DETAIL_WORD_DOWN);
            ptm.setString(1, categoryID);
            ptm.setString(2, serviceID);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceDetailDTO(rs.getInt("id"), rs.getString("provider_ID"), rs.getString("service_ID"), rs.getInt("staff_ID"), rs.getString("name"), rs.getDouble("price"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ServiceDetailDTO> sortListServiceDetailByTypePriceUP(String categoryID, String serviceID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_SERVICE_DETAIL_WORD_UP);
            ptm.setString(1, categoryID);
            ptm.setString(2, serviceID);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ServiceDetailDTO(rs.getInt("id"), rs.getString("provider_ID"), rs.getString("service_ID"), rs.getInt("staff_ID"), rs.getString("name"), rs.getDouble("price"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ServiceDTO> getListService(String categoryID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SERVICE_LIST);
            ptm.setString(1, categoryID);
            rs = ptm.executeQuery();

            StaffDAO staffDAO = new StaffDAO();

            while (rs.next()) {
//                lấy service_id
                String service_id = rs.getString("service_ID");
                list.add(new ServiceDTO(service_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), rs.getInt("status"), staffDAO.getListStaffByServiceDetail(service_id)
            
         ));
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

    public static List<ServiceDTO> sortServiceCategoryWordUP(String categoryID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_SERVICE_CATEGORY_WORD_UP);
            ptm.setString(1, categoryID);
            rs = ptm.executeQuery();

            StaffDAO staffDAO = new StaffDAO();

            while (rs.next()) {

                String service_id = rs.getString("service_ID");

                list.add(new ServiceDTO(service_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), staffDAO.getListStaffByServiceDetail(service_id)));
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

    public static List<ServiceDTO> sortServiceCategoryWordDOWN(String categoryID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_SERVICE_CATEGORY_WORD_DOWN);
            ptm.setString(1, categoryID);
            rs = ptm.executeQuery();

            StaffDAO staffDAO = new StaffDAO();

            while (rs.next()) {

                String service_id = rs.getString("service_ID");

                list.add(new ServiceDTO(service_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), staffDAO.getListStaffByServiceDetail(service_id)));
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

    public static List<ServiceDTO> searhServiceCategory(String categoryID, String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ServiceDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SEARCH_SERVICE_CATEGORY);
            ptm.setString(1, categoryID);
            ptm.setString(2, "%" + search + "%");
            rs = ptm.executeQuery();

            StaffDAO staffDAO = new StaffDAO();

            while (rs.next()) {

                String service_id = rs.getString("service_ID");

                list.add(new ServiceDTO(service_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), staffDAO.getListStaffByServiceDetail(service_id)));
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

    public static ServiceDetailDTO getServiceDetailByID(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ServiceDetailDTO serviceDetail = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SERVICE_BY_ID);
            ptm.setString(1, id);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String provider_ID = rs.getString("provider_ID");
                String service_ID = rs.getString("service_ID");
                int staff_ID = rs.getInt("staff_ID");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                String description = rs.getString("description");
                int status = rs.getInt("status");
                serviceDetail = new ServiceDetailDTO(Integer.parseInt(id), provider_ID, service_ID, staff_ID, name, price, description, status);
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

        return serviceDetail;
    }

//    se.id, pr.name, se.staff_ID, se.[name], st.[name], se.price, se.avatar, se.[description], st.[status]
    public static ServiceCartDTO getServiceInfoByID(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ServiceCartDTO serviceDetail = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SERVICE_INFO);
            ptm.setString(1, id);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String provider_name = rs.getString("provider_name");
                String service_name = rs.getString("name");
                String staff_name = rs.getString("staff_name");
                double price = rs.getDouble("price");
                String avatar = rs.getString("avatar");
                String description = rs.getString("description");
                int status = rs.getInt("status");
                serviceDetail = new ServiceCartDTO(Integer.parseInt(id), provider_name, service_name, staff_name, price, avatar, description, status);
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

        return serviceDetail;
    }

    public static void main(String[] args) throws SQLException {
//        List<ServiceDetailDTO> list = sortListServiceDetailByTypeWordDOWN("HC", "1");
//
//        for (ServiceDetailDTO x : list) {
//            System.out.println(x);
//        }
        System.out.println(getServiceInfoByID("3").getProviderName());
//        System.out.println(StaffDAO.getListStaffByServiceDetail("2"));

    }
}
