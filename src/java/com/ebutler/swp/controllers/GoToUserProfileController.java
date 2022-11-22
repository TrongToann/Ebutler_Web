/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.AddressDAO;
import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dao.OrderHistoryDAO;
import com.ebutler.swp.dto.AddressDTO;
import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.ProductOrderHistoryDTO;
import com.ebutler.swp.dto.ServiceOrderedHistoryDTO;
import com.ebutler.swp.dto.UserDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class GoToUserProfileController extends HttpServlet {

   private static final String ERROR = "errorPage.jsp";
   private static final String SUCCESS = "customer_profilePage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            
            String current_form = request.getParameter("current_form");
            
            UserDTO currentUser = (UserDTO) session.getAttribute("LOGIN_USER");
            CustomerDAO dao = new CustomerDAO();
            CustomerDTO customer = dao.getCurrentCustomer(currentUser.getUsername());
//            session.setAttribute("CURRENT_CUSTOMER", customer);
            OrderHistoryDAO historyDAO = new OrderHistoryDAO();
            List<ProductOrderHistoryDTO> orderedProductListPending = historyDAO.getListProductOrderHistory(currentUser.getUsername(), 0);
            List<ServiceOrderedHistoryDTO> orderedServiceListPending = historyDAO.getListServideOrderHistory(currentUser.getUsername(), 0);
            
            List<ProductOrderHistoryDTO> orderedProductListDelivered = historyDAO.getListProductOrderHistory(currentUser.getUsername(), 3);
            List<ServiceOrderedHistoryDTO> orderedServiceListDelivered = historyDAO.getListServideOrderHistory(currentUser.getUsername(), 2);
            
            List<ProductOrderHistoryDTO> orderedProductListCanceled = historyDAO.getListProductOrderHistory(currentUser.getUsername(), 4);
            
            AddressDAO addressDAO = new AddressDAO();
            ArrayList<AddressDTO> list_address = addressDAO.SelectAddress(currentUser.getUsername());
            session.setAttribute("CURRENT_CUSTOMER", customer);
            session.setAttribute("ORDERED_PRODUCT_LIST_PENDING", orderedProductListPending);
            session.setAttribute("ORDERED_SERVICE_LIST_PENDING", orderedServiceListPending);
            session.setAttribute("ORDERED_PRODUCT_LIST_DELIVERED", orderedProductListDelivered);
            session.setAttribute("ORDERED_SERVICE_LIST_DELIVERED", orderedServiceListDelivered);
            session.setAttribute("ORDERED_PRODUCT_LIST_CANCELED", orderedProductListCanceled);
            
            request.setAttribute("CURRENT_FORM", current_form);
            
            customer.setAddress_list(list_address);
            
            url = SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
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
