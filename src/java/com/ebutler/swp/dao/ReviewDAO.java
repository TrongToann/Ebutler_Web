/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.dao;

import com.ebutler.swp.dto.ProductCategoryDTO;
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
 * @author Admin
 */
public class ReviewDAO {
    
    private final String SELECT_REVIEW = "select username, product_id, comment, rating, status, id from tblReviewProduct where product_id = ?";
    private final String INSERT_REVIEW = "insert into tblReviewProduct(username, product_id, comment, rating, status) values ( ?, ?, ?, ?, ?)";
    private final String PURCHASED = "select COUNT(*) from tblOrder_Product_Detail opd JOIN tblOrder o ON opd.order_ID = o.order_ID where o.customer_ID = ? and opd.product_detail_ID = ?";
    
    public boolean HasPurchased(String username, String product_id) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                ptm = conn.prepareStatement(PURCHASED);
                ptm.setString(1, username);
                ptm.setString(2, product_id);
                rs = ptm.executeQuery();
                if(rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0 ? true : false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
            
            if(rs != null) {
                rs.close();
            }
        }
        return false;
    }
    
    
    public boolean InsertReview(ReviewDTO review) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        
        try {
            conn = DBUtils.getConnection();
            if(conn != null)
            {         
                ptm = conn.prepareStatement(INSERT_REVIEW);
                ptm.setString(1, review.getUsername());
                ptm.setString(2, review.getProduct_id());
                ptm.setString(3, review.getComment());
                ptm.setInt(4, review.getRating());
                ptm.setInt(5, review.getStatus());
                return (ptm.executeUpdate() > 0) ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            if(conn != null) conn.close();
            if(ptm != null) ptm.close();
        }
        
        return false;
    }
    
    public ArrayList<ReviewDTO> getReviewByProduct(String product_id) throws SQLException{
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ArrayList<ReviewDTO> list = new ArrayList<>();
        
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                ptm = conn.prepareStatement(SELECT_REVIEW);
                ptm.setString(1, product_id);
                rs = ptm.executeQuery();
                while(rs.next()){
                    list.add(new ReviewDTO(rs.getInt(6),rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5)));
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
