/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dao.ReviewDAO;
import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.ReviewDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class AddReviewController extends HttpServlet {
    
    private final String ERROR = "errorPage.jsp";
    private final String SUCCESS = "LoadingReviewController";
    private final String NOT_PASS = "customer_productPage.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String comment = request.getParameter("comment");
            String product_id = request.getParameter("product_id");
            int rating = Integer.parseInt(request.getParameter("rating"));
            
            HttpSession session = request.getSession();
            
            CustomerDTO customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
            
            ReviewDAO reviewDAO = new ReviewDAO();
            
            if(!reviewDAO.HasPurchased(customer.getUsername(), product_id)) {
                request.setAttribute("REVIEW_ERROR", "Bạn cần mua sản phẩm để dược hỗ trợ tính năng này!");
                url = NOT_PASS;
                return;
            }
            
            ReviewDTO review = new ReviewDTO(customer.getUsername(), product_id, comment, rating, 1);
            
            url = reviewDAO.InsertReview(review) ? SUCCESS : NOT_PASS;
            
        } catch (Exception e) 
        {
            log("ERROR at AddReviewController: " + e.toString());
        }
        finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
