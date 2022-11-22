/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.OrderDTO;
import com.ebutler.swp.dto.OrderDetailDTO;
import com.ebutler.swp.dto.ProductDetailDTO;
import com.ebutler.swp.dto.ProviderDTO;
import com.ebutler.swp.dto.ProviderServiceDTO1;
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
public class Provider_Delete_OrderController extends HttpServlet {

    private final String SUCCESS = "Provider_OrderController"; 
    private final String ERROR = "OrderProvider.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            List<OrderDetailDTO> listOrder = new ArrayList();
            List<OrderDTO> listOrderUpdate = new ArrayList();
            
            ProviderDAO providerDAO = new ProviderDAO();
            HttpSession session = request.getSession();
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER");
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            listOrder = providerDAO.loadOrderDetail(provider, orderID);
            boolean checkAll = true;
            boolean checkOrder = providerDAO.deleteOrder(orderID);
            if (!checkOrder) {
                checkAll = false;
            }
            boolean checkOrderDetail = providerDAO.deleteOrderDetail(orderID);
            boolean checkOrderServiceDetail = providerDAO.deleteOrder_ServiceDetail(orderID);
            if (!checkOrderDetail || !checkOrderServiceDetail) {
                checkAll = false;
            }
            boolean checkOrderDetailDelivery = providerDAO.deleteOrderDelivery(orderID);
            if (!checkOrderDetailDelivery) {
                checkAll = false;
            }
            if (checkAll) {

                for (int i = 0; i < listOrder.size(); i++) {
                    int quantity = providerDAO.getProductQuantity(listOrder.get(i).getProduct_detail_ID());
                    int quantityOrder = listOrder.get(i).getQuantity();
                    int setQuantity = quantity + quantityOrder;
                    boolean updateFinal = providerDAO.updateReturnQuantity(setQuantity, listOrder.get(i).getProduct_detail_ID());
                    if (!updateFinal) {
                        request.setAttribute("MESSAGE_UPDATE", "Error Update ! Fix it");
                    }
                }
               
                url = SUCCESS;
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
