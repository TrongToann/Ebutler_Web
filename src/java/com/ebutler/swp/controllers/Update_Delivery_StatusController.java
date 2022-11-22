/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.DeliveryDAO;
import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dao.UserDAO;
import com.ebutler.swp.dto.DeliveryDTO;
import com.ebutler.swp.dto.OrderDetailDTO;
import com.ebutler.swp.dto.OrderDetailInfoDTO;
import com.ebutler.swp.dto.ShipperDTO;
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
public class Update_Delivery_StatusController extends HttpServlet {

    private final String SUCCESS = "Delivery_Order_DetailController";
    private final String ERROR = "delivery_detail.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            ProviderDAO providerDAO = new ProviderDAO();
            List<OrderDetailInfoDTO> listDetailInfo = new ArrayList();
            List<OrderDetailDTO> listCheck = new ArrayList();
            List<OrderDetailDTO> listCheckDefault = new ArrayList();
            List<OrderDetailDTO> listCheckCancel = new ArrayList();
            boolean move = false;
            boolean checkForUpdateDelivery = false;
            boolean checkForUpdateDeliveryCancel = false;
            boolean updateDeliveryStatusForProduct = false;
            boolean updateDelivery = false;
            boolean updateOrder = false;
            int statusDelivery = Integer.parseInt(request.getParameter("DeliveryStatus"));
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            int id = Integer.parseInt(request.getParameter("Product_id"));
            int order_ID = Integer.parseInt(request.getParameter("orderID"));
            int product_Detail_ID = Integer.parseInt(request.getParameter("Product_Order_ID"));
            DeliveryDAO deliveryDAO = new DeliveryDAO();
            int checkDeliveryStatus = deliveryDAO.getStatusDelivery(order_ID, product_Detail_ID);
            if (checkDeliveryStatus < statusDelivery) {
                updateDeliveryStatusForProduct = deliveryDAO.updateProductOrder(statusDelivery, id);
                if (updateDeliveryStatusForProduct) {
                    int status = 1;
                    int statusOrder = 1;
                    switch (statusDelivery) {
                        case 0:
                            statusOrder = 0;
                            status = 0;
                            updateOrder = deliveryDAO.updateOrder(statusOrder, order_ID);
                            updateOrder = deliveryDAO.updateDelivery(status, order_ID);
                            break;
                        case 1:
                            statusOrder = 1;
                            status = 1;
                            updateOrder = deliveryDAO.updateOrder(statusOrder, order_ID);
                            updateOrder = deliveryDAO.updateDelivery(status, order_ID);
                            break;
                        case 2:
                            statusOrder = 1;
                            status = 2;
                            updateOrder = deliveryDAO.updateOrder(statusOrder, order_ID);
                            updateOrder = deliveryDAO.updateDelivery(status, order_ID);
                            break;
                        case 3:
                            break;
                        case 4:

                            break;
                        default:
                            break;
                    }

                    move = true;
                }

                listCheck = deliveryDAO.checkForDelivery(order_ID);
                listCheckDefault = deliveryDAO.checkForDeliveryDefault(order_ID);
                listCheckCancel = deliveryDAO.checkForDeliveryCancel(order_ID);
                checkForUpdateDelivery = (listCheck.size() == listCheckDefault.size());
                checkForUpdateDeliveryCancel = (listCheckCancel.size() == listCheckDefault.size());
                if (updateDeliveryStatusForProduct) {
                    move = true;
                }
                if (checkForUpdateDelivery) {
                    updateDelivery = deliveryDAO.updateDelivery(statusDelivery, order_ID);
                    move = true;
                }
                if (checkForUpdateDelivery) {
                    int status = 1;
                    switch (statusDelivery) {
                        case 0:
                            status = 0;
                            break;
                        case 1:
                            status = 1;
                            break;
                        case 2:
                            status = 1;
                            break;
                        case 3:
                            status = 2;
                            break;
                        case 4:
                            status = 3;
                            break;
                        default:
                            break;
                    }
                    updateOrder = deliveryDAO.updateOrder(status, order_ID);
                    move = true;
                }

                if (checkForUpdateDeliveryCancel) {
                    int status = 1;
                    switch (statusDelivery) {
                        case 0:
                            status = 0;
                            break;
                        case 1:
                            status = 1;
                            break;
                        case 2:
                            status = 1;
                            break;
                        case 3:
                            status = 2;
                            break;
                        case 4:
                            status = 3;
                            break;
                        default:
                            break;
                    }
                    updateOrder = deliveryDAO.updateOrder(status, order_ID);
                    move = true;
                }
                if (checkForUpdateDeliveryCancel) {
                    updateDelivery = deliveryDAO.updateDelivery(statusDelivery, order_ID);
                    move = true;
                }
                List<OrderDetailDTO> listOrder = new ArrayList();
                String userDetail = (String) session.getAttribute("ShippingDetail");
                listOrder = deliveryDAO.loadOrderDetail(order_ID);
                //listDetailInfo = providerDAO.loadOrderInfo(order_ID, customerID) ;
                if (move) {
                    url = SUCCESS;
                    session.setAttribute("Delivery_Detail", listOrder);
                    ShipperDTO shipper = (ShipperDTO) session.getAttribute("CURRENT_SHIPPER");
                    List<DeliveryDTO> listDelivery = (List<DeliveryDTO>) session.getAttribute("Delivery_List");
                    UserDAO userDAO = new UserDAO();
                    for (int i = 0; i < listDelivery.size(); i++) {
                        if (listDelivery.get(i).getOrderID() == order_ID) {
                            double newWallet = (listDelivery.get(i).getTotal()) + shipper.getWallet() ;
                            userDAO.updateShipperWallet(newWallet, shipper.getUsername());

                        }
                    }

                }
            } else {
                request.setAttribute("ErrorUpdateStatus", "Cannot Update Status Had Been Come Through");
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
