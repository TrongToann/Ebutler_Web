/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dto.OrderPayPalDetail;
import com.ebutler.swp.dto.PaymentServiceDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import com.paypal.base.rest.PayPalRESTException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author thekh
 */
@WebServlet(name = "AuthorizePaymentController", urlPatterns = {"/AuthorizePaymentController"})
public class AuthorizePaymentController extends HttpServlet {



    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String total = request.getParameter("total");
            String payment = request.getParameter("payment");
            String cardShipper = request.getParameter("card");
            String total2 = request.getParameter("total2");
            String address = request.getParameter("address");
            String pointBefore = request.getParameter("point");

            if (cardShipper == null) {
                cardShipper = "false";
            }
            String cardPrice = request.getParameter("price");

            HttpSession session = request.getSession();
            if (session != null) {
                OrderPayPalDetail order = null;
                if (cardShipper.equals("true")) {
                    order = new OrderPayPalDetail(String.valueOf(cardPrice), "0", String.valueOf(cardPrice));
                } else {
                    order = new OrderPayPalDetail(String.valueOf(total), "0", String.valueOf(total));
                }

                PaymentServiceDTO paymentServices = new PaymentServiceDTO();
                String approvalLink = paymentServices.authorizePayment(order);

                response.sendRedirect(approvalLink);
                session.setAttribute("TOTAL", total);
                session.setAttribute("PAYMENT", payment);
                session.setAttribute("CARD_SHIPPER", cardShipper);
                session.setAttribute("CARD_PRICE", cardPrice);
                session.setAttribute("TOTAL2", total2);
                session.setAttribute("ADDRESS", address);
                session.setAttribute("POINT_BEFORE", pointBefore);

            }

        } catch (PayPalRESTException e) {
            log("Error at AuthorizePaymentController: " + e.getMessage());
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AuthorizePaymentController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AuthorizePaymentController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
