/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.DeliveryDAO;
import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.OrderDetailDTO;
import com.ebutler.swp.dto.OrderDetailInfoDTO;
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
 * @author DELL
 */
public class Delivery_Order_DetailController extends HttpServlet {

    private final String SUCCESS = "delivery_detail.jsp";
    private final String ERROR = "delivery_homePage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            ProviderDAO providerDAO = new ProviderDAO();
            DeliveryDAO deliveryDAO = new DeliveryDAO();
            List<OrderDetailInfoDTO> listDetailInfo = new ArrayList();
            List<OrderDetailDTO> listOrder = new ArrayList();
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            String customerID = (String) session.getAttribute("customerID");
            String checkDelivery = deliveryDAO.assignDeliveryChecking(orderID);
            if (user.getUsername().equals(checkDelivery)) {
                if (customerID == null) {
                    customerID = request.getParameter("customerID");
                }

                listDetailInfo = providerDAO.loadOrderInfo(orderID, customerID);
                String userDetail = (String) session.getAttribute("ShippingDetail");
                listOrder = deliveryDAO.loadOrderDetail(orderID);
                if (listOrder != null) {
                    url = SUCCESS;
                    session.setAttribute("Delivery_Detail", listOrder);
                    session.setAttribute("Info_Detail_Delivery", listDetailInfo);
                    session.setAttribute("customerID", customerID);
                }
            }else if (checkDelivery == null) {
                session.setAttribute("ERROR_ASSIGN", "Assigned This Order Now To View Detail"); 
            }else {
                session.setAttribute("ERROR_ASSIGN", "This Order Has Been Assigned!!"); 
            }

        } catch (Exception e) {
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
