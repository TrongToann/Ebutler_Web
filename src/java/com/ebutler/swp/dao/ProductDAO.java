/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.ProductCartDTO;
import com.ebutler.swp.dto.ProductDTO;
import com.ebutler.swp.dto.ProductDetailDTO;
import com.ebutler.swp.dto.ReviewDTO;
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
public class ProductDAO {

//    private static final String GET_LIST_PRODUCT = "SELECT category_Name,p.product_Name, category_Image, p.price, p.quantity FROM tblProduct_Category c JOIN tblProduct t  ON c.category_ID = t.category_ID INNER JOIN tblProduct_Provider p ON p.product_ID = t.product_ID where c.category_ID = ?";
    private static final String GET_LIST_PRODUCT = "SELECT category_Name, p.product_Provider_ID, p.provider_ID, p.product_ID, p.product_Name, category_Image, p.price, p.quantity, p.image, p.description, p.status FROM tblProductCategory c JOIN tblProduct t  ON c.category_ID = t.category_ID INNER JOIN tblProductDetail p ON p.product_ID = t.product_ID where c.category_ID = ?";

    private static final String GET_LIST_PRODUCT_BY_TYPE = "SELECT product.product_ID, product.category_ID ,product.name, product.image FROM tblProductCategory cate JOIN tblProduct product ON cate.category_ID = product.category_ID where cate.category_ID = ?";
    private static final String TEST = "SELECT * from tblProductDetail ORDER BY id OFFSET ? ROWS";

    private static final String GET_LIST_PRODUCT_BY_TYPE_DETAIL = "SELECT detail.id, detail.provider_ID, detail.product_ID, detail.name, detail.quantity, detail.price, detail.image, detail.description, detail.status FROM tblProduct product JOIN tblProductDetail detail on product.product_ID = detail.product_ID JOIN tblProductCategory cate ON cate.category_ID = product.category_ID WHERE cate.category_ID = ? AND product.product_ID = ?";

    private static final String GET_SEARCH_PRODUCT = "SELECT product.product_ID, product.category_ID ,product.name, product.image FROM tblProductCategory cate JOIN tblProduct product ON cate.category_ID = product.category_ID where product.name LIKE ? AND cate.category_ID = ?";
    private static final String GET_SEARCH_PRODUCT1 = "SELECT t.id, provider_ID, t.product_ID, name, quantity, price, image, description, status FROM tblProductDetail t JOIN tblProduct h ON t.product_ID = h.product_ID JOIN tblProductCategory c ON c.category_ID = h.category_ID where product_Name like ? and t.product_ID = ?";
    private static final String GET_SEARCH_PRODUCT_DETAIL_BY_TYPE = "SELECT detail.id, detail.provider_ID, detail.product_ID, detail.name, detail.quantity, detail.price, detail.image, detail.description, detail.status FROM tblProduct product JOIN tblProductDetail detail on product.product_ID = detail.product_ID JOIN tblProductCategory cate ON cate.category_ID = product.category_ID WHERE cate.category_ID = ? AND product.product_ID = ? AND detail.name like ?";
    private static final String GET_SEARCH_PRODUCT_CATEGORY = "SELECT product.product_ID, product.category_ID, product.name, product.image FROM tblProduct product JOIN tblProductCategory cate on product.category_ID = cate.category_ID WHERE product.category_ID = ? AND product.name LIKE ?";

    private static final String GET_PRODUCT_BY_ID = "SELECT provider_ID, product_ID, name, quantity, price, image, description, status FROM tblProductDetail WHERE id = ?";
    private static final String UPDATE_QUANTITY = "UPDATE tblProductDetail SET quantity = ? WHERE id = ?";

    private static final String SORT_PRODUCT_DETAIL_PRICE_UP = "SELECT detail.id, detail.provider_ID, detail.product_ID, detail.name, detail.quantity, detail.price, detail.image, detail.description, detail.status FROM tblProduct product JOIN tblProductDetail detail on product.product_ID = detail.product_ID JOIN tblProductCategory cate ON cate.category_ID = product.category_ID WHERE cate.category_ID = ? AND product.product_ID = ? ORDER BY detail.price ASC";
    private static final String SORT_PRODUCT_DETAIL_PRICE_DOWN = "SELECT detail.id, detail.provider_ID, detail.product_ID, detail.name, detail.quantity, detail.price, detail.image, detail.description, detail.status FROM tblProduct product JOIN tblProductDetail detail on product.product_ID = detail.product_ID JOIN tblProductCategory cate ON cate.category_ID = product.category_ID WHERE cate.category_ID = ? AND product.product_ID = ? ORDER BY detail.price DESC";
    private static final String SORT_PRODUCT_DETAIL_WORD_UP = "SELECT detail.id, detail.provider_ID, detail.product_ID, detail.name, detail.quantity, detail.price, detail.image, detail.description, detail.status FROM tblProduct product JOIN tblProductDetail detail on product.product_ID = detail.product_ID JOIN tblProductCategory cate ON cate.category_ID = product.category_ID WHERE cate.category_ID = ? AND product.product_ID = ? ORDER BY detail.name ASC";
    private static final String SORT_PRODUCT_DETAIL_WORD_DOWN = "SELECT detail.id, detail.provider_ID, detail.product_ID, detail.name, detail.quantity, detail.price, detail.image, detail.description, detail.status FROM tblProduct product JOIN tblProductDetail detail on product.product_ID = detail.product_ID JOIN tblProductCategory cate ON cate.category_ID = product.category_ID WHERE cate.category_ID = ? AND product.product_ID = ? ORDER BY detail.name DESC";

    private static final String SORT_PRODUCT_CATEGORY_WORD_UP = "SELECT pro.product_ID, pro.category_ID, pro.name, pro.image from tblProductCategory cate JOIN tblProduct pro on cate.category_ID = pro.category_ID where cate.category_ID = ? ORDER BY pro.name ASC";
    private static final String SORT_PRODUCT_CATEGORY_WORD_DOWN = "SELECT pro.product_ID, pro.category_ID, pro.name, pro.image from tblProductCategory cate JOIN tblProduct pro on cate.category_ID = pro.category_ID where cate.category_ID = ? ORDER BY pro.name DESC";

    private static final String GET_NUMBER_PAGE_PRODUCT_DETAIL = "SELECT COUNT(*) AS [quantity] FROM tblProduct product JOIN tblProductDetail detail on product.product_ID = detail.product_ID JOIN tblProductCategory cate ON cate.category_ID = product.category_ID WHERE cate.category_ID = ? AND product.product_ID = ?";

    private static final String UPLOAD_PHOTO = "UPDATE tblProductDetail SET image = ? WHERE id = ?  ";

    private static final String CANCEL_PRODUCT = "UPDATE tblOrder_Product_Detail set status = 4 where product_detail_ID = ? and order_ID = ? and status = 0";
    private static final String GET_TOTAL_PRODUCT = "SELECT (opd.price * opd.quantity) as total from tblOrder o JOIN tblOrder_Product_Detail opd on o.order_ID = opd.order_ID where opd.order_ID = ? and opd.product_detail_ID = ? and o.payment = 'PayPal'";

    private static final String GET_PRODUCT_INFO = "SELECT provider.[name] as provider_name, detail.product_ID, detail.[name] as product_name, detail.quantity, detail.price, detail.image, detail.description, detail.status\n"
            + "FROM tblProductDetail detail JOIN tblProvider provider\n"
            + "ON detail.provider_ID = provider.username\n"
            + "WHERE detail.id = ? ";

    public static ProductCartDTO getProductForCart(String id) throws SQLException {
        ProductCartDTO product = new ProductCartDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT_INFO);
                ptm.setString(1, id);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String provider_name = rs.getString("provider_name");
                    String product_ID = rs.getString("product_ID");
                    String product_name = rs.getString("product_name");
                    int quantity = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    int status = rs.getInt("status");

                    product = new ProductCartDTO(id, provider_name, product_ID, product_name, quantity, price, image, description, status);
                }
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return product;
    }

    public double getTotalProduct(int product_id, int order_ID) throws SQLException {
        double total = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_TOTAL_PRODUCT);
                ptm.setInt(2, product_id);
                ptm.setInt(1, order_ID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    total = rs.getDouble("total");
                }
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return total;
    }

    public boolean cancelOrder(int product_id, int order_ID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CANCEL_PRODUCT);
                ptm.setInt(1, product_id);
                ptm.setInt(2, order_ID);
                return ptm.executeUpdate() > 0 ? true : false;
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
        return false;
    }

    public static boolean uploadPhoto(String id, String path) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPLOAD_PHOTO);
                ptm.setString(1, path);
                ptm.setString(2, id);
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

    public static List<ProductDTO> getListProductByPlace(String categoty_ID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_LIST_PRODUCT_BY_TYPE);
            ptm.setString(1, categoty_ID);
            rs = ptm.executeQuery();
            while (rs.next()) {

                String product_id = rs.getString("product_ID");

                list.add(new ProductDTO(product_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), getListProductByPlaceDetail(categoty_ID, product_id)));
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

    public static List<ProductDetailDTO> getListProductByPlaceDetail(String categoty_ID, String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_LIST_PRODUCT_BY_TYPE_DETAIL);
            ptm.setString(1, categoty_ID);
            ptm.setString(2, productID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String product_id = rs.getString("id");

                ReviewDAO reviewDAO = new ReviewDAO();
                ArrayList<ReviewDTO> review_list = reviewDAO.getReviewByProduct(product_id);

                ProductDetailDTO product = new ProductDetailDTO(product_id, rs.getString("provider_ID"), rs.getString("product_ID"), rs.getString("name"), rs.getInt("quantity"), rs.getDouble("price"), rs.getString("image"), rs.getString("description"), rs.getInt("status"));

                product.setReview_list(review_list);
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

    public static List<ProductDetailDTO> getPagingProductDetail(String categoryID, String productID, int num) throws SQLException {
        String sql = " SELECT detail.id, detail.provider_ID, detail.product_ID, detail.name, detail.quantity, detail.price, detail.image, detail.description, detail.status FROM tblProduct product JOIN tblProductDetail detail on product.product_ID = detail.product_ID JOIN tblProductCategory cate ON cate.category_ID = product.category_ID\n"
                + " WHERE cate.category_ID = ? AND product.product_ID = ? ORDER BY id asc\n"
                + " OFFSET ? ROWS FETCH FIRST 12 ROWS ONLY";
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(sql);
            ptm.setString(1, categoryID);
            ptm.setString(2, productID);
            ptm.setInt(3, (num - 1) * 12);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetailDTO(rs.getString("id"), rs.getString("provider_ID"), rs.getString("product_ID"), rs.getString("name"), rs.getInt("quantity"), rs.getDouble("price"), rs.getString("image"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ProductDetailDTO> getSearchProductDetailByType(String categoty_ID, String productID, String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SEARCH_PRODUCT_DETAIL_BY_TYPE);
            ptm.setString(1, categoty_ID);
            ptm.setString(2, productID);
            ptm.setString(3, "%" + search + "%");
            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetailDTO(rs.getString("id"), rs.getString("provider_ID"), rs.getString("product_ID"), rs.getString("name"), rs.getInt("quantity"), rs.getDouble("price"), rs.getString("image"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ProductDTO> getSearchProductCategory(String categoty_ID, String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SEARCH_PRODUCT_CATEGORY);
            ptm.setString(1, categoty_ID);
            ptm.setString(2, "%" + search + "%");
            rs = ptm.executeQuery();
            while (rs.next()) {

                String product_id = rs.getString("product_ID");

                list.add(new ProductDTO(product_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), getListProductByPlaceDetail(categoty_ID, product_id)));
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

    public static ProductDetailDTO getProductByID(String id) throws SQLException {
        ProductDetailDTO product = new ProductDetailDTO();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT_BY_ID);
                ptm.setString(1, id);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String provider_ID = rs.getString("provider_ID");
                    String productID = rs.getString("product_ID");
                    String name = rs.getString("name");
                    int quantity = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    String img = rs.getString("image");
                    String description = "";
                    int status = rs.getInt("status");
                    product = new ProductDetailDTO(id, provider_ID, productID, name, quantity, price, img, description, status);
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
        return product;
    }

    public static boolean setQuantiy(String id, int quantity) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            int stockQuantity = (getProductByID(id).getQuantity() - quantity);
            if (conn != null && stockQuantity >= 0) {
                ptm = conn.prepareStatement(UPDATE_QUANTITY);
                ptm.setInt(1, stockQuantity);
                ptm.setString(2, id);
                ptm.executeUpdate();
                check = true;
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

    public static boolean checkQuantiy(String id, int quantity) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            int qty = getProductByID(id).getQuantity();
            int stockQuantity = (getProductByID(id).getQuantity() - quantity);
            if (stockQuantity >= 0) {
                check = true;
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

    public static List<ProductDTO> getSearchProduct(String productName, String categoryID) throws SQLException {

        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList();
        try {

            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_SEARCH_PRODUCT);
            ptm.setString(1, "%" + productName + "%");
            ptm.setString(2, categoryID);
            rs = ptm.executeQuery();
            while (rs.next()) {

                String product_id = rs.getString("product_ID");

                list.add(new ProductDTO(product_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), getListProductByPlaceDetail(categoryID, product_id)));
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

    public static List<ProductDetailDTO> sortListProductDetailPriceUP(String categoryID, String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_PRODUCT_DETAIL_PRICE_UP);
            ptm.setString(1, categoryID);
            ptm.setString(2, productID);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetailDTO(rs.getString("id"), rs.getString("provider_ID"), rs.getString("product_ID"), rs.getString("name"), rs.getInt("quantity"), rs.getDouble("price"), rs.getString("image"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ProductDetailDTO> sortListProductDetailPriceDOWN(String categoryID, String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_PRODUCT_DETAIL_PRICE_DOWN);
            ptm.setString(1, categoryID);
            ptm.setString(2, productID);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetailDTO(rs.getString("id"), rs.getString("provider_ID"), rs.getString("product_ID"), rs.getString("name"), rs.getInt("quantity"), rs.getDouble("price"), rs.getString("image"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ProductDetailDTO> sortListProductDetailWordUP(String categoryID, String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_PRODUCT_DETAIL_WORD_UP);
            ptm.setString(1, categoryID);
            ptm.setString(2, productID);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetailDTO(rs.getString("id"), rs.getString("provider_ID"), rs.getString("product_ID"), rs.getString("name"), rs.getInt("quantity"), rs.getDouble("price"), rs.getString("image"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ProductDetailDTO> sortListProductDetailWordDOWN(String categoryID, String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDetailDTO> list = new ArrayList();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_PRODUCT_DETAIL_WORD_UP);
            ptm.setString(1, categoryID);
            ptm.setString(2, productID);

            rs = ptm.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetailDTO(rs.getString("id"), rs.getString("provider_ID"), rs.getString("product_ID"), rs.getString("name"), rs.getInt("quantity"), rs.getDouble("price"), rs.getString("image"), rs.getString("description"), rs.getInt("status")));
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

    public static List<ProductDTO> sortListProductCategoryWordUP(String categoryID) throws SQLException {
        List<ProductDTO> list = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_PRODUCT_CATEGORY_WORD_UP);
            ptm.setString(1, categoryID);
            rs = ptm.executeQuery();
            while (rs.next()) {

                String product_id = rs.getString("product_ID");

                list.add(new ProductDTO(product_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), getListProductByPlaceDetail(categoryID, product_id)));
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

    public static List<ProductDTO> sortListProductCategoryWordDOWN(String categoryID) throws SQLException {
        List<ProductDTO> list = new ArrayList();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SORT_PRODUCT_CATEGORY_WORD_DOWN);
            ptm.setString(1, categoryID);
            rs = ptm.executeQuery();
            while (rs.next()) {

                String product_id = rs.getString("product_ID");

                list.add(new ProductDTO(product_id, rs.getString("category_ID"), rs.getString("name"), rs.getString("image"), getListProductByPlaceDetail(categoryID, product_id)));
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

    public static int getNumberPageProductDetail(String categoryID, String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET_NUMBER_PAGE_PRODUCT_DETAIL);
            ptm.setString(1, categoryID);
            ptm.setString(2, productID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                int total = rs.getInt(1);
                int countPage = 0;
                countPage = total / 12;
                if (total % 12 != 0) {
                    countPage++;
                }
                return countPage;
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
        return 0;
    }

    public static void main(String[] args) throws SQLException {
//        List<ProductDetailDTO> list = getPagingProductDetail("KC", "3", 1);
//
//        for (ProductDetailDTO x : list) {
//            System.out.println(x);
//        }
        ProductCartDTO product = getProductForCart("1");
        System.out.println(product.getProvider_name());
    }
}
