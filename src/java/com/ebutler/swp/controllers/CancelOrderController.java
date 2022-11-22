/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dao.ProductDAO;
import com.ebutler.swp.dto.CustomerDTO;
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
public class CancelOrderController extends HttpServlet {

    private final String ERROR = "errorPage.jsp";
    private final String SUCCESS = "GoToUserProfileController";
            
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int product_id = Integer.parseInt(request.getParameter("product_id"));
            int order_id = Integer.parseInt(request.getParameter("order_id"));
            
            HttpSession session = request.getSession();
            CustomerDAO customerDAO = new CustomerDAO();
            
            CustomerDTO login_customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
            
            ProductDAO productDAO = new ProductDAO();
            
            if(productDAO.cancelOrder(product_id, order_id)) {
                request.setAttribute("MESSAGE_SUCCESS", "Cancel order product successfully!");
                
                login_customer.setPoint(login_customer.getPoint() + productDAO.getTotalProduct(product_id, order_id));
                customerDAO.updateWallet(login_customer);
                session.setAttribute("CURRENT_CUSTOMER", login_customer);
            } else {
                request.setAttribute("MESSAGE_FAIL", "Cancel order product fail!");
            };
            
            url = SUCCESS;
        } catch (Exception e) {
            log("ERROR at CancelOrderController: " + e.toString());
        } finally {
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
